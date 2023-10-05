		 
#Область Задача1

&НаКлиенте
Процедура Задача1(Команда)
	Задача1НаСервере();
КонецПроцедуры

&НаСервере
Процедура Задача1НаСервере()
	
	//1. Выбрать все элементы справочника "Номенклатура"
	ВыборкаНоменклатура = Справочники.Номенклатура.Выбрать();
	
	//2. Обход выборки в цикле
	Пока ВыборкаНоменклатура.Следующий() Цикл
		
		//для групп реквизит "СтавкаНДС" не используется, поэтому группы нужно пропустить
		Если ВыборкаНоменклатура.ЭтоГруппа Тогда
			Продолжить;
		КонецЕсли; 
		
		//3. Получить объект для управления данными элемента справочника
		ТекущийОбъект = ВыборкаНоменклатура.ПолучитьОбъект();
		
		//4. Изменить данные объекта
		ТекущийОбъект.СтавкаНДС = Перечисления.СтавкиНДС.НДС20;
		
		//5. Записать данные объекта (новые) в базу
		ТекущийОбъект.Записать();
	
	КонецЦикла; 
	
	Сообщить("Заполнение ставки НДС завершено!");
	
КонецПроцедуры

#КонецОбласти
         
#Область Задача2
		 
&НаКлиенте
Процедура Задача2(Команда)
	
	АдресНаСайте = Задача2НаСервере();
	
	//3. Проверить заполнен ли адрес на сайте
	Если ПустаяСтрока(АдресНаСайте) = Ложь Тогда
		
		//4. открыть ссылку в браузере
		Попытка
			ПерейтиПоНавигационнойСсылке(АдресНаСайте);		
		Исключение
		    Сообщить("Ну удалось открыть страницу товара, возможно ссылка указана неправильно...Содержание ошибки:" + ОписаниеОшибки());
		КонецПопытки;
				
	КонецЕсли; 
	
КонецПроцедуры

&НаСервере
Функция Задача2НаСервере()

	//1. Найти товар по артикулу
	НайденныйТовар = Справочники.Номенклатура.НайтиПоРеквизиту("Артикул", "RV-R650S");
	
	Если НайденныйТовар.Пустая() = Ложь Тогда
		//2. Получаем значение свойства "АдресНаСайте" (реквизит справочника)
		АдресНаСайте = НайденныйТовар.АдресНаСайте;
	Иначе
		АдресНаСайте = "";
	КонецЕсли; 
	
	Возврат АдресНаСайте;
	
КонецФункции

#КонецОбласти

#Область Задача3

&НаКлиенте
Процедура Задача3(Команда)
	Задача3НаСервере();
КонецПроцедуры

&НаСервере
Процедура Задача3НаСервере()

	//1. Выбрать всех контрагентов
	ВыборкаКонтрагенты = Справочники.Контрагенты.Выбрать();
	
	Сообщить("Контрагенты без договоров:");
	
	МассивКонтрагентовБезДоговоров = Новый Массив;
	//2. Обход выборки
	Пока ВыборкаКонтрагенты.Следующий() Цикл
		
		//3. Получение ссылки текущего контрагента
		СсылкаНаКонтрагента = ВыборкаКонтрагенты.Ссылка;
		
		//4. Получение выборки договоров с отбором по владельцу (ссылке на контрагента)
		ВыборкаДоговоры = Справочники.ДоговорыКонтрагентов.Выбрать(, СсылкаНаКонтрагента);
		
		//5. Проверяем есть ли в выборке хотя бы один элемент
		ЕстьДоговоры = ВыборкаДоговоры.Следующий();
		
		Если ЕстьДоговоры = Ложь Тогда
			МассивКонтрагентовБезДоговоров.Добавить(ВыборкаКонтрагенты.Ссылка);
		КонецЕсли; 
		
	КонецЦикла; 
	
	Для каждого ТекКонтрагент Из МассивКонтрагентовБезДоговоров Цикл
		Сообщить(" - " + ТекКонтрагент.Наименование + " (ИНН " + ТекКонтрагент.ИНН + ")");
	КонецЦикла; 
	
КонецПроцедуры

#КонецОбласти

#Область Задача4

&НаКлиенте
Процедура Задача4(Команда)
	Задача4НаСервере();
КонецПроцедуры

&НаСервере
Процедура Задача4НаСервере()

	
КонецПроцедуры

#КонецОбласти

#Область Задача5

&НаКлиенте
Процедура Задача5(Команда)
	Задача5НаСервере();
КонецПроцедуры

