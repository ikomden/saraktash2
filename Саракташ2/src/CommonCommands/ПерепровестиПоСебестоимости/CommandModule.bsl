
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	//Вставить содержимое обработчика.
	//ПараметрыФормы = Новый Структура("", );
	//ОткрытьФорму("ОбщаяФорма.", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно, ПараметрыВыполненияКоманды.НавигационнаяСсылка);
	
	Кнопки = Новый СписокЗначений;
	Кнопки.Добавить("Перепровести ВСЕ", "Перепровести ВСЕ");
	Кнопки.Добавить("Перепровести с даты", "Перепровести с даты");
	Кнопки.Добавить("Отмена", "Отмена");
	
	Ответ = Вопрос("Выберите", Кнопки);
	Если Ответ = "Отмена" Или Ответ = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОтДаты = '00010101';
	Если Ответ = "Перепровести с даты" Тогда
		Если Не ВвестиДату(ОтДаты, "Укажите дату", ЧастиДаты.Дата) Тогда
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	УчетСебестоимости.ПерепровестиДокументыОтДаты(ОтДаты, Истина);	
	
КонецПроцедуры
