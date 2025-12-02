import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/bloc/BlocEvent/P01Getsparepart.dart';
import 'package:newmaster/page/P13MAIN/P13MAIN.dart' show P13MAIN;
import 'package:newmaster/page/P13MAIN/P13VAR.dart';

import '../../bloc/BlocEvent/P11Getsparepart.dart';
import '../../bloc/BlocEvent/P12Getsparepart.dart';
import '../../bloc/BlocEvent/P13Gethistory.dart';
import '../../mainBody.dart';

class P12MAIN extends StatefulWidget {
  P12MAIN({super.key, this.data});
  List<P12MAINclass>? data;

  @override
  State<P12MAIN> createState() => _P12MAINState();
}

class _P12MAINState extends State<P12MAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P12DATA_Bloc>().add(P12DATA_GET());
  }

  @override
  Widget build(BuildContext context) {
    List<P12MAINclass> _datain = widget.data ?? [];
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: Text('Sparepart List')),
      body: ListView.builder(
        itemCount: _datain.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(_datain[index].Customer.toString()),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Remark: ${_datain[index].Remark}'),
                  Text('Machine: ${_datain[index].Machine}'),
                  Text(
                    'Date: ${_datain[index].Date}/${_datain[index].Month}/${_datain[index].Year}',
                  ),
                ],
              ),
              isThreeLine: true,
              onTap: () {
                setState(() {
                  P13VAR.Customer = _datain[index].Customer;
                  P13VAR.Machine = _datain[index].Machine;
                  P13VAR.Date = _datain[index].Date;
                  P13VAR.Month = _datain[index].Month;
                  P13VAR.Year = _datain[index].Year;
                  P13VAR.Remark = _datain[index].Remark;
                });
                var selectedParts = [
                  _datain[index]
                ]; // หรือ logic ที่คุณกำหนดเอง

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
                          child: BlocProvider(
                            create: (_) => P12DATA_Bloc()..add(P12DATA_GET2()),
                            child: P13MAIN(
                              data: selectedParts,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
