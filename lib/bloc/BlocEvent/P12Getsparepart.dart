// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newmaster/page/P13MAIN/P13VAR.dart';
import '../../data/global.dart';
import '../../widget/common/Loading.dart';
import 'package:dio/dio.dart';

//-------------------------------------------------

abstract class P12DATA_Event {}

class P12DATA_GET extends P12DATA_Event {}

class P12DATA_GET2 extends P12DATA_Event {}

class P12DATA_GET3 extends P12DATA_Event {}

class P12DATA_FLUSH extends P12DATA_Event {}

class P12DATA_Bloc extends Bloc<P12DATA_Event, List<P12MAINclass>> {
  P12DATA_Bloc() : super([]) {
    on<P12DATA_GET>((event, emit) {
      return _P12DATA_GET([], emit);
    });

    on<P12DATA_GET2>((event, emit) {
      return _P12DATA_GET2([], emit);
    });
    on<P12DATA_GET3>((event, emit) {
      return _P12DATA_GET3([], emit);
    });
    on<P12DATA_FLUSH>((event, emit) {
      return _P12DATA_FLUSH([], emit);
    });
    final List<List<String>> data;
  }

  Future<void> _P12DATA_GET(
      List<P12MAINclass> toAdd, Emitter<List<P12MAINclass>> emit) async {
    List<P12MAINclass> output = [];
    //-------------------------------------------------------------------------------------
    final response = await Dio().get(
      "${serversparepart}History",
      // data: {
      //   "InstrumentName": P01VAR.InstrumentName,
      // },
    );
    var input = [];
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.data);
      var databuff = response.data;
      input = databuff;
      List<P12MAINclass> outputdata = input.map((data) {
        return P12MAINclass(
          Customer: savenull(data['Customer']),
          Date: savenull(data['Date']),
          Month: savenull(data['Month']),
          Year: savenull(data['Year']),
          Remark: savenull(data['Remark']),
          Machine: savenull(data['Machine']),
        );
      }).toList();

      output = outputdata;
      emit(output);
    } else {
      output = [];
      emit(output);
    }
  }

  Future<void> _P12DATA_GET2(
      List<P12MAINclass> toAdd, Emitter<List<P12MAINclass>> emit) async {
    List<P12MAINclass> output = [];
    //-------------------------------------------------------------------------------------
    final response = await Dio().get(
      "${serversparepart}Historymat",
      queryParameters: {
        "Date": P13VAR.Date,
        "Month": P13VAR.Month,
        "Year": P13VAR.Year,
        "Remark": P13VAR.Remark,
        "Machine": P13VAR.Machine,
        "Customer": P13VAR.Customer,
      },
    );

    var input = [];
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.data);
      var databuff = response.data;
      input = databuff;
      List<P12MAINclass> outputdata = input.map((data) {
        return P12MAINclass(
          Mat: savenull(data['Mat']),
          Name: savenull(data['Name']),
          Volume: savenull(data['Volume']),
        );
      }).toList();

      output = outputdata;
      emit(output);
    } else {
      output = [];
      emit(output);
    }
  }

  Future<void> _P12DATA_GET3(
      List<P12MAINclass> toAdd, Emitter<List<P12MAINclass>> emit) async {
    // List<P12MAINclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P12MAINclass> datadummy = [
    //   P12MAINclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P12MAINclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P12MAINclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P12MAINclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P12DATA_FLUSH(
      List<P12MAINclass> toAdd, Emitter<List<P12MAINclass>> emit) async {
    List<P12MAINclass> output = [];
    emit(output);
  }
}

class P12MAINclass {
  P12MAINclass({
    this.Customer = '',
    this.Date = '',
    this.Month = '',
    this.Year = '',
    this.Remark = '',
    this.Machine = '',
    this.Mat = '',
    this.Name = '',
    this.Volume = '',
    this.CAL_100G_NO1 = '',
    this.CAL_100G_NO2 = '',
    this.CAL_100G_NO3 = '',
    this.CAL_100G_AVERAGE = '',
    this.CAL_200G_NO1 = '',
    this.CAL_200G_NO2 = '',
    this.CAL_200G_NO3 = '',
    this.CAL_200G_AVERAGE = '',
    this.CHECK_BY = '',
    this.APPROVE_BY = '',
    this.STATUS = '',
    this.count = 0,
  });

  String Customer;
  String Date;
  String Month;
  String Year;
  String Remark;
  String Machine;
  String Mat;
  String Name;
  String Volume;
  String CAL_100G_NO1;
  String CAL_100G_NO2;
  String CAL_100G_NO3;
  String CAL_100G_AVERAGE;
  String CAL_200G_NO1;
  String CAL_200G_NO2;
  String CAL_200G_NO3;
  String CAL_200G_AVERAGE;
  String CHECK_BY;
  String APPROVE_BY;
  String STATUS;
  int count;
}

String savenull(input) {
  String output = '';
  if (input != null) {
    output = input.toString();
  }
  return output;
}

String formatDate(String? date) {
  if (date == null || date.isEmpty) return '';
  if (date == 'CLOSE LINE') return 'CLOSE LINE';
  try {
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);
    return DateFormat('dd-MMM').format(parsedDate);
  } catch (e) {
    return '';
  }
}
