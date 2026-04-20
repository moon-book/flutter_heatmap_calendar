import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'activity_tooltip.dart';
import 'tooltip_controller.dart';

class HeatMapCalendarExample extends StatefulWidget {
  const HeatMapCalendarExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HeatMapCalendarExample();
}

class _HeatMapCalendarExample extends State<HeatMapCalendarExample> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController heatLevelController = TextEditingController();

  bool isOpacityMode = true;

  TooltipController tooltipController = TooltipController();
  Map<DateTime, int> heatMapDatasets = {
    DateTime(2026, 4, 4): 1,
    DateTime(2026, 4, 15): 1,
    DateTime(2026, 4, 20): 1,
  };

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    heatLevelController.dispose();
  }

  Widget _textField(final String hint, final TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 20, top: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xffe7e7e7), width: 1.0)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF20bca4), width: 1.0)),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          isDense: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heatmap Calendar'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(20),
              elevation: 20,
              child: Padding(
                padding: const EdgeInsets.all(20),

                // HeatMapCalendar
                child: HeatMapCalendar(
                  // flexible: true,
                  size: 32,
                  fontSize: 12,
                  datasets: heatMapDatasets,
                  colorMode: isOpacityMode ? ColorMode.opacity : ColorMode.color,
                  colorsets: const {
                    1: Colors.red,
                    3: Colors.orange,
                    5: Colors.yellow,
                    7: Colors.green,
                    9: Colors.blue,
                    11: Colors.indigo,
                    13: Colors.purple,
                  },
                  enableBackBtn: false,
                  enableNextBtn: true,
                  monthYearDelimiter: '/',
                  useShortYearNumber: true,
                  onEnter: (date, position) {
                    print('--- ');
                    tooltipController
                      ..setPosition(position)
                      ..show(
                        context: context,
                        child: ActivityTooltip(
                          date: date ?? DateTime(1970),
                          count: heatMapDatasets[date] ?? -1,
                        ),
                      );
                  },
                  onHover: (date, position) {
                    final data = heatMapDatasets[date];
                    if (data == null || date == null) {
                      tooltipController.hide();
                      return;
                    }

                    tooltipController.update(position);
                  },
                ),
              ),
            ),
            _textField('YYYYMMDD', dateController),
            _textField('Heat Level', heatLevelController),
            ElevatedButton(
              child: const Text('COMMIT'),
              onPressed: () {
                setState(() {
                  heatMapDatasets[DateTime.parse(dateController.text)] = int.parse(heatLevelController.text);
                });
              },
            ),

            // ColorMode/OpacityMode Switch.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Color Mode'),
                CupertinoSwitch(
                  value: isOpacityMode,
                  onChanged: (value) {
                    setState(() {
                      isOpacityMode = value;
                    });
                  },
                ),
                const Text('Opacity Mode'),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
