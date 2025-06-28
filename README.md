[![Stars](https://img.shields.io/github/stars/BlizD/S3_SSL.svg?label=Github%20%E2%98%85&a)](https://github.com/BlizD/S3_SSL/stargazers)
[![Release](https://img.shields.io/github/tag/BlizD/S3_SSL.svg?label=Last%20release&a)](https://github.com/BlizD/S3_SSL/releases)
[![Github All Releases](https://img.shields.io/github/downloads/BlizD/S3_SSL/total.svg)]() 
[![Github Releases](https://img.shields.io/github/downloads/BlizD/S3_SSL/latest/total.svg)]()
[![OpenYellow](https://img.shields.io/endpoint?url=https://openyellow.org/data/badges/2/387114027.json)](https://openyellow.org/grid?data=top&repo=387114027)

## Скачать последний релиз ## 

* [Скачать последний релиз 2025.06.28.01](https://github.com/BlizD/S3_SSL/releases/download/2025.06.28.01/s3_ssl_2025.06.28.01.cfe)

# S3_SSL

Расширение для БСП для хранения файлов на s3 (minio, Amazon S3, Mail.Ru Cloud и т.п.)

Разработано совместно с [@zotov-vs](https://github.com/zotov-vs)

Версия БСП: 3.1.2.343

Версия платформы: 8.3.17.1851

При обращении к API используется [Connector](https://github.com/vbondarevsky/Connector) @vbondarevsky

Спасибо malikov-pro за публикации [external-storage-1c-ssl](https://github.com/malikov-pro/external-storage-1c-ssl)
[Хранение файлов томов БСП в хранилище с OpenStack API](https://infostart.ru/public/1276986/) @malikov-pro


# Инструкция «Хранение файлов на s3»

На примере облака mail.ru (скрины для облака взяты из инструкции в 2021 году :), сейчас могут быть другими)
Конфигурация Документооборот 2.1.27.1

В [релизе 2025.06.28.01](https://github.com/BlizD/S3_SSL/releases) выполнена адаптация расширения для Документооборот 8 КОРП, редакция 2.1 (2.1.34.1)


#2 @ArkadiyBL Адаптация расширения для Документооборот 8 КОРП, редакция 2.1 (2.1.34.1) 

## Особенности при подключении расширения
ВНИМАНИЕ! Расширение «s3_ХранениеФайлов» работает если указано «Безопасный режим» = НЕТ

![Свойство "Безопасный режим"](https://github.com/BlizD/S3_SSL/blob/main/screen/image-2.png)

## Как настроить хранение в томах на s3

Открываем «Настройка и администрирование» - «Настройка программы»
Далее «Работа с файлами»

![alt text](https://github.com/BlizD/S3_SSL/blob/main/screen/image-12.png)

Указываем 
«Хранить файлы в томах на диске» = ДА
И жмем на гиперссылку «Тома хранения файлов»

![alt text](https://github.com/BlizD/S3_SSL/blob/main/screen/image-4.png)

В группу «Группа по умолчанию» добавляем элемент «Облако S3 (b_test.hb.bizmrg.com)»
* «Наименование тома» = «Облако S3 (b_test.hb.bizmrg.com)»
* «Тип хранилища» = Объектное s3
* «Адрес хранилища» = https://b_test.hb.bizmrg.com
* «Имя префикса» = DOC
* «Имя префикса рабочая база» = DOC
* «Регион» = ru-msk
* «Идентификатор ключа доступа» = 8oQhLfcxGZKPskDhHP6phW
* «Секретный ключ» = Вставить секретный ключ

Жмем записать и закрыть


![alt text](https://github.com/BlizD/S3_SSL/blob/main/screen/image-5.png)


##  Как перенести файлы из Базы данных в S3

Открываем «Настройка и администрирование» - «Настройка программы» Далее «Работа с файлами»

 ![alt text](https://github.com/BlizD/S3_SSL/blob/main/screen/image-13.png)

Жмем на гиперссылку «Тома хранения файлов»

 ![alt text](https://github.com/BlizD/S3_SSL/blob/main/screen/image-8.png)

В форме списка жмем на кнопку «Перенос в тома»

 ![alt text](https://github.com/BlizD/S3_SSL/blob/main/screen/image-9.png)

В открывшемся окне жмем на кнопку «Перенести файлы в тома»

 ![alt text](https://github.com/BlizD/S3_SSL/blob/main/screen/image-10.png)

В окне с предупреждением жмем «Да»

 ![alt text](https://github.com/BlizD/S3_SSL/blob/main/screen/image-11.png)

Ждем, когда выполнится выгрузка.


## Как проверить целостность тома s3

Открываем «Настройка и администрирование» - «Настройка программы» Далее «Работа с файлами»

 ![alt text](https://github.com/BlizD/S3_SSL/blob/main/screen/image-13.png)

 Жмем на гиперссылку «Тома хранения файлов»

 ![alt text](https://github.com/BlizD/S3_SSL/blob/main/screen/image-8.png)


 Открываем элемент «Облако S3 (b_test.hb.bizmrg.com)»
 
Далее жмем на кнопку «Проверить целостность»

Будет сформирован отчет:
Если «Целостностные данные» = 100% значит перенос файлов выполнен успешно


## Как посмотреть путь к файлу на диске s3

Открываем карточку файла, далее жмем на «Версии»
 
Далее жмем кнопку «Открыть карточку»
 
Далее жмем «Еще» - «Изменить форму» 
 ![alt text](https://github.com/BlizD/S3_SSL/blob/main/screen/image-14.png)
Ставим галочку для «Группа хранение» и жмем «Да»
 
Теперь в форме версии отображается путь к файлу:
