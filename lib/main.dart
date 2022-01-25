import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = TextEditingController();
  List<bool> _selection = [true, false, false];
  String? tip;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              //mainAxisAlignment = MainAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (tip != null)
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      '$tip',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                Text('Total Amount'),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: '£100.00'),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ToggleButtons(
                    children: [
                      Text('10%'),
                      Text('15%'),
                      Text('20%'),
                    ],
                    isSelected: _selection,
                    onPressed: updateSelection,
                  ),
                ),
                ElevatedButton(
                  onPressed: calculateTip,
                  child: Text('Calculate Tip'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red)),
                )
              ],
            ),
          ),
        ));
  }

  void updateSelection(int selectedIndex) {
    for (int i = 0; i < _selection.length; i++) {
      // if (selectedIndex == i) {
      //   _selection[i] = true;
      // } else {
      //   _selection[i] = false;
      // }

      _selection[i] = selectedIndex == i;
    }
    setState(() {});
  }

  void calculateTip() {
    final totalAmount = double.parse(controller.text);
    final selectedIndex = _selection.indexWhere((element) => element);
    final tipPercentage = [0.1, 0.15, 0.2][selectedIndex];

    final tipTotal = (totalAmount * tipPercentage).toStringAsFixed(2);

    setState(() {
      tip = '\$$tipTotal';
    });
  }
}
