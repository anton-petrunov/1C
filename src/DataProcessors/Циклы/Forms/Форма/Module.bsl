
&НаКлиенте
Процедура Задача1(Команда)
	
	НачальноеЧисло = 1;
	КонечноеЧисло = 100;
	Сумма = 0;
	Для Счетчик=НачальноеЧисло По КонечноеЧисло Цикл
		Сумма = Сумма + Счетчик;
	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура Задача2(Команда)
	
	Для Число=1 По 9 Цикл
		Для Множитель=1 По 9 Цикл
			Произведение = Число*Множитель;
			Сообщить(""+Число + "*" + Множитель + " = " + Произведение);
		КонецЦикла;
	КонецЦикла;  
	
	//таблица умножения на 9
	Число = 9;
	Для Множитель=1 По 9 Цикл
		Произведение = Число*Множитель;
		Сообщить(""+Число + "*" + Множитель + " = " + Произведение);
	КонецЦикла;
	
	//Среднее = СуммаЗначений / КоличествоЗначений
	
	
КонецПроцедуры

&НаКлиенте
Процедура Задача3(Команда)
		
	МассивЧисел = Новый Массив;
	МассивЧисел.Добавить(125.14);	
	МассивЧисел.Добавить(755.81);	
	МассивЧисел.Добавить(235.11);
	
	//Среднее = ПолучитьСреднееЗначение(МассивЧисел);
	//Сообщить(Среднее);
	
	Среднее = Неопределено;
	РассчитатьСреднееЗначение(МассивЧисел, Среднее);
	Сообщить(Среднее);
	
КонецПроцедуры

Функция ПолучитьСреднееЗначение(МассивЗначений) 

	КоличествоЗначений = МассивЗначений.Количество();
	СуммаЧисел = 0;
	Для каждого ТекСумма Из МассивЗначений Цикл
		СуммаЧисел = СуммаЧисел + ТекСумма;
	КонецЦикла;
	
	Если КоличествоЗначений = 0 Тогда
		Среднее = 0;
	Иначе
		Среднее = СуммаЧисел / КоличествоЗначений;
	КонецЕсли;     
	
	Возврат Среднее;
	
КонецФункции

Процедура РассчитатьСреднееЗначение(МассивЗначений, Результат=Неопределено)
	
	КоличествоЗначений = МассивЗначений.Количество();
	СуммаЧисел = 0;
	Для каждого ТекСумма Из МассивЗначений Цикл
		СуммаЧисел = СуммаЧисел + ТекСумма;
	КонецЦикла;
	
	Если КоличествоЗначений = 0 Тогда
		Среднее = 0;
	Иначе
		Среднее = СуммаЧисел / КоличествоЗначений;
	КонецЕсли; 
	
	Результат = Среднее;
	
КонецПроцедуры

Функция СтрокаЯвляетсяЧислом(Строка)

	//"123456"
	//"ф2"

	СтрокаЦифр = "0123456789";
	КоличествоСимволов = СтрДлина(Строка);

	Результат = Истина;
	Для НомерСимвола=1 По КоличествоСимволов Цикл
		
		ТекущийСимвол = Сред(Строка,НомерСимвола, 1);
		ПозицияСимвола = СтрНайти(СтрокаЦифр,ТекущийСимвол);
		
		Если ПозицияСимвола = 0 Тогда
			Результат = Ложь;
			Прервать;
		КонецЕсли;

	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура Задача4(Команда)
	
	Сообщить(СтрокаЯвляетсяЧислом("123"));
	Сообщить(СтрокаЯвляетсяЧислом("s2"));
	Сообщить(СтрокаЯвляетсяЧислом("15"));

	
КонецПроцедуры
