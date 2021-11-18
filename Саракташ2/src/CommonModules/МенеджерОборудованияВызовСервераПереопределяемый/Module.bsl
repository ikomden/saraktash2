 
#Область ПрограммныйИнтерфейс

// Возвращает список доступных типов оборудования.
// 
// Возвращаемое значение:
//   Массив - Массив доступных типов подключаемого оборудования в конфигурации.
//
Функция ПолучитьДоступныеТипыОборудования() Экспорт
	
	СписокОборудования = Новый Массив;
	
	// Сканеры штрихкода
	СписокОборудования.Добавить(Перечисления.ТипыПодключаемогоОборудования.СканерШтрихкода);
	// Конец Сканеры штрихкода

	Возврат СписокОборудования;
	
КонецФункции

// Возвращает флаг возможности добавления новых драйверов в справочник драйверов.
// 
// Возвращаемое значение:
//   Булево - В случае разрешение добавления новых драйверов возвращает Истина.
//
Функция ВозможностьДобавленияНовыхДрайверов() Экспорт
	
	Возврат Истина;
	
КонецФункции

// Возвращает флаг возможности использовать подключаемое оборудование.
// 
// Возвращаемое значение:
//   Булево - В случае разрешение использовать подключаемое оборудование.
//
Функция ИспользоватьПодключаемоеОборудование() Экспорт
	
	Возврат Константы.ИспользоватьПодключаемоеОборудование.Получить();
	
КонецФункции

// Возвращает признак возможности обращения к разделенным данным из текущего сеанса.
//  
// Возвращаемое значение:
//  Булево - В случае вызова в неразделенной конфигурации возвращает Истина.
//
Функция ДоступноИспользованиеРазделенныхДанных() Экспорт
	
	Возврат ОбщегоНазначенияПовтИсп.ДоступноИспользованиеРазделенныхДанных();
	
КонецФункции

// Обновление библиотеки в целевой конфигурации.
//                                   
Процедура ОбновлениеБиблиотеки() Экспорт
	
	ОбновитьПоставляемыеДрайвера();
	ОбновитьУстановленныеДрайвера();
	
КонецПроцедуры

