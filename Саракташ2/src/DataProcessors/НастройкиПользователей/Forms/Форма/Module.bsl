
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	//Для Каждого ПользовательИБ Из ПользователиИнформационнойБазы.ПолучитьПользователей() Цикл
	//	Элементы.Пользователь1.СписокВыбора.Добавить(ПользовательИБ.Имя, СокрЛП(ПользовательИБ.ПолноеИмя));
	//	Элементы.Пользователь2.СписокВыбора.Добавить(ПользовательИБ.Имя, СокрЛП(ПользовательИБ.ПолноеИмя)); 
	//КонецЦикла;	
		
КонецПроцедуры

&НаСервере
Процедура СкопироватьНастройкиПервогоВторомуНаСервере()
	
	Пользователи2 = Новый Массив;
	Пользователи2.Добавить(Пользователь2);
	
	КопируемыеНастройки = Новый Массив;
	//КопируемыеНастройки.Добавить("НастройкиОтчетов");
	//КопируемыеНастройки.Добавить("НастройкиВнешнегоВида");
	КопируемыеНастройки.Добавить("ПерсональныеНастройки");
	//КопируемыеНастройки.Добавить("Избранное");
	КопируемыеНастройки.Добавить("НастройкиПечати");
	КопируемыеНастройки.Добавить("ПрочиеПользовательскиеНастройки");   
	
	КопированиеНастроекПользователей(Пользователь1, Пользователи2, КопируемыеНастройки);
	
КонецПроцедуры

&НаКлиенте
Процедура СкопироватьНастройкиПервогоВторому(Команда)
	СкопироватьНастройкиПервогоВторомуНаСервере();
КонецПроцедуры

