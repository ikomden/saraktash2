
&НаКлиенте
Процедура СоздатьНаОснованииЗаказа(Команда)
	
	Заказ = ОткрытьФормуМодально("Документ.ЗаказПокупателя.Форма.ФормаВыбораОпт");
	Если Заказ <> Неопределено Тогда
		ОткрытьФорму("Документ.ПеремещениеТоваров.ФормаОбъекта", Новый Структура("Основание", Заказ));	
	КонецЕсли;

КонецПроцедуры
