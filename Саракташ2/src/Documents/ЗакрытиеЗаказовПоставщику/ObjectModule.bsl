
Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	Движения.ОжидаемыеТовары.Записывать = Истина;
	
	Выборка = ВыборкаОстатковПоЗаказамНаДату(Заказы.ВыгрузитьКолонку("Заказ")); 
	Если Выборка <> Неопределено Тогда
		Пока Выборка.Следующий() Цикл
			Движение = Движения.ОжидаемыеТовары.Добавить();
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
			Движение.Период = Дата;
			Движение.Номенклатура = Выборка.Номенклатура;
			Движение.Заказ = Выборка.Заказ;
			Движение.Количество = Выборка.КоличествоОстаток; 		
		КонецЦикла;
	КонецЕсли; 
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ЗаказПоставщику") Тогда
		мЗаказы = Новый Массив;
		мЗаказы.Добавить(ДанныеЗаполнения);
		Выборка = ВыборкаОстатковПоЗаказамНаДату(мЗаказы);
		Если Выборка <> Неопределено И Выборка.Следующий() Тогда
			нс = Заказы.Добавить();
			нс.Заказ = ДанныеЗаполнения;
		КонецЕсли; 
	КонецЕсли;
	
КонецПроцедуры

Функция ВыборкаОстатковПоЗаказамНаДату(Заказы)
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ОжидаемыеТоварыОстатки.Номенклатура,
	|	ОжидаемыеТоварыОстатки.Заказ,
	|	ОжидаемыеТоварыОстатки.КоличествоОстаток
	|ИЗ
	|	РегистрНакопления.ОжидаемыеТовары.Остатки(&ДатаДокумента, Заказ В (&Заказы)) КАК ОжидаемыеТоварыОстатки";
	Запрос.УстановитьПараметр("ДатаДокумента",Дата);
	Запрос.УстановитьПараметр("Заказы",Заказы);
	РезультатЗапроса = Запрос.Выполнить();
	Если НЕ РезультатЗапроса.Пустой() Тогда
		Выборка = РезультатЗапроса.Выбрать();
	Иначе
		Выборка = Неопределено;
	КонецЕсли;
	
	Возврат Выборка;
	
КонецФункции