// Выполняет копирование настроек пользователя с возвратом признака о наличии настроек.
//
// Параметры:
//  ПользовательИсточникСсылка - СправочникСсылка.Пользователи - 
//                             - СправочникСсылка.ВнешниеПользователи - 
//  ПользователиПриемник - Массив из ТаблицаЗначений - 
//  КопируемыеНастройки - Массив из Строка - 
//  НеСкопированныеНастройкиОтчетов - ТаблицаЗначений - где:
//    * Пользователь - СправочникСсылка.Пользователи - 
//    * СписокОтчетов - СписокЗначений - 
//
// Возвращаемое значение:
//  Булево - 
//
Функция КопированиеНастроекПользователей(ПользовательИсточникСсылка, ПользователиПриемник, КопируемыеНастройки,
										НеСкопированныеНастройкиОтчетов = Неопределено) Экспорт
	
	СоответствиеНастройкаХранилище = Новый Соответствие;
	СоответствиеНастройкаХранилище.Вставить("НастройкиОтчетов", ХранилищеПользовательскихНастроекОтчетов);
	СоответствиеНастройкаХранилище.Вставить("НастройкиВнешнегоВида", ХранилищеСистемныхНастроек);
	СоответствиеНастройкаХранилище.Вставить("ДанныеФорм", ХранилищеНастроекДанныхФорм);
	СоответствиеНастройкаХранилище.Вставить("ПерсональныеНастройки", ХранилищеОбщихНастроек);
	СоответствиеНастройкаХранилище.Вставить("Избранное", ХранилищеСистемныхНастроек);
	СоответствиеНастройкаХранилище.Вставить("НастройкиПечати", ХранилищеСистемныхНастроек);
	СоответствиеНастройкаХранилище.Вставить("ВариантыОтчетов", ХранилищеВариантовОтчетов);
	ЕстьНастройки = Ложь;
	ТаблицаВариантовОтчетов = Неопределено;
	ПользовательИсточник = ИмяПользователяИБ(ПользовательИсточникСсылка);
	
	ПолучателиНастроек = Новый Массив;
	Для Каждого Элемент Из ПользователиПриемник Цикл
		ПолучателиНастроек.Добавить(ИмяПользователяИБ(Элемент));
	КонецЦикла;
	
	// Получение пользовательских настроек.
	СведенияОПользователе = Новый Структура;
	СведенияОПользователе.Вставить("ПользовательСсылка", ПользовательИсточникСсылка);
	СведенияОПользователе.Вставить("ИмяПользователяИнформационнойБазы", ПользовательИсточник);
	ПрочиеНастройкиПользователей = Новый Структура;
	//ПользователиСлужебный.ПриПолученииПрочихНастроекПользователя(СведенияОПользователе, ПрочиеНастройкиПользователей);
	Ключи = Новый СписокЗначений;
	МассивПрочихНастроек = Новый Массив;
	Если ПрочиеНастройкиПользователей.Количество() <> 0 Тогда
		
		Для Каждого ПрочаяНастройка Из ПрочиеНастройкиПользователей Цикл
			ПрочиеНастройкиСтруктура = Новый Структура;
			Если ПрочаяНастройка.Ключ = "НастройкаБыстрогоДоступа" Тогда
				СписокНастроек = ПрочаяНастройка.Значение.СписокНастроек;
				Для Каждого Элемент Из СписокНастроек Цикл
					Ключи.Добавить(Элемент.Объект, Элемент.Идентификатор);
				КонецЦикла;
				ПрочиеНастройкиСтруктура.Вставить("ИдентификаторНастройки", "НастройкаБыстрогоДоступа");
				ПрочиеНастройкиСтруктура.Вставить("ЗначениеНастройки", Ключи);
			Иначе
				ПрочиеНастройкиСтруктура.Вставить("ИдентификаторНастройки", ПрочаяНастройка.Ключ);
				ПрочиеНастройкиСтруктура.Вставить("ЗначениеНастройки", ПрочаяНастройка.Значение.СписокНастроек);
			КонецЕсли;
			МассивПрочихНастроек.Добавить(ПрочиеНастройкиСтруктура);
		КонецЦикла;
		
	КонецЕсли;
	
	Для Каждого КопируемаяНастройка Из КопируемыеНастройки Цикл
		МенеджерНастроек = СоответствиеНастройкаХранилище[КопируемаяНастройка];
		
		Если КопируемаяНастройка = "ПрочиеПользовательскиеНастройки" Тогда
			Для Каждого ПользовательПриемник Из ПользователиПриемник Цикл
				СведенияОПользователе = Новый Структура;
				СведенияОПользователе.Вставить("ПользовательСсылка", ПользовательПриемник);
				СведенияОПользователе.Вставить("ИмяПользователяИнформационнойБазы", ИмяПользователяИБ(ПользовательПриемник));
				Для Каждого ЭлементМассива Из МассивПрочихНастроек Цикл
					//ПользователиСлужебный.ПриСохраненииПрочихНастроекПользователя(СведенияОПользователе, ЭлементМассива);
				КонецЦикла;
			КонецЦикла;
			Продолжить;
		КонецЕсли;
		
		//Если КопируемаяНастройка = "НастройкиОтчетов" Тогда
		//	
		//	Если ТипЗнч(СоответствиеНастройкаХранилище["ВариантыОтчетов"]) = Тип("СтандартноеХранилищеНастроекМенеджер") Тогда
				ТаблицаВариантовОтчетов = Неопределено; //ПользовательскиеВариантыОтчетов(ПользовательИсточник);
				ТаблицаКлючейИТиповВариантовОтчетов = Неопределено; //ПолучениеКлючейВариантовОтчетов(ТаблицаВариантовОтчетов);
		//		КопируемыеНастройки.Добавить("ВариантыОтчетов");
		//	КонецЕсли;
		//	
		//КонецЕсли;
		
		//Если КопируемаяНастройка = "НастройкиВнешнегоВида" Тогда
		//	НастройкиДинамическихСписков = ЧтениеНастроекИзХранилища(ХранилищеПользовательскихНастроекДинамическихСписков, ПользовательИсточник);
		//	СкопироватьНастройкиДинамическихСписков(ПолучателиНастроек, ПользовательИсточник, НастройкиДинамическихСписков);
		//КонецЕсли;
		
		НастройкиИзХранилища = СписокНастроек(
			ПользовательИсточник, МенеджерНастроек, КопируемаяНастройка, ТаблицаКлючейИТиповВариантовОтчетов, Истина);
		
		Если НастройкиИзХранилища.Количество() <> 0 Тогда
			ЕстьНастройки = Истина;
		КонецЕсли;
		
		Для Каждого ПользовательПриемник Из ПользователиПриемник Цикл
			СкопироватьНастройки(
				МенеджерНастроек, НастройкиИзХранилища, ПользовательИсточник, ПользовательПриемник, НеСкопированныеНастройкиОтчетов);
			ТаблицаВариантовОтчетов = Неопределено;
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат ЕстьНастройки;
	
КонецФункции

