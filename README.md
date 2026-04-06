## Домашнее задание к занятию «Использование Terraform в команде»

### Задание 1
<p align="center">
  <img src="screenshots/S1-1.png" alt="checkov" width="900"/>
  <br>
  </p>
<p>
Ошибки CKV_TF_1 и CKV_TF_2  - строке source используется ?ref=main   <br>
source = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"   <br>
CKV_TF_1: Требует использовать конкретный commit hash вместо ветки   <br>
CKV_TF_2: Требует использовать тег с версией вместо ветки   <br>
CKV_YC_2: "Ensure compute instance does not have public IP"   <br>
У ВМ есть публичный IP-адрес   <br>
CKV_YC_11: "Ensure security group is assigned to network interface"   <br>
К сетевым интерфейсам не привязана группа безопасности   <br>
</p>

### Задание 2
<p align="center">
  <img src="screenshots/S2-1.png" alt="terraform init -migrate-state для миграции state в S3" width="800"/>
  <br>
  <em>terraform init -migrate-state для миграции state в S3</em>
</p> 

<p align="center">
  <img src="screenshots/S2-2.png" alt="terraform.tfstate" width="800"/>
  <br>
  <em>terraform.tfstate</em>
</p> 

<p align="center">
  <img src="screenshots/S2-3.png" alt="tfstate lock" width="800"/>
  <br>
  <em>tfstate  lock</em>
</p> 

### Задание 3
<p align="center">
  <img src="screenshots/S3.png" alt="PR результат анализа checkov, план изменений инфраструктуры из вывода команды terraform plan" width="800"/>
  <br>
  <em>PR результат анализа checkov, план изменений инфраструктуры из вывода команды terraform plan</em>
</p> 
  <br>
  <p align="center">
  <a href="https://github.com/Ollrins/Terraform-meta-arguments/pull/1">ссылка на PR для ревью #1</a>
</p>
    
### Задание 4
<p align="center">
  <img src="screenshots/S4.png" alt="скриншоты проверок из terraform console" width="800"/>
  <br>
  <em>скриншоты проверок из terraform console</em>
</p> 

### Задание 5
<p align="center">
  <img src="screenshots/S5.png" alt="переменные с валидацией" width="800"/>
  <br>
  <em>переменные с валидацией</em>
</p> 

### Задание 7
<p align="center">
  <img src="screenshots/S7-1.png" alt="cat main.tf создание s3 backet" width="800"/>
  <br>
  <em>cat main.tf создание s3 backet</em>
</p> 
<p align="center">
  <img src="screenshots/S7.png" alt="вывод outputs" width="800"/>
  <br>
  <em>вывод outputs</em>
</p> 




1. Создание bucket в Yandex Object Storage
```bash
# Установите имя bucket (должно быть уникальным во всем Yandex Cloud)
BUCKET_NAME="tf-state-your-unique-name-$(date +%Y%m%d)"

# Создайте bucket
yc storage bucket create \
  --name $BUCKET_NAME \
  --folder-id YOUR_FOLDER_ID \
  --default-storage-class standard

# Проверьте создание bucket
yc storage bucket list --folder-id YOUR_FOLDER_ID

# Настройте ACL для bucket (опционально - приватный доступ)
yc storage bucket update \
  --name $BUCKET_NAME \
  --acl private
```

2. Создание сервисного аккаунта для доступа к S3
```bash
# Создайте сервисный аккаунт
SA_NAME="tf-state-sa"
yc iam service-account create --name $SA_NAME --folder-id YOUR_FOLDER_ID

# Получите ID сервисного аккаунта
SA_ID=$(yc iam service-account get $SA_NAME --format json | jq -r '.id')
echo "Service Account ID: $SA_ID"
```

3. Назначение прав на bucket
```bash
# Назначьте права на bucket (read + write)
yc storage bucket update \
  --name $BUCKET_NAME \
  --grant-read write,read \
  --subject-id $SA_ID

# Альтернативный вариант: назначить права через ACL
# yc storage bucket update --name $BUCKET_NAME --acl grant-write --grantee-id $SA_ID
```
4. Создание ключей доступа для сервисного аккаунта
```bash
# Создайте ключ доступа для сервисного аккаунта
yc iam access-key create \
  --service-account-name $SA_NAME \
  --format json > sa_keys.json

# Извлеките ключи
ACCESS_KEY=$(jq -r '.access_key.key_id' sa_keys.json)
SECRET_KEY=$(jq -r '.secret' sa_keys.json)

echo "Access Key: $ACCESS_KEY"
echo "Secret Key: $SECRET_KEY"

# Сохраните ключи в безопасное место (опционально)
# echo "AWS_ACCESS_KEY_ID=$ACCESS_KEY" > .env
# echo "AWS_SECRET_ACCESS_KEY=$SECRET_KEY" >> .env
```
5. Настройка переменных окружения для доступа к S3
```bash
# Установите переменные окружения для доступа к S3
export AWS_ACCESS_KEY_ID=$ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=$SECRET_KEY
export AWS_DEFAULT_REGION="ru-central1"

# Проверьте, что переменные установлены
echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
echo "AWS_DEFAULT_REGION: $AWS_DEFAULT_REGION"
```
6. Создание конфигурации backend.tf
Перейдите в директорию с вашим Terraform проектом:

```bash
cd /path/to/your/terraform/project
```
Создайте файл backend.tf:

```bash
cat > backend.tf << EOF
terraform {
  required_version = "~> 1.12.0"
  
  backend "s3" {
    bucket  = "$BUCKET_NAME"
    key     = "terraform.tfstate"
    region  = "ru-central1"
    
    # Встроенный механизм блокировок (Terraform >= 1.6)
    # Не требует отдельной базы данных!
    use_lockfile = true
    
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}
EOF

# Просмотрите созданный файл
cat backend.tf
```
7. Инициализация Terraform с миграцией state
```bash
# Инициализируйте Terraform с миграцией существующего state
terraform init -migrate-state

# При запросе подтвердите миграцию, введя "yes"
```
8. Проверка загрузки state в S3
```bash
# Проверьте, что state загружен в S3
yc storage object list \
  --bucket-name $BUCKET_NAME \
  --folder-id YOUR_FOLDER_ID

# Скачайте и проверьте содержимое state
yc storage object get \
  --bucket-name $BUCKET_NAME \
  --name terraform.tfstate \
  --output terraform.tfstate.downloaded

# Проверьте содержимое скачанного state файла
cat terraform.tfstate.downloaded | jq '.'

# Удалите временный файл (опционально)
rm terraform.tfstate.downloaded
```
9. Очистка (при необходимости)
```bash
# Удалить объект state из bucket
yc storage object delete \
  --bucket-name $BUCKET_NAME \
  --name terraform.tfstate

# Удалить bucket (только если он пуст)
yc storage bucket delete --name $BUCKET_NAME

# Удалить сервисный аккаунт
yc iam service-account delete --name $SA_NAME

# Удалить файл с ключами
rm sa_keys.json .env
```
