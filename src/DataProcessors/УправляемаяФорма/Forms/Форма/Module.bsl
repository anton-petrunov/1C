
&НаКлиенте
Процедура ИзменитьЗаголовок(Команда)
	
	Заголовок = "Первая форма";
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьВысоту(Команда)
	Высота = 2;
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьШирину(Команда)
	Ширина = 5;
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьВсеЭлементы(Команда)
	
	Для каждого ТекущийЭлемент Из Элементы Цикл
		Сообщить(ТекущийЭлемент.Имя);
	КонецЦикла; 
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьВидимостьВидаКонтрагентов(Команда)
	
	Элементы.ВидыКонтрагентов.Видимость = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьВидимостьВидаконтрагентов(Команда)
	Элементы.ВидыКонтрагентов.Видимость = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПревратитьВГиперссылку(Команда)
	
	Элементы.ПоказатьВидимостьВидаконтрагентов.Вид = ВидКнопкиФормы.Гиперссылка;
	
КонецПроцедуры

&НаКлиенте
Процедура ВидДействияПриИзменении(Элемент)
	
	Если ВидДействия = "Включить" Тогда
		Элементы.ВидыКонтрагентов.Видимость = Истина;	
	Иначе
		Элементы.ВидыКонтрагентов.Видимость = Ложь;	
	КонецЕсли; 
	
	//способ № 2
	//Элементы.ВидыКонтрагентов.Видимость = (ВидДействия = "Включить");
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьНаименование(Команда)
	
	//правильно:
	Наименование = "Произвольное наименование";
	
	//неправильно:
	//Элементы.Наименование = "Произвольное наименование";
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиНоменклатуру(Команда)
	
	Номенклатура = ПолучитьНоменклатуруПоКоду(КодНоменклатуры);
	
КонецПроцедуры

&НаСервере
Функция ПолучитьНоменклатуруПоКоду(Код)
	
	СсылкаНаТовар = Справочники.Номенклатура.НайтиПоКоду(Код);
	Возврат СсылкаНаТовар;
	
КонецФункции

&НаКлиенте
Процедура Директива_НаКлиенте(Команда)
	
	Ответ = Вопрос("Сегодня рабочий день?", РежимДиалогаВопрос.ДаНет);
	Если Ответ = КодВозвратаДиалога.Да Тогда
		Сообщить("Отличного рабочего дня!");
	Иначе
		Сообщить("Хороших выходных!");
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура Директива_НаСервере(Команда)
	Директива_НаСервереНаСервере();
КонецПроцедуры

&НаСервере
Процедура Директива_НаСервереНаСервере()
	
	ВидыКонтрагентов = Перечисления.ВидыКонтрагентов.ИндивидуальныйПредприниматель;
	
	Элементы.ВидыКонтрагентов.ЦветФона = Новый Цвет(255, 255,0);
	
КонецПроцедуры

&НаКлиенте
Процедура Директива_НаСервереБезКонтекста(Команда)
	
	ВидыКонтрагентов = Директива_НаСервереБезКонтекстаНаСервере();
	Элементы.ВидыКонтрагентов.ЦветФона = Новый Цвет(255, 255,0);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция Директива_НаСервереБезКонтекстаНаСервере()
	
	ВидыКонтрагентов = Перечисления.ВидыКонтрагентов.ИндивидуальныйПредприниматель;
	
	Возврат ВидыКонтрагентов;
	
КонецФункции

&НаКлиенте
Процедура ТекДата(Команда)
	Сообщить(ТекущаяДата());
КонецПроцедуры

&НаКлиенте
Процедура Директива_НаСервереБезКонтекстаСПараметрами(Команда)
	
	Артикул = ПолучитьАртикулНоменклатуры(Номенклатура);
	Сообщить(Артикул);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьАртикулНоменклатуры(СсылкаНаНоменклатуру)
	
	Возврат СсылкаНаНоменклатуру.Артикул;
	
КонецФункции

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Элементы.Наименование.ЦветФона = Новый Цвет(255, 255, 0);
	Элементы.Группа1.Видимость = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьЦенуПриИзменении(Элемент)
	
	Если ПоказыватьЦену = Истина Тогда
		Сообщить("Флаг установлен");
	Иначе
		Сообщить("Флаг снят");
	КонецЕсли; 
	
КонецПроцедуры





	
	
	
	
