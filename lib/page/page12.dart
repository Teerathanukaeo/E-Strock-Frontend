// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/page/P12MAIN/P12MAIN.dart';
import '../bloc/BlocEvent/P11Getsparepart.dart';
import '../bloc/BlocEvent/P12Getsparepart.dart';

//---------------------------------------------------------

class Page12 extends StatelessWidget {
  const Page12({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page12blockget();
  }
}

class Page12blockget extends StatelessWidget {
  const Page12blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P12DATA_Bloc(),
        child: BlocBuilder<P12DATA_Bloc, List<P12MAINclass>>(
          builder: (context, data) {
            return Page12Body(
              data: data,
            );
          },
        ));
  }
}

class Page12Body extends StatelessWidget {
  Page12Body({
    super.key,
    this.data,
  });
  List<P12MAINclass>? data;
  @override
  Widget build(BuildContext context) {
    return P12MAIN(
      data: data,
    );
  }
}
