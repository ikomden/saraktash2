
&НаКлиенте
Процедура ПриОткрытии(Отказ)	
	ПриОткрытииСервер(Отказ);
	
	Если ЭтоTasker() Тогда 
		ЗавершитьРаботуСистемы();
	Иначе
		Сообщить("Выполнено");
		Закрыть();	
	КонецЕсли;
КонецПроцедуры

Функция ЭтоTasker() 
	
	Возврат ПараметрыСеанса.ТекущийПользователь.Наименование = "Tasker1c";
	
КонецФункции

Процедура ПриОткрытииСервер(Отказ)
	
	Попытка
		ОбъектСовсемОбъект=РеквизитФормыВЗначение("Объект");		
		ОбъектСовсемОбъект.ВыполнитьРегламент();
	Исключение
		ОО = ОписаниеОшибки();
		ОбщегоНазначения.ЗаписатьСобытие("Обмен", "Ошибка: " + ОО);		
	КонецПопытки;
	
КонецПроцедуры


&НаСервере
Процедура СнятьТоварыСРезерваНаСервере()
	РеквизитФормыВЗначение("Объект").СнятьТоварыСРезерва();
КонецПроцедуры


&НаКлиенте
Процедура СнятьТоварыСРезерва(Команда)
	СнятьТоварыСРезерваНаСервере();
КонецПроцедуры

