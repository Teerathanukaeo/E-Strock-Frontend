import 'package:dio/dio.dart' show Dio;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newmaster/bloc/BlocEvent/P01Getsparepart.dart'
    show P01DATA_Bloc, P01DATA_GET, P01MAINclass;
import 'package:newmaster/data/global.dart' show serversparepart;
import 'package:newmaster/page/P01MAIN/P01VAR.dart' show P01VAR;
import 'package:newmaster/page/P11MAIN/P11VAR.dart';
import 'package:newmaster/widget/common/Radiobutton.dart' show index;

import '../../bloc/BlocEvent/P11Getsparepart.dart'; // แก้ path ให้ถูกต้อง

class P11MAIN extends StatefulWidget {
  P11MAIN({super.key, this.data, this.data2});
  final List<P11MAINclass>? data;
  final List<P01MAINclass>? data2;

  @override
  State<P11MAIN> createState() => _P11MAINState();
}

List<P01MAINclass> stockRemainList = [];

class _P11MAINState extends State<P11MAIN> {
  @override
  late List<P01MAINclass> selected;

  @override
  void initState() {
    super.initState();
    selected = List.from(widget.data2 ?? []);
    calculateStockRemain();
  }

  void calculateStockRemain() {
    final List<P11MAINclass> outList = widget.data ?? [];
    final List<P01MAINclass> inList = widget.data2 ?? [];

    final Map<String, int> outMap = {};
    for (var item in outList) {
      int outVolume = int.tryParse(item.Volume) ?? 0;
      outMap[item.Mat] = (outMap[item.Mat] ?? 0) + outVolume;
    }

    stockRemainList = inList.map((item) {
      int inVolume = int.tryParse(item.Volume) ?? 0;
      final outQty = outMap[item.Mat] ?? 0;

      return P01MAINclass(
        Mat: item.Mat,
        Name: item.Name,
        Customer: item.Customer,
        count: item.count,
        Volume: item.Volume,
        // Volume: int.parse(item.Volume) - item.count,
      );
    }).toList();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final List<P01MAINclass> selected = widget.data2 ?? [];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'รายการอะไหล่ที่เลือก',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: selected.isEmpty
                  ? Center(child: Text('ไม่มีรายการที่เลือก'))
                  : ListView.separated(
                      itemCount: selected.length,
                      separatorBuilder: (_, __) => Divider(),
                      itemBuilder: (context, index) {
                        final item = selected[index];
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
                                    'assets/images/${item.Mat}.png',
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('Customer: ${P01VAR.Customer}'),
                                    Text('Machine: ${P01VAR.Machine}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${item.count} ชิ้น',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    selected.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            const Divider(thickness: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'รวมรายการ:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${selected.length} รายการ',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 16),

// ปุ่ม Stock In และ Stock Out
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      for (var item in selected) {
                        // แปลง Volume ปัจจุบันเป็นจำนวนเต็ม
                        final currentVolume = int.tryParse(item.Volume) ?? 0;

                        // เพิ่มจำนวน stock ด้วยค่า count
                        final newVolume = currentVolume + item.count;

                        // อัปเดต Stock Temp ด้วยจำนวนใหม่
                        final response = await Dio().post(
                          "${serversparepart}E_StockTemp",
                          data: {
                            "Mat": item.Mat,
                            "Volume": newVolume.toString(),
                            "Customer": item.Customer,
                            "Remark":
                                "Stock In", // เปลี่ยน Remark เป็น Stock In
                          },
                        );

                        if (response.statusCode == 200) {
                          print(
                              '✅ Stock updated (Increased) for Mat: ${item.Mat}');
                        } else {
                          print(
                              '❌ Failed to update stock for Mat: ${item.Mat}');
                        }

                        // เพิ่มประวัติใน E_StockHistory เช่นเดียวกับ Stock Out แต่ Remark เป็น Stock In
                        final historyResponse = await Dio().post(
                          "${serversparepart}E_StockHistory",
                          data: {
                            "Date": DateFormat('dd').format(P01VAR.now),
                            "Mat": item.Mat,
                            "Name": item.Name,
                            "Volume": item.count.toString(),
                            "Customer": P01VAR.Customer,
                            "Remark":
                                "Stock In", // เปลี่ยน Remark เป็น Stock In
                            "Month": DateFormat('MM').format(P01VAR.now),
                            "Year": DateFormat('yyyy').format(P01VAR.now),
                            "Machine": P01VAR.Machine,
                            "Time": DateFormat('HH:mm').format(P01VAR.now),
                          },
                        );

                        if (historyResponse.statusCode == 200) {
                          print(
                              '📦 History saved (Stock In) for Mat: ${item.Mat}');
                        } else {
                          print(
                              '❌ Failed to save history for Mat: ${item.Mat}');
                        }
                      }

                      // เคลียร์รายการหลังเพิ่ม Stock
                      setState(() {
                        selected.clear();
                      });
                    },
                    icon: Icon(Icons.add_box, color: Colors.white),
                    label: Text(
                      'Stock In',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // ขอบมน
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      for (var item in selected) {
                        final summary = int.parse(item.Volume) - item.count;

                        // 🔁 อัปเดต Stock ปัจจุบัน
                        final response = await Dio().post(
                          "${serversparepart}E_StockTemp",
                          data: {
                            "Mat": item.Mat,
                            "Volume": summary.toString(),
                            "Customer": item.Customer,
                            "Remark": "Stock Out",
                          },
                        );

                        if (response.statusCode == 200) {
                          print('✅ Stock updated for Mat: ${item.Mat}');
                        } else {
                          print(
                              '❌ Failed to update stock for Mat: ${item.Mat}');
                        }

                        // 🆕 เพิ่มบันทึกใน E_StockHistory
                        final historyResponse = await Dio().post(
                          "${serversparepart}E_StockHistory",
                          data: {
                            "Date": DateFormat('dd').format(P01VAR.now),
                            "Mat": item.Mat,
                            "Name": item.Name,
                            "Volume": item.count.toString(),
                            "Customer": P01VAR.Customer,
                            "Remark": P01VAR.Remark,
                            "Month": DateFormat('MM').format(P01VAR.now),
                            "Year": DateFormat('yyyy').format(P01VAR.now),
                            "Machine": P01VAR.Machine,
                            "Time": DateFormat('hh:mm').format(P01VAR.now),
                          },
                        );

                        if (historyResponse.statusCode == 200) {
                          print('📦 History saved for Mat: ${item.Mat}');
                        } else {
                          print(
                              '❌ Failed to save history for Mat: ${item.Mat}');
                        }
                      }

                      // รีเฟรชข้อมูล + เคลียร์รายการ
                      // context.read<P11DATA_Bloc>().add(P11DATA_GET2());

                      setState(() {
                        selected.clear();
                      });
                    },
                    icon: Icon(Icons.outbox, color: Colors.white),
                    label: Text(
                      'Stock Out',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // ขอบมน
                      ),
                    ),
                  ),
                ),
              ],
            ), // ช่องว่างด้านล่าง
          ],
        ),
      ),
    );
  }
}