// Обновить поставляемые драйверы в составе конфигурации.
//                                   
Процедура ОбновитьПоставляемыеДрайвера() Экспорт
	
	// Сканеры штрихкода
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикСканкодСканерыШтрихкода, "AddIn.ScancodeScanner", , Истина, , Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикАтолСканерыШтрихкода, "AddIn.Scaner45", , Истина, , Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.Обработчик1ССканерыШтрихкода, "AddIn.Scanner", "Драйвер1ССканерШтрихкода", Ложь, "8.1.8.1");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.Обработчик1ССканерыШтрихкодаNative, "AddIn.InputDevice", "Драйвер1СУстройстваВводаNative", Ложь, "8.1.8.1");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикГексагонСканерыШтрихкода, "AddIn.ProtonScanner", "ДрайверГексагонСканерШтрихкода", Ложь);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикАтолСканерыШтрихкода8X, "AddIn.ATOL_Scaners_1CInt", "ДрайверАТОЛУстройстваВвода8X", Ложь);
	// Конец Сканеры штрихкода
	
	// Считыватели магнитных карт
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.Обработчик1ССчитывателиМагнитныхКарт, "AddIn.Scanner", "Драйвер1ССканерШтрихкода", Ложь, "8.1.8.1");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.Обработчик1ССчитывателиМагнитныхКартNative, "AddIn.InputDevice", "Драйвер1СУстройстваВводаNative", Ложь, "8.1.8.1");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикАтолСчитывателиМагнитныхКарт, "AddIn.Scaner45", , Истина, , Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикАтолСчитывателиМагнитныхКарт8X, "AddIn.ATOL_Scaners_1CInt", "ДрайверАТОЛУстройстваВвода8X", Ложь);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикIronLogicСчитывателиБесконтактныхКарт, "AddIn.ZR1CExtension", "ДрайверIronLogicCсчитывателиZ2", Ложь, "1.2.2.1");
	// Конец Считыватели магнитных карт.
	
	// Фискальные регистраторы
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.Обработчик1СФискальныйРегистраторЭмулятор, "AddIn.EmulatorFP1C", "Драйвер1СФискальныйРегистратор", Ложь, "1.0.13.1");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.Обработчик1СРарусФискальныеРегистраторыФеликс, "AddIn.fr_feliksRMK1c82", "Драйвер1СРарусФискальныеРегистраторыФеликс", Ложь, "1.2.3.9");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.Обработчик1СРарусФискальныеРегистраторыМебиус, "AddIn.fr_moebius1c82", "Драйвер1СРарусФискальныеРегистраторыМебиус", Ложь, "1.1.1.5");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикАтолФискальныеРегистраторы, "AddIn.ATOL_KKM_1C", , Истина, , Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикАтолФискальныеРегистраторыУниверсальный, "AddIn.ATOL_KKM_1C", , Истина, , Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикАтолФискальныеРегистраторы8X, "AddIn.ATOL_KKM_1C82", "ДрайверАТОЛФискальныеРегистраторы8X", Ложь);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикВерсияТФискальныеРегистраторы, "AddIn.KSBFR1K1C", , Истина, ,Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикККСФискальныеРегистраторы, "AddIn.SparkTF", "ДрайверККСФискальныеРегистраторы", Ложь);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикШтрихМФискальныеРегистраторы, "AddIn.DrvFR1C", , Истина, , Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикШтрихМФискальныеРегистраторыУниверсальный, "AddIn.SMDrvFR1C", "ДрайверШтрихМФискальныеРегистраторы", Ложь);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикОРИОНФискальныеРегистраторы, "AddIn.OrionFR_1C8", , Истина, ,Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикКристаллСервисФискальныеРегистраторыPirit, "AddIn.PiritK", "ДрайверКристаллСервисФискальныеРегистраторыPirit", Ложь, "4.02");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикДримкасФискальныеРегистраторыVikiPrint, "AddIn.VikiP", "ДрайверДримкасФискальныеРегистраторыVikiPrint", Ложь, "4.02");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикИскраФискальныеРегистраторыПрим, "AddIn.IskraFR", "ДрайверИскраФискальныеРегистраторыПрим", Ложь, "1.0.0.5");
	// Конец Фискальные регистраторы.
	
	// ККТ с передачей данных                                                                                                                            
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикАтолККТ54ФЗ, "AddIn.ATOL_KKM_1C82_54FZ", "ДрайверАТОЛККТ54ФЗ", Ложь);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикАтолККТ54ФЗ9X, "AddIn.ATOL_KKT_1C83_V9", "ДрайверАтолККТ54ФЗ9X", Ложь, "9.12.1.6236");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикШтрихМККТ54ФЗ, "AddIn.SMDrvFR1C22", "ДрайверШтрихМККТ54ФЗ", Ложь);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикВерсияТK1Ф54ФЗ, "AddIn.VT_KKT_1CInt", "ДрайверВерсияТK1Ф54ФЗ", Ложь);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикИскраККТ54ФЗ, "AddIn.IskraKKT", "ДрайверИскраККТ54ФЗ", Ложь, "2.0.1.5");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикККСККТ54ФЗ, "AddIn.Spark115F", "ДрайверККСККТ54ФЗ", Ложь, "1.0.0.1");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикMSTARККТ54ФЗ, "AddIn.AlfaFiscalPrinter", "ДрайверMSTARККТ54ФЗ", Ложь, "1.0.13");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикСчетмашККТ54ФЗ, "AddIn.fr_feliksrmf1c83", "ДрайверСчетмашККТ54ФЗ", Ложь, "1.1.0.18");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикNEWTONККТ54ФЗ, "AddIn.NewtonMicroFR54FZ", "ДрайверNEWTONККТ54ФЗ",  Ложь, "1.0.5.6");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикARSККТ54ФЗ, "AddIn.Ars1CFiscalDriver", "ДрайверARSККТ54ФЗ",  Ложь, "1.0.9");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикДримкасККТ54ФЗ, "AddIn.VikiP", "ДрайверДримкасККТ54ФЗ",  Ложь, "1.2.0.923");
	// Конец ККТ с передачей данных                                                                                              
	
	// Принтеры чеков
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.Обработчик1СПринтерЧеков, "AddIn.ReceiptPrinterNative", "Драйвер1СПринтерЧеков", Ложь, "2.0.3.5");
	// Конец Принтеры чеков.
	
	// Дисплеи покупателя
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикАтолДисплеиПокупателя, "AddIn.Line45", , Истина, , Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикККСДисплеиПокупателя, "AddIn.VFCD220E", "ДрайверККСДисплеиПокупателя", Ложь, "1.0.1.1");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикСканкодДисплеиПокупателя, "AddIn.1CDSPPromag", , Истина, , Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикШтрихМДисплеиПокупателя, "AddIn.LineDisplay", , Истина, , Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикКристаллСервисДисплеиПокупателяVikiVision, "AddIn.VikiVision", "ДрайверКристаллСервисДисплеиПокупателяVikiVision", Ложь, "1.03");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.Обработчик1СДисплейПокупателя, "AddIn.CustomerDisplay1C", "Драйвер1СДисплейПокупателя", Ложь, "1.0.5.1");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикАтолДисплеиПокупателя8X, "AddIn.ATOL_Line_1CInt", "ДрайверАТОЛДисплейПокупателя8X", Ложь);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикСканкодДисплеиПокупателяNative, "AddIn.DSPPromag8", "ДрайверСканкодДисплеиПокупателяNative", Ложь, "1.0.0.3");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикPOSUAДисплеиПокупателя, "AddIn.LPOSVFD", "ДрайверPOSUAДисплеиПокупателя", Ложь, "1.0.8.0");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.Обработчик1СРарусДисплеиПокупателя, "Addin.d_android1c83", "Драйвер1СРарусДисплеиПокупателя", Ложь, "1.0.15.54");
	// Конец Дисплеи покупателя
	
	// Терминалы сбора данных
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикАтолТерминалыСбораДанных, "AddIn.PDX45", , Истина, , Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикГексагонТерминалыСбораДанных, "AddIn.ProtonTSD", "ДрайверГексагонТСД", Ложь, "6.6");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикСканкодТерминалыСбораДанных, "AddIn.CipherLab", , Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикСканситиТерминалыСбораДанных, "AddIn.iPOSoft_DT", "ДрайверСканситиТСДCipherLab", Истина, ,Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикКлеверенсТерминалыСбораДанных, "AddIn.Cleverence.TO_TSD", "ДрайверКлеверенсТСД", Ложь);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикШтрихМТерминалыСбораДанных, "AddIn.Terminals", , Истина, ,Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикАтолТерминалыСбораДанныхMobileLogistics, "AddIn.PDX1C_Int", "ДрайверАТОЛТСДMobileLogistics", Ложь);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикСканкодТерминалыСбораДанныхNative, "AddIn.CipherLab8", "ДрайверСканкодТерминалыСбораДанныхNative", Ложь, "1.0.0.9");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикRightScanТерминалыСбораДанных, "AddIn.RSExchange", "ДрайверRightScanТерминалыСбораДанных", Ложь);
	// Конец Терминалы сбора данных.
	
	// Эквайринговые терминалы
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикИНПАСЭквайринговыеТерминалыSmart, "AddIn.a_inpas1c82", "ДрайверИНПАСЭквайринговыеТерминалыSmart", Ложь, "1.0.0.24", Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикИНПАСЭквайринговыеТерминалыUNIPOS, "AddIn.a_inpasDC1c83", "ДрайверИНПАСЭквайринговыеТерминалыUNIPOS", Ложь, "1.1.1.2");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикTRPOSЭквайринговыеТерминалы, "AddIn.a_trpos1c82", "ДрайверTRPOSЭквайринговыеТерминалы", Ложь, "1.0.0.34");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикСБРФЭквайринговыеТерминалы, "AddIn.SBRFCOMObject|AddIn.SBRFCOMExtension", , Истина, , Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикUCSEFTPOSЭквайринговыеТерминалы, "AddIn.UCS_EFTPOS", "ДрайверUCSEFTPOSЭквайринговыеТерминалы", Ложь, "1.0.8.3");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикГАЗПРОМБАНКЭквайринговыеТерминалы, "AddIn.GPBEMVGateNativeAPI1C", "ДрайверГАЗПРОМБАНКЭквайринговыеТерминалы", Ложь, "1.0.3.5");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикARCUS2ЭквайринговыеТерминалыIngenico, "AddIn.IngenicoDriver1C", "ДрайверARCUS2ЭквайринговыеТерминалыIngenico", Ложь, "1.0.0.1");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикIboxProПоддержкаMPosЭквайринга, "AddIn.iboxPro", "ДрайверIboxProПоддержкаMPosЭквайринга", Ложь, "1.2.4");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикШтрихМПлатежныйТерминалYarus, "AddIn.ShtrihPayMan1C", "ДрайверШтрихМПлатежныйТерминалYarus", Ложь);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.Обработчик1СЭквайринговыеТерминалыСбербанк, "AddIn.SberAcquiringTerminal", "Драйвер1СЭквайринговыеТерминалыСбербанк", Ложь, "1.0.2.1");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикMPos2canЭквайринг, "AddIn.mPos2can", "ДрайверMPos2canЭквайринг", Ложь, "1.5.9");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикSKAM1CЭквайринговыеСистемы, "AddIn.skam", "ДрайверSKAM1CЭквайринговыеСистемы", Ложь);
	// Конец Эквайринговые терминалы.
	                           
	// Электронные весы
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикАтолЭлектронныеВесы, "AddIn.Scale45", , Истина, , Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикШтрихМЭлектронныеВесы, "AddIn.Scale45", , Истина, ,Истина);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикCASЭлектронныеВесы, "AddIn.CasCentreSimpleScale", "ДрайверCASЭлектронныеВесы", Ложь);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикАтолЭлектронныеВесы8X, "AddIn.ATOL_Scale_1CInt", "ДрайверАТОЛЭлектронныеВесы8X", Ложь);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикМассаКЭлектронныеВесы, "AddIn.MassaKDriverR1C", "ДрайверМассаКЭлектронныеВесыИСПечатьюЭтикеток", Ложь, "2.3.10063");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикШтрихМЭлектронныеВесыPOS2, "AddIn.DrvSM1C", "ДрайверШтрихМЭлектронныеВесыPOS2", Ложь);
	// Конец Электронные весы
	
	// Весы с печатью этикеток
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикACOMВесыСПечатьюЭтикеток);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикШтрихМВесыСПечатьюЭтикеток, "AddIn.DrvLP", , Истина, ,Истина);    
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикCASВесыСПечатьюЭтикеток, "AddIn.CasCentrePrintingScale", "ДрайверCASВесыСПечатьюЭтикеток", Ложь); 
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикМассаКВесыСПечатьюЭтикеток, "AddIn.MassaKDriverR1C", "ДрайверМассаКЭлектронныеВесыИСПечатьюЭтикеток", Ложь, "2.3.10063");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикАТОЛВесыСПечатьюЭтикеток8X, "AddIn.ATOL_ScaleLP_1CInt", "ДрайверАТОЛВесыСПечатьюЭтикеток8X", Ложь);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикРБСВесыCПечатьюЭтикеток, "AddIn.Rbs1CDriver", "ДрайверРБСВесыCПечатьюЭтикеток", Ложь, "1.0.6");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикШтрихМВесыСПечатьюЭтикетокШтрихПринт, "AddIn.DrvLP1C", "ДрайверШтрихМВесыСПечатьюЭтикетокШтрихПринт", Ложь, "A.1.8.550");
	// Конец Весы с печатью этикеток.
	
	// Офлайн оборудование
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикАтолККМOffline);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикШтрихМККМOffline);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.Обработчик1СККМOffline);
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.Обработчик1СЭвоторККМOffline);
	// Конец Офлайн оборудование
	
	// Принтеры этикеток
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикГексагонПринтераЭтикеток, "AddIn.HexagonLabelPrinterDriver", "ДрайверГексагонПринтераЭтикеток", Ложь, "2.6.6");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикСканситиПринтераЭтикеток, "AddIn.ScanCityTSC1C", "ДрайверСканситиПринтераЭтикеток", Ложь, "1.0.0.42");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикСканкодПринтераЭтикетокGodexEZPL8Native, "AddIn.GodexEZPL8", "ДрайверСканкодПринтераЭтикетокGodexEZPL8Native", Ложь, "1.0.0.31");
	// Конец Принтеры этикеток.
	
	// RFID считыватели
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикERFIDСчитывательRFID, "AddIn.RFIDReader", "ДрайверERFIDСчитывательRFID", Ложь, "1.0.0.11");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикКлеверенсСчитывателиRFID, "AddIn.Cleverence.TO_RFID", "ДрайверКлеверенсCчитывателиRFID", Ложь, "1.2.33");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикСканкодСчитывательRFIDCipherLab, "AddIn.CipherLab186x", "ДрайверСканкодСчитывательRFIDCipherLab", Ложь, "1.0.0.12");
	Справочники.ДрайверыОборудования.ЗаполнитьПредопределенныйЭлемент(Перечисления.ОбработчикиДрайверовПодключаемогоОборудования.ОбработчикISBCСчитывательRFID, "AddIn.RFIDDevice", "ДрайверISBCСчитывательRFID", Ложь, "1.1.1.0");
	// Конец RFID считыватели
	
