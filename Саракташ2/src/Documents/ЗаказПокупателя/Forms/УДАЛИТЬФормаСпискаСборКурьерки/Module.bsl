&НаКлиенте
Перем мсВыбранныеЗаказы;

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	мсВыбранныеЗаказы = Новый Массив;
	СписокЗаказов.Параметры.УстановитьЗначениеПараметра("мсВыбранныеЗаказы",мсВыбранныеЗаказы);	
	
	СписокЗаказов.Параметры.УстановитьЗначениеПараметра("мсСтатусы",ПолучитьНеобходимыеСтатусыДляВывода());
	
	СписокЗаказов.Параметры.УстановитьЗначениеПараметра("мсЗаказыСНехваткойТовара",ПолучитьЗаказыСНехваткойОстатка());	
	
КонецПроцедуры

Функция ПолучитьНеобходимыеСтатусыДляВывода()
	
	мсСтатусы = Новый Массив;	
	мсСтатусы.Добавить(Справочники.СтатусыЗаказов.НайтиПоНаименованию("Заказ оплачен и  ждет отправки"));
	мсСтатусы.Добавить(Справочники.СтатусыЗаказов.НайтиПоНаименованию("В обработке"));	
	
	Возврат мсСтатусы;
	
КонецФункции

Функция ПолучитьЗаказыСНехваткойОстатка()
	
	Возврат Документы.ЗаказПокупателя.ПолучитьЗаказыСнедостающимКоличеством();
	
КонецФункции

&НаКлиенте
Процедура СписокЗаказовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле.Имя = "ЗаказВыбран" Тогда
		
		СтандартнаяОбработка = Ложь;
		
		мИндекс = мсВыбранныеЗаказы.Найти(ВыбраннаяСтрока);
		Если мИндекс = Неопределено Тогда 			
			мсВыбранныеЗаказы.Добавить(ВыбраннаяСтрока);			
		Иначе			
			мсВыбранныеЗаказы.Удалить(мИндекс);			
		КонецЕсли;
		
		СписокЗаказов.Параметры.УстановитьЗначениеПараметра("мсВыбранныеЗаказы",мсВыбранныеЗаказы);
		
	КонецЕсли;		
		
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьВсе(Команда)
	
	мсВыбранныеЗаказы.Очистить();
	
	мсВыбранныеЗаказы = ПолучитьВсеЗаказы();
			
	СписокЗаказов.Параметры.УстановитьЗначениеПараметра("мсВыбранныеЗаказы", мсВыбранныеЗаказы);
	
КонецПроцедуры

