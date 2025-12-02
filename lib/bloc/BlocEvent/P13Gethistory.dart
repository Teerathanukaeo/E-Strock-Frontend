// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newmaster/page/P13MAIN/P13VAR.dart';
import '../../data/global.dart';
import '../../widget/common/Loading.dart';
import 'package:dio/dio.dart';

//-------------------------------------------------

abstract class P13DATA_Event {}

class P13DATA_GET extends P13DATA_Event {}

class P13DATA_GET2 extends P13DATA_Event {}

class P13DATA_GET3 extends P13DATA_Event {}

class P13DATA_FLUSH extends P13DATA_Event {}

class P13DATA_Bloc extends Bloc<P13DATA_Event, List<P13MAINclass>> {
  P13DATA_Bloc() : super([]) {
    on<P13DATA_GET>((event, emit) {
      return _P13DATA_GET([], emit);
    });

    on<P13DATA_GET2>((event, emit) {
      return _P13DATA_GET2([], emit);
    });
    on<P13DATA_GET3>((event, emit) {
      return _P13DATA_GET3([], emit);
    });
    on<P13DATA_FLUSH>((event, emit) {
      return _P13DATA_FLUSH([], emit);
    });
    final List<List<String>> data;
  }

  Future<void> _P13DATA_GET(
      List<P13MAINclass> toAdd, Emitter<List<P13MAINclass>> emit) async {
    List<P13MAINclass> output = [];
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
      List<P13MAINclass> outputdata = input.map((data) {
        return P13MAINclass(
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

  Future<void> _P13DATA_GET2(
      List<P13MAINclass> toAdd, Emitter<List<P13MAINclass>> emit) async {
    // List<P13MAINclass> output = [];
    //-------------------------------------------------------------------------------------
    // var input = dummydatainput2;

    // List<P13MAINclass> outputdata = input
    //     .where((data) =>
    //         data['location'] == 'ESIE1' &&
    //         data['plant'] == 'YES' &&
    //         data['step01'] == 'YES')
    //     .map((data) {
    //   return P13MAINclass(
    //     PLANT: savenull(data['plant']),
    //     ORDER: savenull(data['order']),
    //     MAT: savenull(data['mat']),
    //     LOCATION: savenull(data['location']),
    //     LOT: savenull(data['lot']),
    //     CUSTOMER: savenull(data['customer']),
    //     PARTNO: savenull(data['partno']),
    //     PARTNAME: savenull(data['partname']),
    //     STEP01: savenull(data['step1']),
    //     STEP02: savenull(data['step2']),
    //     STEP03: savenull(data['step3']),
    //     STEP04: savenull(data['step4']),
    //     STEP05: savenull(data['step5']),
    //     STEP06: savenull(data['step6']),
    //     STEP07: savenull(data['step7']),
    //     STEP08: savenull(data['step8']),
    //     STEP09: savenull(data['step9']),
    //   );
    // }).toList();

    // output = outputdata;
    // emit(output);
  }

  Future<void> _P13DATA_GET3(
      List<P13MAINclass> toAdd, Emitter<List<P13MAINclass>> emit) async {
    // List<P13MAINclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P13MAINclass> datadummy = [
    //   P13MAINclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P13MAINclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P13MAINclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P13MAINclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P13DATA_FLUSH(
      List<P13MAINclass> toAdd, Emitter<List<P13MAINclass>> emit) async {
    List<P13MAINclass> output = [];
    emit(output);
  }
}

class P13MAINclass {
  P13MAINclass({
    this.Mat = '',
    this.Name = '',
    this.Volume = '',
    this.Remark = '',
    this.Machine = '',
    this.Date = '',
    this.Month = '',
    this.Year = '',
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
  String Remark;
  String Machine;
  String Date;
  String Month;
  String Year;
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
