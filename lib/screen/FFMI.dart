import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:animated_custom_dropdown/custom_dropdown.dart';
class FFMIPage extends StatefulWidget {
  @override
  _FFMIPageState createState() => _FFMIPageState();
}

class _FFMIPageState extends State<FFMIPage> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _fatController = TextEditingController();
  //globalkey
  final _formKey = GlobalKey<FormState>();

  // final _genderController = TextEditingController();

  String _gender = 'Nam';
  String _metricMeasurement = 'Hệ Mét';

  double _ffmi = 0.0;
  double _leanBodyMass = 0.0;
  double _ffmiNormalized = 0.0;

  void _calculateFFMI() {
    if (_formKey.currentState!.validate()) {
      final weight = double.tryParse(_weightController.text) ?? 0.0;
      final height = double.tryParse(_heightController.text) ?? 0.0;
      final bodyFat = double.tryParse(_fatController.text) ?? 0.0;

      // thực hiện tính toán nếu đúng
      if (weight > 0 && height > 0) {
        final leanBodyMass = weight * (1 - bodyFat / 100);
        final heightInMeters = height / 100;
        final ffmi = leanBodyMass / (heightInMeters * heightInMeters);
        final ffmiNormalized = ffmi + 6.1 * (1.8 - heightInMeters);

        setState(() {
          _ffmi = ffmi;
          _leanBodyMass = leanBodyMass;
          _ffmiNormalized = ffmiNormalized;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tính FFMI'),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {},
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text("Hệ đo lường",
                    style: Theme.of(context).textTheme.titleMedium)),
            SegmentedButton(
              style: ButtonStyle(
                  iconColor: MaterialStateProperty.all(Colors.white)),
              segments: [
                ButtonSegment(
                  value: 'Hệ Mét',
                  label: Text(
                    'Hệ Mét',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontFamily:
                              GoogleFonts.inter(fontWeight: FontWeight.bold)
                                  .fontFamily,
                          color: _metricMeasurement.contains("Hệ Mét")
                              ? Colors.white
                              : Colors.black,
                        ),
                  ),
                ),
                ButtonSegment(
                  value: 'Hệ Mỹ',
                  label: Text(
                    'Hệ Mỹ',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontFamily:
                              GoogleFonts.inter(fontWeight: FontWeight.bold)
                                  .fontFamily,
                          color: _metricMeasurement.contains("Hệ Mỹ")
                              ? Colors.white
                              : Colors.black,
                        ),
                  ),
                ),
              ],
              selected: {_metricMeasurement},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _metricMeasurement = newSelection.first;
                });
              },
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Vui lòng nhập cân nặng";
                      } else if (value.length > 3) {
                        return "Cân nặng không phù hợp";
                      } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return 'Chiều cao không chứa kí tự';
                      }
                      return null;
                    },
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Cân nặng',
                      suffixText: _metricMeasurement == 'Hệ Mét' ? 'kg' : 'lbs',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Vui lòng nhập cân nặng";
                      } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return 'Chiều cao không chứa kí tự';
                      }
                      return null;
                    },
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Chiều cao',
                      suffixText:
                          _metricMeasurement == 'Hệ Mét' ? 'cm' : 'inches',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Vui lòng nhập cân nặng";
                      } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return 'Lượng mỡ không chứa kí tự';
                      }
                      return null;
                    },
                    controller: _fatController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Lượng mỡ trong cơ thể',
                      suffixText: '%',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              isExpanded: true,
              value: _gender,
              onChanged: (String? newValue) {
                setState(() {
                  _gender = newValue!;
                });
              },
              items: <String>['Nam', 'Nữ']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateFFMI,
              child: const Text('Tính FFMI'),
            ),
            const SizedBox(height: 16),
            if (_ffmi > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kết quả',
                      style: Theme.of(context).textTheme.titleLarge),
                  Text('FFMI: ', style: Theme.of(context).textTheme.titleSmall),
                  Text('${_ffmi.toStringAsFixed(1)} kg/m²',
                      style: Theme.of(context).textTheme.displayMedium),
                  Text('Trên trung bình',
                      style: Theme.of(context).textTheme.titleSmall),
                  Text('FFMI Bình thường hoá: ',
                      style: Theme.of(context).textTheme.titleSmall),
                  Text('${_ffmiNormalized.toStringAsFixed(1)} kg/m²',
                      style: Theme.of(context).textTheme.titleMedium),
                  Text('Khối lượng khi loại trừ mỡ: ',
                      style: Theme.of(context).textTheme.titleSmall),
                  Text('${_leanBodyMass.toStringAsFixed(1)} kg',
                      style: Theme.of(context).textTheme.titleMedium),
                  Text('Tổng khối lượng mỡ: ',
                      style: Theme.of(context).textTheme.titleSmall),
                  Text('${_fatController.text} %',
                      style: Theme.of(context).textTheme.titleMedium)
                ],
              ),
          ],
        ),
      ),
    );
  }
}
