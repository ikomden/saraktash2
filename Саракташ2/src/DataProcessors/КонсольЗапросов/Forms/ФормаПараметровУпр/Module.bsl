
// ОБЩИЕ ПРОЦЕДУРЫ И ФУНКЦИИ

// На сервере

&НаСервере
Процедура НайтиПараметрыЗапроса()
	
	Попытка
		Запрос = Новый Запрос(Параметры.ТекстЗапроса);
		ОписаниеПараметров = Запрос.НайтиПараметры();
		
		ПараметрыЗапроса.Очистить();
		Для Каждого Параметр Из ОписаниеПараметров Цикл 
			
			СтрокаПараметра = ПараметрыЗапроса.Добавить();
			СтрокаПараметра.ИмяПараметра    = Параметр.Имя;
			СтрокаПараметра.СпособУстановки = "Значение";
			СтрокаПараметра.ТипЗначения     = Параметр.ТипЗначения;
		КонецЦикла;
	Исключение
		Сообщить(КраткоеПредставлениеОшибки(ИнформацияОбОшибке()), СтатусСообщения.Важное);
	КонецПопытки;
	
КонецПроцедуры // НайтиПараметрыЗапроса()

&НаСервереБезКонтекста
Функция ПолучитьИмяМетаданногоПоТипу(Тип)
	
	ОбъектМетаданных = Метаданные.НайтиПоТипу(Тип);
	Если ОбъектМетаданных = Неопределено Тогда 
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат ОбъектМетаданных.Имя;
	
КонецФункции // ПолучитьИмяМетаданногоПоТипу()

// На сервере без контекста

// На клиенте

// Устанавливает свойство ИмяСвойства элемента формы с именем ИмяЭлемента в значение Значение.
// Применяется в тех случаях, когда элемент формы может не быть на форме из-за отсутствия прав у пользователя
// на объект, реквизит объекта или команду.
//
// Параметры:
//  ЭлементыФормы - свойство ЭлементыФормы управляемой формы.
//  ИмяЭлемента   - Строка       - имя элемента формы
//  ИмяСвойства   - Строка       - имя устанавливаемого свойства элемента формы
//  Значение      - Произвольный - новое значение элемента
//
&НаКлиенте
Процедура УстановитьСвойствоЭлементаФормы(ИмяЭлемента, ИмяСвойства, Значение)
	
	ЭлементФормы = Элементы.Найти(ИмяЭлемента);
	Если Не ЭлементФормы = Неопределено Тогда
		ЭлементФормы[ИмяСвойства] = Значение;
	КонецЕсли;
	
КонецПроцедуры // УстановитьСвойствоЭлементаФормы()

// ПРОЦЕДУРЫ - ОБРАБОТЧИКИ СОБЫТИЙ

// Обработчики событий элементов формы

// Обработчики событий формы

&НаКлиенте
Процедура ПараметрыЗапросаПриАктивизацииЯчейки(Элемент)
	
	ТекущиеДанные = Элемент.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ТекущиеДанные.СпособУстановки = "Значение" Тогда 
		
		ТекущийТипЗначения = пкм_УстановитьПараметры(ТекущиеДанные.ИмяПараметра);
		
		Если Не ТекущийТипЗначения = Неопределено
			И Не ТекущийТипЗначения.СодержитТип(Тип("СписокЗначений")) Тогда 
			ТекущиеДанные.ТипЗначения = ТекущийТипЗначения;
		КонецЕсли;
		
	ИначеЕсли ТекущиеДанные.СпособУстановки = "Выражение" Тогда 
		ТекущиеДанные.ТипЗначения = Новый ОписаниеТипов("Строка");
	ИначеЕсли ТекущиеДанные.СпособУстановки = "Список" Тогда 
		ТекущиеДанные.ТипЗначения = Новый ОписаниеТипов("СписокЗначений");
	КонецЕсли;
	
	Элементы.ПараметрыЗапросаЗначениеПараметра.ОграничениеТипа = ТекущиеДанные.ТипЗначения;
	
	ЭтоДатаИлиЧисло = (ТекущиеДанные.ТипЗначения.СодержитТип(Тип("Дата"))
					Или ТекущиеДанные.ТипЗначения.СодержитТип(Тип("Число")));
	//
	ЭтоБулевоИлиСтрока = (ТекущиеДанные.ТипЗначения.СодержитТип(Тип("Булево"))
					Или ТекущиеДанные.ТипЗначения.СодержитТип(Тип("Строка")));
	//
	ЭтоСписокЗначений = ТекущиеДанные.ТипЗначения.СодержитТип(Тип("СписокЗначений"));
	
	УстановитьСвойствоЭлементаФормы("ПараметрыЗапросаЗначениеПараметра", "КнопкаРегулирования", ЭтоДатаИлиЧисло И Не ЭтоСписокЗначений);
	УстановитьСвойствоЭлементаФормы("ПараметрыЗапросаЗначениеПараметра", "КнопкаОткрытия",      Не ЭтоДатаИлиЧисло И Не ЭтоБулевоИлиСтрока И Не ЭтоСписокЗначений);
	
КонецПроцедуры // ПараметрыЗапросаПриАктивизацииЯчейки()

