
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ТолькоПросмотр = Истина;
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	Набор = РегистрыСведений.ДанныеСерийныхНомеров.СоздатьНаборЗаписей();
	Набор.Отбор.СерийныйНомер.Установить(ТекущийОбъект.Ссылка);
	Набор.Прочитать();
	Для Каждого Запись Из Набор Цикл
		ЗаполнитьЗначенияСвойств(ЭтаФорма, Запись);
	КонецЦикла;
	
КонецПроцедуры
