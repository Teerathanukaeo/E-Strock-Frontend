import 'package:flutter/material.dart';
import '../page/page0.dart';

String token = '';
String selectpage = '';
Widget CuPage = const Page0();
int CuPageLV = 0;

class USERDATA {
  static int UserLV = 0;
  static String NAME = '';
  static String ID = '';
}

class logindata {
  static bool isControl = false;
  static String userID = '';
  static String userPASS = '';
}

//------------------------------------------------------------
// String serverG = 'http://127.0.0.1:15152/';
// String serverN = 'http://127.0.0.1:2600';
// String webHOOK = '172.101.34.209';
// String webHOOK = '172.20.43.176';
//------------------------------------------------------------
String webHOOK = '172.23.10.51';
String serverG = 'http://172.23.10.51:15152/';

String serverSARS = 'http://172.23.10.51:5000';
String serverSARMAIN = 'http://172.23.10.51:1885';
String serversparepart = 'http://127.0.0.1:3005/';

class serverNG {
  // static String BP12 = 'http://127.0.0.1:2600';
  // static String HES = 'http://127.0.0.1:2700';
  static String BP12 = 'http://172.23.10.51:2600';
  static String HES = 'http://172.23.10.51:2700';
}

//
//selectBLANCE(USERDATA.Branch)
String selectBLANCE(input) {
  String serverN = '';
  if (input == "BANGPOO") {
    serverN = serverNG.BP12;
  } else if (input == "RAYONG") {
    serverN = serverNG.HES;
  }

  return serverN;
}