// Получает имя пользователя информационной базы по переданной ссылке
// справочника.
//
// Параметры:
//   ПользовательСсылка - СправочникСсылка.Пользователи - для которого нужно получить
//                        имя пользователя информационной базы.
//
// Возвращаемое значение
//   - Неопределено -  Если Пользователь ИБ не найден.
//   - Строка - Имя пользователя информационной базы.
// 
Функция ИмяПользователяИБ(ПользовательСсылка) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	ИдентификаторПользователяИБ = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПользовательСсылка, "ИдентификаторПользователяИБ");
	ПользовательИБ = ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(ИдентификаторПользователяИБ);
	
	Если ПользовательИБ <> Неопределено Тогда
		Возврат ПользовательИБ.Имя;
	//ИначеЕсли ПользовательСсылка = Пользователи.СсылкаНеуказанногоПользователя() Тогда
	//	Возврат "";
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

// Возвращает список пользовательских настроек.
//
// Параметры:
//  ИмяПользователя - Неопределено, Строка - 
//  МенеджерНастроек - СтандартноеХранилищеНастроекМенеджер  - 
//                   - ХранилищеНастроекМенеджер.ХранилищеВариантовОтчетов - 
//  КопируемаяНастройка - Строка - 
//  ТаблицаКлючейИТиповВариантовОтчетов - Неопределено - 
//                                      - ТаблицаЗначений - где:
//                                          * КлючВарианта - Строка - 
//                                          * Пометка - Булево - 
//  ДляКопирования - Булево - 
//
// Возвращаемое значение:
//  ТаблицаЗначений - где:
//    * КлючОбъекта - Строка - 
//    * КлючНастроек - Строка - 
//
Функция СписокНастроек(ИмяПользователя, МенеджерНастроек, 
	КопируемаяНастройка, ТаблицаКлючейИТиповВариантовОтчетов = Неопределено, ДляКопирования = Ложь)
	
	ПолучитьИзбранное = Ложь;
	ПолучитьНастройкиПечати = Ложь;
	Если КопируемаяНастройка = "Избранное" Тогда
		ПолучитьИзбранное = Истина;
	КонецЕсли;
	
	Если КопируемаяНастройка = "НастройкиПечати" Тогда
		ПолучитьНастройкиПечати = Истина;
	КонецЕсли;
	
	ТаблицаНастроек = Новый ТаблицаЗначений;
	ТаблицаНастроек.Колонки.Добавить("КлючОбъекта");
	ТаблицаНастроек.Колонки.Добавить("КлючНастроек");
	
	Отбор = Новый Структура;
	Отбор.Вставить("Пользователь", ИмяПользователя);
	
	ВыборкаНастроек = МенеджерНастроек.Выбрать(Отбор);
	
	Пропустить = Ложь;
	Пока СледующаяНастройка(ВыборкаНастроек, Пропустить) Цикл
		
		Если Пропустить Тогда
			Продолжить;
		КонецЕсли;
		
		Если Не ПолучитьИзбранное
			И СтрНайти(ВыборкаНастроек.КлючОбъекта, "ИзбранноеРаботыПользователя") <> 0 Тогда
			Продолжить;
		ИначеЕсли ПолучитьИзбранное Тогда
			
			Если СтрНайти(ВыборкаНастроек.КлючОбъекта, "ИзбранноеРаботыПользователя") = 0 Тогда
				Продолжить;
			ИначеЕсли СтрНайти(ВыборкаНастроек.КлючОбъекта, "ИзбранноеРаботыПользователя") <> 0 Тогда
				ДобавитьСтрокуВТаблицуЗначений(ТаблицаНастроек, ВыборкаНастроек);
				Продолжить;
			КонецЕсли;
			
		КонецЕсли;
		
		Если Не ПолучитьНастройкиПечати
			И СтрНайти(ВыборкаНастроек.КлючОбъекта, "НастройкиПечатиТабличногоДокумента") <> 0 Тогда
			Продолжить;
		ИначеЕсли ПолучитьНастройкиПечати Тогда
			
			Если СтрНайти(ВыборкаНастроек.КлючОбъекта, "НастройкиПечатиТабличногоДокумента") = 0 Тогда
				Продолжить;
			ИначеЕсли СтрНайти(ВыборкаНастроек.КлючОбъекта, "НастройкиПечатиТабличногоДокумента") <> 0 Тогда
				ДобавитьСтрокуВТаблицуЗначений(ТаблицаНастроек, ВыборкаНастроек);
				Продолжить;
			КонецЕсли;
			
		КонецЕсли;
		
		Если ТаблицаКлючейИТиповВариантовОтчетов <> Неопределено Тогда
			
			НайденныйВариантОтчета = ТаблицаКлючейИТиповВариантовОтчетов.Найти(ВыборкаНастроек.КлючОбъекта, "КлючВарианта");
			Если НайденныйВариантОтчета <> Неопределено Тогда
				
				Если Не НайденныйВариантОтчета.Пометка Тогда
					Продолжить;
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЕсли;
		
		Если ДляКопирования И ПропуститьНастройку(ВыборкаНастроек.КлючОбъекта, ВыборкаНастроек.КлючНастроек) Тогда
			Продолжить;
		КонецЕсли;
		
		ДобавитьСтрокуВТаблицуЗначений(ТаблицаНастроек, ВыборкаНастроек);
	КонецЦикла;
	
	Возврат ТаблицаНастроек;
	
