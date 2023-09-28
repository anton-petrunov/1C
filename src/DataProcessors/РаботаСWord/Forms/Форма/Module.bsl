
&НаКлиенте
Процедура ОткрытьWord(Команда)
	
	Word = Новый COMОбъект("Word.Application");
	Word.Visible = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьДокументWord(Команда)
	
	Word = Новый COMОбъект("Word.Application");
	
	Документ = Word.Documents.Open("C:\temp\Коммерческое предложение_Исходный.docx");
	
	Word.Visible = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьДокументWordПоШаблону(Команда)
	
	Word = Новый COMОбъект("Word.Application");
	
	Документ = Word.Documents.Add("C:\temp\Коммерческое предложение_Исходный.docx");
	
	Word.Visible = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаменитьТекстВДокументе(Команда)
	
	Word = Новый COMОбъект("Word.Application");
	
	Документ = Word.Documents.Add("C:\temp\Коммерческое предложение_Исходный.docx");
	
	Range = Документ.Content;
	Если Range.Find.Execute("Иванов И.И.") Тогда
		Range.Text = "Федоров П.П";
	КонецЕсли;
	
	Word.Visible = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьСтрокуВТаблицу(Команда)
	
	Word = Новый COMОбъект("Word.Application");
	
	Документ = Word.Documents.Add("C:\temp\Коммерческое предложение_Исходный.docx");
	
	Range = Документ.Range();
	Range.Find.Execute("#[ЯкорьТаблицы]#");
	Table = Range.Tables(1);
	СтрокаОбразец = Range.Rows(1);
	
	НоваяСтрока = Table.Rows.Add(СтрокаОбразец);
	НоваяСтрока.Cells(1).Range.Text = 1;
	НоваяСтрока.Cells(2).Range.Text = "Смартфон Xiomi 9T синий";
	НоваяСтрока.Cells(3).Range.Text = "шт.";
	НоваяСтрока.Cells(4).Range.Text = 5;
	НоваяСтрока.Cells(5).Range.Text = Формат(20150, "ЧДЦ=2");
	НоваяСтрока.Cells(6).Range.Text = Формат(5*20150, "ЧДЦ=2");
	
	СтрокаОбразец.Delete();
	
	Word.Visible = Истина;
	
КонецПроцедуры
