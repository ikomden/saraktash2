
Процедура ОбработкаПроведения(Отказ, Режим)
	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр Цены
	Движения.ЦеныНоменклатуры.Записывать = Истина;
	Для Каждого ТекСтрокаЦены Из Цены Цикл
		Движение = Движения.ЦеныНоменклатуры.Добавить();
		Движение.Период = Дата;
		Движение.Номенклатура = ТекСтрокаЦены.Номенклатура;
		Движение.ВидЦен = ВидЦен;
		Движение.Цена = ТекСтрокаЦены.Цена;
	КонецЦикла;

	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;	
	КонецЕсли;	
	
	Выб = ПланыОбмена.ОбменССайтом.Выбрать(); //ЮРР 04.04.2017 20:11:56 Использование другого ПО
	Пока Выб.Следующий() Цикл
		
		Если Выб.ЭтотУзел Тогда
			Продолжить;
		КонецЕсли;
		
		Если Выб.ПометкаУдаления
			ИЛИ НЕ Выб.Активен 
			ИЛИ НЕ Выб.ВыгружатьЗаказы Тогда
			Продолжить;
		КонецЕсли;
		
		//Остатки
		Набор = РегистрыСведений.ЦеныНоменклатуры.СоздатьНаборЗаписей();
		Набор.Отбор.Регистратор.Значение = Ссылка;
		ПланыОбмена.ЗарегистрироватьИзменения(Выб.Ссылка, Набор);		
		
	КонецЦикла;
	
КонецПроцедуры
