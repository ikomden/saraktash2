&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ПриОткрытииСервер();
КонецПроцедуры

Процедура ПриОткрытииСервер()	
	НовыйСтатус = Справочники.СтатусыЗаказов.НайтиПоНаименованию("Выполнен");	
КонецПроцедуры

&НаСервере
Процедура НайтиЗаказыНаСервере()
	Если ПустаяСтрока(ОтборСписокНомеров) Тогда 
		Сообщить("Не заполнен список номеров", СтатусСообщения.Важное);	
		Возврат;
	КонецЕсли;
	
	мсНомераЗаказов = Новый Массив;
	КолСтрок = СтрЧислоСтрок(ОтборСписокНомеров);
	Для Строка=1 По КолСтрок Цикл 
		
		ИскомыйНомер = СтрПолучитьСтроку(ОтборСписокНомеров, Строка);
		
		ЗаказСсылка = НайтиЗаказПоНомеру(ИскомыйНомер);
		Если НЕ ЗначениеЗаполнено(ЗаказСсылка) Тогда 
			
			Сообщить("Заказ с номером """ + ИскомыйНомер + """ не найден");
			Продолжить;
			
		КонецЕсли;
		нСтрока = СпискоЗаказов.Добавить();
		нСтрока.ССылка = ЗаказСсылка;
		нСтрока.Статус = ЗаказСсылка.Статус;
		нСтрока.IDНаСайте = ЗаказСсылка.IDНаСайте;		
		
	КонецЦикла;
	
КонецПроцедуры

Функция НайтиЗаказПоНомеру(НомерЗаказа)
	
	Заказ = Неопределено;
	
	Попытка
		НомерЗаказа = Число(СокрЛП(НомерЗаказа));
	Исключение
		Возврат Заказ;	
	КонецПопытки;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЗаказПокупателя.Ссылка КАК Заказ
		|ИЗ
		|	Документ.ЗаказПокупателя КАК ЗаказПокупателя
		|ГДЕ
		|	ЗаказПокупателя.IDНаСайте = &IDНаСайте";
	
	Запрос.УстановитьПараметр("IDНаСайте", НомерЗаказа);	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		Возврат Выборка.Заказ;
	КонецЦикла;	
	
КонецФункции

&НаКлиенте
Процедура НайтиЗаказы(Команда)
	НайтиЗаказыНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура СпискоЗаказовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОткрытьЗначение(Элемент.ТекущиеДанные.Ссылка);	
	
КонецПроцедуры


&НаСервере
Процедура ИзменитьСтатусыЗаказовНаСервере()
	
	Если СпискоЗаказов.Количество() = 0 Тогда 
		Сообщить("Нет заказов для изменения статуса.");
		Возврат;
	КонецЕсли;
	
	Для Каждого ЗаказСсылка Из СпискоЗаказов Цикл 
		
		Попытка
			
			ЗаказОбъект = ЗаказСсылка.Ссылка.ПолучитьОбъект();
			ЗаказОбъект.Статус = НовыйСтатус;
			ЗаказОбъект.Записать();
			
		Исключение
			ОО = ОписаниеОшибки();
			Сообщить("" + ЗаказСсылка + ": статус не был изменен. Возникла ошибка: " + ОО);
			Возврат;
		КонецПопытки;		
		
	КонецЦикла;
	
	СпискоЗаказов.Очистить();
	
КонецПроцедуры


&НаКлиенте
Процедура ИзменитьСтатусыЗаказов(Команда)
	ИзменитьСтатусыЗаказовНаСервере();
	НайтиЗаказыНаСервере(); //Перечитать
	Сообщить("Изменение статусов завершено.");
КонецПроцедуры