КонецПроцедуры

// Обновить установленные драйвера.
//
Процедура ОбновитьУстановленныеДрайвера() Экспорт
	
	// Сканеры штрихкода
	МенеджерОборудованияВызовСервера.ОбновитьУстановленныеДрайвера(Перечисления.ТипыПодключаемогоОборудования.СканерШтрихкода);
	// Конец Сканеры штрихкода
	//-- НЕ ГИСМ
	
КонецПроцедуры

// Возвращает флаг возможности использовать драйверов снятых с поддержки.
// 
// Возвращаемое значение:
//   Булево - В случае возможность использовать снятых с поддержки драйверов возвращает Истина.
//
Функция ВозможностьИспользоватьСнятыхСПоддержкиДрайверов() Экспорт
	
	Возврат Истина;
	
КонецФункции

#КонецОбласти

#Область ПроцедурыОбновленияБПОМеждуВерсиями

// Обновить параметры ККТ.
//
Процедура ОбновитьПараметрыККТ() Экспорт
КонецПроцедуры

// Обновить параметры ККМ Офлайн.
//
Процедура ОбновитьПараметрыККМОфлайн205() Экспорт
	
КонецПроцедуры

//Обновить параметры ККМ Офлайн Эвотор
Процедура ОбновитьПараметрыККМОфлайнЭвотор() Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти

