
&НаСервере
Процедура СохранитьНаСервере(ПолноеИмяФайла)
	
	Попытка
		
		ХЗ = Константы.Наклейка.Получить();
		
		ДД = ХЗ.Получить();
		
		ДД.Записать(ПолноеИмяФайла);
		
		Сообщить("Шаблон наклейки сохранен успешно!");
		
	Исключение
		
		ОО = ОписаниеОшибки();
		Сообщить("При сохранении произошла ошибка: " + Символы.ПС + ОО);
		
	КонецПопытки;
	
КонецПроцедуры


&НаКлиенте
Процедура Сохранить(Команда)
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	Диалог.Заголовок = "Выберите имя файлф для сохранения";
	Диалог.МножественныйВыбор = Ложь;
	Диалог.Фильтр = "Табличный документ(*.mxl)|*.mxl";
	
	Если Диалог.Выбрать() Тогда
		
		СохранитьНаСервере(Диалог.ПолноеИмяФайла);
		
	КонецЕсли;
	
КонецПроцедуры


&НаСервере
Процедура ЗагрузитьНаСервере(ПолноеИмяФайла)
	
	Попытка
		
		ДД = Новый ДвоичныеДанные(ПолноеИмяФайла);		
		ХЗ = Новый ХранилищеЗначения(ДД);		
		Константы.Наклейка.Установить(ХЗ);
		
		Сообщить("Шаблон наклейки загружен успешно!");
		
	Исключение
		
		ОО = ОписаниеОшибки();
		Сообщить("При загрузке произошла ошибка: " + Символы.ПС + ОО);
		
	КонецПопытки;
	
КонецПроцедуры


&НаКлиенте
Процедура Загрузить(Команда)
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.Заголовок = "Выберите файл с шаблоном наклейки";
	Диалог.МножественныйВыбор = Ложь;
	Диалог.Фильтр = "Табличный документ(*.mxl)|*.mxl";
	
	Если Диалог.Выбрать() Тогда
		
		ЗагрузитьНаСервере(Диалог.ПолноеИмяФайла);
		
	КонецЕсли;
	
КонецПроцедуры

