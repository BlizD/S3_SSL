﻿
// + #s3 Иванов А.Б. 12.01.2021
&НаСервере
Процедура s3_ПриСозданииНаСервереПосле(Отказ, СтандартнаяОбработка)
	
	Если Объект.Ссылка.Пустая() Тогда
		s3_РазрешеноИзменениеНастроекХранилищаS3 = Истина;
	КонецЕсли;
	
	s3_УправлениеФормой();
	
КонецПроцедуры // - #s3 Иванов А.Б. 12.01.2021

// + #s3 Иванов А.Б. 12.01.2021
&НаСервере
Процедура s3_УправлениеФормой()
	
	Элементы.s3_ТипХранилища.ТолькоПросмотр = Истина;
	Элементы.s3_АдресХранилища.ТолькоПросмотр = Истина;
	Элементы.s3_ИмяПрефикса.ТолькоПросмотр = Истина;
	Элементы.s3_ИмяПрефиксаРабочаяБаза.ТолькоПросмотр = Истина;
	Элементы.s3_Регион.ТолькоПросмотр = Истина;
	Элементы.s3_ИдентификаторКлючаДоступа.ТолькоПросмотр = Истина;
	Элементы.s3_СекретныйКлюч.ТолькоПросмотр = Истина;
	
	ЭтоРабочаяБаза = s3_API.s3_ЭтоРабочаяБаза();
	
	Если ЭтоРабочаяБаза 
		И s3_РазрешеноИзменениеНастроекХранилищаS3 Тогда
		Элементы.s3_ИмяПрефиксаРабочаяБаза.ТолькоПросмотр = Ложь;	
	КонецЕсли;
	
	Если s3_РазрешеноИзменениеНастроекХранилищаS3 Тогда
		
		Элементы.s3_ТипХранилища.ТолькоПросмотр = Ложь;
		Элементы.s3_АдресХранилища.ТолькоПросмотр = Ложь;
		Элементы.s3_ИмяПрефикса.ТолькоПросмотр = Ложь;
		Элементы.s3_Регион.ТолькоПросмотр = Ложь;
		Элементы.s3_ИдентификаторКлючаДоступа.ТолькоПросмотр = Ложь;
		Элементы.s3_СекретныйКлюч.ТолькоПросмотр = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры // - #s3 Иванов А.Б. 12.01.2021

// + #s3 Иванов А.Б. 12.01.2021
&НаКлиенте
Процедура s3_ИмяПрефиксаПриИзмененииПосле(Элемент)
	
	ЭтоРабочаяБаза = s3_API.s3_ЭтоРабочаяБаза();
	
	Если ЭтоРабочаяБаза Тогда
		Если НЕ ЗначениеЗаполнено(Объект.s3_ИмяПрефиксаРабочаяБаза) Тогда
			Объект.s3_ИмяПрефиксаРабочаяБаза = Объект.s3_ИмяПрефикса;	
		КонецЕсли;
	КонецЕсли;
	
	s3_СформироватьНаименование();
	
КонецПроцедуры // - #s3 Иванов А.Б. 12.01.2021

&НаКлиенте
Процедура s3_СформироватьНаименование()
	
	Если Объект.Ссылка.Пустая() Тогда
		Объект.Наименование = СтрШаблон("%1 (%2)"
					, Объект.s3_ИмяПрефикса
					, Объект.s3_АдресХранилища);
	КонецЕсли;

КонецПроцедуры


// + #s3 Иванов А.Б. 12.01.2021
&НаСервере
Процедура s3_РазрешеноИзменениеНастроекХранилищаS3ПриИзмененииПослеНаСервере()
	s3_УправлениеФормой();
КонецПроцедуры // - #s3 Иванов А.Б. 12.01.2021

// + #s3 Иванов А.Б. 12.01.2021
&НаКлиенте
Процедура s3_РазрешеноИзменениеНастроекХранилищаS3ПриИзмененииПосле(Элемент)
	s3_РазрешеноИзменениеНастроекХранилищаS3ПриИзмененииПослеНаСервере();
КонецПроцедуры // - #s3 Иванов А.Б. 12.01.2021

&НаКлиенте
Процедура s3_ТипХранилищаПриИзменении(Элемент)
	s3_УправлениеФормой();
КонецПроцедуры

&НаКлиенте
Процедура s3_s3_АдресХранилищаПриИзмененииПосле(Элемент)
	s3_СформироватьНаименование();
КонецПроцедуры
