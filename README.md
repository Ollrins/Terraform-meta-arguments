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
 Скачать архив с провайдером Yandex Cloud
```bash
wget https://github.com/yandex-cloud/terraform-provider-yandex/releases/download/v0.193.0/terraform-provider-yandex_0.193.0_linux_amd64.zip
```
 Создать папку для провайдера в plugins
 ```bash
mkdir -p /home/Ollrins/ter-homeworks/03/src/plugins/registry.terraform.io/yandex-cloud/yandex/0.193.0/linux_amd64/
```
 Распаковать архив в нужную папку
```bash
unzip terraform-provider-yandex_0.193.0_linux_amd64.zip -d /home/Ollrins/ter-homeworks/03/src/plugins/registry.terraform.io/yandex-cloud/yandex/0.193.0/linux_amd64/
```
2. Скачивание исходников провайдера Local
 Вернуться в папку проекта
```bash
cd /home/Ollrins/ter-homeworks/03/src
```
 Скачать архив с исходным кодом провайдера local
 ```bash
wget https://github.com/hashicorp/terraform-provider-local/archive/refs/tags/v2.7.0.tar.gz
```
 Распаковать архив
```bash
tar -xzf v2.7.0.tar.gz
```
 Установить Go из репозитория
```bash
sudo dnf install golang -y
```
 Проверить установку
 ```bash
go version
```
3. Сборка провайдера Local из исходников
 Перейти в папку с исходниками
```bash
cd /home/Ollrins/ter-homeworks/03/src/terraform-provider-local-2.7.0
```
 Собрать провайдер (требуется установленный Go)
 ```bash
go build -o terraform-provider-local
```
 Создать папку для провайдера в plugins
 ```bash
mkdir -p /home/Ollrins/ter-homeworks/03/src/plugins/registry.terraform.io/hashicorp/local/2.7.0/linux_amd64/
```
 Скопировать собранный провайдер
 ```bash
cp terraform-provider-local /home/Ollrins/ter-homeworks/03/src/plugins/registry.terraform.io/hashicorp/local/2.7.0/linux_amd64/
```
4. Проверка структуры папок
 Проверить, что оба провайдера на месте
```bash
ls -la /home/Ollrins/ter-homeworks/03/src/plugins/registry.terraform.io/hashicorp/local/2.7.0/linux_amd64/
ls -la /home/Ollrins/ter-homeworks/03/src/plugins/registry.terraform.io/yandex-cloud/yandex/0.193.0/linux_amd64/
```
5. Инициализация Terraform с локальными провайдерами
 Вернуться в папку проекта
```bash
cd /home/Ollrins/ter-homeworks/03/src
```
 Инициализировать с указанием папки плагинов
```bash
terraform init -plugin-dir=./plugins
```
