
Процедура ПередЗаписью(Отказ)
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ТолькоДляКатегорий = (Категории.Количество() > 0);
	
КонецПроцедуры
