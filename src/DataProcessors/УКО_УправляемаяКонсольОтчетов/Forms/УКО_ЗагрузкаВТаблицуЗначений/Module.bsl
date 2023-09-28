#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Элементы.ПримерExcel.Картинка = Элементы.БиблиотекаКартинокУКО_Excel.Картинка;
	
	Шаг = 1;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьЭлементыУправления();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПолноеИмяФайлаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла (РежимДиалогаВыбораФайла.Открытие);
	ДиалогВыбораФайла.Каталог = ПолноеИмяФайла;
	ДиалогВыбораФайла.ПолноеИмяФайла = ПолноеИмяФайла;
	ДиалогВыбораФайла.Фильтр = ФильтрЗагрузкиДанныхИзТабличногоДокумента();
	ДиалогВыбораФайла.Заголовок = НСтр("ru = 'Выбор файла'; en = 'Select file'");
	ДиалогВыбораФайла.МножественныйВыбор = Ложь;
	
	ДиалогВыбораФайла.Показать(Новый ОписаниеОповещения("ВыборФайлаЗакончен", ЭтотОбъект));
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПримерMXL(Команда)
	
	ПолучитьФайл(ПримерФайлаMXL(), НСтр("ru = 'Пример.mxl'; en = 'Sample.mxl'"));
	
КонецПроцедуры

&НаКлиенте
Процедура ПримерExcel(Команда)
	
	ПолучитьФайл(ПримерФайлаExcel(), НСтр("ru = 'Пример.xlsx'; en = 'Sample.xlsx'"));
	
КонецПроцедуры

&НаКлиенте
Процедура Назад(Команда)
	
	Шаг = Шаг - 1;
	ОбновитьЭлементыУправления()
	
КонецПроцедуры

&НаКлиенте
Процедура Далее(Команда)
	
	Если Шаг = 1 Тогда
		
		Если ЗначениеЗаполнено(ПолноеИмяФайла) Тогда 
			ЗагрузкаДанныхФайла();
		Иначе
			ТекстОшибки = НСтр("ru = 'Не выбран файл'; en = 'No file selected'");
		КонецЕсли;
		
		Если ЗначениеЗаполнено(ТекстОшибки) Тогда
			ПоказатьПредупреждение(,ТекстОшибки,,УКО_ОбщегоНазначенияКлиентСервер_ИмяРасширения());
			ТекущийЭлемент = Элементы.ПолноеИмяФайла;
			Возврат;
		КонецЕсли;
		
	КонецЕсли;
	
	Шаг = Шаг + 1;
	ОбновитьЭлементыУправления()
	
КонецПроцедуры

&НаКлиенте
Процедура Загрузить(Команда)
	
	Закрыть(ЗагрузкаДанныхСервер());
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьВсе(Команда)
	
	УстановитьВсеКолонки(Ложь);

КонецПроцедуры

&НаКлиенте
Процедура УстановитьВсе(Команда)
	
	УстановитьВсеКолонки();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ПримерФайлаMXL()
	
	ПримерФайлаДвоичныеДанные = ОбъектОбработки().ПолучитьМакет("УКО_ПримерФайлаMXLДляЗагрузкиВТаблицуЗначений_ru");
	Возврат ПоместитьВоВременноеХранилище(ПримерФайлаДвоичныеДанные);
	
КонецФункции

&НаСервере
Функция ПримерФайлаExcel()
	
	ПримерФайлаДвоичныеДанные = ОбъектОбработки().ПолучитьМакет("УКО_ПримерФайлаExcelДляЗагрузкиВТаблицуЗначений_ru");
	Возврат ПоместитьВоВременноеХранилище(ПримерФайлаДвоичныеДанные);
	
КонецФункции

&НаКлиенте
Функция ФильтрЗагрузкиДанныхИзТабличногоДокумента()
	
	ПоддерживаемыеФорматы = Новый СписокЗначений;
	ПоддерживаемыеФорматы.Добавить("*.mxl", НСтр("ru = 'Файлы табличных документов от 1С'; en = 'Files of tabular documents from 1C'"));
	ПоддерживаемыеФорматы.Добавить("*.xls; *.xlsx", НСтр("ru = 'Файлы Excel'; en = 'Files Excel'"));
	
	Возврат УКО_ОбщегоНазначенияКлиентСервер_ФильтрФайлов(ПоддерживаемыеФорматы);
	
