
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Раскрасить();
	
КонецПроцедуры

&НаСервере
Процедура Раскрасить()
	
	СлужебныйСервер.РаскраситьПоСтатусам(ЭтаФорма,"Список","Ссылка");
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ИзмененЭлементСтатусЗаказа" Тогда  		
		Раскрасить();
	КонецЕсли;
	
КонецПроцедуры


