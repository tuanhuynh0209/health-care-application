import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/screen/drug/add_drug.dart';
import 'package:flutter/material.dart';

enum MedFabCallbackType { add, cart, none }

class MedicationFab extends StatefulWidget {
  const MedicationFab({super.key});
  @override
  State<MedicationFab> createState() => _MedicationFabState();
}

class _MedicationFabState extends State<MedicationFab>
    with SingleTickerProviderStateMixin {
  late Animation<double> animate;
  late AnimationController controller;
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: isOpen ? colorScheme.surface : Colors.transparent,
      elevation: isOpen ? 100 : 0,
      animationDuration: Duration.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                isOpen
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Thêm thuốc"),
                              const SizedBox(
                                width: 10,
                              ),
                              FloatingActionButton(
                                  heroTag: "hero1",
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AddDrugPage(),
                                        ));
                                  },
                                  mini: true,
                                  child: const Icon(Icons.add, size: 18)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Giỏ hàng"),
                              const SizedBox(
                                width: 10,
                              ),
                              FloatingActionButton(
                                  heroTag: "hero2",
                                  onPressed: () {},
                                  mini: true,
                                  child: const Badge(
                                    child: Icon(Icons.shopping_cart_outlined,
                                        size: 18),
                                  )),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      isOpen = !isOpen;
                    });
                  },
                  child: const Icon(Icons.more_horiz_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
