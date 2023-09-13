
&НаСервере
Процедура ЗаписатьКонтрагентаНаСервере()
	
	//Контрагент - ДанныеФормыСтруктура
	
	//1. Преобразование ДанныеФормыСтруктура -> СправочникОбъект.Контрагенты
	КонтрагентОбъект = РеквизитФормыВЗначение("Контрагент");
	
	//2. Вызов метода "Записать()" для объекта СправочникОбъект.Контрагенты
	КонтрагентОбъект.Записать();
	
	//3. Преобразование СправочникОбъект.Контрагенты -> ДанныеФормыСтруктура  
	ЗначениеВРеквизитФормы(КонтрагентОбъект, "Контрагент");
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьКонтрагента(Команда)
	ЗаписатьКонтрагентаНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ВызватьМетодОбъекта(Команда)
	
	 ВызватьМетодОбъектаСервер();
	
КонецПроцедуры

&НаСервере
Процедура ВызватьМетодОбъектаСервер()

	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	ОбработкаОбъект.ВывестиСообщение();

КонецПроцедуры // ()


&НаСервере
Процедура ВывестиТекст() Экспорт

	Сообщить("Вызвана процедуры модуля формы");

КонецПроцедуры // ()
