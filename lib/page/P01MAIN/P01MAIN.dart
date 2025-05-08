import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/bloc/BlocEvent/P01Getsparepart.dart';
import 'package:newmaster/page/P01MAIN/P01VAR.dart';
import '../../widget/common/Advancedropdown.dart';

class P01MAIN extends StatefulWidget {
  P01MAIN({super.key, this.data});
  List<P01MAINclass>? data;

  @override
  State<P01MAIN> createState() => _P01MAINState();
}

class _P01MAINState extends State<P01MAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P01DATA_Bloc>().add(P01DATA_GET());
  }

  @override
  Widget build(BuildContext context) {
    List<P01MAINclass> _datain = widget.data ?? [];

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        // ✅ ครอบเพื่อจัดกลางทั้งหน้าจอ
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisSize: MainAxisSize.min, // ✅ ให้ Column ขนาดพอดี
              children: [
                Table(
                  border: TableBorder.all(),
                  columnWidths: const {
                    0: FixedColumnWidth(200),
                    1: FixedColumnWidth(100),
                    2: FixedColumnWidth(200),
                    3: FixedColumnWidth(200),
                    4: FixedColumnWidth(200),
                  },
                  children: [
                    TableRow(
                      children: [
                        for (var i in [
                          'Picture',
                          'Material No',
                          'Material Name',
                          'Volume',
                          'Type'
                        ])
                          TableCell(
                            child: SizedBox(
                              height: 60,
                              child: Center(
                                child: Text(
                                  i,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    ..._datain.map((item) {
                      return TableRow(
                        children: [
                          TableCell(
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Image.asset(
                                  'images/${item.CAL_1G_NO1}.jpg',
                                  width: 50,
                                  height: 50,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.broken_image);
                                  },
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 20,
                              child: Center(
                                child: Text(
                                  item.CAL_1G_NO1,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 20,
                              child: Center(
                                child: Text(
                                  item.CAL_1G_NO2,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 20,
                              child: Center(
                                child: Text(
                                  item.CAL_1G_NO3,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    print('กด Type ของ ${item.CAL_1G_NO1}');
                                  },
                                  child: Text('View'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
