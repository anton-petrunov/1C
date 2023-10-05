
Процедура ПечатьЗаказа(ТабДок, Ссылка) Экспорт
	//{{_КОНСТРУКТОР_ПЕЧАТИ(ПечатьЗаказа)
	Макет = Документы.ЗаказКлиента.ПолучитьМакет("ПечатьЗаказа");
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ЗаказКлиента.Дата,
	|	ЗаказКлиента.Договор,
	|	ЗаказКлиента.Контрагент,
	|	ЗаказКлиента.Номер,
	|	ЗаказКлиента.Организация,
	|	ЗаказКлиента.Ответственный,
	|	ЗаказКлиента.Товары.(
	|		НомерСтроки,
	|		Номенклатура,
	|		Количество,
	|		ЕдиницаИзмерения,
	|		Цена,
	|		СтавкаНДС,
	|		Сумма,
	|		СуммаНДС,
	|		СуммаВсего,
	|		Резерв
	|	)
	|ИЗ
	|	Документ.ЗаказКлиента КАК ЗаказКлиента
	|ГДЕ
	|	ЗаказКлиента.Ссылка В (&Ссылка)";
	Запрос.Параметры.Вставить("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();

	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	Шапка = Макет.ПолучитьОбласть("Шапка");
	ОбластьТоварыШапка = Макет.ПолучитьОбласть("ТоварыШапка");
	ОбластьТовары = Макет.ПолучитьОбласть("Товары");
	Подвал = Макет.ПолучитьОбласть("Подвал");

	ТабДок.Очистить();

	ВставлятьРазделительСтраниц = Ложь;
	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;

		ТабДок.Вывести(ОбластьЗаголовок);

		Шапка.Параметры.Заполнить(Выборка);
		ТабДок.Вывести(Шапка, Выборка.Уровень());

		ТабДок.Вывести(ОбластьТоварыШапка);
		ВыборкаТовары = Выборка.Товары.Выбрать();
		Пока ВыборкаТовары.Следующий() Цикл
			ОбластьТовары.Параметры.Заполнить(ВыборкаТовары);
			ТабДок.Вывести(ОбластьТовары, ВыборкаТовары.Уровень());
		КонецЦикла;

		Подвал.Параметры.Заполнить(Выборка);
		ТабДок.Вывести(Подвал);

		ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;
	//}}
КонецПроцедуры

Процедура ПечатьСчетаНаОплату(ТабДок, МассивДокументов, ВыводитьПечать=Ложь) Экспорт

	//2. Получить макет печатной формы
	Макет = Документы.ЗаказКлиента.ПолучитьМакет("ПФ_MXL_СчетНаОплату");

	//получение данных документов
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЗаказКлиента.Номер КАК Номер,
		|	ЗаказКлиента.Дата КАК Дата,
		|	ЗаказКлиента.Организация КАК Организация,
		|	ЗаказКлиента.Организация.ОсновнойБанковскийСчет.Банк КАК Банк,
		|	ЗаказКлиента.Организация.ОсновнойБанковскийСчет.НомерСчета КАК НомерСчетаОрганизации,
		|	ЗаказКлиента.Организация.ОсновнойБанковскийСчет.Банк.Код КАК КодБанка,
		|	ЗаказКлиента.Договор.Номер КАК НомерДоговора,
		|	ЗаказКлиента.Договор.ДатаДоговора КАК ДатаДоговора,
		|	ЗаказКлиента.Организация.Руководитель КАК Руководитель,
		|	ЗаказКлиента.Товары.(
		|		НомерСтроки КАК НомерСтроки,
		|		Номенклатура КАК Номенклатура,
		|		Количество КАК Количество,
		|		ЕдиницаИзмерения КАК ЕдиницаИзмерения,
		|		Цена КАК Цена,
		|		СтавкаНДС КАК СтавкаНДС,
		|		Сумма КАК Сумма,
		|		СуммаНДС КАК СуммаНДС,
		|		СуммаВсего КАК СуммаВсего
		|	) КАК Товары,
		|	ЗаказКлиента.Организация.ИНН КАК УНП,
		|	ЗаказКлиента.Контрагент КАК Контрагент,
		|	ЗаказКлиента.Контрагент.ИНН КАК КонтрагентИНН,
		|	ЕСТЬNULL(ОрганизацииКонтактнаяИнформация.Значение, """") КАК ЮрАдресОрганизации,
		|	ЕСТЬNULL(КонтрагентыКонтактнаяИнформация.Значение, """") КАК ЮрАдресКонтрагента,
		|	ЗаказКлиента.Организация.Логотип КАК Логотип,
		|	ЗаказКлиента.Организация.Печать КАК ПечатьОрганизации,
		|	ЕСТЬNULL(ЗаказКлиента.Организация.Руководитель.Подпись, НЕОПРЕДЕЛЕНО) КАК ПодписьРуководителя
		|ИЗ
		|	Документ.ЗаказКлиента КАК ЗаказКлиента
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Организации.КонтактнаяИнформация КАК ОрганизацииКонтактнаяИнформация
		|		ПО ЗаказКлиента.Организация = ОрганизацииКонтактнаяИнформация.Ссылка
		|			И (ОрганизацииКонтактнаяИнформация.Вид = &ВидКИ_ЮрАдресОрганизации)
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Контрагенты.КонтактнаяИнформация КАК КонтрагентыКонтактнаяИнформация
		|		ПО ЗаказКлиента.Контрагент = КонтрагентыКонтактнаяИнформация.Ссылка
		|			И (КонтрагентыКонтактнаяИнформация.Вид = &ВидКИ_ЮрАдресКонтрагента)
		|ГДЕ
		|	ЗаказКлиента.Ссылка В(&МассивДокументов)";
	
	Запрос.УстановитьПараметр("МассивДокументов", МассивДокументов);
	Запрос.УстановитьПараметр("ВидКИ_ЮрАдресОрганизации", Справочники.ВидыКонтактнойИнформации.ЮридическийАдресОрганизации);
	Запрос.УстановитьПараметр("ВидКИ_ЮрАдресКонтрагента", Справочники.ВидыКонтактнойИнформации.ЮридическийАдресКонтрагента);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	ПервыйДокумент = Истина;
	
	Пока Выборка.Следующий() Цикл
		
		Если ПервыйДокумент Тогда
			ПервыйДокумент = Ложь;
		Иначе
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();	
		КонецЕсли; 
		
		//Получить область из макета
		Область = Макет.ПолучитьОбласть("Шапка");
		
		ХранилищеЛоготипа = Выборка.Логотип;
		ДвоичныеДанныеЛоготипа = ХранилищеЛоготипа.Получить();
		
		Если ДвоичныеДанныеЛоготипа <> Неопределено Тогда
			//вывод логотипа
			Область.Рисунки.Логотип.Картинка = Новый Картинка(ДвоичныеДанныеЛоготипа);
		КонецЕсли; 	
		
		//Заполнить параметры области (если они есть)
		СтруктураЗначений = Новый Структура;
		СтруктураЗначений.Вставить("ПредставлениеОрганизации", "" + Выборка.Организация + ", УНП " + Выборка.УНП + ", " + Выборка.ЮрАдресОрганизации);
		СтруктураЗначений.Вставить("ПредставлениеКонтрагента", "" + Выборка.Контрагент + ", УНП " + Выборка.КонтрагентИНН + ", " + Выборка.ЮрАдресКонтрагента);
		
		Область.Параметры.Заполнить(Выборка);
		Область.Параметры.Заполнить(СтруктураЗначений);
		
		//Вывести область в табличный документ
		ТабДок.Вывести(Область);
		
		Область = Макет.ПолучитьОбласть("ШапкаТаблицы");
		ТабДок.Вывести(Область);
		
		СтруктураИтогов = Новый Структура("ИтогСумма, ИтогСуммаНДС, ИтогСуммаВсего, ИтогСуммаВсегоПрописью", 0, 0, 0);
		
		ВысотаТаблицыДо = ТабДок.ВысотаТаблицы;
		
		КоличествоСтрок = 0;
		ВыборкаТовары = Выборка.Товары.Выбрать();
		Пока ВыборкаТовары.Следующий() Цикл
			
			Область = Макет.ПолучитьОбласть("СтрокаТаблицы");			
			Область.Параметры.Заполнить(ВыборкаТовары);
						
			ТабДок.Вывести(Область);
			
			СтруктураИтогов.ИтогСумма = СтруктураИтогов.ИтогСумма + ВыборкаТовары.Сумма;
			СтруктураИтогов.ИтогСуммаНДС = СтруктураИтогов.ИтогСуммаНДС + ВыборкаТовары.СуммаНДС;
			СтруктураИтогов.ИтогСуммаВсего = СтруктураИтогов.ИтогСуммаВсего + ВыборкаТовары.СуммаВсего;
			
			КоличествоСтрок = КоличествоСтрок + 1;
			
		КонецЦикла;
		
		ПараметрыПрописи = "рубль, рубля, рублей, м, копейка, копейки, копеек, ж, 2";
		СтруктураИтогов.ИтогСуммаВсегоПрописью = ЧислоПрописью(СтруктураИтогов.ИтогСуммаВсего, "ДП=Истина", ПараметрыПрописи); 
		
		Область = Макет.ПолучитьОбласть("Подвал");
		Область.Параметры.Заполнить(СтруктураИтогов);
		ТабДок.Вывести(Область);

		
		Если ВыводитьПечать Тогда
			
			БезЛинии = Новый Линия(ТипЛинииРисункаТабличногоДокумента.НетЛинии);
			
			Область = Макет.ПолучитьОбласть("ПодписьФаксимиле");
			Область.Параметры.Заполнить(СтруктураИтогов);
						
			//вывод подписи руководителя
			ХранилищеПодписи = Выборка.ПодписьРуководителя;
			Если ХранилищеПодписи <> Неопределено Тогда
				
				ДвоичныеДанныеПодписи = ХранилищеПодписи.Получить();
				
				Если ДвоичныеДанныеПодписи <> Неопределено Тогда
					//вывод подпись руководителя
					Область.Рисунки.ПодписьРуководителя.Картинка = Новый Картинка(ДвоичныеДанныеПодписи);
					Область.Рисунки.ПодписьРуководителя.Линия = БезЛинии;
				КонецЕсли;
			
			КонецЕсли; 
			
			//вывод печати организации
			ХранилищеПечати = Выборка.ПечатьОрганизации;
			ДвоичныеДанныеПечати = ХранилищеПечати.Получить();
			
			Если ДвоичныеДанныеПечати <> Неопределено Тогда
				//вывод подпись руководителя
				Область.Рисунки.ПечатьОрганизации.Картинка = Новый Картинка(ДвоичныеДанныеПечати);
				Область.Рисунки.ПечатьОрганизации.Линия = БезЛинии;
			КонецЕсли; 
			
			ТабДок.Вывести(Область);
			
		Иначе
			Область = Макет.ПолучитьОбласть("Подписи");
			Область.Параметры.Заполнить(Выборка);
			ТабДок.Вывести(Область);
		КонецЕсли; 
				
	КонецЦикла;

КонецПроцедуры
