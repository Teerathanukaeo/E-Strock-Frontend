import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/bloc/BlocEvent/P01Getsparepart.dart';
import 'package:newmaster/page/P01MAIN/P01VAR.dart';
import 'package:newmaster/page/P11MAIN/P11MAIN.dart' show P11MAIN;
import 'package:newmaster/page/page11.dart';
import 'package:newmaster/page/page12.dart';

import '../../mainBody.dart';
import '../../widget/common/Advancedropdown.dart';

class P01MAIN extends StatefulWidget {
  P01MAIN({super.key, this.data});
  List<P01MAINclass>? data;

  @override
  State<P01MAIN> createState() => _P01MAINState();
}

class _P01MAINState extends State<P01MAIN> {
  TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  int _selectedMenuIndex = -1; // 0: Import, 1: Remove, 2: History
  List<P01MAINclass> selectedParts = [];
  Map<String, bool> selectedEffect = {};
  @override
  void initState() {
    super.initState();
    // ดึงข้อมูลเมื่อเริ่มต้น
    context.read<P01DATA_Bloc>().add(P01DATA_GET());

    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text.toLowerCase();
        // P01VAR.Customer = '';
        // P01VAR.Machine = '';
        // P01VAR.Remark = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ใช้ข้อมูลจาก widget.data
    List<P01MAINclass> _datain = widget.data ?? [];
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: _datain.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Row(
              children: [
                SizedBox(width: 16),
                // เนื้อหา Card
                Expanded(
                  child: Column(
                    spacing: 16,
                    children: [
                      SizedBox(height: 0),
                      Row(
                        children: [
                          // 🔍 ช่อง Search
                          SizedBox(
                            width: 300,
                            height: 48,
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search by Material No or Name',
                                prefixIcon: Icon(Icons.search),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 0),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // ช่องว่างระหว่าง Search กับ Dropdown
                          SizedBox(width: 16),

                          // 🔽 Dropdown 1
                          AdvanceDropDown(
                            // imgpath: 'assets/icons/icon-down_4@3x.png',
                            listdropdown: const [
                              MapEntry("KOBE CH WIRE", "KOBE CH WIRE"),
                              MapEntry("KONSEI", "KONSEI"),
                              MapEntry("MELCO", "MELCO"),
                              MapEntry(
                                  "MITSUBISHI MOTORS", "MITSUBISHI MOTORS"),
                              MapEntry("NATAPOB", "NATAPOB"),
                              MapEntry(
                                  "NIPPON STEEL PIPE", "NIPPON STEEL PIPE"),
                              MapEntry("SIAM AISIN", "SIAM AISIN"),
                              MapEntry("THAI NOK", "THAI NOK"),
                              MapEntry(
                                  "THAI SPECIAL WIRE", "THAI SPECIAL WIRE"),
                              MapEntry("TOYOTA GATEWAY", "TOYOTA GATEWAY"),
                              MapEntry("TOYOTA SAMRONG", "TOYOTA SAMRONG"),
                            ],
                            onChangeinside: (d, k) {
                              setState(() {
                                P01VAR.Customer = d;
                              });
                            },
                            value: P01VAR.Customer,
                            height: 48,
                            width: 150,
                            borderRaio: 1.0,
                            hint: "Select Customer",
                          ),
                          SizedBox(width: 12),

                          // 🔽 Dropdown 2
                          AdvanceDropDown(
                            // imgpath: 'assets/icons/icon-down_4@3x.png',
                            listdropdown: const [
                              MapEntry("PK5", "PK5"),
                              MapEntry("DG", "DG"),
                              MapEntry("SR", "SR"),
                              MapEntry("SAF", "SAF"),
                              MapEntry("ZR", "ZR"),
                            ],
                            onChangeinside: (d, k) {
                              setState(() {
                                P01VAR.Machine = d;
                              });
                            },
                            value: P01VAR.Machine,
                            height: 48,
                            width: 150,
                            borderRaio: 1.0,
                            hint: "Machine",
                          ),
                          SizedBox(width: 12),

                          // 🔽 Dropdown 2
                          AdvanceDropDown(
                            // imgpath: 'assets/icons/icon-down_4@3x.png',
                            listdropdown: const [
                              MapEntry("PM", "PM"),
                              MapEntry("Problem", "Problem"),
                            ],
                            onChangeinside: (d, k) {
                              setState(() {
                                P01VAR.Remark = d;
                              });
                            },
                            value: P01VAR.Remark,
                            height: 48,
                            width: 150,
                            borderRaio: 1.0,
                            hint: "เหตุผลการนำออก",
                          ),

                          Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: SizedBox(
                                        height: 700,
                                        width: 550,
                                        child: P11MAIN(
                                          data: [], // ไม่มีรายการ out
                                          data2:
                                              selectedParts, // แสดงเฉพาะรายการ selected
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.all(16), // ขนาดของปุ่ม
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // ขอบมน
                              ),
                            ),
                            child: Icon(
                              Icons.shopping_cart, // ไอคอนรถเข็น
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 16),
                        ],
                      ),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            // กรองข้อมูลตามคำค้นหา
                            final List<P01MAINclass> visibleItems =
                                _datain.where((item) {
                              final mat = item.Mat.toLowerCase();
                              final name = item.Name.toLowerCase();
                              return mat.contains(searchQuery) ||
                                  name.contains(searchQuery);
                            }).toList();

                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 3 / 1,
                              ),
                              itemCount: visibleItems.length,
                              itemBuilder: (context, index) {
                                final item = visibleItems[index];
                                return Card(
                                  color: Colors.white,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        // Left: Details
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                color: Colors.yellow,
                                                child: Text(
                                                  "Material No: ${item.Mat}",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text("Material Name:",
                                                            style: TextStyle(
                                                                fontSize: 14)),
                                                        Text(" ${item.Name}",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text("Stock: ",
                                                            style: TextStyle(
                                                                fontSize: 14)),
                                                        Text(
                                                          " ${item.Volume}",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: int
                                                                            .tryParse(item
                                                                                .Volume) !=
                                                                        null &&
                                                                    int.tryParse(item
                                                                            .Safetystock) !=
                                                                        null &&
                                                                    int.parse(item
                                                                            .Volume) <=
                                                                        int.parse(
                                                                            item.Safetystock)
                                                                ? Colors.red
                                                                : Colors.black,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text("Safety Stock: ",
                                                            style: TextStyle(
                                                                fontSize: 14)),
                                                        Text(
                                                            " ${item.Safetystock}",
                                                            style: TextStyle(
                                                                fontSize: 14)),
                                                      ],
                                                    ),

                                                    Row(
                                                      children: [
                                                        Text("Storage: ",
                                                            style: TextStyle(
                                                                fontSize: 14)),
                                                        Text(
                                                            " ${item.Storage}"),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text("Change: ",
                                                            style: TextStyle(
                                                                fontSize: 14)),
                                                        Text(" ${item.Change}"),
                                                      ],
                                                    ),
                                                    // Row(
                                                    //   children: [
                                                    //     Text(
                                                    //       "Storage: ",
                                                    //       style: TextStyle(
                                                    //         fontSize: 14,
                                                    //       ),
                                                    //     ),
                                                    //     Text(
                                                    //       "${int.parse(item.Storage) - item.count}",
                                                    //       style: TextStyle(),
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    // Text(
                                                    //   "Test",
                                                    //   style: TextStyle(
                                                    //       fontSize: 12),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              Row(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        if (item.count > 0)
                                                          item.count--;
                                                      });
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(12),
                                                      minimumSize: Size(48, 48),
                                                      backgroundColor:
                                                          Colors.grey.shade100,
                                                    ),
                                                    child: Icon(Icons.remove,
                                                        size: 20,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    '${item.count}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(width: 8),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        item.count++;
                                                        P01VAR
                                                            .Volume = int.parse(
                                                                item.Volume) -
                                                            item.count;
                                                      });
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(12),
                                                      minimumSize: Size(48, 48),
                                                      backgroundColor:
                                                          Colors.grey.shade100,
                                                    ),
                                                    child: Icon(Icons.add,
                                                        size: 20,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(width: 8),
                                                  AnimatedSwitcher(
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    transitionBuilder:
                                                        (child, animation) =>
                                                            ScaleTransition(
                                                      scale: animation,
                                                      child: child,
                                                    ),
                                                    child: selectedEffect[
                                                                item.Mat] ==
                                                            true
                                                        ? Icon(
                                                            Icons.check_circle,
                                                            key: ValueKey(
                                                                'selected_${item.Mat}'),
                                                            color: Colors.green,
                                                          )
                                                        : ElevatedButton(
                                                            key: ValueKey(
                                                                'basket_${item.Mat}'),
                                                            onPressed: () {
                                                              setState(() {
                                                                final isAlreadyAdded =
                                                                    selectedParts.any((p) =>
                                                                        p.Mat ==
                                                                        item.Mat);
                                                                if (!isAlreadyAdded) {
                                                                  selectedParts.add(
                                                                      P01MAINclass(
                                                                    Mat: item
                                                                        .Mat,
                                                                    Name: item
                                                                        .Name,
                                                                    Volume: item
                                                                        .Volume,
                                                                    count: item
                                                                        .count,
                                                                  ));
                                                                }

                                                                item.count = 0;
                                                                selectedEffect[
                                                                        item.Mat] =
                                                                    true;

                                                                Future.delayed(
                                                                    Duration(
                                                                        seconds:
                                                                            1),
                                                                    () {
                                                                  setState(() {
                                                                    selectedEffect[
                                                                            item.Mat] =
                                                                        false;
                                                                  });
                                                                });

                                                                P01VAR.Volume =
                                                                    item.count;
                                                                P01VAR.Mat =
                                                                    item.Mat;
                                                                P01VAR.Name =
                                                                    item.Name;

                                                                // context
                                                                //     .read<
                                                                //         P01DATA_Bloc>()
                                                                //     .add(
                                                                //         P01DATA_GET2());
                                                              });
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                              ),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(12),
                                                              minimumSize:
                                                                  Size(96, 48),
                                                              backgroundColor:
                                                                  Colors.grey
                                                                      .shade100,
                                                            ),
                                                            child: Icon(
                                                              Icons
                                                                  .shopping_basket_outlined,
                                                              size: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        // Right: Image
                                        Container(
                                          width: 200,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/images/${item.Mat}.png',
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Center(
                                                    child: Icon(
                                                        Icons.broken_image,
                                                        size: 48));
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
