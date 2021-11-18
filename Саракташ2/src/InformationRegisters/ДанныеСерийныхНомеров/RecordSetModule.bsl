
Процедура ПриЗаписи(Отказ, Замещение)
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ОбменССайтом.Ссылка КАК Ссылка
	|ИЗ
	|	ПланОбмена.ОбменССайтом КАК ОбменССайтом
	|ГДЕ
	|	НЕ ОбменССайтом.ЭтотУзел
	|	И НЕ ОбменССайтом.ПометкаУдаления
	|	И ОбменССайтом.РегистрироватьСерийныеНомера";
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		ПланыОбмена.ЗарегистрироватьИзменения(Выборка.Ссылка, ЭтотОбъект);
	КонецЦикла;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ЭтотОбъект.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	СерийныйНомерОбъект = Отбор.СерийныйНомер.Значение.ПолучитьОбъект();
	Для Каждого Запись Из ЭтотОбъект Цикл
		ЗаполнитьЗначенияСвойств(СерийныйНомерОбъект, Запись);
	КонецЦикла;
	СерийныйНомерОбъект.Записать();
	
КонецПроцедуры