&НаСервере
Функция  пкм_УстановитьПараметры(ИмяПараметра)

	ИсходныеПараметры = ЗначениеИзСтрокиВнутр(ПолучитьИзВременногоХранилища(Параметры.АдресПараметровЗапроса));
	НайденныеИсходныеПараметры = ИсходныеПараметры.НайтиСтроки(Новый Структура("ИмяПараметра", ИмяПараметра));
	ТекущийТипЗначения = ?(НайденныеИсходныеПараметры.Количество() = 0, Неопределено, НайденныеИсходныеПараметры[0].ТипЗначения);

КонецФункции


&НаКлиенте
Процедура ПараметрыЗапросаСпособУстановкиПриИзменении(Элемент)
	
	ПараметрыЗапросаПриАктивизацииЯчейки(Элементы.ПараметрыЗапроса);
	
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыЗапросаЗначениеПараметраПриИзменении(Элемент)
	
	ТекущиеДанные = Элемент.Родитель.ТекущиеДанные;
	Если Не ТекущиеДанные.ЗначениеПараметра = Неопределено Тогда 
		МассивТипов = Новый Массив;
		МассивТипов.Добавить(ТипЗнч(ТекущиеДанные.ЗначениеПараметра));
		ТекущиеДанные.ТипЗначения = Новый ОписаниеТипов(МассивТипов);
		
		ПараметрыЗапросаПриАктивизацииЯчейки(Элемент.Родитель);
		
		Если Не ЗначениеЗаполнено(ТекущиеДанные.ИмяПараметра) Тогда 
			ТекущиеДанные.ИмяПараметра = ПолучитьИмяМетаданногоПоТипу(ТипЗнч(ТекущиеДанные.ЗначениеПараметра));
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры // ПараметрыЗапросаЗначениеПараметраПриИзменении()

&НаКлиенте
Процедура ПараметрыЗапросаЗначениеПараметраНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ТекущиеДанные = Элемент.Родитель.ТекущиеДанные;
	Если ТекущиеДанные.ТипЗначения.СодержитТип(Тип("Строка")) Тогда 
		ВвестиСтроку(ТекущиеДанные.ЗначениеПараметра, "Введите текст" + ?(ТекущиеДанные.СпособУстановки = "Выражение", " выражения", "") + "!",, Истина);
	ИначеЕсли ТекущиеДанные.ТипЗначения.СодержитТип(Тип("СписокЗначений")) Тогда 
		Если ТекущиеДанные.ЗначениеПараметра = Неопределено Тогда
			ИсходныеПараметры = ПолучитьИзВременногоХранилища(Параметры.АдресПараметровЗапроса);
			НайденныеИсходныеПараметры = ИсходныеПараметры.НайтиСтроки(Новый Структура("ИмяПараметра", ТекущиеДанные.ИмяПараметра));
			ТекущийТипЗначения = ?(НайденныеИсходныеПараметры.Количество() = 0, Неопределено, НайденныеИсходныеПараметры[0].ТипЗначения);
			
			ЗначениеПараметра = Новый СписокЗначений;
			ЗначениеПараметра.ТипЗначения = ТекущийТипЗначения;
			
			ТекущиеДанные.ЗначениеПараметра = ЗначениеПараметра;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры // ПараметрыЗапросаЗначениеПараметраНачалоВыбора()

// На сервере

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ЭтоАдресВременногоХранилища(Параметры.АдресПараметровЗапроса) Тогда 
		ПараметрыЗапроса.Загрузить(ЗначениеИзСтрокиВнутр(ПолучитьИзВременногоХранилища(Параметры.АдресПараметровЗапроса)));
		// Установим способ установки параметра по умолчанию
		Для Каждого СтрокаПараметра Из ПараметрыЗапроса Цикл 
			Если Не ЗначениеЗаполнено(СтрокаПараметра.СпособУстановки) Тогда 
				СтрокаПараметра.СпособУстановки = "Значение";
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры // ПриСозданииНаСервере()

// На клиенте

&НаКлиенте
Процедура ПриЗакрытии()
	
	УстановитьПараметры(Команды.УстановитьПараметры);
	
КонецПроцедуры // ПриЗакрытии()

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	Если ЭтоАдресВременногоХранилища(ВыбранноеЗначение) Тогда 
		КопияПараметров = ПолучитьИзВременногоХранилища(ВыбранноеЗначение);
		Для Каждого ТекущаяКопия Из КопияПараметров Цикл 
			НайденныеСтроки = ПараметрыЗапроса.НайтиСтроки(Новый Структура("ИмяПараметра", ТекущаяКопия.ИмяПараметра));
			ТекущийПараметр = ?(НайденныеСтроки.Количество() = 0, ПараметрыЗапроса.Добавить(), НайденныеСтроки[0]);
			ЗаполнитьЗначенияСвойств(ТекущийПараметр, ТекущаяКопия);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

// ПРОЦЕДУРЫ - ОБРАБОТЧИКИ ДЕЙСТВИЙ

&НаКлиенте
Процедура ЗаполнитьИзЗапроса(Команда)
	
	НайтиПараметрыЗапроса();
	
КонецПроцедуры // ЗаполнитьИзЗапроса()

&НаКлиенте
Процедура КопироватьИзЗапроса(Команда)
	
	ОткрытьФорму(
		Параметры.ПутьКФормамОбработки + "ФормаВыбораПараметровЗапроса",
		Новый Структура("АдресДереваЗапросов, ИдентификаторЗапроса", Параметры.АдресДереваЗапросов, Параметры.ИдентификаторЗапроса),
		ЭтаФорма);
	//
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПараметры(Команда)
	
	ОповеститьОВыборе(ПараметрыЗапроса);
	
КонецПроцедуры // УстановитьПараметры()












