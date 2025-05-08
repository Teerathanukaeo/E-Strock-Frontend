// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/page/P01MAIN/P01MAIN.dart';

import '../bloc/BlocEvent/P01Getsparepart.dart';

//---------------------------------------------------------

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
/*************  ✨ Codeium Command ⭐  *************/
  /// Build a [Page1blockget] widget.
  ///
  /// This widget is a [BlocProvider] that wraps a [BlocBuilder] that builds a
  /// [Page1Body] widget with the state of the [P01DATA_Bloc].
  ///
/******  422d0439-8ff5-4c64-ab41-4c396641f2d7  *******/ Widget build(
      BuildContext context) {
    return Page1blockget();
  }
}

class Page1blockget extends StatelessWidget {
  const Page1blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P01DATA_Bloc(),
        child: BlocBuilder<P01DATA_Bloc, List<P01MAINclass>>(
          builder: (context, data) {
            return Page1Body(
              data: data,
            );
          },
        ));
  }
}

class Page1Body extends StatelessWidget {
  Page1Body({
    super.key,
    this.data,
  });
  List<P01MAINclass>? data;
  @override
  Widget build(BuildContext context) {
    return P01MAIN(
      data: data,
    );
  }
}
