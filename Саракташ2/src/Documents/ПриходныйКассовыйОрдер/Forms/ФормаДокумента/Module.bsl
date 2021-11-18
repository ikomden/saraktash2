
&НаКлиенте
Процедура ВидОднойСтрокойПриИзменении(Элемент)
	
	Если ВидОднойСтрокой И Объект.Расшифровка.Количество() > 1 Тогда
		ПоказатьПредупреждение(,"В документе больше одной строки!");
		Возврат;
	КонецЕсли;

	НастроитьВидимость();	
	
КонецПроцедуры

&НаКлиенте
Процедура НастроитьВидимость()	
		
	Элементы.СтраницаОднойСтрокой.Видимость = ВидОднойСтрокой;
	Элементы.СтраницаСписком.Видимость = НЕ ВидОднойСтрокой;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ВидОднойСтрокой = Истина;

	Если НЕ Параметры.Ключ.Пустая() Тогда
		Если Объект.Расшифровка.Количество() > 1 Тогда
			ВидОднойСтрокой = Ложь;
			Элементы.ВидОднойСтрокой.ТолькоПросмотр = Истина;
		КонецЕсли;
	Иначе
		Объект.Расшифровка.Добавить();
	КонецЕсли;
	
	НастроитьВидимость();
	
	Объект.Автор = ПовторноеИспользованиеКлиент.ТекущийПользователь();
	
КонецПроцедуры
