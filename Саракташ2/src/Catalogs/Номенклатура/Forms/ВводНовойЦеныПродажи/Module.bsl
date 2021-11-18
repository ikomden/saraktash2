
&НаКлиенте
Процедура ОК(Команда)
	
	Если ЦенаПродажи <> СтараяЦена И ЦенаПродажи <> 0 Тогда
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
	
	СтараяЦена = Параметры.СтараяЦена;
	ВидЦен = Параметры.ВидЦен;
	Номенклатура = Параметры.Номенклатура;
	ЦенаПродажи = СтараяЦена;
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьНовуюЦену()
	
	Док = Документы.УстановкаЦен.СоздатьДокумент();
	Док.ВидЦен = ВидЦен;
	Док.Дата = ТекущаяДата();
	нс = Док.Цены.Добавить();
	нс.Номенклатура = Номенклатура;
	нс.Цена = ЦенаПродажи;
	Док.Записать(РежимЗаписиДокумента.Проведение);
	
КонецПроцедуры
