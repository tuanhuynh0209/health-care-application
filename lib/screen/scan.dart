import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key, this.automaticallyImplyLeading = false});
  final bool? automaticallyImplyLeading;
  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with WidgetsBindingObserver {
  var result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: widget.automaticallyImplyLeading ?? false,),
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          height: 300,
          child: FilledButton(
              onPressed: () async {
                var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimpleBarcodeScannerPage(),
                    ));
                setState(() {
                  if (res is String) {
                    result = res;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("RESULT: $result")));
                    log("RESULT $result");
                  }
                });
              },
              child: Image.asset('assets/images/loader.gif')),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          'Nhấn vào để quét mã đơn thuốc!',
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    )));
  }
}
