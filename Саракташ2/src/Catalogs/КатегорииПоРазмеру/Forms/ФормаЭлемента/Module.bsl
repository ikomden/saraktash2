
//Получение данных на сервере{
Функция ПолучитьДополнительныеРеквизитыПоКоду(Код)
	Возврат ПланыВидовХарактеристик.ДополнительныеРеквизиты.НайтиПоКоду(Код);	
КонецФункции

Функция ПолучитьВариантыДопРеквизитов(ДополнительныйРеквизит)
	
	мсВариантыЗначений = Новый Массив;

	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ДополнительныеЗначенияРеквизитов.Ссылка КАК ВариантЗначения,
	|	ДополнительныеЗначенияРеквизитов.Наименование КАК Наименование
	|ИЗ
	|	Справочник.ДополнительныеЗначенияРеквизитов КАК ДополнительныеЗначенияРеквизитов
	|ГДЕ
	|	ДополнительныеЗначенияРеквизитов.Владелец = &Владелец
	|
	|УПОРЯДОЧИТЬ ПО
	|	Наименование
	|АВТОУПОРЯДОЧИВАНИЕ";	
	Запрос.УстановитьПараметр("Владелец", ДополнительныйРеквизит);	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		мсВариантыЗначений.Добавить(Выборка.ВариантЗначения);		
	КонецЦикла;
	
	Возврат мсВариантыЗначений;
	
КонецФункции

&НаКлиенте
Процедура СоставРазмерНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
		СтандартнаяОбработка = Ложь;
		
	ДополнительныйРеквизитРазмер = ПолучитьДополнительныеРеквизитыПоКоду("000000001");
	
	//Размер
	Элемент.СписокВыбора.Очистить();
	Элемент.СписокВыбора.ЗагрузитьЗначения(ПолучитьВариантыДопРеквизитов(ДополнительныйРеквизитРазмер)); //Размер

КонецПроцедуры
