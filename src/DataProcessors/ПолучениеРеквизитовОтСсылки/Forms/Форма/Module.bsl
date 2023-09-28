
&НаКлиенте
Процедура ПолучитьИНН(Команда)

	ИНН = ПолучитьИНННаСервере(Объект.Контрагент);
	
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = ИНН;
	Сообщение.Сообщить();
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьИНННаСервере(Контрагент)

	//1. пример получения реквизита по ссылке
	ИНН = Контрагент.ИНН;//вот тут выполняется запрос, который получает ВСЕ данные контрагента
	//Наименование = Контрагент.Наименование;
	//Код = Контрагент.Код;
	
	//2. пример получения реквизита по объекту
	КонтрагентОбъект = Контрагент.ПолучитьОбъект();
	ИНН = КонтрагентОбъект.ИНН;
	
	//3. запрос (только нужные данные)
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Контрагенты.ИНН КАК ИНН
		|ИЗ
		|	Справочник.Контрагенты КАК Контрагенты
		|ГДЕ
		|	Контрагенты.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", Контрагент);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	
	ИНН = Выборка.ИНН;
	
	
	Возврат ИНН;

КонецФункции
