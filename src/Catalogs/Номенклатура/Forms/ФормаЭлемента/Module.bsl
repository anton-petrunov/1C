
&НаКлиенте
Процедура ЗаполнитьПолноеНаименование(Команда)
	
	Если ПустаяСтрока(Объект.НаименованиеПолное) = Ложь Тогда
		
		ЧтоДелатьПослеОтветаНаВопрос = Новый ОписаниеОповещения("ПослеОтветаНаВопрос", ЭтотОбъект);
		
		ПоказатьВопрос(ЧтоДелатьПослеОтветаНаВопрос, "Текущее полное наименование будет замено. Продолжить?", РежимДиалогаВопрос.ДаНет);
		
	Иначе
		
		Объект.НаименованиеПолное = Объект.Наименование;
		
	КонецЕсли; 
		
КонецПроцедуры

&НаКлиенте
Процедура ПослеОтветаНаВопрос(РезультатВопроса, ДополнительныеПараметры) Экспорт

	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		Объект.НаименованиеПолное = Объект.Наименование;
	КонецЕсли; 

КонецПроцедуры // ПослеОтветаНаВопрос()


&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	
	Если ПустаяСтрока(Объект.НаименованиеПолное) Тогда
		Объект.НаименованиеПолное = Объект.Наименование;
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиНаСтраницуТовара(Команда)

	Если ПустаяСтрока(Объект.АдресНаСайте) Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Не указан адрес страницы товара!";
		Сообщение.Поле = "Объект.АдресНаСайте";
		Сообщение.Сообщить();
		Возврат;
		
	КонецЕсли;
		
	Попытка                                                                                		
		ПерейтиПоНавигационнойСсылке(Объект.АдресНаСайте);
	Исключение
		Сообщить("Не удалось открыть страницу товара. Возможно, указана некорректная ссылка");
	КонецПопытки;

КонецПроцедуры

&НаСервере
Процедура ПутьВКаталогеНаСервере()
	
	//1. Преобразование ДанныеФормыСтруктура -> СправочникОбъект.Контрагенты
	НоменклатураОбъект = РеквизитФормыВЗначение("Объект");
	
	//2. Вызов метода "ПолноеНаименование()" для объекта СправочникОбъект.Контрагенты
	ПутьВКаталоге = НоменклатураОбъект.ПолноеНаименование();
	
КонецПроцедуры

&НаКлиенте
Процедура ПутьВКаталоге(Команда)
	ПутьВКаталогеНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура АдресКартинкиНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Модифицированность = Истина;
	
	ПараметрыДиалога = Новый ПараметрыДиалогаПомещенияФайлов;
	ПараметрыДиалога.Заголовок = "Выберите изображение";
	ПараметрыДиалога.Фильтр = "Изображение | *.jpg; *.png;*.bmp;*.jpeg";
	
	ЧтоДелатьПослеВыбораФайла = Новый ОписаниеОповещения("ПослеВыбораКартинки", ЭтотОбъект);
	НачатьПомещениеФайлаНаСервер(ЧтоДелатьПослеВыбораФайла,,,,ПараметрыДиалога, УникальныйИдентификатор); 
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораКартинки(ОписаниеПомещенногоФайла, ДополнительныеПараметры) Экспорт

	Если ОписаниеПомещенногоФайла = Неопределено Тогда
		Возврат;	
	КонецЕсли; 
	
	АдресКартинки = ОписаниеПомещенногоФайла.Адрес;

КонецПроцедуры // ПослеВыбораКартинки()


&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если ЭтоАдресВременногоХранилища(АдресКартинки) Тогда
		ДанныеФайла = ПолучитьИзВременногоХранилища(АдресКартинки);
		ТекущийОбъект.Картинка = Новый ХранилищеЗначения(ДанныеФайла, Новый СжатиеДанных(9));
	ИначеЕсли ПустаяСтрока(АдресКартинки) = Истина Тогда
		ТекущийОбъект.Картинка = Неопределено;
	КонецЕсли; 
	
КонецПроцедуры


&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	АдресКартинки = ПолучитьНавигационнуюСсылку(ТекущийОбъект, "Картинка");
	
КонецПроцедуры


&НаКлиенте
Процедура ОчиститьКартинку(Команда)
	
	АдресКартинки = "";
	
КонецПроцедуры


&НаКлиенте
Процедура ВидНоменклатурыПриИзменении(Элемент)
	
	Объект.ТипНоменклатуры = ПолучитьТипНоменклатурыПоВиду(Объект.ВидНоменклатуры);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьТипНоменклатурыПоВиду(ВидНоменклатуры)

	Если ВидНоменклатуры.Пустая() Тогда
		Возврат Перечисления.ТипыНоменклатуры.ПустаяСсылка();
	КонецЕсли; 
	
	ВидНоменклатурыОбъект = ВидНоменклатуры.ПолучитьОбъект();
	Тип = ВидНоменклатурыОбъект.ТипНоменклатуры;
	
	Возврат Тип;

КонецФункции // ()

&НаКлиенте
Процедура НаименованиеАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	
	//Объект.НаименованиеПолное = Текст;
	
КонецПроцедуры


