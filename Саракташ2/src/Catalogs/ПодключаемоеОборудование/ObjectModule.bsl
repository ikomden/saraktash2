#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

// Процедура производит инициализацию параметров устройства.
//
Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтоНовый() Тогда
		Параметры = Новый ХранилищеЗначения(Новый Структура());
	КонецЕсли;
	
КонецПроцедуры // ПередЗаписью()

// Процедура проверяет уникальность наименования элемента справочника
// для данного компьютера.
Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
 
	Если Не ПустаяСтрока(Наименование) Тогда
		Запрос = Новый Запрос("
		|ВЫБРАТЬ
		|    1
		|ИЗ
		|    Справочник.ПодключаемоеОборудование КАК ПодключаемоеОборудование
		|ГДЕ
		|    ПодключаемоеОборудование.Наименование = &Наименование
		|    И ПодключаемоеОборудование.РабочееМесто = &РабочееМесто
		|    И ПодключаемоеОборудование.Ссылка <> &Ссылка
		|");

		Запрос.УстановитьПараметр("Наименование", Наименование);
		Запрос.УстановитьПараметр("РабочееМесто", РабочееМесто);
		Запрос.УстановитьПараметр("Ссылка"      , Ссылка);

		Если Не Запрос.Выполнить().Пустой() Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Указано неуникальное наименование элемента. Укажите уникальное наименование.'"), ЭтотОбъект, , , Отказ);
		КонецЕсли;
	КонецЕсли;
	
		ИндексЭлемента = ПроверяемыеРеквизиты.Найти("Организация");
		Если ИндексЭлемента <> Неопределено Тогда
			ПроверяемыеРеквизиты.Удалить(ИндексЭлемента);
		КонецЕсли;
		ИндексЭлемента = ПроверяемыеРеквизиты.Найти("СпособФорматноЛогическогоКонтроля");
		Если ИндексЭлемента <> Неопределено Тогда
			ПроверяемыеРеквизиты.Удалить(ИндексЭлемента);
		КонецЕсли;
		
	
		
		ИндексЭлемента = ПроверяемыеРеквизиты.Найти("ТипОфлайнОборудования");
		
		Если Не ИндексЭлемента = Неопределено Тогда
			ПроверяемыеРеквизиты.Удалить(ИндексЭлемента);
		КонецЕсли;
		
	
КонецПроцедуры // ОбработкаПроверкиЗаполнения()

// Процедура производит очистку реквизитов, которые не должны копироваться.
// Следующие реквизиты очищаются при копировании:
// "Параметры"      - параметры устройства сбрасываются в Неопределено;
// "Наименование"   - устанавливается отличное от исходного наименования;
Процедура ПриКопировании(ОбъектКопирования)
	
	УстройствоИспользуется = Истина;
	Параметры = Неопределено;

	Наименование = НСтр("ru='%Наименование% (копия)'");
	Наименование = СтрЗаменить(Наименование, "%Наименование%", ОбъектКопирования.Наименование);
	
КонецПроцедуры

// При записи
//
Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Если НЕ ЗначениеЗаполнено(СпособФорматноЛогическогоКонтроля) Тогда
		СпособФорматноЛогическогоКонтроля = Перечисления.СпособыФорматноЛогическогоКонтроля.РазделятьСтроки;
		ДопустимоеРасхождениеФорматноЛогическогоКонтроля = 0.01;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли