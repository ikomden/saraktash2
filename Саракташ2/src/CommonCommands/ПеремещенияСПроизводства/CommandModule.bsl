
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	//Вставить содержимое обработчика.
	ПараметрыФормы = Новый Структура;
	Отбор = Новый Структура;
	Отбор.Вставить("СкладОтправитель", ПредопределенноеЗначение("Справочник.Склады.Саракташ"));
	ПараметрыФормы.Вставить("Отбор", Отбор);
	ОткрытьФорму("Документ.ПеремещениеТоваров.ФормаСписка", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, Новый УникальныйИдентификатор, ПараметрыВыполненияКоманды.Окно, ПараметрыВыполненияКоманды.НавигационнаяСсылка);
КонецПроцедуры
