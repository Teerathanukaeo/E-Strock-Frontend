// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../data/global.dart';
import '../../page/P01MAIN/P01VAR.dart';
import '../../widget/common/Loading.dart';
import 'package:dio/dio.dart';

//-------------------------------------------------

abstract class P01DATA_Event {}

class P01DATA_GET extends P01DATA_Event {}

class P01DATA_GET2 extends P01DATA_Event {}

class P01DATA_GET3 extends P01DATA_Event {}

class P01DATA_FLUSH extends P01DATA_Event {}

class P01DATA_Bloc extends Bloc<P01DATA_Event, List<P01MAINclass>> {
  P01DATA_Bloc() : super([]) {
    on<P01DATA_GET>((event, emit) {
      return _P01DATA_GET([], emit);
    });

    on<P01DATA_GET2>((event, emit) {
      return _P01DATA_GET2([], emit);
    });
    on<P01DATA_GET3>((event, emit) {
      return _P01DATA_GET3([], emit);
    });
    on<P01DATA_FLUSH>((event, emit) {
      return _P01DATA_FLUSH([], emit);
    });
    final List<List<String>> data;
  }

  Future<void> _P01DATA_GET(
      List<P01MAINclass> toAdd, Emitter<List<P01MAINclass>> emit) async {
    List<P01MAINclass> output = [];
    //-------------------------------------------------------------------------------------
    final response = await Dio().get(
      "${serversparepart}Mat",
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
      List<P01MAINclass> outputdata = input.map((data) {
        return P01MAINclass(
          CAL_1G_NO1: savenull(data['Mat']),
          CAL_1G_NO2: savenull(data['Name']),
          CAL_1G_NO3: savenull(data['Quantity']),
        );
      }).toList();

      output = outputdata;
      emit(output);
    } else {
      output = [];
      emit(output);
    }
  }

  Future<void> _P01DATA_GET2(
      List<P01MAINclass> toAdd, Emitter<List<P01MAINclass>> emit) async {
    // List<P01MAINclass> output = [];
    //-------------------------------------------------------------------------------------
    // var input = dummydatainput2;

    // List<P01MAINclass> outputdata = input
    //     .where((data) =>
    //         data['location'] == 'ESIE1' &&
    //         data['plant'] == 'YES' &&
    //         data['step01'] == 'YES')
    //     .map((data) {
    //   return P01MAINclass(
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

  Future<void> _P01DATA_GET3(
      List<P01MAINclass> toAdd, Emitter<List<P01MAINclass>> emit) async {
    // List<P01MAINclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P01MAINclass> datadummy = [
    //   P01MAINclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P01MAINclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P01MAINclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P01MAINclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P01DATA_FLUSH(
      List<P01MAINclass> toAdd, Emitter<List<P01MAINclass>> emit) async {
    List<P01MAINclass> output = [];
    emit(output);
  }
}

class P01MAINclass {
  P01MAINclass(
      {this.DATETIME = '',
      this.CAL_1G_NO1 = '',
      this.CAL_1G_NO2 = '',
      this.CAL_1G_NO3 = '',
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
      this.STATUS = ''});

  String DATETIME;
  String CAL_1G_NO1;
  String CAL_1G_NO2;
  String CAL_1G_NO3;
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
