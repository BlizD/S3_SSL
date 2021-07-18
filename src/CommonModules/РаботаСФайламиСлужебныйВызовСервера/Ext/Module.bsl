﻿
// + #s3 Иванов А.Б. 12.01.2021
&ИзменениеИКонтроль("УдалитьДанные")
Процедура s3_УдалитьДанные(ФайлИлиВерсия, УникальныйИдентификатор)

	БлокировкаДанных = Новый БлокировкаДанных;
	ЭлементБлокировкиДанных = БлокировкаДанных.Добавить(ФайлИлиВерсия.Метаданные().ПолноеИмя());
	ЭлементБлокировкиДанных.УстановитьЗначение("Ссылка", ФайлИлиВерсия);

	ЭтоВерсияФайла = ТипЗнч(ФайлИлиВерсия) = Тип("СправочникСсылка.ВерсииФайлов");

	НачатьТранзакцию();
	Попытка

		БлокировкаДанных.Заблокировать();
		ЗаблокироватьДанныеДляРедактирования(ФайлИлиВерсия, , УникальныйИдентификатор);

		ФайлИлиВерсияОбъект = ФайлИлиВерсия.ПолучитьОбъект();

		Если ЭтоВерсияФайла Тогда
			Если ФайлИлиВерсияОбъект.ТипХраненияФайла = Перечисления.ТипыХраненияФайлов.ВТомахНаДиске Тогда

				Если ЗначениеЗаполнено(ФайлИлиВерсияОбъект.ПутьКФайлу) Тогда
					ПолныйПутьВТоме = ФайловыеФункции.ПолныйПутьТома(ФайлИлиВерсияОбъект.Том) + ФайлИлиВерсияОбъект.ПутьКФайлу; 
					#Удаление
					УдалитьФайл(ПолныйПутьВТоме);
					#КонецУдаления
					#Вставка 
					// + #s3 Иванов А.Б. 12.01.2021
					s3_API.УдалитьФайлСТома(ФайлИлиВерсияОбъект.Том, ПолныйПутьВТоме);
					// - #s3 Иванов А.Б. 12.01.2021					
					#КонецВставки
					ФайлИлиВерсияОбъект.ПутьКФайлу = "";
				КонецЕсли;

			Иначе
				УдалитьЗаписьИзРегистраХранимыеФайлыВерсий(ФайлИлиВерсия);
			КонецЕсли;
		КонецЕсли;

		ФайлИлиВерсияОбъект.ПометкаУдаления = Истина;
		ФайлИлиВерсияОбъект.ДополнительныеСвойства.Вставить("УдалениеДанных", Истина);
		ФайлИлиВерсияОбъект.Записать();

		РазблокироватьДанныеДляРедактирования(ФайлИлиВерсия, УникальныйИдентификатор);
		ЗафиксироватьТранзакцию();

	Исключение
		ОтменитьТранзакцию();
		РазблокироватьДанныеДляРедактирования(ФайлИлиВерсия, УникальныйИдентификатор);
		ВызватьИсключение;
	КонецПопытки;

КонецПроцедуры // - #s3 Иванов А.Б. 12.01.2021

// + #s3 Иванов А.Б. 12.01.2021
&ИзменениеИКонтроль("ДанныеФайлаИДвоичныеДанные")
Функция s3_ДанныеФайлаИДвоичныеДанные(ФайлИлиВерсияСсылка, АдресПодписи, ИдентификаторФормы)

	Если ТипЗнч(ФайлИлиВерсияСсылка) = Тип("СправочникСсылка.Файлы") Тогда
		ВерсияСсылка = ФайлИлиВерсияСсылка.ТекущаяВерсия;
		ДанныеФайла = РаботаСФайламиВызовСервера.ДанныеФайла(ФайлИлиВерсияСсылка);
	Иначе
		ВерсияСсылка = ФайлИлиВерсияСсылка;
		ДанныеФайла = РаботаСФайламиВызовСервера.ДанныеФайла(, ФайлИлиВерсияСсылка);
	КонецЕсли;

	ДвоичныеДанные = Неопределено;

	ТипХраненияФайла = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ВерсияСсылка, "ТипХраненияФайла");
	Если ТипХраненияФайла = Перечисления.ТипыХраненияФайлов.ВТомахНаДиске Тогда
		Если НЕ ВерсияСсылка.Том.Пустая() Тогда
			ПолныйПуть = ФайловыеФункцииСлужебный.ПолныйПутьТома(ВерсияСсылка.Том) + ВерсияСсылка.ПутьКФайлу; 
			Попытка
				#Удаление
				ДвоичныеДанные = Новый ДвоичныеДанные(ПолныйПуть);				
				#КонецУдаления				
				#Вставка 
				// + #s3 Иванов А.Б. 12.01.2021
				ДвоичныеДанные = s3_API.ПолучитьДвоичныеДанныеФайла(ВерсияСсылка.Том, ПолныйПуть);                                                                        
				// - #s3 Иванов А.Б. 12.01.2021
				#КонецВставки
			Исключение
				// Запись в журнал регистрации.
				СообщениеОбОшибке = СформироватьТекстОшибкиПолученияФайлСТомаДляАдминистратора(
				ИнформацияОбОшибке(), ВерсияСсылка.Владелец);

				ЗаписьЖурналаРегистрации(
				НСтр("ru = 'Файлы.Открытие файла'",
				ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
				УровеньЖурналаРегистрации.Ошибка,
				Метаданные.Справочники.Файлы,
				ВерсияСсылка.Владелец,
				СообщениеОбОшибке);

				ВызватьИсключение ФайловыеФункцииСлужебныйКлиентСервер.ОшибкаФайлНеНайденВХранилищеФайлов(
				ВерсияСсылка.ПолноеНаименование + "." + ВерсияСсылка.Расширение);
			КонецПопытки;
		КонецЕсли;
	Иначе
		ХранилищеФайла = ПолучитьХранилищеФайлаИзИнформационнойБазы(ВерсияСсылка);
		ДвоичныеДанные = ХранилищеФайла.Получить();
	КонецЕсли;

	ДвоичныеДанныеПодписи = Неопределено;
	Если АдресПодписи <> Неопределено Тогда
		ДвоичныеДанныеПодписи = ПолучитьИзВременногоХранилища(АдресПодписи);
	КонецЕсли;

	Если ИдентификаторФормы <> Неопределено Тогда
		ДвоичныеДанные = ПоместитьВоВременноеХранилище(ДвоичныеДанные, ИдентификаторФормы);
	КонецЕсли;

	СтруктураВозврата = Новый Структура("ДанныеФайла, ДвоичныеДанные, ДвоичныеДанныеПодписи",
	ДанныеФайла, ДвоичныеДанные, ДвоичныеДанныеПодписи);

	Возврат СтруктураВозврата;
КонецФункции // - #s3 Иванов А.Б. 12.01.2021
