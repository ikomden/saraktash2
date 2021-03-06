
Процедура ПередЗаписью(Отказ)
	
	Телефоны = Новый Массив;
	АдресаЭП = Новый Массив;
	Адреса = Новый Массив;
	Для Каждого Стр Из КонтактнаяИнформация Цикл
		Если Стр.Тип = Перечисления.ТипыКонтактнойИнформации.Телефон Тогда
			Телефоны.Добавить(Стр.Представление);
		ИначеЕсли Стр.Тип = Перечисления.ТипыКонтактнойИнформации.АдресЭлектроннойПочты Тогда
			АдресаЭП.Добавить(Стр.Представление);
		ИначеЕсли Стр.Тип = Перечисления.ТипыКонтактнойИнформации.Адрес ИЛИ Стр.Тип = Перечисления.ТипыКонтактнойИнформации.АдресЮридический Тогда
			Адреса.Добавить(Стр.Представление);
		КонецЕсли;		
	КонецЦикла;
	
	Если Телефоны.Количество()>0 Тогда
		ПоискПоТелефону = СтрСоединить(Телефоны,";");
	Иначе
		ПоискПоТелефону = "";
	КонецЕсли;
	
	Если АдресаЭП.Количество()>0 Тогда
		ПоискПоАдресуЭлектроннойПочты = СтрСоединить(АдресаЭП,";");
	Иначе
		ПоискПоАдресуЭлектроннойПочты = "";
	КонецЕсли;
	
	Если Адреса.Количество()>0 Тогда
		ПоискПоАдресам = СтрСоединить(Адреса,";");
	Иначе
		ПоискПоАдресам = "";
	КонецЕсли;
	
	инд = КонтактнаяИнформация.Количество()-1;
	Пока инд >= 0 Цикл
		ТекСтрока = КонтактнаяИнформация[инд];
		Если ТекСтрока.Тип = Перечисления.ТипыКонтактнойИнформации.Адрес
			И Не ПустаяСтрока(ТекСтрока.Представление) Тогда
			ОсновнойАдрес = ТекСтрока.Представление;
			Прервать;
		КонецЕсли;
		инд = инд-1;
	КонецЦикла;
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если НЕ ОбменДанными.Загрузка Тогда		
		
		Выб = ПланыОбмена.ОбменССайтом.Выбрать();
		Пока Выб.Следующий() Цикл
			
			Если Выб.ЭтотУзел Тогда
				Продолжить;
			КонецЕсли;
			
			Если Выб.ПометкаУдаления
				ИЛИ НЕ Выб.Активен 
				ИЛИ НЕ Выб.ВыгружатьПользователей Тогда
				Продолжить;
			КонецЕсли;
			
			//Контрагенты
			ПланыОбмена.ЗарегистрироватьИзменения(Выб.Ссылка,Ссылка);			
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры
