# Приложение для складского учета товаров

## Пользовательские сценарии
* Можно создать склад. У склада есть уникальное название и не уникальный атрибут региона, который можно выбрать из 8 доступных федеральных округов РФ: Центральный, Северо-Западный, Южный, Северо-Кавказский, Приволжский, Уральский, Сибирский, Дальневосточный
* Можно создать товар, у которого есть уникальное название
* Можно создать доставку товара на склад, что увеличивает его количество на складе
* Можно создавать передачу товара между складами, что уменьшает его количество на исходном складе и увеличивает на целевом
* Можно редактировать и удалять товары
* Можно удалять склады

# Что используется?

## Библиотеки
* haml
* aasm
* sidekiq

## Прочее
* locale (ru)
* transaction
* lambda (params_prepare_concern)
* seeds (read regions from csv)
* overload (application_record)
