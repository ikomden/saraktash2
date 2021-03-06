
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	СкрытьНаОжидании = Истина;
	ЗаполнитьДерево();
	
КонецПроцедуры

Процедура ЗаполнитьДерево()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ЗаказПокупателяТовары.Ссылка КАК Заказ,
	|	ЗаказПокупателяТовары.Номенклатура КАК Номенклатура,
	|	ЗаказПокупателяТовары.Количество КАК ЗаказКоличество,
	|	0 КАК ЗаказОжидает
	|ПОМЕСТИТЬ втЗаказы
	|ИЗ
	|	Документ.ЗаказПокупателя.Товары КАК ЗаказПокупателяТовары
	|ГДЕ
	|	ЗаказПокупателяТовары.Ссылка.Статус.ТоварРезервируется
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗаказПокупателяТовары.Ссылка,
	|	ЗаказПокупателяТовары.Номенклатура,
	|	0,
	|	ЗаказПокупателяТовары.Количество
	|ИЗ
	|	Документ.ЗаказПокупателя.Товары КАК ЗаказПокупателяТовары
	|ГДЕ
	|	ЗаказПокупателяТовары.Ссылка.Статус В(&мсСтатусыОжидает)
	|	И НЕ &СкрытьНаОжидании
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	втЗаказы.Номенклатура КАК Номенклатура,
	|	СУММА(втЗаказы.ЗаказКоличество) КАК ЗаказКоличествоВсего,
	|	СУММА(втЗаказы.ЗаказОжидает) КАК ЗаказОжидаетВсего
	|ПОМЕСТИТЬ втНоменклатураЗаказано
	|ИЗ
	|	втЗаказы КАК втЗаказы
	|
	|СГРУППИРОВАТЬ ПО
	|	втЗаказы.Номенклатура
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЗапасыОстатки.Номенклатура КАК Номенклатура,
	|	ЗапасыОстатки.КоличествоОстаток КАК КоличествоДоступно
	|ПОМЕСТИТЬ втОстатки
	|ИЗ
	|	РегистрНакопления.Запасы.Остатки(
	|			,
	|			Номенклатура В
	|				(ВЫБРАТЬ
	|					втНоменклатураЗаказано.Номенклатура КАК Номенклатура
	|				ИЗ
	|					втНоменклатураЗаказано КАК втНоменклатураЗаказано)) КАК ЗапасыОстатки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТоварыВРезервеОстатки.Номенклатура КАК Номенклатура,
	|	ТоварыВРезервеОстатки.КоличествоОстаток КАК КоличествоОстаток
	|ПОМЕСТИТЬ втРезервыВсего
	|ИЗ
	|	РегистрНакопления.ТоварыВРезерве.Остатки(
	|			,
	|			Номенклатура В
	|				(ВЫБРАТЬ
	|					втНоменклатураЗаказано.Номенклатура КАК Номенклатура
	|				ИЗ
	|					втНоменклатураЗаказано КАК втНоменклатураЗаказано)) КАК ТоварыВРезервеОстатки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	втНоменклатураЗаказано.Номенклатура КАК Номенклатура,
	|	втНоменклатураЗаказано.ЗаказКоличествоВсего КАК ЗаказКоличествоВсего,
	|	втНоменклатураЗаказано.ЗаказОжидаетВсего КАК ЗаказОжидаетВсего,
	|	ЕСТЬNULL(втОстатки.КоличествоДоступно, 0) - ЕСТЬNULL(втРезервыВсего.КоличествоОстаток, 0) КАК КоличествоДоступно,
	|	ЕСТЬNULL(втРезервыВсего.КоличествоОстаток, 0) КАК КоличествоРезерв
	|ПОМЕСТИТЬ втНоменклатураНехватает
	|ИЗ
	|	втНоменклатураЗаказано КАК втНоменклатураЗаказано
	|		ЛЕВОЕ СОЕДИНЕНИЕ втОстатки КАК втОстатки
	|		ПО втНоменклатураЗаказано.Номенклатура = втОстатки.Номенклатура
	|		ЛЕВОЕ СОЕДИНЕНИЕ втРезервыВсего КАК втРезервыВсего
	|		ПО втНоменклатураЗаказано.Номенклатура = втРезервыВсего.Номенклатура
	|ГДЕ
	|	(втНоменклатураЗаказано.ЗаказКоличествоВсего > ЕСТЬNULL(втОстатки.КоличествоДоступно, 0)
	|			ИЛИ втНоменклатураЗаказано.ЗаказОжидаетВсего <> 0)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТоварыВРезервеОстатки.ДокументРезерва КАК ДокументРезерва,
	|	ТоварыВРезервеОстатки.Номенклатура КАК Номенклатура,
	|	ТоварыВРезервеОстатки.КоличествоОстаток КАК РезервПоЗаказу
	|ПОМЕСТИТЬ втРезервыПоЗаказам
	|ИЗ
	|	РегистрНакопления.ТоварыВРезерве.Остатки(
	|			,
	|			Номенклатура В
	|				(ВЫБРАТЬ
	|					втНоменклатураЗаказано.Номенклатура КАК Номенклатура
	|				ИЗ
	|					втНоменклатураЗаказано КАК втНоменклатураЗаказано)) КАК ТоварыВРезервеОстатки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	втЗаказы.Заказ КАК Заказ,
	|	втЗаказы.Заказ.Статус КАК ЗаказСтатус,
	|	втЗаказы.Заказ.СпособДоставки КАК ЗаказСпособДоставки,
	|	втЗаказы.Заказ.МетодОплаты КАК ЗаказМетодОплаты,
	|	втЗаказы.Номенклатура КАК Номенклатура,
	|	втЗаказы.ЗаказКоличество КАК ЗаказКоличество,
	|	втЗаказы.ЗаказОжидает КАК ЗаказОжидает,
	|	втНоменклатураНехватает.ЗаказКоличествоВсего КАК ЗаказКоличествоВсего,
	|	втНоменклатураНехватает.ЗаказОжидаетВсего КАК ЗаказОжидаетВсего,
	|	втНоменклатураНехватает.КоличествоДоступно КАК КоличествоДоступно,
	|	втНоменклатураНехватает.КоличествоРезерв КАК КоличествоРезерв,
	|	ЕСТЬNULL(втРезервыПоЗаказам.РезервПоЗаказу, 0) КАК РезервПоЗаказу
	|ИЗ
	|	втЗаказы КАК втЗаказы
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ втНоменклатураНехватает КАК втНоменклатураНехватает
	|		ПО втЗаказы.Номенклатура = втНоменклатураНехватает.Номенклатура
	|		ЛЕВОЕ СОЕДИНЕНИЕ втРезервыПоЗаказам КАК втРезервыПоЗаказам
	|		ПО втЗаказы.Заказ = втРезервыПоЗаказам.ДокументРезерва
	|			И втЗаказы.Номенклатура = втРезервыПоЗаказам.Номенклатура
	|ИТОГИ ПО
	|	Номенклатура,
	|	КоличествоДоступно,
	|	КоличествоРезерв,
	|	ЗаказКоличествоВсего,
	|	ЗаказОжидаетВсего";
	
	
	//Пока поле ожидает выкосил
		
	мсСтатусыОтбор = Новый Массив;
	мсСтатусыОтбор.Добавить(Справочники.СтатусыЗаказов.Новый);	
	Запрос.УстановитьПараметр("мсСтатусыОтбор", мсСтатусыОтбор);
	
	мсСтатусыОжидает = Новый Массив;
	мсСтатусыОжидает.Добавить(Справочники.СтатусыЗаказов.НайтиПоНаименованию("Ожидается поступление товара"));	
	Запрос.УстановитьПараметр("мсСтатусыОжидает", мсСтатусыОжидает);
	
	Запрос.УстановитьПараметр("СкрытьНаОжидании", СкрытьНаОжидании);
	
	Выборка = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);	
	
	//Результат = Запрос.Выполнить().Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкам);
	
	НовыйДерево = Новый ДеревоЗначений;
	НовыйДерево.Колонки.Добавить("Номенклатура", Новый ОписаниеТипов("СправочникСсылка.Номенклатура"));
	НовыйДерево.Колонки.Добавить("КоличествоОстаток", Новый ОписаниеТипов("Число",,,Новый КвалификаторыЧисла(10,2)));
	НовыйДерево.Колонки.Добавить("КоличествоДоступно", Новый ОписаниеТипов("Число",,,Новый КвалификаторыЧисла(10,2)));
	НовыйДерево.Колонки.Добавить("КоличествоРезерв", Новый ОписаниеТипов("Число",,,Новый КвалификаторыЧисла(10,2)));	
	НовыйДерево.Колонки.Добавить("Заказ", Новый ОписаниеТипов("ДокументСсылка.ЗаказПокупателя"));
	НовыйДерево.Колонки.Добавить("ЗаказКоличество", Новый ОписаниеТипов("Число",,,Новый КвалификаторыЧисла(10,2)));
	НовыйДерево.Колонки.Добавить("ЗаказОжидает", Новый ОписаниеТипов("Число",,,Новый КвалификаторыЧисла(10,2)));
	НовыйДерево.Колонки.Добавить("IDНаСайте", Новый ОписаниеТипов("Число",,,Новый КвалификаторыЧисла(11,0)));
	НовыйДерево.Колонки.Добавить("ОжидатьИзделие", Новый ОписаниеТипов("Булево"));
	НовыйДерево.Колонки.Добавить("ЗаказСтатус", Новый ОписаниеТипов("СправочникСсылка.СтатусыЗаказов"));
	НовыйДерево.Колонки.Добавить("ЗаказСпособДоставки", Новый ОписаниеТипов("СправочникСсылка.СпособыДоставки"));
	НовыйДерево.Колонки.Добавить("ЗаказМетодОплаты", Новый ОписаниеТипов("СправочникСсылка.МетодыОплаты"));
	
	Пока Выборка.Следующий() Цикл //Номенклатура
		
		ВыборкаКоличествоОстаток = Выборка.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		Пока ВыборкаКоличествоОстаток.Следующий() Цикл
			
			ВыборкаКоличествоРезерв =  ВыборкаКоличествоОстаток.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
			Пока ВыборкаКоличествоРезерв.Следующий() Цикл				
				
				ВыборкаЗаказКоличество =  ВыборкаКоличествоРезерв.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
				Пока ВыборкаЗаказКоличество.Следующий() Цикл
					
					ВыборкаЗаказОжидает =  ВыборкаЗаказКоличество.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);				
					Пока ВыборкаЗаказОжидает.Следующий() Цикл
						
						нСтрокаНомерклатура = НовыйДерево.Строки.Добавить();		
						нСтрокаНомерклатура.Номенклатура = ВыборкаЗаказОжидает.Номенклатура;
						нСтрокаНомерклатура.КоличествоДоступно = ВыборкаЗаказОжидает.КоличествоДоступно;
						нСтрокаНомерклатура.КоличествоРезерв = ВыборкаЗаказОжидает.КоличествоРезерв;
						нСтрокаНомерклатура.КоличествоОстаток = ВыборкаЗаказОжидает.КоличествоДоступно - ВыборкаЗаказКоличество.ЗаказКоличествоВсего;
						нСтрокаНомерклатура.ЗаказКоличество = ВыборкаЗаказОжидает.ЗаказКоличествоВсего;
						нСтрокаНомерклатура.ЗаказОжидает = ВыборкаЗаказОжидает.ЗаказОжидаетВсего;
						
						ВыборкаЗаказ = ВыборкаЗаказОжидает.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
						Пока ВыборкаЗаказ.Следующий() Цикл 
							
							нСтрокаЗаказ = нСтрокаНомерклатура.Строки.Добавить();
							нСтрокаЗаказ.Номенклатура = ПустаяНоменклатураДляОформления;
							нСтрокаЗаказ.Заказ = ВыборкаЗаказ.Заказ;
							нСтрокаЗаказ.IDНаСайте = ВыборкаЗаказ.Заказ.IDНаСайте;
							нСтрокаЗаказ.ЗаказКоличество = ВыборкаЗаказ.ЗаказКоличество;
							нСтрокаЗаказ.КоличествоРезерв = ВыборкаЗаказ.РезервПоЗаказу;
							нСтрокаЗаказ.ЗаказОжидает = ВыборкаЗаказ.ЗаказОжидает;
							нСтрокаЗаказ.ЗаказСтатус = ВыборкаЗаказ.ЗаказСтатус;
							нСтрокаЗаказ.ЗаказСпособДоставки = ВыборкаЗаказ.ЗаказСпособДоставки;
							нСтрокаЗаказ.ЗаказМетодОплаты = ВыборкаЗаказ.ЗаказМетодОплаты;
							нСтрокаЗаказ.ОжидатьИзделие = нСтрокаЗаказ.ЗаказОжидает <> 0;							
							
						КонецЦикла;
						
					КонецЦикла; 				
					
				КонецЦикла;
				
			КонецЦикла;
			
		КонецЦикла;		
		
	КонецЦикла;	 	
	
	ЗначениеВРеквизитФормы(НовыйДерево, "Дерево");
	
	
