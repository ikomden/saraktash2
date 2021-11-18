
Процедура ОбработкаПроведения(Отказ, Режим)
	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр ДенежныеСредства Приход
	Движения.ДенежныеСредства.Записывать = Истина;
	Движение = Движения.ДенежныеСредства.Добавить();
	Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
	Движение.Период = Дата;
	Движение.КассаСчет = Касса;
	Движение.Сумма = СуммаДокумента;

	// регистр Доходы 
	Движения.Доходы.Записывать = Истина;
	Для Каждого ТекСтрокаРасшифровка Из Расшифровка Цикл
		Если ТекСтрокаРасшифровка.Статья = Справочники.СтатьиДоходов.КорректировкаОстатков Тогда
			Продолжить;
		КонецЕсли;
		Движение = Движения.Доходы.Добавить();
		Движение.Период = Дата;
		Движение.Статья = ТекСтрокаРасшифровка.Статья;
		Движение.Сумма = ТекСтрокаРасшифровка.Сумма;
	КонецЦикла;
	
	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	
	Движения.Взаиморасчеты.Записывать = Истина;
	Для Каждого Стр Из Расшифровка Цикл
		Если ТипЗнч(Стр.Сделка) = Тип("ДокументСсылка.ЗаказПокупателя") Тогда
			Движение = Движения.Взаиморасчеты.ДобавитьРасход();
			Движение.Период = Дата;
			Движение.Контрагент = Стр.Сделка.Контрагент;
			Движение.Сделка = Стр.Сделка; 			
			Движение.Сумма = Стр.Сумма; 
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	СуммаДокумента = Расшифровка.Итог("Сумма");
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	//{{__КОНСТРУКТОР_ВВОД_НА_ОСНОВАНИИ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ВозвратТоваровПоставщику") Тогда
		// Заполнение шапки
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ЗаказПокупателя") Тогда
		// Заполнение шапки
		Контрагент = ДанныеЗаполнения.Контрагент;
		СуммаДокумента = ДанныеЗаполнения.СуммаДокумента;
		нс = Расшифровка.Добавить();
		нс.Сделка = ДанныеЗаполнения;
		нс.Статья = Справочники.СтатьиДоходов.ОплатаОтПокупателя;
		нс.Сумма = СлужебныйСервер.ОстатокДолгаПоЗаказу(ДанныеЗаполнения);
	КонецЕсли;
	//}}__КОНСТРУКТОР_ВВОД_НА_ОСНОВАНИИ
КонецПроцедуры