&НаСервере
Процедура Задача5НаСервере()
	
	//1. Выбрать всех контрагентов
	ВыборкаКонтрагенты = Справочники.Контрагенты.Выбрать();
	
	КоличествоСозданныхДоговоров = 0;
	
	//2. Обход выборки
	Пока ВыборкаКонтрагенты.Следующий() Цикл
		
		//3. Получение ссылки текущего контрагента
		СсылкаНаКонтрагента = ВыборкаКонтрагенты.Ссылка;
		
		//4. Получение выборки договоров с отбором по владельцу (ссылке на контрагента)
		ВыборкаДоговоры = Справочники.ДоговорыКонтрагентов.Выбрать(, СсылкаНаКонтрагента);
		
		//5. Проверяем есть ли в выборке хотя бы один элемент
		ЕстьДоговоры = ВыборкаДоговоры.Следующий();
		
		Если ЕстьДоговоры = Ложь Тогда
			
			//6. Создание нового договора
			НовыйДоговор = Справочники.ДоговорыКонтрагентов.СоздатьЭлемент();
			НовыйДоговор.Владелец = ВыборкаКонтрагенты.Ссылка;
			НовыйДоговор.Номер = "б/н";
			НовыйДоговор.ДатаДоговора = ТекущаяДата();
			НовыйДоговор.Наименование = "Договор № " + НовыйДоговор.Номер + " от " + Формат(НовыйДоговор.ДатаДоговора, "ДФ=dd.MM.yyyy");
			НовыйДоговор.Основной = Истина;
			
			//7. Определение вида договора
			Если ВыборкаКонтрагенты.Покупатель И НЕ ВыборкаКонтрагенты.Поставщик И НЕ ВыборкаКонтрагенты.ПрочиеОтношения Тогда
				//только "Покупатель"
				ВидДоговора = Перечисления.ВидыДоговоров.СПокупателем;
			ИначеЕсли ВыборкаКонтрагенты.Поставщик И НЕ ВыборкаКонтрагенты.Покупатель И НЕ ВыборкаКонтрагенты.ПрочиеОтношения Тогда
				//только "Поставщик"
				ВидДоговора = Перечисления.ВидыДоговоров.СПоставщиком;
			ИначеЕсли ВыборкаКонтрагенты.ПрочиеОтношения И НЕ ВыборкаКонтрагенты.Покупатель И НЕ ВыборкаКонтрагенты.Поставщик Тогда
				//только "Прочие отношения"
				ВидДоговора = Перечисления.ВидыДоговоров.Прочее;
			Иначе
				//все остальные комбинации
				ВидДоговора = Перечисления.ВидыДоговоров.СПокупателем;
			КонецЕсли; 
			
			//8. Заполнение вида договора у элемента справочника
			НовыйДоговор.ВидДоговора = ВидДоговора;
			
			//9. Записать элемент справочника
			НовыйДоговор.Записать();
			
			КоличествоСозданныхДоговоров = КоличествоСозданныхДоговоров + 1;
			
		КонецЕсли; 
		
	КонецЦикла; 
	
	Сообщить("Обработка завершена. Создано договоров: " + КоличествоСозданныхДоговоров);
	
КонецПроцедуры

#КонецОбласти   

#Область Задача6

&НаКлиенте
Процедура Задача6(Команда)
	Задача6НаСервере();
КонецПроцедуры

