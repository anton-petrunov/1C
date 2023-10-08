# Доработка конфигурации. Создание документа "Акт выполненных работ" и его печатных форм (обычной, факсимиле)

## Постановка задачи

### 1. Документ “Акт выполненных работ”
#### 1.1. Создайте документ “Акт выполненных работ”
![1](https://github.com/anton-petrunov/1C/assets/97449490/54776c2b-b1ed-4d49-bcb4-efeb16654741)
#### 1.2. Автоматическое заполнение ставки НДС и единицы измерения номенклатуры
![2](https://github.com/anton-petrunov/1C/assets/97449490/09673586-05df-4d24-8a45-6075c2634013)
#### 1.3. Пересчет сумм в табличной части
![3](https://github.com/anton-petrunov/1C/assets/97449490/5855c938-adad-4583-bb66-e77205f11e14)
#### 1.4. Отображение суммы акта в форме списка
![4](https://github.com/anton-petrunov/1C/assets/97449490/3c5c10d9-3208-4293-b74e-c313ee3c8bf8)
#### 1.5. Ввод документа “Акт выполненных работ на основании документа “Заказ клиента”
![5](https://github.com/anton-petrunov/1C/assets/97449490/2490b353-9955-4c9a-9dfc-a52c2a06172f)
#### 1.6. Формирование движений в регистре “Продажи”
![6](https://github.com/anton-petrunov/1C/assets/97449490/4879d48b-ef8f-4326-b2db-03678e3d6645)
### 2. Печатные формы документа “Акт выполненных работ”
![7](https://github.com/anton-petrunov/1C/assets/97449490/4b7e1c78-1b7d-4eef-b0d6-6245af1d18f0)

[Шаблон_АктВыполненныхРабот.xls](https://github.com/anton-petrunov/1C/files/12841254/_.xls)
#### 2.1. Пример заполненной формы “Акт выполненных работ”
![8](https://github.com/anton-petrunov/1C/assets/97449490/8ec504e4-2c2a-481e-a87b-30cc97e0ebdb)
#### 2.2. Заполнение формы “Акт выполненных работ (факсимиле)”
![9](https://github.com/anton-petrunov/1C/assets/97449490/a69dabfe-0312-4f46-885c-4818e80524a6)
## Решение
### Исходный код
[Ссылка на документ АктВыполненныхРабот на GitHub](https://github.com/anton-petrunov/1C/tree/problem_28/src/Documents/АктВыполненныхРабот)

[Ссылка на модуль менеджера документа на GitHub (содержит большую часть кода)](https://github.com/anton-petrunov/1C/tree/problem_28/src/Documents/АктВыполненныхРабот/ManagerModule.bsl)

[Ссылкка на модули команд печати документа на GitHub](https://github.com/anton-petrunov/1C/tree/problem_28/src/Documents/АктВыполненныхРабот/Commands)
### Демонстрация работы приложения
### Архив с выгрузкой информационной базы
[28 1.0.0.9.zip](https://github.com/anton-petrunov/1C/files/12841345/28.1.0.0.9.zip)
