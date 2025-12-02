// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newmaster/page/P01MAIN/P01VAR.dart' show P01VAR;
import 'package:newmaster/page/P11MAIN/P11VAR.dart' show P11VAR;
import '../../data/global.dart';
import '../../widget/common/Loading.dart';
import 'package:dio/dio.dart';

//-------------------------------------------------

abstract class P11DATA_Event {}

class P11DATA_GET extends P11DATA_Event {}

class P11DATA_GET2 extends P11DATA_Event {}

class P11DATA_GET3 extends P11DATA_Event {}

class P11DATA_FLUSH extends P11DATA_Event {}

class P11DATA_Bloc extends Bloc<P11DATA_Event, List<P11MAINclass>> {
  P11DATA_Bloc() : super([]) {
    on<P11DATA_GET>((event, emit) {
      return _P11DATA_GET([], emit);
    });

    on<P11DATA_GET2>((event, emit) {
      return _P11DATA_GET2([], emit);
    });
    on<P11DATA_GET3>((event, emit) {
      return _P11DATA_GET3([], emit);
    });
    on<P11DATA_FLUSH>((event, emit) {
      return _P11DATA_FLUSH([], emit);
    });
    final List<List<String>> data;
  }

  Future<void> _P11DATA_GET(
      List<P11MAINclass> toAdd, Emitter<List<P11MAINclass>> emit) async {
    List<P11MAINclass> output = [];
    //-------------------------------------------------------------------------------------
    final response = await Dio().get(
      "${serversparepart}E_StockTempGet",
      // data: {
      //   "InstrumentName": P01VAR.InstrumentName,
      // },
    );
    var input = [];
    if (response.statusCode == 200) {
      var databuff = response.data;
      input = databuff;
      List<P11MAINclass> outputdata = input.map((data) {
        return P11MAINclass(
            Mat: savenull(data['Mat']),
            Name: savenull(data['Name']),
            Volume: savenull(data['Volume']),
            Customer: savenull(data['Customer']));
      }).toList();

      output = outputdata;
      emit(output);
    } else {
      output = [];
      emit(output);
    }
  }

  Future<void> _P11DATA_GET2(
      List<P11MAINclass> toAdd, Emitter<List<P11MAINclass>> emit) async {
    List<P11MAINclass> output = [];
    //-------------------------------------------------------------------------------------
    final response = await Dio().post(
      "${serversparepart}E_StockHistory",
      data: {
        "Time": P01VAR.Time,
        "Date": P01VAR.Day,
        "Month": P01VAR.Month,
        "Year": P01VAR.Year,
        "Mat": P01VAR.Mat,
        "Volume": P01VAR.Volume,
        "Customer": P01VAR.Customer,
        "Remark": P01VAR.Remark,
        "Machine": P01VAR.Machine,
      },
    );
    // output = outputdata;
    // emit(output);
  }

  Future<void> _P11DATA_GET3(
      List<P11MAINclass> toAdd, Emitter<List<P11MAINclass>> emit) async {
    // List<P11MAINclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P11MAINclass> datadummy = [
    //   P11MAINclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P11MAINclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P11MAINclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P11MAINclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P11DATA_FLUSH(
      List<P11MAINclass> toAdd, Emitter<List<P11MAINclass>> emit) async {
    List<P11MAINclass> output = [];
    emit(output);
  }
}

class P11MAINclass {
  P11MAINclass({
    this.Mat = '',
    this.Name = '',
    this.Volume = '',
    this.Customer = '',
    this.CAL_1G_AVERAGE = '',
    this.CAL_50G_NO1 = '',
    this.CAL_50G_NO2 = '',
    this.CAL_50G_NO3 = '',
    this.CAL_50G_AVERAGE = '',
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

  String Mat;
  String Name;
  String Volume;
  String Customer;
  String CAL_1G_AVERAGE;
  String CAL_50G_NO1;
  String CAL_50G_NO2;
  String CAL_50G_NO3;
  String CAL_50G_AVERAGE;
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
