import 'dart:math';

import 'package:app_well_mate/components/medication_item.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllDrug extends StatefulWidget {
  const AllDrug({super.key});

  @override
  State<AllDrug> createState() => _AllDrugState();
}

class _AllDrugState extends State<AllDrug> {
  List<ScheduleDetailModel> mockData = List.generate(
      10,
      (e) => ScheduleDetailModel(
            detail: PrescriptionDetailModel(
                drug: DrugModel(name: "Paracetamol"),
                quantity: Random().nextInt(100),
                quantityUsed: 0,
                amountPerConsumption: Random().nextInt(10),
                notes: "Trước khi ăn"),
          ));

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 20 + 16 + 32),
      itemCount: mockData.length,
      itemBuilder: (context, index) =>
          MedicationItem(prescription: mockData[index]),
      separatorBuilder: (context, index) => const Divider(
        indent: 20,
        endIndent: 20,
      ),
    );
  }
}