Функция ПолучитьВсеЗаказы()
	
	мсСписокЗаказов = Новый Массив;	
	
	//сграбить СКД из динамического списка выполнить ее в ТЗ и уже заполнить массив о всеми заказами
	Схема = Элементы.СписокЗаказов.ПолучитьИсполняемуюСхемуКомпоновкиДанных();
	
    Настройки = Элементы.СписокЗаказов.ПолучитьИсполняемыеНастройкиКомпоновкиДанных();
	
    КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных();
    МакетКомпоновки = КомпоновщикМакета.Выполнить(Схема, Настройки,,,Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
    ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
    ПроцессорКомпоновки.Инициализировать(МакетКомпоновки);
    
    ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений ;
    
    ТЗ = Новый ТаблицаЗначений;
    ПроцессорВывода.УстановитьОбъект(ТЗ); 
    ПроцессорВывода.Вывести(ПроцессорКомпоновки);
	
	Для Каждого Строка Из ТЗ Цикл 
		
		мсСписокЗаказов.Добавить(Строка.Ссылка);				
		
	КонецЦикла;
	
	Элементы.СписокЗаказов.ПолучитьИсполняемуюСхемуКомпоновкиДанных();
		
	Возврат мсСписокЗаказов;	
	
КонецФункции

&НаКлиенте
Процедура УбратьВыборВсех(Команда)
	
	мсВыбранныеЗаказы.Очистить();
	
	СписокЗаказов.Параметры.УстановитьЗначениеПараметра("мсВыбранныеЗаказы", мсВыбранныеЗаказы);
	
КонецПроцедуры

&НаКлиенте
Процедура Печать(Команда)
	
	Если мсВыбранныеЗаказы.Количество() = 0 Тогда 
		Сообщить("Не выбрно ни одного заказа.");	
		Возврат;
	КонецЕсли;
	
	Если Команда.Имя = "ПечатьЗаказов" ИЛИ Команда.Имя = "ПечатьЗаказовБыстрая" Тогда
		МакетПечати = "ПечатьЗаказов";
	ИначеЕсли  Команда.Имя = "ПечатьНаклеек" ИЛИ Команда.Имя = "ПечатьНаклеекБыстрая" Тогда
		МакетПечати = "ПечатьНаклеек";
	КонецЕсли;
	
	ТДПечать = Новый ТабличныйДокумент;
	ПечатьЗаказовСервер(ТДПечать, МакетПечати, мсВыбранныеЗаказы);
	ТДПечать.ОтображатьСетку = Ложь;
	ТДПечать.Защита = Ложь;
	ТДПечать.ТолькоПросмотр = Ложь;
	ТДПечать.ОтображатьЗаголовки = Ложь;
	ТДПечать.АвтоМасштаб = Истина;
	
	//Для наклеек свой принтер
	Если Команда.Имя = "ПечатьНаклеек" ИЛИ Команда.Имя = "ПечатьНаклеекБыстрая" Тогда
		ТДПечать.ИмяПринтера = ПолныеПрава.ПолучитьЗначениеКонстанты("ИмяПринтераПечатьЭтикеток");
		ТДПечать.ОриентацияСтраницы = ОриентацияСтраницы.Ландшафт;
		//ТДПечать.ПолеСверху = 10;
		//ТДПечать.ПолеСлева = 24;		
		//ТДПечать.ПолеСнизу = 10;
		//ТДПечать.ПолеСправа = 5;
		
		ТДПечать.ПолеСверху = 0;
		ТДПечать.ПолеСлева = 18;		
		ТДПечать.ПолеСнизу = 0;
		ТДПечать.ПолеСправа = 0;
		
	КонецЕсли;	
	
	Если Команда.Имя = "ПечатьЗаказов" Тогда		
		ТДПечать.Показать("Печать: Товарная накладная");
	ИначеЕсли  Команда.Имя = "ПечатьНаклеек" Тогда
		ТДПечать.Показать("Печать: Наклейки");
	ИначеЕсли Команда.Имя = "ПечатьЗаказовБыстрая" ИЛИ Команда.Имя = "ПечатьНаклеекБыстрая" Тогда
		ТДПечать.Напечатать();
	КонецЕсли;                             		
	
КонецПроцедуры

Процедура ПечатьЗаказовСервер(ТДПечать, МакетПечати, мсВыбранныеЗаказы)
	
	Для Каждого Заказ ИЗ мсВыбранныеЗаказы Цикл 
		
		ТДПечатнаяФормаДокумента = Документы.ЗаказПокупателя.ПолучитьПечатнуюФорму(Заказ,МакетПечати);			
		ТДПечать.Вывести(ТДПечатнаяФормаДокумента);
		
	КонецЦикла;	
	
КонецПроцедуры

//////////
//Измнение статусов заказов

&НаКлиенте
Процедура ИзменитьСтатус(Команда)
	
	Если мсВыбранныеЗаказы.Количество() = 0 Тогда 
		Сообщить("Не выбрно ни одного заказа.");	
		Возврат;
	КонецЕсли;
	
	сзСтатусы = ПолучитьСписокСтатусов();
	сзСтатусы.ПоказатьВыборЭлемента(Новый ОписаниеОповещения("ПослеВыбораСтатусаЗаказа",ЭтаФорма),"Выберите статус");	
	
КонецПроцедуры

Функция ПолучитьСписокСтатусов()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	СтатусыЗаказов.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.СтатусыЗаказов КАК СтатусыЗаказов
		|
		|УПОРЯДОЧИТЬ ПО
		|	Ссылка
		|АВТОУПОРЯДОЧИВАНИЕ";
	
	РезультатЗапроса = Запрос.Выполнить();	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();	
	
	сзСтатусы = Новый СписокЗначений;
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		сзСтатусы.Добавить(ВыборкаДетальныеЗаписи.Ссылка);
	КонецЦикла;
	
	Возврат сзСтатусы;
	
КонецФункции

&НаКлиенте
Процедура ПослеВыбораСтатусаЗаказа(ВыбранныйСтатус,СписокПараметров) Экспорт
	
	Если ЗначениеЗаполнено(ВыбранныйСтатус.Значение) Тогда 
		
		Для Каждого Заказ ИЗ мсВыбранныеЗаказы Цикл			
			
			ИзменитьСтатусДокумента(Заказ, ВыбранныйСтатус.Значение);
			
		КонецЦикла;
		
	КонецЕсли;
	
	СписокЗаказов.Параметры.УстановитьЗначениеПараметра("мсВыбранныеЗаказы",мсВыбранныеЗаказы);
	
КонецПроцедуры

Процедура ИзменитьСтатусДокумента(ДокументСсылка, НовыйСтатус)
	
	ДокументОбъект = ДокументСсылка.ПолучитьОбъект();	
	ДокументОбъект.Статус = НовыйСтатус;
	ДокументОбъект.Записать();	
	
КонецПроцедуры

&НаКлиенте
Процедура СписокЗаказовПриИзменении(Элемент)
	СписокЗаказов.Параметры.УстановитьЗначениеПараметра("мсЗаказыСНехваткойТовара",ПолучитьЗаказыСНехваткойОстатка());
КонецПроцедуры

&НаКлиенте
Процедура ПечатьСпискаЗаказов(Команда)
	
	ТДПечать = Новый ТабличныйДокумент;
	
	ПечатьСпискаЗаказовСервер(ТДПечать, мсВыбранныеЗаказы); 
	ТДПечать.ОтображатьСетку = Ложь;
	ТДПечать.Защита = Ложь;
	ТДПечать.ТолькоПросмотр = Ложь;
	ТДПечать.ОтображатьЗаголовки = Ложь;
	ТДПечать.АвтоМасштаб = Истина;
	
	ТДПечать.Показать("Печать: Изделия для заказов");
	
КонецПроцедуры

Процедура ПечатьСпискаЗаказовСервер(ТДПечать, мсВыбранныеЗаказы)
	
	ТДПечатнаяФорма = Документы.ЗаказПокупателя.ПолучитьПечатьСпискаЗаказов(мсВыбранныеЗаказы);
	ТДПечать.Вывести(ТДПечатнаяФорма);	

КонецПроцедуры

//Измнение статусов заказов
//////////