#Область ОборудованиеККТ

// Процедура заполняет реквизиты организации для регистрации ФН.
//
Процедура ЗаполнитьРеквизитыОрганизацииДляРегистрацииФН(Организация, ПараметрыРегистрации) Экспорт
	
КонецПроцедуры

// Получить структуру шаблона чека.
Функция ПолучитьСтруктуруШаблонаЧека(ПараметрыШаблонаЧека, ДополнительныйТекст = "", ТипОборудования = "") Экспорт
	
КонецФункции 

#КонецОбласти

#Область ОборудованиеOffline

// Функция возвращает префикс весового товара применяемого для генерации штрихкода.
// Используется при выгрузке в весы с печатью этикеток.
//
// Параметры:
//  ПодключаемоеОборудованиеСсылка - Ссылка на экземпляр подключаемого оборудования.
// 
// Возвращаемое значение:
//   Число - Префикс весового товара.
//
Функция ПолучитьПрефиксВесовогоТовара(ПодключаемоеОборудованиеСсылка) Экспорт
	
	Возврат Неопределено;
	
КонецФункции

// Функция возвращает префикс штучного товара применяемого для генерации штрихкода.
// Используется при выгрузке в весы с печатью этикеток.
//
// Параметры:
//  ПодключаемоеОборудованиеСсылка - Ссылка на экземпляр подключаемого оборудования.
// 
// Возвращаемое значение:
//   Число - Префикс штучного товара который фасуется на весах.
//
Функция ПолучитьПрефиксШтучногоТовара(ПодключаемоеОборудованиеСсылка) Экспорт
	
	Возврат Неопределено;
	
