
&НаКлиенте
Процедура ОК(Команда)
	
	Если Стоимость <> СтараяСтоимость И Стоимость <> 0 Тогда
		ЗаписатьНовуюЦену();
		Закрыть(Истина);
	Иначе
		Закрыть(Ложь);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть(Ложь);
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СтараяСтоимость = Параметры.СтараяСтоимость;
	ВидЦен = Параметры.ВидЦен;
	СпособДоставки = Параметры.СпособДоставки;
	Стоимость = СтараяСтоимость;
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьНовуюЦену()
	
	Док = Документы.УстановкаЦен.СоздатьДокумент();
	Док.ВидЦен = ВидЦен;
	Док.Дата = ТекущаяДата();
	нс = Док.Цены.Добавить();
	нс.Номенклатура = СпособДоставки;
	нс.Цена = Стоимость;
	Док.Записать(РежимЗаписиДокумента.Проведение);
	
КонецПроцедуры
