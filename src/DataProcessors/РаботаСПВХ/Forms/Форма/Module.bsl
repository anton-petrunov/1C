
&НаСервере
Процедура СоздатьЭлементНаСервере()
	
	//НовыйДопРеквизит = ПланыВидовХарактеристик.ДополнительныеРеквизиты.СоздатьЭлемент();
	//НовыйДопРеквизит.Наименование = "Код ИМНС";
	//НовыйДопРеквизит.ТипЗначения = Новый ОписаниеТипов("Строка");
	//НовыйДопРеквизит.Записать();
	
	НовыйДопРеквизит = ПланыВидовХарактеристик.ДополнительныеРеквизиты.СоздатьЭлемент();
	НовыйДопРеквизит.Наименование = "Код ИМНС";
	НовыйДопРеквизит.ТипЗначения = Новый ОписаниеТипов("СправочникСсылка.Сотрудники");
	НовыйДопРеквизит.Записать();
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьЭлемент(Команда)
	СоздатьЭлементНаСервере();
КонецПроцедуры

&НаСервере
Процедура СоздатьГруппуНаСервере()
	
	НоваяГруппа = ПланыВидовХарактеристик.ДополнительныеРеквизиты.СоздатьГруппу();
	НоваяГруппа.Наименование = "Справочник ""Контактные лица""";
	НоваяГруппа.Записать();
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьГруппу(Команда)
	СоздатьГруппуНаСервере();
КонецПроцедуры

&НаСервере
Процедура СоздатьЭлементВГруппеНаСервере()
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура СоздатьЭлементВГруппе(Команда)
	СоздатьЭлементВГруппеНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПоискЭлементаНаСервере()
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ПоискЭлемента(Команда)
	ПоискЭлементаНаСервере();
КонецПроцедуры

&НаСервере
Процедура ИзменитьЭлементНаСервере()
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьЭлемент(Команда)
	ИзменитьЭлементНаСервере();
КонецПроцедуры

&НаСервере
Процедура УдалитьЭлементНаСервере()
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура УдалитьЭлемент(Команда)
	УдалитьЭлементНаСервере();
КонецПроцедуры

&НаСервере
Процедура ВыбратьЭлементыНаСервере()
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьЭлементы(Команда)
	ВыбратьЭлементыНаСервере();
КонецПроцедуры
