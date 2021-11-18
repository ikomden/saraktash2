
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ВыбранныйАртикул = Неопределено;
	ЭтоПриемкаРыночныхИзделий = Неопределено;

	Если Параметры.Свойство("ВыбранныйАртикул", ВыбранныйАртикул)
		И Не (Параметры.Свойство("ЭтоПриемкаРыночныхИзделий", ЭтоПриемкаРыночныхИзделий)
		И ЭтоПриемкаРыночныхИзделий = Истина)
		Тогда
		Список.Параметры.УстановитьЗначениеПараметра("ВыбранныйАртикул", ВыбранныйАртикул);
		Элементы.ФормаПоказатьВсе.Видимость = Истина;
	Иначе
		Элементы.ФормаПоказатьВсе.Видимость = Ложь;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ПоказатьВсеНаСервере()
	
	Для Каждого Элемент Из Список.Параметры.Элементы Цикл
		Элемент.Использование = Ложь;
	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура ПоказатьВсе(Команда)
	
	ПоказатьВсеНаСервере();
	Элементы.Список.Обновить();
	
КонецПроцедуры
