// Формирует и выводит сообщение, которое может быть связано с элементом 
// управления формы.
//
//  Параметры
//  ТекстСообщенияПользователю - Строка - текст сообщения.
//  КлючДанных                 - ЛюбаяСсылка - на объект информационной базы.
//                               Ссылка на объект информационной базы, к которому это сообщение относится,
//                               или ключ записи.
//  Поле                       - Строка - наименование реквизита формы.
//  ПутьКДанным                - Строка - путь к данным (путь к реквизиту формы).
//  Отказ                      - Булево - Выходной параметр.
//                               Всегда устанавливается в значение Истина.
//
//	Пример:
//
//	1. Для вывода сообщения у поля управляемой формы, связанного с реквизитом объекта:
//	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
//		НСтр("ru = 'Сообщение об ошибке.'"), ,
//		"ПолеВРеквизитеФормыОбъект",
//		"Объект");
//
//	Альтернативный вариант использования в форме объекта:
//	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
//		НСтр("ru = 'Сообщение об ошибке.'"), ,
//		"Объект.ПолеВРеквизитеФормыОбъект");
//
//	2. Для вывода сообщения рядом с полем управляемой формы, связанным с реквизитом формы:
//	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
//		НСтр("ru = 'Сообщение об ошибке.'"), ,
//		"ИмяРеквизитаФормы");
//
//	3. Для вывода сообщения связанного с объектом информационной базы.
//	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
//		НСтр("ru = 'Сообщение об ошибке.'"), ОбъектИнформационнойБазы, "Ответственный",,Отказ);
//
// 4. Для вывода сообщения по ссылке на объект информационной базы.
//	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
//		НСтр("ru = 'Сообщение об ошибке.'"), Ссылка, , , Отказ);
//
// Случаи некорректного использования:
//  1. Передача одновременно параметров КлючДанных и ПутьКДанным.
//  2. Передача в параметре КлючДанных значения типа отличного от допустимых.
//  3. Установка ссылки без установки поля (и/или пути к данным).
//
Процедура СообщитьПользователю(
		Знач ТекстСообщенияПользователю,
		Знач КлючДанных = Неопределено,
		Знач Поле = "",
		Знач ПутьКДанным = "",
		Отказ = Ложь) Экспорт
	
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = ТекстСообщенияПользователю;
	Сообщение.Поле = Поле;
	
	ЭтоОбъект = Ложь;
	
#Если НЕ ТонкийКлиент И НЕ ВебКлиент Тогда
	Если КлючДанных <> Неопределено
	   И XMLТипЗнч(КлючДанных) <> Неопределено Тогда
		ТипЗначенияСтрокой = XMLТипЗнч(КлючДанных).ИмяТипа;
		ЭтоОбъект = СтрНайти(ТипЗначенияСтрокой, "Object.") > 0;
	КонецЕсли;
#КонецЕсли
	
	Если ЭтоОбъект Тогда
		Сообщение.УстановитьДанные(КлючДанных);
	Иначе
		Сообщение.КлючДанных = КлючДанных;
	КонецЕсли;
	
	Если НЕ ПустаяСтрока(ПутьКДанным) Тогда
		Сообщение.ПутьКДанным = ПутьКДанным;
	КонецЕсли;
		
	Сообщение.Сообщить();
	
	Отказ = Истина;
	
КонецПроцедуры