КонецФункции

#КонецОбласти

#Область РаботаСФормойЭкземпляраОборудования

// Дополнительные переопределяемые действия с управляемой формой в Экземпляре оборудования
// при событии "ПриСозданииНаСервере".
//
Процедура ЭкземплярОборудованияПриСозданииНаСервере(Объект, ЭтаФорма, Отказ, Параметры, СтандартнаяОбработка) Экспорт
	//++ НЕ ГИСМ
	Элемент = ЭтаФорма.Элементы.Добавить("ПравилоОбмена", Тип("ПолеФормы"), );
	Элемент.Вид = ВидПоляФормы.ПолеВвода;
	Элемент.ПутьКДанным = "Объект.ПравилоОбмена";
	
	ЭтаФорма.Элементы.ПравилоОбмена.Видимость = Ложь;	
КонецПроцедуры

// Дополнительные переопределяемые действия с управляемой формой в Экземпляре оборудования
// при событии "ПриЧтенииНаСервере".
//
Процедура ЭкземплярОборудованияПриЧтенииНаСервере(ТекущийОбъект, ЭтаФорма) Экспорт

КонецПроцедуры

// Дополнительные переопределяемые действия с управляемой формой в Экземпляре оборудования
// при событии "ПередЗаписьюНаСервере".
//
Процедура ЭкземплярОборудованияПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи) Экспорт