&НаСервере
Процедура Задача6НаСервере()
	
	//1. Найти контрагента по ИНН
	КонтрагентСсылка = Справочники.Контрагенты.НайтиПоРеквизиту("ИНН", "123456789");
	
	Если КонтрагентСсылка.Пустая() Тогда
		Сообщить("Контрагент с ИНН 123456789 не найден в справочнике");
		Возврат;
	КонецЕсли; 
	
	//2. Получение объекта от ссылки
	КонтрагентОбъект = КонтрагентСсылка.ПолучитьОбъект();
	
	//3. очистка табличной части "Контактная информация"
	КонтрагентОбъект.КонтактнаяИнформация.Очистить();
	
	//4. Добавить строку в табличную часть контактная информация
	//юр. адрес
	//СтрокаЮрАдрес = КонтрагентОбъект.КонтактнаяИнформация.Найти(Справочники.ВидыКонтактнойИнформации.ЮридическийАдресКонтрагента, "Вид");
	//Если СтрокаЮрАдрес = Неопределено Тогда
		НоваяСтрока = КонтрагентОбъект.КонтактнаяИнформация.Добавить();
		НоваяСтрока.Тип = Перечисления.ТипыКонтактнойИнформации.Адрес;
		НоваяСтрока.Вид = Справочники.ВидыКонтактнойИнформации.ЮридическийАдресКонтрагента;
		НоваяСтрока.Значение = "125032, Москва, ул. Тверская, 13, оф. 405";

	//Иначе
	//	СтрокаЮрАдрес.Значение = "125032, Москва, ул. Тверская, 13, оф. 405";
	//КонецЕсли; 
	
	//почтовый адрес
	НоваяСтрока = КонтрагентОбъект.КонтактнаяИнформация.Добавить();
	НоваяСтрока.Тип = Перечисления.ТипыКонтактнойИнформации.Адрес;
	НоваяСтрока.Вид = Справочники.ВидыКонтактнойИнформации.ПочтовыйАдресКонтрагента;
	НоваяСтрока.Значение = "127051, Москва, Цветной бульвар, 18, оф. 14";
	
	//телефон
	НоваяСтрока = КонтрагентОбъект.КонтактнаяИнформация.Добавить();
	НоваяСтрока.Тип = Перечисления.ТипыКонтактнойИнформации.Телефон;
	НоваяСтрока.Вид = Справочники.ВидыКонтактнойИнформации.ТелефонКонтрагента;
	НоваяСтрока.Значение = "+7 (495) 778-71-74";
	
	//email
	НоваяСтрока = КонтрагентОбъект.КонтактнаяИнформация.Добавить();
	НоваяСтрока.Тип = Перечисления.ТипыКонтактнойИнформации.ЭлПочта;
	НоваяСтрока.Вид = Справочники.ВидыКонтактнойИнформации.EmailКонтрагента;
	НоваяСтрока.Значение = "info@raduga.ru";
	
	//5. Записать данные в базу
	КонтрагентОбъект.Записать();
	
КонецПроцедуры

#КонецОбласти  

#Область Задача7

&НаКлиенте
Процедура Задача7(Команда)
	Задача7НаСервере();
КонецПроцедуры

&НаСервере
Процедура Задача7НаСервере()
	
	//Сообщить("Версия текущей конфигурации: " + Метаданные.Версия);
	//Сообщить("Название конфигурации: " + Метаданные.Синоним);
	//Сообщить("Разработчик конфигурации: " + Метаданные.Поставщик);
	
	КоллекцияОбъектовМетаданныхСправочники = Метаданные.Справочники;
	
	Сообщить("Справочники текущей конфигурации:");
	Для каждого ОбъектМетаданных Из КоллекцияОбъектовМетаданныхСправочники Цикл
		Сообщить(ОбъектМетаданных.Имя + " (" + ОбъектМетаданных.Синоним + ")");
	КонецЦикла;
	
	//все реквизиты справочника "Контрагенты"
	ОбъектМетаданныхСправочник = Метаданные.Справочники.Контрагенты;
	
	Сообщить("Реквизиты справочника ""Контрагенты""");
	ОписанияРеквизитов = ОбъектМетаданныхСправочник.Реквизиты;
	Для каждого ОписаниеРеквизита Из ОписанияРеквизитов Цикл
		Сообщить("Имя реквизита: " + ОписаниеРеквизита.Имя + ", тип: " + ОписаниеРеквизита.Тип);
	КонецЦикла; 
	
КонецПроцедуры

#КонецОбласти 

#Область Задача8

&НаКлиенте
Процедура Задача8(Команда)
	Задача8НаСервере();
КонецПроцедуры

&НаСервере
Процедура Задача8НаСервере()
	
	НовыйТовар = Справочники.Номенклатура.СоздатьЭлемент();
	НовыйТовар.Наименование = "Гейзерная кофеварка Bialetti Moka Express";
	НовыйТовар.Артикул = "1241241";
	НовыйТовар.СтавкаНДС = Перечисления.СтавкиНДС.НДС20;
	НовыйТовар.НаименованиеПолное = НовыйТовар.Наименование;
	НовыйТовар.ЕдиницаИзмерения = Справочники.КлассификаторЕдиницИзмерения.шт;
	НовыйТовар.ВидНоменклатуры = Справочники.ВидыНоменклатуры.НайтиПоНаименованию("Кофеварки");
	
	//получение метаданных справочника "Номенклатура"
	МетаданныеСправочника = НовыйТовар.Метаданные();
	
	//получение описания реквизитов справочника "Номенклатура"
	РеквизитыСправочника = МетаданныеСправочника.Реквизиты;
	
	//проверка наличия в коллекции реквизитов реквизита с именем "АдресНаСайте"
	Если РеквизитыСправочника.Найти("АдресНаСайте") <> Неопределено Тогда
		НовыйТовар.АдресНаСайте = "https://catalog.onliner.by/teapot/bialetti/mokaexpress6";	
	КонецЕсли; 
	
	НовыйТовар.Записать();
	