КонецФункции

&НаКлиенте
Процедура ВыборФайлаЗакончен(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныеФайлы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПолноеИмяФайла = ВыбранныеФайлы[0];
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЭлементыУправления()
	
	ПоследнийШаг = 2;
	
	Если Шаг = 1 Тогда
		ЗаголовокШага = НСтр("ru = 'Выбор файла'; en = 'Select file'");
	ИначеЕсли Шаг = 2 Тогда
		ЗаголовокШага = НСтр("ru = 'Загрузка данных'; en = 'Data loading'");
	КонецЕсли;
	
	УКО_ФормыКлиентСервер_Заголовок(ЭтаФорма, СтрШаблон("Шаг %1/%2. %3 : %4",
												Шаг, ПоследнийШаг, ЗаголовокШага, НСтр("ru = 'Загрузка в таблицу значений'; en = 'Loading in the table of values'")));
	
	Элементы.ФормаНазад.Видимость = (Шаг > 1);
	Элементы.ФормаДалее.Видимость = (Шаг < ПоследнийШаг);
	Элементы.ФормаЗагрузить.Видимость = (Шаг = ПоследнийШаг);
	
	Элементы.ФормаДалее.КнопкаПоУмолчанию = (Шаг = 1);
	Элементы.ФормаЗагрузить.КнопкаПоУмолчанию = (Шаг = ПоследнийШаг);
	
	Элементы.СтраницаЗагрузкаФайла.Видимость = (Шаг = 1);
	Элементы.СтраницаЗагрузкаДанных.Видимость = (Шаг = 2);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузкаДанныхФайла()
	
	ДвоичныеДанныеФайла = Новый ДвоичныеДанные(ПолноеИмяФайла);
	АдресФайла = УКО_ВременноеХранилищеВызовСервера_Поместить(ДвоичныеДанныеФайла, АдресФайла, УникальныйИдентификатор);
	
	ЗагрузкаДанныхКолонокСервер()

КонецПроцедуры

&НаСервере
Процедура ЗагрузкаДанныхКолонокСервер()
	
	ТабличныйДокумент = ТабличныйДокументФайла();
	
	КолонкиФайла.Очистить();
	
	// Считываем колонки
	НомерНекорректногоИдентификатора = 1;
	Для НомерКолонки = 1 По ТабличныйДокумент.ШиринаТаблицы Цикл 
		
		Область = ТабличныйДокумент.Область(1, НомерКолонки);
		ИмяКолонки = Область.Текст;
		
		Если ЗначениеЗаполнено(ИмяКолонки) Тогда
			
			НоваяКолонка = КолонкиФайла.Добавить();
			
			Если УКО_СтрокиКлиентСервер_ЭтоКорректныйИдентификатор(ИмяКолонки) Тогда
				НоваяКолонка.Идентификатор = ИмяКолонки;
			Иначе
				НоваяКолонка.Идентификатор = СтрШаблон(НСтр("ru = 'НекорректныйИдентификатор%1'; en = 'InvalidID%1'"), НомерНекорректногоИдентификатора);
				НомерНекорректногоИдентификатора = НомерНекорректногоИдентификатора + 1;
			КонецЕсли;
			
			НоваяКолонка.Загружать = Истина;
			НоваяКолонка.НомерКолонки = НомерКолонки;
			
		КонецЕсли;
		
	КонецЦикла;

КонецПроцедуры

&НаСервере
Функция ТабличныйДокументФайла()
	
	Файл = Новый Файл(ПолноеИмяФайла);
	Расширение = ВРег(Файл.Расширение);
	
	ДвоичныеДанныеФайла = ПолучитьИзВременногоХранилища(АдресФайла);
	
	ТабличныйДокумент = Новый ТабличныйДокумент;
	ТипФайлаТаблицы = Неопределено;
	
	ЧтениеПотоком = Ложь;
	Если Расширение = ".MXL" Тогда
		ЧтениеПотоком = Истина;
		ТипФайлаТаблицы = ТипФайлаТабличногоДокумента.MXL;
	ИначеЕсли Расширение = ".XLS" Тогда
		ТипФайлаТаблицы = ТипФайлаТабличногоДокумента.XLS;
	ИначеЕсли Расширение = ".XLSX" Тогда
		ТипФайлаТаблицы = ТипФайлаТабличногоДокумента.XLSX;
	КонецЕсли;
	
	Если ЧтениеПотоком Тогда
		
		ОбъектЧтения = ДвоичныеДанныеФайла.ОткрытьПотокДляЧтения();
		
	Иначе 
		
		ПолноеИмяФайлаВременногоФайла = ПолучитьИмяВременногоФайла(Расширение);
		ДвоичныеДанныеФайла.Записать(ПолноеИмяФайлаВременногоФайла);
		
		ОбъектЧтения = ПолноеИмяФайлаВременногоФайла;
		
	КонецЕсли;
	
	ТабличныйДокумент.Прочитать(ОбъектЧтения, СпособЧтенияЗначенийТабличногоДокумента.Значение, ТипФайлаТаблицы);
	
	Если Не ЧтениеПотоком Тогда
		УдалитьФайлы(ПолноеИмяФайлаВременногоФайла);
	КонецЕсли;
	
	Возврат ТабличныйДокумент;
	
КонецФункции

&НаСервере
Функция ЗагрузкаДанныхСервер()
	
	Результат = Новый ТаблицаЗначений;
	ТабличныйДокумент = ТабличныйДокументФайла();
	
	// Загрузка колонок
	ЗагружаемыеКолонки = Новый ТаблицаЗначений;
	ЗагружаемыеКолонки.Колонки.Добавить("Идентификатор", УКО_ОбщегоНазначенияКлиентСервер_ОписаниеТиповСтрока());
	ЗагружаемыеКолонки.Колонки.Добавить("Номер", УКО_ОбщегоНазначенияКлиентСервер_ОписаниеТиповЧисло(10));
	ЗагружаемыеКолонки.Колонки.Добавить("Типы");
	ЗагружаемыеКолонки.Колонки.Добавить("МаксимальнаяДлинаСтроки", УКО_ОбщегоНазначенияКлиентСервер_ОписаниеТиповЧисло(10));
	
	Для Каждого Колонка Из КолонкиФайла Цикл 
		
		Если Не Колонка.Загружать Тогда
			Продолжить;
		КонецЕсли;
		
		ЗагружаемаяКолонка = ЗагружаемыеКолонки.Добавить();
		ЗагружаемаяКолонка.Идентификатор = Колонка.Идентификатор;
		ЗагружаемаяКолонка.Номер = Колонка.НомерКолонки;
		ЗагружаемаяКолонка.Типы = Новый Соответствие;
		
		Результат.Колонки.Добавить(Колонка.Идентификатор, Новый ОписаниеТипов);
		
	КонецЦикла;
	
	// Загрузка строк
	Для НомерСтроки = 2 По ТабличныйДокумент.ВысотаТаблицы Цикл 
			
		НоваяСтрока = Результат.Добавить();
		
		Для Каждого ЗагружаемаяКолонка Из ЗагружаемыеКолонки Цикл 
			
			Область = ТабличныйДокумент.Область(НомерСтроки, ЗагружаемаяКолонка.Номер);
			Если Область.Расшифровка = Неопределено Тогда
				ЗначениеЯчейки = Область.Текст;
			Иначе
				ЗначениеЯчейки = Область.Расшифровка;
			КонецЕсли;
			
			ТипЗначенияЯчейки = ТипЗнч(ЗначениеЯчейки);
			
			НоваяСтрока[ЗагружаемаяКолонка.Идентификатор] = ЗначениеЯчейки;
			ЗагружаемаяКолонка.Типы.Вставить(ТипЗначенияЯчейки, Истина);
			
			Если ТипЗначенияЯчейки = Тип("Строка") Тогда
				ЗагружаемаяКолонка.МаксимальнаяДлинаСтроки = Макс(ЗагружаемаяКолонка.МаксимальнаяДлинаСтроки, СтрДлина(ЗначениеЯчейки));
			КонецЕсли;
			
		КонецЦикла;
				
	КонецЦикла;
	
	// Получение результата
	Для Каждого ЗагружаемаяКолонка Из ЗагружаемыеКолонки Цикл 
		
		ИмяКолонки = ЗагружаемаяКолонка.Идентификатор;
		
		ТипыКолонки = Новый Массив;
		Для Каждого ЭлементТип Из ЗагружаемаяКолонка.Типы Цикл 
			ТипыКолонки.Добавить(ЭлементТип.Ключ);
		КонецЦикла;
		КвалификаторыСтроки = Новый КвалификаторыСтроки(ЗагружаемаяКолонка.МаксимальнаяДлинаСтроки);
		ОписаниеТипов = Новый ОписаниеТипов(ТипыКолонки,,КвалификаторыСтроки);
		
		ИмяКолонкиВременной = ИмяКолонки + "ВременнаяКолонка";
		
		Результат.Колонки.Добавить(ИмяКолонкиВременной, ОписаниеТипов);
		Результат.ЗагрузитьКолонку(Результат.ВыгрузитьКолонку(ИмяКолонки), ИмяКолонкиВременной);
		
		Результат.Колонки.Удалить(ИмяКолонки);
		Результат.Колонки[ИмяКолонкиВременной].Имя = ИмяКолонки;
		
	КонецЦикла;
	
	Возврат ПоместитьВоВременноеХранилище(Результат);
	
КонецФункции

&НаКлиенте
Функция УстановитьВсеКолонки(Загружать = Истина)
	
	Для Каждого СтрокаКолонка Из КолонкиФайла Цикл 
		СтрокаКолонка.Загружать = Загружать;
	КонецЦикла;
	
КонецФункции

#КонецОбласти


&НаСервере
Функция ОбъектОбработки()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции
&НаСервере
// Помещает значение во временное хранилище
//
// Параметры:
//  Значение  - Произвольный - Произвольное значение
//  Адрес  - Строка - Адрес во временном хранилище
//  УникальныйИдентификатор  - УникальныйИдентификатор - Уникальный идентификатор
//
// Возвращаемое значение:
//   Строка - Адрес во временном хранилище
//
Функция УКО_ВременноеХранилищеВызовСервера_Поместить(Значение, Адрес = Неопределено, УникальныйИдентификатор = Неопределено) Экспорт
	
	Возврат ОбъектОбработки().УКО_ВременноеХранилище_Поместить(Значение, Адрес, УникальныйИдентификатор);
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Проверяет является ли строка корректным идентификатором, строка вида СуммаКонтрагента, _Идентификатор
//
// Параметры:
//   Строка - Строка - Проверяемая строка
//
// Возвращаемое значение:
//   Булево - Истина, идентификатор корректный
//
Функция УКО_СтрокиКлиентСервер_ЭтоКорректныйИдентификатор(Строка) Экспорт
	
	ПервыйСимволСимволы = УКО_СтрокиКлиентСервер_НаборСимволовРусскиеЛатинскиеБуквы() + "_";
	ПоследующиеСимволы = УКО_СтрокиКлиентСервер_НаборСимволовРусскиеЛатинскиеБуквы() + УКО_СтрокиКлиентСервер_НаборСимволовЦифры() + "_";
	 
	Если ПустаяСтрока(Строка) ИЛИ Не СтрНайти(ПервыйСимволСимволы, Лев(Строка, 1)) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Для Сч = 2 По СтрДлина(Строка) Цикл 
		
		Символ = Сред(Строка, Сч, 1);
		
		Если Не СтрНайти(ПоследующиеСимволы, Символ) Тогда
			Возврат Ложь;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает имя расширения
// Возвращаемое значение:
//   Строка	- Имя расширения
Функция УКО_ОбщегоНазначенияКлиентСервер_ИмяРасширения() Экспорт 
	
	Возврат НСтр("ru = 'Управляемая консоль отчетов'; en = 'Managed reporting console'");
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает Описание типов строка)
// Параметры:
//   ДлинаСтроки - Число - Длина строки
// Возвращаемое значение:
//   ОписаниеТипов - Описание типов строка
Функция УКО_ОбщегоНазначенияКлиентСервер_ОписаниеТиповСтрока(ДлинаСтроки = 0) Экспорт
	
	Возврат Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(ДлинаСтроки));
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает Описание типов Число
// Параметры:
//   ЧислоРазрядов - Число - Число разрядов
//   ЧислоРазрядовДробнойЧасти - Число - Число разрядов дробной части
// Возвращаемое значение:
//   ОписаниеТипов - Описание типов Число
Функция УКО_ОбщегоНазначенияКлиентСервер_ОписаниеТиповЧисло(ЧислоРазрядов = 0, ЧислоРазрядовДробнойЧасти = 0) Экспорт
	
	Возврат Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(ЧислоРазрядов, ЧислоРазрядовДробнойЧасти));
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает набор символов букв русского и английского языков
// Возвращаемое значение:
//   Строка - Набор символов букв
Функция УКО_СтрокиКлиентСервер_НаборСимволовРусскиеЛатинскиеБуквы()
	
	НаборСимволовРусскиеБуквы = "ЙЦУКЕ" + Символ(1025) + "НГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ"; //1025 - Код символа буквы ежик, елка
	НаборСимволовРусскиеБуквы = НаборСимволовРусскиеБуквы + НРег(НаборСимволовРусскиеБуквы);
	
	Возврат НаборСимволовРусскиеБуквы + УКО_СтрокиКлиентСервер_НаборСимволовЛатинскиеБуквы();
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает строку фильтра для диалога выбора файла
//
// Параметры:
//   ПоддерживаемыеФорматы - СписокЗначений - Формат (Представление..., Значение - Расширение)
//   ВключаяВсеФайлы - Булево - Включать все файлы
//
// Возвращаемое значение:
//   Строку - Фильтр для диалога выбора файла
//
Функция УКО_ОбщегоНазначенияКлиентСервер_ФильтрФайлов(ПоддерживаемыеФорматы, ВключаяВсеФайлы = Истина) Экспорт
	
	Фильтры = Новый Массив;
	
	Если ПоддерживаемыеФорматы.Количество() > 1 Тогда
		Фильтры.Добавить(УКО_ОбщегоНазначенияКлиентСервер_СтрокаФильтраФайлов(НСтр("ru = 'Все поддерживаемые форматы'; en = 'All supported format'"), СтрСоединить(ПоддерживаемыеФорматы.ВыгрузитьЗначения(), ";")));
	КонецЕсли;
	
	Для Каждого ПоддерживаемыйФормат Из ПоддерживаемыеФорматы Цикл 
		Фильтры.Добавить(УКО_ОбщегоНазначенияКлиентСервер_СтрокаФильтраФайлов(ПоддерживаемыйФормат.Представление, ПоддерживаемыйФормат.Значение));
	КонецЦикла;

	Если ВключаяВсеФайлы Тогда
		Фильтры.Добавить(УКО_ОбщегоНазначенияКлиентСервер_СтрокаФильтраФайлов(НСтр("ru = 'Все файлы'; en = 'All files'"), ПолучитьМаскуВсеФайлы()));
	КонецЕсли;
	
	Возврат СтрСоединить(Фильтры, "|");
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста

Функция УКО_ОбщегоНазначенияКлиентСервер_СтрокаФильтраФайлов(Представление, Расширение)
	
	Возврат СтрШаблон("%1 (%2)|%2", Представление, Расширение);
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста

Функция УКО_СтрокиКлиентСервер_НаборСимволовЛатинскиеБуквы()
	
	НаборСимволов = "QWERTYUIOPASDFGHJKLZXCVBNM";
	Возврат НаборСимволов + НРег(НаборСимволов);
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста

Функция УКО_СтрокиКлиентСервер_НаборСимволовЦифры()
	
	Возврат "0123456789";
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Обновляет заголовок формы
//
// Параметры:
//  Форма - Форма - Форма
//  Заголовок - Строка - Заголовок формы
//  Дополнение - Булево - Дополнять заголовок названием расширения
//
Процедура УКО_ФормыКлиентСервер_Заголовок(Форма, Заголовок, Дополнение = Ложь) Экспорт
	
	НовыйЗаголовок = Заголовок;
	
	Если Дополнение Тогда
		НовыйЗаголовок = НовыйЗаголовок + " : " + УКО_ОбщегоНазначенияКлиентСервер_ИмяРасширения();
	КонецЕсли;
	
	Форма.Заголовок = НовыйЗаголовок;
	
КонецПроцедуры
