import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

enum MedicationItemAction { delete, edit, snooze, buy, confirm }

class WidgetBuyMedicine extends StatefulWidget {
  const WidgetBuyMedicine({super.key});

  @override
  State<WidgetBuyMedicine> createState() => _WidgetBuyMedicine();
}

class _WidgetBuyMedicine extends State<WidgetBuyMedicine> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'https://i.giphy.com/BSx6mzbW1ew7K.webp'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Panadol Extra",
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text("3 vỉ _ 8.000 đ / vỉ",
                              style: Theme.of(context).textTheme.labelSmall),
                          Text("25.000 đ",
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ),
                  ],
                ),
                PopupMenuButton(
                  style: Theme.of(context).iconButtonTheme.style,
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                        value: MedicationItemAction.delete,
                        child: ListTile(
                            leading: Icon(Symbols.delete),
                            title: Text("Xoá thuốc này"))),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28),
            child: Divider(),
          )
        ],
      ),
    );
  }
}