КонецФункции

Функция СледующаяНастройка(ВыборкаНастроек, Пропустить)
	
	Попытка 
		Пропустить = Ложь;
		Возврат ВыборкаНастроек.Следующий();
	Исключение
		Пропустить = Истина;
		Возврат Истина;
	КонецПопытки;
	
КонецФункции

// Копирует пользовательские настройки.
//
// Параметры:
//  МенеджерНастроек
//  ТаблицаНастроек - ТаблицаЗначений - где:
//    * КлючОбъекта - Строка - 
//    * КлючНастроек - Строка - 
//  ПользовательИсточник - Неопределено, Строка - 
//  ПользовательПриемник - СправочникСсылка.Пользователи - 
//  НеСкопированныеНастройкиОтчетов - Неопределено - 
//
Процедура СкопироватьНастройки(МенеджерНастроек, ТаблицаНастроек, ПользовательИсточник,
								ПользовательПриемник, НеСкопированныеНастройкиОтчетов)
	
	ПользовательПриемникИБ = ИмяПользователяИБ(ПользовательПриемник);
	ТекущийПользователь = Неопределено;
	
	ОчередьНастроек = Новый Соответствие;
	ЭтоХранилищеСистемныхНастроек = (МенеджерНастроек = ХранилищеСистемныхНастроек);
	
	Для Каждого Настройка Из ТаблицаНастроек Цикл
		
		КлючОбъекта = Настройка.КлючОбъекта;
		КлючНастройки = Настройка.КлючНастроек;
		
		Если ЭтоХранилищеСистемныхНастроек Тогда
			ОчередьНастроек.Вставить(КлючОбъекта, КлючНастройки);
		КонецЕсли;
		
		Если МенеджерНастроек = ХранилищеПользовательскихНастроекОтчетов
			Или МенеджерНастроек = ХранилищеВариантовОтчетов Тогда
			
			МассивДоступныхОтчетов = ОтчетыДоступныеПользователю(ПользовательПриемникИБ, ПользовательПриемник);
			КлючОтчета = СтрРазделить(КлючОбъекта, "/", Ложь);
			Если МассивДоступныхОтчетов.Найти(КлючОтчета[0]) = Неопределено Тогда
				
				Если МенеджерНастроек = ХранилищеПользовательскихНастроекОтчетов
					И НеСкопированныеНастройкиОтчетов <> Неопределено Тогда
					
					Если ТекущийПользователь = Неопределено Тогда
						СтрокаТаблицы = НеСкопированныеНастройкиОтчетов.Добавить();
						СтрокаТаблицы.Пользователь = Строка(ПользовательПриемник.Наименование);
						ТекущийПользователь = Строка(ПользовательПриемник.Наименование);
					КонецЕсли;
					
					Если СтрокаТаблицы.СписокОтчетов.НайтиПоЗначению(КлючОтчета[0]) = Неопределено Тогда
						СтрокаТаблицы.СписокОтчетов.Добавить(КлючОтчета[0]);
					КонецЕсли;
					
				КонецЕсли;
				
				Продолжить;
			КонецЕсли;
			
		КонецЕсли;
		
		Попытка
			Значение = МенеджерНастроек.Загрузить(КлючОбъекта, КлючНастройки, , ПользовательИсточник);
		Исключение
			Продолжить;
		КонецПопытки;
		ОписаниеНастроек = МенеджерНастроек.ПолучитьОписание(КлючОбъекта, КлючНастройки, ПользовательИсточник);
		МенеджерНастроек.Сохранить(КлючОбъекта, КлючНастройки, Значение,
			ОписаниеНастроек, ПользовательПриемникИБ);
	КонецЦикла;
	
	Если Не ОбщегоНазначения.ИнформационнаяБазаФайловая()
		И ОчередьНастроек.Количество() > 0 Тогда
		ЗаполнитьОчередьНастроек(ОчередьНастроек, ПользовательПриемникИБ);
	КонецЕсли;
	