КонецПроцедуры

&НаКлиенте
Процедура ПерезаполнитьДерево(Команда)
 	ЗаполнитьДерево();	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(Элемент.ТекущиеДанные.Заказ) Тогда 
		ОткрытьЗначение(Элемент.ТекущиеДанные.Заказ);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СохранитьИзмененияНаСервере()
	
	СтатусНовый = Справочники.СтатусыЗаказов.Новый;
	СтатусОжидаетИзделие = Справочники.СтатусыЗаказов.НайтиПоКоду("000000014"); //Ожидается поступление товара
	
	ЭлементыНоменклатура = Дерево.ПолучитьЭлементы();	
	Для Каждого СтрокаНоменклатура ИЗ ЭлементыНоменклатура Цикл //Номенклатура
		
		ЭлементыЗаказ = СтрокаНоменклатура.ПолучитьЭлементы() ;
		
		//Заказ
		Для Каждого СтрокаЗаказ Из ЭлементыЗаказ Цикл 
			
			Если СтрокаЗаказ.ЗаказСтатус <> СтатусОжидаетИзделие И СтрокаЗаказ.ОжидатьИзделие Тогда 
				
				Заказ = СтрокаЗаказ.Заказ.ПолучитьОбъект();
				Заказ.Статус = СтатусОжидаетИзделие;
				Заказ.Записать();
				
			КонецЕсли;
			
			Если СтрокаЗаказ.ЗаказСтатус = СтатусОжидаетИзделие И НЕ СтрокаЗаказ.ОжидатьИзделие Тогда 
				
				Заказ = СтрокаЗаказ.Заказ.ПолучитьОбъект();
				Заказ.Статус = СтатусНовый;
				Заказ.Записать();
				
			КонецЕсли;			
			
		КонецЦикла;		
		
	КонецЦикла;
	
	ЗаполнитьДерево();

КонецПроцедуры

&НаКлиенте
Процедура СохранитьИзменения(Команда)
	СохранитьИзмененияНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура СкрытьНаОжиданииПриИзменении(Элемент)
	ЗаполнитьДерево();
КонецПроцедуры

