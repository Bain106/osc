Для Каждого диск Из диски Цикл
	информацияОДиске = Новый ИнформацияОДиске(диск);
	Если НЕ информацияОДиске.Готов Тогда
		Продолжить;
	КонецЕсли;
	
	//Сообщить(информацияОДиске.Доступно);
	//Сообщить(информацияОДиске.ИмяФС);
	//Сообщить(информацияОДиске.ТипДиска);
	//Сообщить(информацияОДиске.Готов);
	//Сообщить(информацияОДиске.Имя);
	//Сообщить(информацияОДиске.КорневойКаталог);
	//Сообщить(информацияОДиске.ОбщийОбъемСвободногоМеста);
	//Сообщить(информацияОДиске.РазмерДиска);
	//Сообщить(информацияОДиске.МеткаТома);
	
	букваДиска = Лев(информацияОДиске.Имя, 1);
	Если буквыДисков <> "" И СтрНайти(буквыДисков, букваДиска) = 0 Тогда
		Продолжить;
	КонецЕсли;
	Если информацияОДиске.РазмерДиска = 0 Тогда
		Продолжить;
	КонецЕсли;
	свободноПроцент = Окр(информацияОДиске.ОбщийОбъемСвободногоМеста * 100 / информацияОДиске.РазмерДиска, 2);
	Сообщить(" На диске " + букваДиска + " свободно " + свободноПроцент);
	Если свободноПроцент <= критическийПорог Тогда
		текстСообщения = текстСообщения + Символы.ПС + "Zakanchivaetsya mesto na diske " + букваДиска + ", svobodno: " + свободноПроцент + "%.";
		
		// Создадим объект
		УправлениеЭП = Новый ТУправлениеЭлектроннойПочтой();
		// Введем параметры ЭП
		УчетнаяЗаписьЭП = УправлениеЭП.УчетнаяЗаписьЭП;
		УчетнаяЗаписьЭП.АдресSMTP = "smtp.yandex.ru";
		УчетнаяЗаписьЭП.ПортSMTP = 465;
		УчетнаяЗаписьЭП.ПользовательSMTP = "dst1c@yandex.ru";
		УчетнаяЗаписьЭП.ПарольSMTP = "ypcfbeexujhbyufzypcfbeexujhbyufz";
		УчетнаяЗаписьЭП.ИспользоватьSSL = Истина;
		
		// Структура сообщения
		СтруктураСообщения = УправлениеЭП.СтруктураСообщения;
		СтруктураСообщения.АдресЭлектроннойПочтыПолучателя = "tryit03@mail.ru;";
		// Флаг наличия ошибок
		БылиОшибки = Ложь;
		
		// Заполним структуру сообщения
		СтруктураСообщения.АдресЭлектроннойПочтыОтправителя = УправлениеЭП.УчетнаяЗаписьЭП.ПользовательSMTP;
		СтруктураСообщения.ТемаСообщения = "На сервере " + си.ИмяКомпьютера + " Заканчивается место";
		СтруктураСообщения.ТипТекстаПочтовогоСообщения = "HTML";
		УправлениеЭП.НачатьТекстСообщенияHTML();
		УправлениеЭП.ДобавитьВТекстСообщенияHTML();
		УправлениеЭП.ДобавитьВТекстСообщенияHTML(текстСообщения);
		УправлениеЭП.ДобавитьВТекстСообщенияHTML();
		УправлениеЭП.ЗавершитьТекстСообщенияHTML();
		
		// Отправим сообщение
		Если УправлениеЭП.ОтправитьСообщение() Тогда
			Сообщить("ОтправитьСообщение: УСПЕШНО");
		Иначе
			Сообщить("ОтправитьСообщение: " + УправлениеЭП.ТекстОшибки);
			БылиОшибки = Истина;
		КонецЕсли;
	КонецЕсли;
	
	
КонецЦикла;
Сообщить("Завершена проверка свободного места на дисках.");

