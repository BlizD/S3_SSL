﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

&ИзменениеИКонтроль("ПриКомпоновкеРезультата")
Процедура s3_ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)

	#Удаление
	ТаблицаФайловНаДиске = Новый ТаблицаЗначений;
	ТаблицаФайловНаДиске.Колонки.Добавить("Имя");
	ТаблицаФайловНаДиске.Колонки.Добавить("Файл");
	ТаблицаФайловНаДиске.Колонки.Добавить("Ссылка");
	ТаблицаФайловНаДиске.Колонки.Добавить("ИмяБезРасширения");
	ТаблицаФайловНаДиске.Колонки.Добавить("ПолноеИмя");
	ТаблицаФайловНаДиске.Колонки.Добавить("Путь");
	ТаблицаФайловНаДиске.Колонки.Добавить("Том");
	ТаблицаФайловНаДиске.Колонки.Добавить("Расширение");
	ТаблицаФайловНаДиске.Колонки.Добавить("СтатусПроверки");
	ТаблицаФайловНаДиске.Колонки.Добавить("Количество");
	ТаблицаФайловНаДиске.Колонки.Добавить("Отредактировал");
	ТаблицаФайловНаДиске.Колонки.Добавить("ДатаРедактирования");
	ТаблицаФайловНаДиске.Колонки.Добавить("ВремяИзменения");
	ТаблицаФайловНаДиске.Колонки.Добавить("Размер");
	#КонецУдаления
	#Вставка 
	// [+] Иванов А.Б. 31.10.21 
	ТаблицаФайловНаДиске = s3_API.ПолучитьОписаниеТаблицаФайловНаДиске();
	// [-] Иванов А.Б. 31.10.21 
	#КонецВставки	

	ПараметрТом = КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("Том");

	Если ПараметрТом <> Неопределено Тогда
		ПутьКТому = ФайловыеФункцииСлужебный.ПолныйПутьТома(ПараметрТом.Значение);
	КонецЕсли;

	#Удаление
	МассивФайлов = НайтиФайлы(ПутьКТому,"*", Истина);
	Для Каждого Файл Из МассивФайлов Цикл
		Если Не Файл.ЭтоФайл() Тогда 
			Продолжить;
		КонецЕсли;
		НоваяСтрока = ТаблицаФайловНаДиске.Добавить();
		НоваяСтрока.Имя = Файл.Имя;
		НоваяСтрока.ИмяБезРасширения = Файл.ИмяБезРасширения;
		НоваяСтрока.ПолноеИмя = Файл.ПолноеИмя;
		НоваяСтрока.Путь = Файл.Путь;
		НоваяСтрока.Расширение = Файл.Расширение;
		НоваяСтрока.ВремяИзменения = Файл.ПолучитьВремяИзменения();
		НоваяСтрока.Размер = Файл.Размер();
		НоваяСтрока.СтатусПроверки = НСтр("ru = 'Лишние файлы (есть на диске, но сведения о них отсутствуют)'");
		НоваяСтрока.Количество = 1;
		НоваяСтрока.Том = ПараметрТом.Значение;
	КонецЦикла;
	#КонецУдаления
	#Вставка 
	// [+] Иванов А.Б. 31.10.21
	СсылкаНаТом = ПараметрТом.Значение;
	Если s3_API.ЭтоТипХранилища_ОбъектноеS3(СсылкаНаТом) Тогда
		ТаблицаФайловНаДиске = s3_API.ПолучитьСписокФайловСДискаS3(СсылкаНаТом);	
	Иначе
		МассивФайлов = НайтиФайлы(ПутьКТому, "*", Истина);
		Для Каждого Файл Из МассивФайлов Цикл
			Если Не Файл.ЭтоФайл() Тогда 
				Продолжить;
			КонецЕсли;
			НоваяСтрока = ТаблицаФайловНаДиске.Добавить();
			НоваяСтрока.Имя = Файл.Имя;
			НоваяСтрока.ИмяБезРасширения = Файл.ИмяБезРасширения;
			НоваяСтрока.ПолноеИмя = Файл.ПолноеИмя;
			НоваяСтрока.Путь = Файл.Путь;
			НоваяСтрока.Расширение = Файл.Расширение;
			НоваяСтрока.ВремяИзменения = Файл.ПолучитьВремяИзменения();
			НоваяСтрока.РазмерВТомеХраненияФайлов = Файл.Размер();
			НоваяСтрока.СтатусПроверки = НСтр("ru = 'Лишние файлы (есть на диске, но сведения о них отсутствуют)'");
			НоваяСтрока.Количество = 1;
			НоваяСтрока.Том = ПараметрТом.Значение;
		КонецЦикла;
		
	КонецЕсли;	
	// [-] Иванов А.Б. 31.10.21
	#КонецВставки	

	РаботаСФайламиВызовСервера.ПроверитьЦелостностьФайлов(ТаблицаФайловНаДиске, ПараметрТом.Значение);

	СтандартнаяОбработка = Ложь;

	ДокументРезультат.Очистить();

	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	Настройки = КомпоновщикНастроек.ПолучитьНастройки();

	ВнешниеНаборыДанных = Новый Структура;
	ВнешниеНаборыДанных.Вставить("ТаблицаПроверкиТома", ТаблицаФайловНаДиске);

	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, Настройки, ДанныеРасшифровки);

	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, ВнешниеНаборыДанных, ДанныеРасшифровки, Истина);

	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);

	ПроцессорВывода.Вывести(ПроцессорКомпоновки);

КонецПроцедуры

#КонецОбласти

#КонецЕсли