КонецПроцедуры

Процедура ДобавитьСтрокуВТаблицуЗначений(ТаблицаНастроек, ВыборкаНастроек)
	
	Если СтрНайти(ВыборкаНастроек.КлючОбъекта, "ВнешнийОтчет.") <> 0 Тогда
		Возврат;
	КонецЕсли;
	
	НоваяСтрока = ТаблицаНастроек.Добавить();
	НоваяСтрока.КлючОбъекта = ВыборкаНастроек.КлючОбъекта;
	НоваяСтрока.КлючНастроек = ВыборкаНастроек.КлючНастроек;
	
КонецПроцедуры

Процедура ЗаполнитьОчередьНастроек(ОчередьНастроек, ПолучательНастроек)
	
	СтарыеНастройки = ХранилищеОбщихНастроек.Загрузить("ОчередьНастроек", "НеПримененныеНастройки",, ПолучательНастроек);
	Если ТипЗнч(СтарыеНастройки) = Тип("ХранилищеЗначения") Тогда
		СтарыеНастройки = СтарыеНастройки.Получить();
		Если ТипЗнч(СтарыеНастройки) = Тип("Соответствие") Тогда
			ОбщегоНазначенияКлиентСервер.ДополнитьСоответствие(ОчередьНастроек, СтарыеНастройки, Истина);
		КонецЕсли;
	КонецЕсли;
	ХранилищеОбщихНастроек.Сохранить(
		"ОчередьНастроек",
		"НеПримененныеНастройки",
		Новый ХранилищеЗначения(ОчередьНастроек, Новый СжатиеДанных(9)),
		,
		ПолучательНастроек);
	
КонецПроцедуры


Функция ПропуститьНастройку(КлючОбъекта, КлючНастроек)
	
	ИсключенияПоКлючуОбъекта = Новый Массив;
	ИсключенияПоКлючуНастроек = Новый Массив;
	
	// Исключения. Настройки, которые нельзя копировать.
	ИсключенияПоКлючуОбъекта.Добавить("ЛокальныйКэшФайлов");
	ИсключенияПоКлючуНастроек.Добавить("ПутьКЛокальномуКэшуФайлов");
	
	Если ИсключенияПоКлючуОбъекта.Найти(КлючОбъекта) <> Неопределено
		И ИсключенияПоКлючуНастроек.Найти(КлючНастроек) <> Неопределено Тогда
		Возврат Истина;
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

// Формирует массив отчетов, доступных переданному пользователю.
//
// Параметры:
//  ПользовательИнформационнойБазы - Строка - имя пользователя информационной базы, у которого проверяются
//                                   права доступа на отчет.
//
// Возвращаемое значение:
//   Массив - Результат - Массив - ключи отчетов, доступных переданному пользователю.
//
Функция ОтчетыДоступныеПользователю(ИмяПользователяИБ, ПользовательСсылка)
	Результат = Новый Массив;
	
	//УстановитьПривилегированныйРежим(Истина);
	//ПользовательИБ = ПользователиИнформационнойБазы.НайтиПоИмени(ИмяПользователяИБ);
	//Для Каждого ОтчетМетаданные Из Метаданные.Отчеты Цикл
	//	
	//	Если ПравоДоступа("Просмотр", ОтчетМетаданные, ПользовательИБ) Тогда
	//		Результат.Добавить("Отчет." + ОтчетМетаданные.Имя);
	//	КонецЕсли;
	//	
	//КонецЦикла;
	//
	//Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ДополнительныеОтчетыИОбработки") Тогда
	//	МодульДополнительныеОтчетыИОбработки = ОбщегоНазначения.ОбщийМодуль("ДополнительныеОтчетыИОбработки");
	//	МодульДополнительныеОтчетыИОбработки.ПриДобавленииДополнительныхОтчетовДоступныхУказанномуПользователю(Результат,
	//		ПользовательИБ, ПользовательСсылка);
	//КонецЕсли;
	
	Возврат Результат;
	
КонецФункции
