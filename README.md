## Домашнее задание к занятию «Управляющие конструкции в коде Terraform»

### Задание 1
<p align="center">
  <img src="screenshots/S1.png" alt="скриншот входящих правил «Группы безопасности» в ЛК Yandex Cloud" width="900"/>
  <br>
  <em>скриншот входящих правил «Группы безопасности» в ЛК Yandex Cloud</em>
</p>

### Задание 4
<p align="center">
  <img src="screenshots/S4.png" alt="скриншот файла inventory.ini" width="800"/>
  <br>
  <em>скриншот файла inventory.ini</em>
</p> 

### Задание 5
<p align="center">
  <img src="screenshots/S5.png" alt="output в виде списка словарей" width="800"/>
  <br>
  <em>output в виде списка словарей</em>
</p> 

1. Скачивание и установка провайдера Yandex Cloud
```bash
# Скачать архив с провайдером Yandex Cloud
wget https://github.com/yandex-cloud/terraform-provider-yandex/releases/download/v0.193.0/terraform-provider-yandex_0.193.0_linux_amd64.zip
```
# Создать папку для провайдера в plugins
mkdir -p /home/Ollrins/ter-homeworks/03/src/plugins/registry.terraform.io/yandex-cloud/yandex/0.193.0/linux_amd64/
```
# Распаковать архив в нужную папку
unzip terraform-provider-yandex_0.193.0_linux_amd64.zip -d /home/Ollrins/ter-homeworks/03/src/plugins/registry.terraform.io/yandex-cloud/yandex/0.193.0/linux_amd64/
```
2. Скачивание исходников провайдера Local
```bash
# Вернуться в папку проекта
cd /home/Ollrins/ter-homeworks/03/src
```
# Скачать архив с исходным кодом провайдера local
wget https://github.com/hashicorp/terraform-provider-local/archive/refs/tags/v2.7.0.tar.gz
```
# Распаковать архив
tar -xzf v2.7.0.tar.gz
```
# Установить Go из репозитория
sudo dnf install golang -y
```
# Проверить установку
go version
```
3. Сборка провайдера Local из исходников
```bash
# Перейти в папку с исходниками
cd /home/Ollrins/ter-homeworks/03/src/terraform-provider-local-2.7.0
```
# Собрать провайдер (требуется установленный Go)
go build -o terraform-provider-local
```
# Создать папку для провайдера в plugins
mkdir -p /home/Ollrins/ter-homeworks/03/src/plugins/registry.terraform.io/hashicorp/local/2.7.0/linux_amd64/
```
# Скопировать собранный провайдер
cp terraform-provider-local /home/Ollrins/ter-homeworks/03/src/plugins/registry.terraform.io/hashicorp/local/2.7.0/linux_amd64/
```
4. Проверка структуры папок
```bash
# Проверить, что оба провайдера на месте
ls -la /home/Ollrins/ter-homeworks/03/src/plugins/registry.terraform.io/hashicorp/local/2.7.0/linux_amd64/
ls -la /home/Ollrins/ter-homeworks/03/src/plugins/registry.terraform.io/yandex-cloud/yandex/0.193.0/linux_amd64/
```
5. Инициализация Terraform с локальными провайдерами
```bash
# Вернуться в папку проекта
cd /home/Ollrins/ter-homeworks/03/src
```
# Инициализировать с указанием папки плагинов
```bash
terraform init -plugin-dir=./plugins
```