КонецПроцедуры

// Дополнительные переопределяемые действия с управляемой формой в Экземпляре оборудования
// при событии "ПриЗаписиНаСервере".
//
Процедура ЭкземплярОборудованияПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи) Экспорт

КонецПроцедуры

// Дополнительные переопределяемые действия с управляемой формой в Экземпляре оборудования
// при событии "ПослеЗаписиНаСервере".
//
Процедура ЭкземплярОборудованияПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи) Экспорт

КонецПроцедуры

// Дополнительные переопределяемые действия с управляемой формой в Экземпляре оборудования
// при событии "ОбработкаПроверкиЗаполненияНаСервере".
//
Процедура ЭкземплярОборудованияОбработкаПроверкиЗаполненияНаСервере(Объект, ЭтаФорма, Отказ, ПроверяемыеРеквизиты) Экспорт

КонецПроцедуры

#КонецОбласти

// Функция возвращает параметры выбора для поля ввода ПравилоОбмена.
//
Функция ПолучитьПараметрыВыбораПравилаОбмена(ПодключаемоеОборудованиеОбъект) Экспорт
	
	ПараметрыВыбора = Новый Массив;
	
	
	Возврат Новый ФиксированныйМассив(ПараметрыВыбора);
	
КонецФункции

// Функция создает узел для данного экземпляра подключаемого оборудования и возвращает ссылку на него
// Применяется перед записью элемента справочника Подключаемое оборудование.
Функция ПолучитьУзелРИБ(ПодключаемоеОборудованиеОбъект) Экспорт
	
	//++ НЕ ГИСМ
	УзелОбъект = ПланыОбмена.ОбменСПодключаемымОборудованиемOffline.СоздатьУзел();
	УзелОбъект.УстановитьНовыйКод();
	УзелОбъект.Наименование = ПодключаемоеОборудованиеОбъект.Наименование;
	УзелОбъект.Записать();
	
	Возврат УзелОбъект.Ссылка;
	//-- НЕ ГИСМ
	
	Возврат Неопределено;
	
КонецФункции
