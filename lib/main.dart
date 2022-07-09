import 'dart:developer' as dev;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PrizeIt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'PrizeIt'),
    );
  }
}

class PrizeCard extends StatefulWidget {
  const PrizeCard({Key? key}) : super(key: key);

  @override
  State<PrizeCard> createState() => _PrizeCardState();
}

class _PrizeCardState extends State<PrizeCard> {
  double? cost;
  int? units;
  double? costPerUnit;
  String output = 'NA';
  String costLabel = "Cost: ";
  String unitsLabel = "Units: ";

  void updateUnitsLabel(bool show) {
    if (show) {
      setState((){unitsLabel = "Units: ";});
    } else {
      setState((){unitsLabel = "";});
    }
  }

  void updateCostLabel(bool show) {
    if (show) {
      setState((){costLabel = "Cost: ";});
    } else {
      setState((){costLabel = "";});
    }
  }

  void updateCostPerUnit() {
    dev.log('In updateCostPerUnit');
    if (cost == null || units == null) {
      costPerUnit = null;
      setState((){output = 'NA';});
      dev.log('something is null');
      return;
    }

    if (units == 0) {
      costPerUnit = null;
      setState((){output = 'NA';});
      dev.log("can't divide by 0");
      return;
    }

    costPerUnit = (cost! / units!);
    setState((){
      output = costPerUnit.toString();
      dev.log('Output: $output');
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      height: 100,
      child: Row(
        children: [
          // const Text('This is a prize card'),
         Column(
           children: [
             Container(
               width: 100,
               height: 30,
               margin: const EdgeInsets.all(5.0),
               child: TextField(
                 decoration: InputDecoration(labelText: costLabel),
                 keyboardType: TextInputType.number,
                 // inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                 onChanged: ((changed) => {
                   if(changed.isEmpty) {
                     updateCostLabel(true),
                     cost = null,
                   } else {
                     updateCostLabel(false),
                     cost = double.parse(changed),
                   },

                   dev.log('Cost: $cost'),
                   updateCostPerUnit(),
                 }),
               ),
             ),
             Container(
               width: 100,
               height: 30,
               margin: const EdgeInsets.all(5.0),
               child: TextField(
                 decoration: InputDecoration(labelText: unitsLabel),
                 keyboardType: TextInputType.number,
                 onChanged: ((changed) => {
                   if (changed.isEmpty) {
                     updateUnitsLabel(true),
                     units = 0
                   } else {
                     updateUnitsLabel(false),
                     units = int.parse(changed),
                   },
                   updateCostPerUnit()
                 }),
               ),
             ),
           ],
         ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(output)
            ],
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<PrizeCard> _prizeCards = [];

  void _clearPrizeList() {
    setState(() {
      _prizeCards.clear();
    });
  }

  void _addPrizeCard() {
    setState(() {
      _prizeCards.add(PrizeCard());
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          TextButton(
              style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary),
              onPressed: _clearPrizeList,
              child: const Text('Clear All'),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _prizeCards.length,
        itemBuilder: (BuildContext context, int index) {
          return _prizeCards[index];
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPrizeCard,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
