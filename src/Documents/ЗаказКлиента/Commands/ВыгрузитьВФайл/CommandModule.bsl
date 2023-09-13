
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	Проводник = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ЧтоДелатьПослеВыбора = Новый ОписаниеОповещения("ПослеВыбораКаталога", ЭтотОбъект, ПараметрКоманды);
	Проводник.Показать(ЧтоДелатьПослеВыбора);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораКаталога(ВыбранныеФайлы, МассивЗаказов) Экспорт
	
	Если ВыбранныеФайлы = Неопределено Тогда
		Возврат;
	КонецЕсли; 
	
	ПутьККаталогу = ВыбранныеФайлы[0];
	
	ДанныеЗаказов = ПолучитьДанныеЗаказовНаСервере(МассивЗаказов);
	
	Для каждого ИнформацияОЗаказе Из ДанныеЗаказов Цикл
		
		НовыйФайл = Новый ТекстовыйДокумент;
		
		Для каждого СтрокаТовара Из ИнформацияОЗаказе.Товары Цикл
			
			ТекСтрока = "" + СтрокаТовара.Наименование + ";" + Формат(СтрокаТовара.Количество, "ЧДЦ=2; ЧГ=0") + ";" + Формат(СтрокаТовара.Цена, "ЧДЦ=2; ЧГ=0");
			НовыйФайл.ДобавитьСтроку(ТекСтрока);	
			
		КонецЦикла; 
		
		ИмяФайла = "Заказ клиента № " + ИнформацияОЗаказе.Номер + " от " + Формат(ИнформацияОЗаказе.Дата, "ДФ=dd.MM.yyyy") + ".txt";
		
		НовыйФайл.Записать(ПутьККаталогу + "\" + ИмяФайла, КодировкаТекста.UTF8);
		
	КонецЦикла; 
	
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = "Выгрузка данных завершена!";
	Сообщение.Сообщить();

КонецПроцедуры // ПослеВыбораКаталога()

&НаСервере
Функция ПолучитьДанныеЗаказовНаСервере(МассивЗаказов)

	МассивРезультат = Новый Массив;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЗаказКлиента.Номер КАК Номер,
		|	ЗаказКлиента.Дата КАК Дата,
		|	ЗаказКлиента.Контрагент КАК Контрагент,
		|	ЗаказКлиента.Товары.(
		|		Номенклатура КАК Номенклатура,
		|		Количество КАК Количество,
		|		Цена КАК Цена,
		|		Номенклатура.Наименование КАК Наименование
		|	) КАК Товары
		|ИЗ
		|	Документ.ЗаказКлиента КАК ЗаказКлиента
		|ГДЕ
		|	ЗаказКлиента.Ссылка В(&МассивЗаказов)";
	
	Запрос.УстановитьПараметр("МассивЗаказов", МассивЗаказов);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		СтруктураЗаказа = Новый Структура;
		СтруктураЗаказа.Вставить("Номер", Выборка.Номер);
		СтруктураЗаказа.Вставить("Дата", Выборка.Дата);
		СтруктураЗаказа.Вставить("Контрагент", Выборка.Контрагент);
		
		МассивТоваров = Новый Массив;
		ВыборкаТовары = Выборка.Товары.Выбрать();
		Пока ВыборкаТовары.Следующий() Цикл
			
			СтруктуруТовара = Новый Структура;
			СтруктуруТовара.Вставить("Наименование", ВыборкаТовары.Наименование);
			СтруктуруТовара.Вставить("Количество", ВыборкаТовары.Количество);
			СтруктуруТовара.Вставить("Цена", ВыборкаТовары.Цена);
			
			МассивТоваров.Добавить(СтруктуруТовара);
			
		КонецЦикла;
		
		СтруктураЗаказа.Вставить("Товары", МассивТоваров);
		
		МассивРезультат.Добавить(СтруктураЗаказа);
		
	КонецЦикла;
	
	Возврат МассивРезультат;
	
КонецФункции
