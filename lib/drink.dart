import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodselector/constants.dart';
import 'package:foodselector/editdrink.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
    this.switchValue = true,
  });

  List<SwitchListTile> expandedValue;
  String headerValue;
  bool isExpanded;
  bool switchValue;
}

class Drink extends StatefulWidget {
  Map<String, String> data;
  Drink(this.data, {Key? key}) : super(key: key);

  @override
  State<Drink> createState() => _DrinkState();
}

class _DrinkState extends State<Drink> {
  List<Item> itemData = [];
  @override
  initState() {
    super.initState();

    List locationsList = drinkDb.entries
        .map((entry) => "${entry.value['Location']}")
        .toSet()
        .toList();

    itemData = List<Item>.generate(locationsList.length, (index) {
      return Item(
          expandedValue: getSwitchList(locationsList[index]),
          headerValue: locationsList[index]);
    });
  }

  List<SwitchListTile> getSwitchList(location) {
    List<SwitchListTile> switchList = [];

    drinkDb.entries.forEach((entry) async {
      if (entry.value["Location"] == location) {
        switchList.add(SwitchListTile(
          // key: Key("$location${entry.value["Name"]}"),
          title: Text("${entry.value["Name"]}"),
          value: widget.data.containsKey("$location${entry.value["Name"]}") &&
                  widget.data["$location${entry.value["Name"]}"] == "false"
              ? false
              : true,
          onChanged: (bool value) async {
            final storage = new FlutterSecureStorage();
            await storage.write(
                key: "$location${entry.value["Name"]}",
                value: value.toString());
            Navigator.pop(context);
          },
          secondary:
              widget.data.containsKey("$location${entry.value["Name"]}") &&
                      widget.data["$location${entry.value["Name"]}"] == "false"
                  ? Icon(Icons.block)
                  : Icon(Icons.local_cafe),
        ));
      }
    });
    return switchList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drink"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditDrink(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  itemData[index].isExpanded = !isExpanded;
                });
              },
              children: itemData.map<ExpansionPanel>((Item item) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(item.headerValue),
                    );
                  },
                  body: Column(
                    children: [...item.expandedValue],
                  ),
                  isExpanded: item.isExpanded,
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
