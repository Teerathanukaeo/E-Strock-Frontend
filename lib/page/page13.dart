// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/bloc/BlocEvent/P13GetHistory.dart';
import 'package:newmaster/page/P13MAIN/P13MAIN.dart';
import '../bloc/BlocEvent/P11Getsparepart.dart';
import '../bloc/BlocEvent/P12Getsparepart.dart';

//---------------------------------------------------------

class Page13 extends StatelessWidget {
  const Page13({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page13blockget();
  }
}

class Page13blockget extends StatelessWidget {
  const Page13blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P13DATA_Bloc(),
        child: BlocBuilder<P13DATA_Bloc, List<P13MAINclass>>(
          builder: (context, data) {
            return Page13Body(
              data: data,
            );
          },
        ));
  }
}

class Page13Body extends StatelessWidget {
  Page13Body({
    super.key,
    this.data,
  });
  List<P13MAINclass>? data;
  @override
  Widget build(BuildContext context) {
    return P13MAIN();
  }
}
