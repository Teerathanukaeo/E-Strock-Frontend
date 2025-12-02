// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/bloc/BlocEvent/P01Getsparepart.dart'
    show P01DATA_Bloc, P01DATA_GET, P01MAINclass;
import 'package:newmaster/page/P11MAIN/P11MAIN.dart';
import '../bloc/BlocEvent/P11Getsparepart.dart';

//---------------------------------------------------------

class Page11 extends StatelessWidget {
  const Page11({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page11blockget();
  }
}

class Page11blockget extends StatelessWidget {
  const Page11blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<P11DATA_Bloc>(
          create: (_) => P11DATA_Bloc()..add(P11DATA_GET()),
        ),
        BlocProvider<P01DATA_Bloc>(
          create: (_) => P01DATA_Bloc()..add(P01DATA_GET()),
        ),
      ],
      child: BlocBuilder<P11DATA_Bloc, List<P11MAINclass>>(
        builder: (context, data1) {
          return BlocBuilder<P01DATA_Bloc, List<P01MAINclass>>(
            builder: (context, data2) {
              return Page11Body(
                data: data1,
                data2: data2,
              );
            },
          );
        },
      ),
    );
  }
}

class Page11Body extends StatelessWidget {
  Page11Body({
    super.key,
    this.data,
    this.data2,
  });

  List<P11MAINclass>? data;
  List<P01MAINclass>? data2;

  @override
  Widget build(BuildContext context) {
    return P11MAIN(
      data: data,
      data2: data2,
    );
  }
}
