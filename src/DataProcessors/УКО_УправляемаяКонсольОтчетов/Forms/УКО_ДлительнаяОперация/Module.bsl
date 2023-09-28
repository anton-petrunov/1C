
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Элементы.ДекорацияДлительнаяОперация.Картинка = Элементы.БиблиотекаКартинокУКО_ДлительнаяОперацияАнимация48.Картинка;

	ДлительнаяОперация = Параметры.ДлительнаяОперация;
	Наименование = ДлительнаяОперация.Наименование;
	
	Элементы.Индикатор.Видимость = (Параметры.Прогресс <> Неопределено);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	ОписаниеОповещения = Новый ОписаниеОповещения(ДлительнаяОперация.ИмяОбработчика, ВладелецФормы);
	ВыполнитьОбработкуОповещения(ОписаниеОповещения, Неопределено);
	
	ПриЗакрытииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбработчикОжиданияДлительнойОперации();
	
	// Обработка исключений 1С совместимо и платформенной проверки {
	Оповещение = Новый ОписаниеОповещения("ОбработчикОжиданияДлительнойОперации", ЭтотОбъект);
	//}
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПриЗакрытииНаСервере()
	
	ОбъектОбработки().УКО_ДлительныеОперации_Отменить(ДлительнаяОперация.Идентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикОжиданияДлительнойОперации() Экспорт
	
	УКО_ДлительныеОперацииКлиент_СтандартныйОбработчикОжиданияДлительнойОперации(ЭтаФорма, ДлительнаяОперация,
		УКО_ДлительныеОперацииВызовСервера_ДанныеСостояния(ДлительнаяОперация.Идентификатор, ДлительнаяОперация.АдресРезультатаВыполнения));
	
КонецПроцедуры

#КонецОбласти



&НаСервере
Функция ОбъектОбработки()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает сокращенный идентификатор расширения
// Возвращаемое значение:
//   Строка	- Сокращенный идентификатор расширения
Функция УКО_ОбщегоНазначенияКлиентСервер_ИдентификаторРасширенияСокращенный() Экспорт 
	
	Возврат "УКО";
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает имя события журнала регистрации
//
// Возвращаемое значение:
//   Строка	- имя события журнала регистрации
//
Функция УКО_ОбщегоНазначенияКлиентСервер_СобытиеЖурналаРегистрации() Экспорт
	
	Возврат УКО_ОбщегоНазначенияКлиентСервер_ПолноеИмяРасширения();
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает версию расширения
// Возвращаемое значение:
//   Строка	- версию расширения
Функция УКО_ОбщегоНазначенияКлиентСервер_ВерсияРасширения() Экспорт
	
	Возврат "3.8.9";
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает имя расширения
// Возвращаемое значение:
//   Строка	- Имя расширения
Функция УКО_ОбщегоНазначенияКлиентСервер_ИмяРасширения() Экспорт 
	
	Возврат НСтр("ru = 'Управляемая консоль отчетов'; en = 'Managed reporting console'");
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает полное имя расширения
//
// Возвращаемое значение:
//   Строка	- полное имя расширения
//
Функция УКО_ОбщегоНазначенияКлиентСервер_ПолноеИмяРасширения() Экспорт
	
	Возврат СтрШаблон("%1 %2", УКО_ОбщегоНазначенияКлиентСервер_ИмяРасширения(), УКО_ОбщегоНазначенияКлиентСервер_ВерсияРасширения());
	
КонецФункции
&НаСервере
// Получает состояние фонового задания длительной операции
//
// Параметры:
//  Идентификатор - УникальныйИдентификатор - Идентификатор фонового задания
//  АдресРезультатаВыполнения - Строка - Адрес результата выполнения
//
// Возвращаемое значение:
//   Структура	- Результат структурой
//		* Статус - УКО_ДлительныеОперацииКлиентСервер - Статус длительной операции
//
Функция УКО_ДлительныеОперацииВызовСервера_ДанныеСостояния(Идентификатор, АдресРезультатаВыполнения) Экспорт
	
	Возврат ОбъектОбработки().УКО_ДлительныеОперации_ДанныеСостояния(Идентификатор, АдресРезультатаВыполнения);
	
КонецФункции
&НаКлиенте
// Обработчик ожидания длительной операции
//
// Параметры:
//   Форма - Форма - Форма владелец
//   ДлительнаяОперация - ДанныеДлительнойОперации - Данные операции
//   СостояниеВыполнения - Структура - Состояние выполнения
//
Процедура УКО_ДлительныеОперацииКлиент_СтандартныйОбработчикОжиданияДлительнойОперации(Форма, ДлительнаяОперация, СостояниеВыполнения) Экспорт
	
	ОткрытаДополнительнаяФорма = (СтрНайти(Форма.ИмяФормы, "ДлительнаяОперация"));
	ЗаданиеЗавершено = Ложь;
	
	Если СостояниеВыполнения.Статус = "Перечисление.УКО_СтатусФоновогоЗадания.Активно" Тогда
		
		ОписаниеСостоянииВыполнения = СостояниеВыполнения.Состояние;
		
		Если ОписаниеСостоянииВыполнения <> Неопределено Тогда
			
			Если ОписаниеСостоянииВыполнения.Свойство("Состояние") Тогда
				ДлительнаяОперация.Состояние = ОписаниеСостоянииВыполнения.Состояние;
			КонецЕсли;
			
			Если ОписаниеСостоянииВыполнения.Свойство("Индикатор") Тогда
				ДлительнаяОперация.Прогресс = ОписаниеСостоянииВыполнения.Индикатор;
			КонецЕсли;
			
		КонецЕсли;
		
		ТекстСостояния = ДлительнаяОперация.Состояние;
		// Обновление информации о выполнении
		Если ОткрытаДополнительнаяФорма Тогда
			
			ЭлементСостояние = Форма.Элементы.ДекорацияСостояние;
			ЭлементСостояние.Заголовок = ТекстСостояния;
			
			ТребуемаяВысота = СтрЧислоСтрок(ТекстСостояния);
			Если ЭлементСостояние.Высота <> ТребуемаяВысота Тогда
				ЭлементСостояние.Высота = ТребуемаяВысота;
			КонецЕсли;
			
			Форма.Индикатор = ДлительнаяОперация.Прогресс;
			
		Иначе
			
			ТекстСостояния = СтрПолучитьСтроку(ТекстСостояния, 1);
			Состояние(ДлительнаяОперация.Наименование, ДлительнаяОперация.Прогресс, ТекстСостояния, Элементы.БиблиотекаКартинокУКО_ДлительнаяОперацияАнимация48.Картинка);
			
		КонецЕсли;
			
		ПрошлоСекунд = (ТекущаяУниверсальнаяДатаВМиллисекундах() - ДлительнаяОперация.Начало)/1000;
		Если ПрошлоСекунд > 5 И Не ОткрытаДополнительнаяФорма Тогда
			
			ПараметрыФормы = Новый Структура;
			ПараметрыФормы.Вставить("ДлительнаяОперация", ДлительнаяОперация);
			ПараметрыФормы.Вставить("Прогресс", ДлительнаяОперация.Прогресс);
			
			Форма.Доступность = Истина;
			УКО_ФормыКлиент_ОткрытьДополнительную("ДлительнаяОперация", ПараметрыФормы, Форма);
			
		Иначе
			
			ДлительнаяОперация.ИнтервалОжидания = УКО_ДлительныеОперацииКлиентСервер_СледующийШагИнтервалаОжидания(ДлительнаяОперация.ИнтервалОжидания);
			Форма.ПодключитьОбработчикОжидания("ОбработчикОжиданияДлительнойОперации", ДлительнаяОперация.ИнтервалОжидания, Истина);
			
		КонецЕсли;
		
	ИначеЕсли СостояниеВыполнения.Статус = "Перечисление.УКО_СтатусФоновогоЗадания.Завершено" Тогда
		
		ЗаданиеЗавершено = Истина;
		
		Если ОткрытаДополнительнаяФорма Тогда
			ФормаИсточник = Форма.ВладелецФормы;
		Иначе
			ФормаИсточник = Форма;
		КонецЕсли;

		УКО_ДлительныеОперацииКлиент_ОбработкаЗавершенияДлительнойОперации(ФормаИсточник, ФормаИсточник.ДлительнаяОперация, СостояниеВыполнения.Результат);
		
	ИначеЕсли СостояниеВыполнения.Статус = "Перечисление.УКО_СтатусФоновогоЗадания.АварийноЗавершено" Тогда
		
		ЗаданиеЗавершено = Истина;
		ПоказатьПредупреждение(,НСтр("ru = 'Ошибка в фоновом задании'; en = 'Error in background job'"),,УКО_ОбщегоНазначенияКлиентСервер_ИмяРасширения());
		
	КонецЕсли;
	
	Если ЗаданиеЗавершено Тогда
		
		Если ОткрытаДополнительнаяФорма Тогда
			Форма.Закрыть();
		Иначе
			Форма.Доступность = Истина;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры
&НаКлиенте
// Обработчик завершения длительной операции
//
// Параметры:
//   Форма - Форма - Форма владелец
//   ДлительнаяОперация - ДанныеДлительнойОперации - Данные операции
//   Результат - Структура - Результат выполнения
//
Процедура УКО_ДлительныеОперацииКлиент_ОбработкаЗавершенияДлительнойОперации(Форма, ДлительнаяОперация, Результат) Экспорт
	
	Результат = Результат.Результат;
	
	// Оповещения (если окно неактивно)
	Если АктивноеОкно() <> Форма.Окно Тогда
		
		Если ДлительнаяОперация.ЗвуковойСигналПоОкончании Тогда
			#Если ТолстыйКлиентУправляемоеПриложение ИЛИ ТонкийКлиент Тогда
				Сигнал();
			#КонецЕсли
		КонецЕсли;
		
		Если ДлительнаяОперация.УведомлениеОЗавершении Тогда
			Пояснение = СтрШаблон(НСтр("ru = 'Завершена длительная операция:
			|%1'; en = 'Completed a long-running operation:
			|%1'"), ДлительнаяОперация.Наименование);
			
			ПоказатьОповещениеПользователя(УКО_ОбщегоНазначенияКлиентСервер_ИмяРасширения(), Форма.Окно.ПолучитьНавигационнуюСсылку(), Пояснение, Элементы.БиблиотекаКартинокУКО_Логотип32.Картинка, , Форма.УникальныйИдентификатор);
		КонецЕсли;
		
	КонецЕсли;
	
	ОписаниеОповещения = Новый ОписаниеОповещения(ДлительнаяОперация.ИмяОбработчика, Форма, ДлительнаяОперация.ДополнительныеПараметры);
	ВыполнитьОбработкуОповещения(ОписаниеОповещения, Результат);
	
КонецПроцедуры
&НаКлиентеНаСервереБезКонтекста
// Получает следующий интервал ожидания
//
// Параметры:
//   ТекущийИнтервал - Число - Текущий интервал
//
// Возвращаемое значение:
//   Число	- Следующий интервал ожидания
//
Функция УКО_ДлительныеОперацииКлиентСервер_СледующийШагИнтервалаОжидания(ТекущийИнтервал) Экспорт
	
	Возврат Мин(ТекущийИнтервал * 1.5, 15);
	
КонецФункции
&НаКлиенте
// Открывает дополнительную/вспомогательную форму
//
// Параметры:
//	Имя - Строка - Имя формы
//	Параметры - Структура - Параметры формы (необязательный)
//	Владелец - Форма - Форма владелец
//	Уникальность - Произвольный - Уникальность (необязательный)
//	ОписаниеОповещенияОЗакрытии - ОписаниеОповещения - Описание оповещения о закрытии (необязательный)
//
Процедура УКО_ФормыКлиент_ОткрытьДополнительную(Имя, Параметры = Неопределено, Владелец = Неопределено, Уникальность = Неопределено, ОписаниеОповещенияОЗакрытии = Неопределено) Экспорт
	
	Если УКО_ОбщегоНазначенияКлиентСервер_РежимЗапускаВнешняяОбработка() Тогда
		ОбъектФорм = СтрШаблон("ВнешняяОбработка.%1%2.Форма.", УКО_ОбщегоНазначенияКлиентСервер_ПрефиксРасширения(), УКО_ОбщегоНазначенияКлиентСервер_ИдентификаторРасширения());
	Иначе
		ОбъектФорм = "ОбщаяФорма";
	КонецЕсли;
	
	ПолноеИмяФормы = СтрШаблон("%1.%2%3", ОбъектФорм, УКО_ОбщегоНазначенияКлиентСервер_ПрефиксРасширения(), Имя);
	
	Если Владелец = Неопределено Тогда
		РежимОткрытия = Неопределено;
	Иначе 
		РежимОткрытия = РежимОткрытияОкнаФормы.БлокироватьОкноВладельца;
	КонецЕсли;
	
	ОткрытьФорму(ПолноеИмяФормы, Параметры, Владелец, Уникальность,,,ОписаниеОповещенияОЗакрытии, РежимОткрытия);
	
КонецПроцедуры
&НаКлиентеНаСервереБезКонтекста
// Возвращает идентификатор расширения
// Возвращаемое значение:
//   Строка	- Идентификатор расширения
Функция УКО_ОбщегоНазначенияКлиентСервер_ИдентификаторРасширения() Экспорт 
	
	Возврат "УправляемаяКонсольОтчетов";
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает префикс объектов расширения
// Возвращаемое значение:
//   Строка	- Префикс объектов расширения
Функция УКО_ОбщегоНазначенияКлиентСервер_ПрефиксРасширения() Экспорт 
	
	Возврат "УКО_";
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Определяет, это режим запуска программы
//
// Возвращаемое значение:
//   Булево	- Истина, Режим запуска внешняя обработка
//
Функция УКО_ОбщегоНазначенияКлиентСервер_РежимЗапускаВнешняяОбработка() Экспорт
	
	Возврат Истина;
	
КонецФункции
