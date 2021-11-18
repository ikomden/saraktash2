#Область ПрограммныйИнтерфейс

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

// Функция возвращает структуру с данными драйвера оборудования
// (со значениями реквизитов элемента справочника).
//
Функция ПолучитьДанныеДрайвера(Идентификатор) Экспорт

	ДанныеДрайвера = Новый Структура();

	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	ДрайверыОборудованияПереопределяемый.Ссылка,
	|	ДрайверыОборудованияПереопределяемый.ИмяПредопределенныхДанных КАК Имя,
	|	ДрайверыОборудованияПереопределяемый.ТипОборудования КАК ТипОборудования,
	|	ДрайверыОборудованияПереопределяемый.Предопределенный КАК ВСоставеКонфигурации,
	|	ДрайверыОборудованияПереопределяемый.ИдентификаторОбъекта КАК ИдентификаторОбъекта, 
	|	ДрайверыОборудованияПереопределяемый.ОбработчикДрайвера КАК ОбработчикДрайвера,
	|	ДрайверыОборудованияПереопределяемый.ПоставляетсяДистрибутивом КАК ПоставляетсяДистрибутивом, 
	|	ДрайверыОборудованияПереопределяемый.ЗагруженныйДрайвер КАК ЗагруженныйДрайвер,  
	|	ДрайверыОборудованияПереопределяемый.ИмяФайлаДрайвера  КАК ИмяФайлаДрайвера,  
	|	ДрайверыОборудованияПереопределяемый.ИмяМакетаДрайвера КАК ИмяМакетаДрайвера,
	|	ДрайверыОборудованияПереопределяемый.ВерсияДрайвера    КАК ВерсияДрайвера
	|ИЗ
	|	Справочник.ДрайверыОборудования КАК ДрайверыОборудованияПереопределяемый
	|ГДЕ
	|	 ДрайверыОборудованияПереопределяемый.Ссылка = &Идентификатор");
	
	Запрос.УстановитьПараметр("Идентификатор", Идентификатор);
	
	Выборка = Запрос.Выполнить().Выбрать();
	                                                           
	Если Выборка.Следующий() Тогда
		// Заполним структуру данных устройства.
		ДанныеДрайвера.Вставить("ДрайверОборудования"       , Выборка.Ссылка);
		ДанныеДрайвера.Вставить("ДрайверОборудованияИмя"    , Выборка.Имя);
		ДанныеДрайвера.Вставить("ТипОборудования"           , Выборка.ТипОборудования);
		ДанныеДрайвера.Вставить("ВСоставеКонфигурации"      , Выборка.ВСоставеКонфигурации);
		ДанныеДрайвера.Вставить("ИдентификаторОбъекта"      , Выборка.ИдентификаторОбъекта);
		ДанныеДрайвера.Вставить("ОбработчикДрайвера"        , Выборка.ОбработчикДрайвера);
		ДанныеДрайвера.Вставить("ПоставляетсяДистрибутивом" , Выборка.ПоставляетсяДистрибутивом);
		ДанныеДрайвера.Вставить("ИмяМакетаДрайвера"         , Выборка.ИмяМакетаДрайвера);
		ДанныеДрайвера.Вставить("ИмяФайлаДрайвера"          , Выборка.ИмяФайлаДрайвера);
		ДанныеДрайвера.Вставить("ВерсияДрайвера"            , Выборка.ВерсияДрайвера);
	КонецЕсли;
	
	Возврат ДанныеДрайвера;
	
	
КонецФункции

// Процедура заполняет предопределенный элемент справочника.
//
Процедура ЗаполнитьПредопределенныйЭлемент(ОбработчикДрайвера, ИдентификаторОбъекта = Неопределено, ИмяМакетаДрайвера = Неопределено, 
	ПоставляетсяДистрибутивом = Ложь, ВерсияДрайвера = Неопределено, СнятСПоддержки = Ложь) Экспорт
	
	Параметры = МенеджерОборудованияВызовСервера.ПолучитьПараметрыДрайвераПоОбработчику(Строка(ОбработчикДрайвера));
	
	ВремИмяЭлемента = СтрЗаменить(Параметры.Имя, "Обработчик", "Драйвер");
	
	Попытка
		Драйвер = МенеджерОборудованияВызовСервера.ПредопределенныйЭлемент("Справочник.ДрайверыОборудования." + ВремИмяЭлемента);
	Исключение
		Сообщение = НСтр("ru = 'Предопределенный элемент ""%Параметр%"" не найден.'");
		Сообщение = СтрЗаменить(Сообщение, "%Параметр%", "Справочник.ДрайверыОборудования." + ВремИмяЭлемента);
		ВызватьИсключение Сообщение;
	КонецПопытки;
		
	Если Драйвер = Неопределено Тогда  
		Драйвер = Справочники.ДрайверыОборудования.СоздатьЭлемент();
		Драйвер.ИмяПредопределенныхДанных = ВремИмяЭлемента;     
		Драйвер.ТипОборудования           = Параметры.ТипОборудования;
		Драйвер.ОбработчикДрайвера        = ОбработчикДрайвера;
	Иначе 
		Драйвер = Драйвер.ПолучитьОбъект();
	КонецЕсли;
	
	Драйвер.Наименование              = Параметры.Наименование;
	Драйвер.ИдентификаторОбъекта      = ИдентификаторОбъекта;
	Драйвер.ИмяМакетаДрайвера         = ИмяМакетаДрайвера; 
	Драйвер.ПоставляетсяДистрибутивом = ПоставляетсяДистрибутивом;
	Драйвер.ВерсияДрайвера            = ВерсияДрайвера;
	Драйвер.СнятСПоддержки            = СнятСПоддержки;
	Драйвер.Записать();
	
КонецПроцедуры

#КонецЕсли

#КонецОбласти