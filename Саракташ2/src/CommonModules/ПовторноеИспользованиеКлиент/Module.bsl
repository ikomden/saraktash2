Функция ТекущийПользователь() Экспорт
	
	Возврат ПовторноеИспользованиеСервер.ТекущийПользователь();
	
КонецФункции

// Определяет режим эксплуатации информационной базы файловый (Истина) или серверный (Ложь).
// При проверке используется СтрокаСоединенияИнформационнойБазы, которую можно указать явно.
//
// Параметры:
//  СтрокаСоединенияИнформационнойБазы - Строка - параметр используется, если
//                 нужно проверить строку соединения не текущей информационной базы.
//
// Возвращаемое значение:
//  Булево.
//
Функция ИнформационнаяБазаФайловая(Знач СтрокаСоединенияИнформационнойБазы = "") Экспорт
			
	Возврат ПовторноеИспользованиеСервер.ИнформационнаяБазаФайловая();
	
КонецФункции

Функция ПоставщикПроизводства() Экспорт
	Возврат ПовторноеИспользованиеСервер.ПоставщикПроизводства();	
КонецФункции

Функция РазмерДляПлатков() Экспорт
	Возврат ПовторноеИспользованиеСервер.РазмерДляПлатков();	
КонецФункции