КонецПроцедуры

#КонецОбласти

#Область Задача9

&НаКлиенте
Процедура Задача9(Команда)
	Задача9НаСервере();
КонецПроцедуры

&НаСервере
Процедура Задача9НаСервере()
	
	//1. получаем макет (ТекстовыйДокумент)
	Макет = РегистрыСведений.ПроизводственныйКалендарь.ПолучитьМакет("ДанныеКалендаря");
	
	//2. Получаем количество строк
	КоличествоСтрок = Макет.КоличествоСтрок();
	
	//3. Обходим все строки в цикле
	Для НомерСтроки=1 По КоличествоСтрок Цикл
		
		ТекущаяСтрока = Макет.ПолучитьСтроку(НомерСтроки);		
		ПозицияЗапятой = СтрНайти(ТекущаяСтрока, ",");
		Если ПозицияЗапятой = 0 Тогда
			Продолжить;		
		КонецЕсли; 
		
		//получаем из строки вид дня строкой и дата строкой
		ВидДняСтрокой = Лев(ТекущаяСтрока, ПозицияЗапятой - 1);
		ДатаСтрокой = Сред(ТекущаяСтрока, ПозицияЗапятой + 1);
		
		//добавляем запись в регистр сведений
		НоваяЗапись = РегистрыСведений.ПроизводственныйКалендарь.СоздатьМенеджерЗаписи();
		НоваяЗапись.Дата = Дата(ДатаСтрокой);
		//вариант 1
		НоваяЗапись.ВидДня = ПолучитьВидДняПоСтроке(ВидДняСтрокой);
		//вариант 2 (только если значение вида дня строкой совпадает со значением перечисления)
		//НоваяЗапись.ВидДня = Перечисления.ВидыДнейКалендаря[ВидДняСтрокой];
		
		НоваяЗапись.Записать();
		
	КонецЦикла; 
	
КонецПроцедуры

&НаСервере
Функция ПолучитьВидДняПоСтроке(ВидДняСтрокой)

	Если ВидДняСтрокой = "Рабочий" Тогда
		ВидДня = Перечисления.ВидыДнейКалендаря.Рабочий;
	ИначеЕсли ВидДняСтрокой = "Праздник" Тогда
		ВидДня = Перечисления.ВидыДнейКалендаря.Праздник;
	ИначеЕсли ВидДняСтрокой = "Предпраздничный" Тогда
		ВидДня = Перечисления.ВидыДнейКалендаря.Предпраздничный;
	ИначеЕсли ВидДняСтрокой = "Суббота" Тогда
		ВидДня = Перечисления.ВидыДнейКалендаря.Суббота;
	ИначеЕсли ВидДняСтрокой = "Воскресенье" Тогда
		ВидДня = Перечисления.ВидыДнейКалендаря.Воскресенье;
	Иначе
	   	ВидДня = Перечисления.ВидыДнейКалендаря.ПустаяСсылка();
	КонецЕсли; 

	Возврат ВидДня;
	
КонецФункции

&НаКлиенте
Процедура Задача10(Команда)
	Задача10НаСервере();
КонецПроцедуры

&НаСервере
Процедура Задача10НаСервере()
	
	//Найти в справочнике "Номенклатура" элемент с наименованием "Робот-пылесос Redmond RV-R650S WiFi" и сообщить значения всех реквизитов
	//(мы не знаем имена реквизитов)
	
	НайденныйТовар = Справочники.Номенклатура.НайтиПоНаименованию("Робот-пылесос Redmond RV-R650S WiFi");
	Если НайденныйТовар.Пустая() Тогда
		Сообщить("Товар с артикулом RV-R650S не найден");
		Возврат;
	КонецЕсли; 
	
	МетаданныеСправочника = НайденныйТовар.Метаданные();
	РеквизитыСправочника = МетаданныеСправочника.Реквизиты;
	Для каждого ТекРеквизит Из РеквизитыСправочника Цикл
		
		ИмяРеквизита = ТекРеквизит.Имя;
		ЗначениеРеквизита = НайденныйТовар[ИмяРеквизита];
		Сообщить(ИмяРеквизита + ":" + ЗначениеРеквизита);
		
	КонецЦикла; 
	
КонецПроцедуры

#КонецОбласти
