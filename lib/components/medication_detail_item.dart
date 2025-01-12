import 'package:app_well_mate/components/custom_elevated_button.dart';
import 'package:app_well_mate/const/functions.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/drug.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:app_well_mate/screen/drug_info.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

enum MedicationItemAction { delete, edit, snooze, buy, confirm }

class MedicationDetailItem extends StatefulWidget {
  final ScheduleDetailModel prescription;
  final Drug drug;
  //debug
  final String? titleText;
  // const MedicationDetailItem(
  //     {super.key,
  //     required this.prescription,
  //     this.titleText,
  //     required this.drug});
  const MedicationDetailItem({
    Key? key,
    required this.prescription,
    this.titleText,
    required this.drug,
  }) : super(key: key);

  @override
  State<MedicationDetailItem> createState() => _MedicationDetailItemState();
}

class _MedicationDetailItemState extends State<MedicationDetailItem> {
  @override
  Widget build(BuildContext context) {
    int timeDiffSec =
        (toSecond(TimeOfDay.now()) - toSecond(widget.prescription.timeOfUse!));
    TimeOfDay timeDiff = toTime(timeDiffSec.abs());
    Color accent = timeDiffSec > 0 ? colorScheme.error : colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.only(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          widget.titleText != null
              ? Padding(
                  padding: EdgeInsets.fromLTRB(
                      20, widget.titleText != null ? 10 : 0, 20, 0),
                  child: Text(
                    widget.titleText ?? "",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontFamily: "Inter", fontWeight: FontWeight.bold),
                  ))
              : const SizedBox(),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DrugInfoPage(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: accent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Icon(Symbols.pill,
                                  color: colorScheme.surface),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.prescription.detail!.drug!.name ?? "",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          CustomElevatedButton(
                            color: accent,
                            onTap: () {},
                            child: Icon(
                              Icons.check,
                              color: colorScheme.surface,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomElevatedButton(
                              color: accent,
                              onTap: () {},
                              child: Icon(
                                Icons.snooze,
                                color: colorScheme.surface,
                              )),
                        ],
                      ),
                      timeDiffSec < 0
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Icon(
                                  Icons.more_horiz,
                                  color: colorScheme.surface,
                                ),
                              ],
                            )
                          : const SizedBox(),
                      PopupMenuButton(
                        itemBuilder: (context) => const [
                          PopupMenuItem(
                              value: MedicationItemAction.confirm,
                              child: ListTile(
                                  leading: Icon(Symbols.check),
                                  title: Text("Xác nhận đã uống"))),
                          PopupMenuItem(
                              value: MedicationItemAction.snooze,
                              child: ListTile(
                                  leading: Icon(Symbols.snooze),
                                  title: Text("Nhắc tôi sau 10p nữa"))),
                          PopupMenuItem(
                              value: MedicationItemAction.buy,
                              child: ListTile(
                                  leading: Icon(Symbols.shopping_bag),
                                  title: Text("Mua thuốc này"))),
                          PopupMenuItem(
                              value: MedicationItemAction.edit,
                              child: ListTile(
                                  leading: Icon(Symbols.edit),
                                  title: Text("Sửa thuốc này"))),
                          PopupMenuItem(
                              value: MedicationItemAction.delete,
                              child: ListTile(
                                  leading: Icon(Symbols.delete),
                                  title: Text("Xoá thuốc này"))),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Symbols.alarm),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                                "Ngày ${widget.drug.prescriptionCount} ${widget.drug.unit}")
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Symbols.local_dining),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Trước khi ăn")
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Symbols.pill),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                                "${widget.drug.userQuantity}/${widget.drug.quantity}")
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      //đừng có const :)
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              timeDiffSec < 0
                                  ? "Trễ ${timeDiff.hour} giờ, ${timeDiff.minute} phút"
                                  : "Còn ${timeDiff.hour} giờ, ${timeDiff.minute} phút",
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
