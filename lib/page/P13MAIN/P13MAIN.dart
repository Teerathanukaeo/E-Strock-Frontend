import 'package:dio/dio.dart' show Dio;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newmaster/bloc/BlocEvent/P01Getsparepart.dart'
    show P01DATA_Bloc, P01DATA_GET, P13MAINclass;
import 'package:newmaster/bloc/BlocEvent/P12Getsparepart.dart'
    show P12DATA_Bloc, P12DATA_GET2, P12MAINclass;
import 'package:newmaster/bloc/BlocEvent/P13GetHistory.dart';
import 'package:newmaster/data/global.dart' show serversparepart;
import 'package:newmaster/page/P13MAIN/P13VAR.dart';
import 'package:newmaster/widget/common/Radiobutton.dart' show index;

import '../../bloc/BlocEvent/P11Getsparepart.dart'; // แก้ path ให้ถูกต้อง

class P13MAIN extends StatefulWidget {
  const P13MAIN({super.key, this.data});
  final List<P12MAINclass>? data;

  @override
  State<P13MAIN> createState() => _P13MAINState();
}

class _P13MAINState extends State<P13MAIN> {
  @override
  void initState() {
    super.initState();

    if (widget.data != null && widget.data!.isNotEmpty) {
      final item = widget.data!.first;

      P13VAR.Customer = item.Customer;
      P13VAR.Machine = item.Machine;
      P13VAR.Date = item.Date;
      P13VAR.Month = item.Month;
      P13VAR.Year = item.Year;
      P13VAR.Remark = item.Remark;

      context.read<P12DATA_Bloc>().add(P12DATA_GET2());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('รายการอะไหล่')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<P12DATA_Bloc, List<P12MAINclass>>(
          builder: (context, state) {
            if (state.isEmpty) {
              return const Center(child: Text('ไม่มีข้อมูลที่ค้นหา'));
            }
            return ListView.separated(
              itemCount: state.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = state[index];
                return ListTile(
                  subtitle: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'images/${item.Mat}.png',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Center(child: Icon(Icons.broken_image)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Material: ${item.Mat}'),
                            Text('Name: ${item.Name}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Volume: ${item.Volume}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
