import 'package:flutter/material.dart';
import 'package:foodselector/editfood.dart';
import 'constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

class Food extends StatefulWidget {
  Map<String, String> data;
  Food(this.data, {Key? key}) : super(key: key);

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  List<Item> itemData = [];
  @override
  initState() {
    super.initState();

    List locationsList = foodDb.entries
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

    foodDb.entries.forEach((entry) async {
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
                  : Icon(Icons.lunch_dining),
        ));
      }
    });
    return switchList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditFood(),
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
