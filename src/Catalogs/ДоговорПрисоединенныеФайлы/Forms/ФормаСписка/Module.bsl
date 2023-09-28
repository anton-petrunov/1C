
&НаКлиенте
Процедура ОткрытьФайл(Команда)
	
	СсылкаНаФайл = Элементы.Список.ТекущаяСтрока;
	Если СсылкаНаФайл = Неопределено Тогда
		Возврат;
	КонецЕсли; 
	
	ЧтоДелатьПослеПолученияКаталога = Новый ОписаниеОповещения("ПослеПолученияКаталогаВремФайлов", ЭтотОбъект, СсылкаНаФайл);
	НачатьПолучениеКаталогаВременныхФайлов(ЧтоДелатьПослеПолученияКаталога);
		
КонецПроцедуры

&НаКлиенте
Процедура ПослеПолученияКаталогаВремФайлов(ИмяКаталогаВременныхФайлов, ДополнительныеПараметры) Экспорт

	ДанныеФайлаСтруктура = ПолучитьДанныеФайла(ДополнительныеПараметры);

	ДанныеФайла = ПолучитьИзВременногоХранилища(ДанныеФайлаСтруктура.АдресДанных);
	Расширение = ДанныеФайлаСтруктура.Расширение;
	ИмяФайла = ИмяКаталогаВременныхФайлов + "demo" + Расширение;
	
	ДанныеФайла.Записать(ИмяФайла);
	
	ЧтоДелатьПослеЗапускаПриложения = Новый ОписаниеОповещения("ПослеОткрытияФайла", ЭтотОбъект);
	НачатьЗапускПриложения(ЧтоДелатьПослеЗапускаПриложения, ИмяФайла);

КонецПроцедуры // ()

&НаКлиенте
Процедура ПослеОткрытияФайла(КодВозврата, ДополнительныеПараметры) Экспорт

КонецПроцедуры // ПослеОткрытияФайла()

&НаСервереБезКонтекста
Функция ПолучитьДанныеФайла(СсылкаНаФайл)

	СтруктураВозврат = Новый Структура;
	
	ФайлОбъект = СсылкаНаФайл.ПолучитьОбъект();
	
	СтруктураВозврат.Вставить("ИмяФайла", ФайлОбъект.Наименование);
	СтруктураВозврат.Вставить("Расширение", ФайлОбъект.Расширение);
	
	ДвоичныеДанные = ФайлОбъект.ДанныеФайла.Получить();
	АдресДанных = ПоместитьВоВременноеХранилище(ДвоичныеДанные);
	
	СтруктураВозврат.Вставить("АдресДанных", АдресДанных);
	
	
	Возврат СтруктураВозврат;

КонецФункции // ПолучитьДанныеФайла()

&НаКлиенте
Процедура СохранитьФайл(Команда)
	
	СсылкаНаФайл = Элементы.Список.ТекущаяСтрока;
	
	Если СсылкаНаФайл = Неопределено Тогда
		Возврат;
	КонецЕсли; 

	ДанныеФайла = ПолучитьДанныеФайла(СсылкаНаФайл);
	
	ПараметрыДиалога = Новый ПараметрыДиалогаПолученияФайлов;
	ПараметрыДиалога.Заголовок = "Выберите каталог для сохранения файла";
	
	НачатьПолучениеФайлаССервера(ДанныеФайла.АдресДанных, ДанныеФайла.ИмяФайла, ПараметрыДиалога);
	
КонецПроцедуры

