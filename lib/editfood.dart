import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mysql1/mysql1.dart';
import 'constants.dart';

class EditFood extends StatefulWidget {
  EditFood({Key? key}) : super(key: key);
  var location = TextEditingController();
  var name = TextEditingController();
  var cost = TextEditingController();
  @override
  State<EditFood> createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food"),
      ),
      body: Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Add New Food'),
              content: Column(
                children: [
                  TextFormField(
                    controller: widget.location,
                    decoration: const InputDecoration(
                      hintText: 'Enter Location',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: widget.name,
                    decoration: const InputDecoration(
                      hintText: 'Enter Food Name',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: widget.cost,
                    decoration: const InputDecoration(
                      hintText: 'Enter Cost',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    // final storage = new FlutterSecureStorage();
                    // String? value = await storage.read(key: "FoodList");
                    // await storage.write(key: "FoodList", value: "$value|${widget.location}~${widget.name}~${widget.cost}");
                    Navigator.pop(context, 'OK');
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
        tooltip: 'Add New Food',
        child: const Icon(Icons.add),
      ),
    );
  }
}
