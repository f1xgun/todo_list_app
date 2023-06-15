# TODO List App

Todo List App - приложение для создания и выполнения задач.

## Скриншоты
<img src="https://github.com/f1xgun/todo_list_app/assets/88651829/2ac4aa3a-1f37-4f2c-8325-c572f766cf19" width="300">
<img src="https://github.com/f1xgun/todo_list_app/assets/88651829/4d995152-e242-40af-bcef-deda9ae00d60" width="300">
<img src="https://github.com/f1xgun/todo_list_app/assets/88651829/45c0cabb-3917-4250-ba6f-f62e1760a0d8" width="300">
<img src="https://github.com/f1xgun/todo_list_app/assets/88651829/73335c01-97ee-400e-bb93-9760dce284be" width="300">
<img src="https://github.com/f1xgun/todo_list_app/assets/88651829/0e4ab9fe-688d-4a60-bafb-ae1db93a130c" width="300">
<img src="https://github.com/f1xgun/todo_list_app/assets/88651829/cf733436-ef91-4330-a57b-89845e3bf643" width="300">
<img src="https://github.com/f1xgun/todo_list_app/assets/88651829/3c9bfcf3-0c25-45bb-928f-09b12fa21d2e" width="300">

## Используемые зависимости
**State management:** [`bloc`](https://pub.dev/packages/bloc) + [`equatable`](https://pub.dev/packages/equatable)

**Logs:** [`logging`](https://pub.dev/packages/logging)

**ID Generator:** [`uuid`](https://pub.dev/packages/uuid)

**Internationalization:** [`intl`](https://pub.dev/packages/intl)

**JSON Codegeneration:** [`json_serializable`](https://pub.dev/packages/json_serializable) + [`json_annotation`](https://pub.dev/packages/json_annotation)

## Реализованные фичи
 - Логгирование
 - Локализация
 - Смена темы в зависимости от темы в системе ( пока зависит только от темы при загрузке )
 - Просмотр списка задач
 - Добавление/редактирование/удаление задач
 - Скрытие выполненых задач
 - Быстрое добавление задач
 - Важность задачи
 - Дедлайны задачи
 - Возможность удалять/выполнять задачи путем нажатия на чекбокс или свайпами карточки
 - Отображение количества выполненных дел

## Архитектура
В проекте используется feature-first структура.
У каждой feature выделяется три слоя:
- data: слой, в котором происходит всё взаимодействие с внешними источниками данных: их получение, отправка, маппинг;
- domain: самый чистый слой, содержащий модели и сервисы предметной области;
- presentation: слой, представляющий графическую составляющую приложения и логику взаимодействия с пользователем. Может содержать виджеты, страницы и сервисы, необходимые для этого слоя.

Имеется также папка `core`, в которой определяются стили, сервисы общие для всего приложения.
