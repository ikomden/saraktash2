Процедура ПередЗаписьюНаСервере(Отказ)
	
	Если Запись.ПроцентСкидки <> 0 И Запись.СуммаСкидки <> 0 Тогда 
		Отказ = Истина;
		Сообщить("Скидка принимается либо на процент либо на сумму, сразу все нельзя!");
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	ПередЗаписьюНаСервере(Отказ);
КонецПроцедуры
