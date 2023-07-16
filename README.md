# TODO List App

Todo List App - приложение для создания и выполнения задач. [Скачать APK](https://github.com/f1xgun/todo_list_app/releases/download/v0.2.0/app-release.apk")

## Deeplinks
https://todo - На главную страницу

https://todo/task_details - На страницу создания новой таски

## Скриншоты
<img src="https://github.com/f1xgun/todo_list_app/assets/88651829/2ac4aa3a-1f37-4f2c-8325-c572f766cf19" width="300">
<img src="https://github.com/f1xgun/todo_list_app/assets/88651829/4d995152-e242-40af-bcef-deda9ae00d60" width="300">
<img src="https://github.com/f1xgun/todo_list_app/assets/88651829/45c0cabb-3917-4250-ba6f-f62e1760a0d8" width="300">
<img src="https://github.com/f1xgun/todo_list_app/assets/88651829/73335c01-97ee-400e-bb93-9760dce284be" width="300">
<img src="https://github.com/f1xgun/todo_list_app/assets/88651829/0e4ab9fe-688d-4a60-bafb-ae1db93a130c" width="300">
<img src="https://github.com/f1xgun/todo_list_app/assets/88651829/cf733436-ef91-4330-a57b-89845e3bf643" width="300">
<img src="https://github.com/f1xgun/todo_list_app/assets/88651829/3c9bfcf3-0c25-45bb-928f-09b12fa21d2e" width="300">

## Используемые зависимости
**State management:** [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) + [`equatable`](https://pub.dev/packages/equatable)

**Logs:** [`logging`](https://pub.dev/packages/logging) + [`pretty_dio_logger`](https://pub.dev/packages/pretty_dio_logger)

**ID Generator:** [`uuid`](https://pub.dev/packages/uuid)

**Internationalization:** [`intl`](https://pub.dev/packages/intl)

**Code generation for data-models:** [`freezed`](https://pub.dev/packages/freezed)

**JSON Codegeneration:** [`json_serializable`](https://pub.dev/packages/json_serializable) + [`json_annotation`](https://pub.dev/packages/json_annotation)

**HTTP:** [`dio`](https://pub.dev/packages/dio)

**LocalStorage:** [`shared_preferences`](https://pub.dev/packages/shared_preferences) + [`sqflite`](https://pub.dev/packages/sqflite)

**DI:** [`get_it`](https://pub.dev/packages/get_it)

**Firebase Services:** [`firebase_core`](https://pub.dev/packages/firebase_core) + [`firebase_crashlytics`](https://pub.dev/packages/firebase_crashlytics) + [`firebase_remote_config`](https://pub.dev/packages/firebase_remote_config)

**Mock data:** [`mockito`](https://pub.dev/packages/mockito)

**Environment variables:** [`envied`](https://pub.dev/packages/envied)

## Реализованные фичи
 - Логгирование
 - Локализация
 - Смена темы в зависимости от темы в системе ( зависит от темы в системе )
 - Просмотр списка задач
 - Добавление/редактирование/удаление задач
 - Скрытие выполненых задач
 - Быстрое добавление задач
 - Важность задачи
 - Дедлайны задачи
 - Возможность удалять/выполнять задачи путем нажатия на чекбокс или свайпами карточки
 - Отображение количества выполненных дел
 - Возможность сохранения тасок на сервере + хранение локально в базе данных и синхронизация при возмножности
 - Работа с данными без ожидания выполнения действий, связанных с данными в хранилищах
 - Unit, integration tests
 - DI
 - Navigator 2.0
 - Deeplinks
 - Реализована поддержка лендскейп-ориентации и больших экранов
 - Реализована работа с Remote Configs, работает рантайм-переключение цвета важности
 - Подключен и настроен Firebase Crashlytics
 - Собирается аналитика по событиям с помощью Firebase Analytics
 - Настроен CI + распространениче через Firebase App Distribution
 - Поддержаны несколько флейворов: для разработки и продакшена


## Архитектура
В проекте используется feature-first структура.
У каждой feature выделяется три слоя:
- data: слой, в котором происходит всё взаимодействие с внешними источниками данных: их получение, отправка, маппинг;
- domain: слой, содержащий модели и сервисы предметной области;
- presentation: слой, представляющий графическую составляющую приложения и логику взаимодействия с пользователем. Может содержать виджеты, страницы и сервисы, необходимые для этого слоя.

Имеется также папка `core`, в которой определяются стили, сервисы(managers), константы, исключения общие для всего приложения.

## Синхронизация данных в хранилищах
Синхронизация данных на сервере происходит по принципу last-in-wins, т.е берется полученный список тасок с локального хранилища и сравнивается каждая таска по времени последнего изменения, из тасок с одинаковым id берется последняя измененная.

Синхронизация данных локально происходит следующим образом:
1. получаем данные с сервера;
2. проходимся по полученному списку тасок и проверяем есть ли у нас данная таска в нашем локальном хранилище, нет - добавляем ее, иначе смотрим на даты изменения тасок, если таска с сервера изменялась позже, то надо заменить локальную таску на таску с сервера. Если таска локально изменялась позже, то смотрим не является ли данная таска удаленной в момент отсутствия интернета, т.е у таски в поле deleted находится true. Если таска удалена локально без интернета, то необходимо ее окончательно удалить, поскольку в данный момент у нас есть возможность отправить данные на сервер.
3. отправляем на сервер смерженный список тасок

## Для разработчиков
Чтобы самому сбилдить и запустить приложение, необходимо создать файл ```.env``` в корневой папке проекта со следующими полями:
```
TASKS_HOST=<url>
TOKEN=<token>
```

Затем необходимо выполнить кодогенерацию с помощью команды ```dart run build_runner build```. После выполнить конфигурацию проекта для подключения к проекту на firebase, для этого необходимо выполнить команду ```flutterfire configure``` и выбрать ваш проект, в котором подключены Firebase Crashlytics, Remote Configs, Firebase Analytics. После того, как сгенерируются все файлы, можно запускать проект и всё должно успешно работать. 
