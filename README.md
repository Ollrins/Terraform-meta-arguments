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
