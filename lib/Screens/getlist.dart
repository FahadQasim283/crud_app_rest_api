import 'package:crud_app/Constants/Widgets/constants.dart';
import 'package:crud_app/Utils/Routes/routenames.dart';
import 'package:crud_app/Utils/Routes/services.dart';
import 'package:flutter/material.dart';

import '../Constants/Widgets/customwidgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Your Task"),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.addPageRoute);
          },
          label: const Text("Add Task"),
          icon: const Icon(Icons.add)),
      body: Visibility(
        visible: Constants.isLoading,
        replacement: Constants.items.isEmpty
            ? Center(
                child: Text(
                "No items",
                style: Theme.of(context).textTheme.headlineMedium,
              ))
            : RefreshIndicator(
                onRefresh: fetchData,
                child: ListView.builder(
                  itemCount: Constants.items.length,
                  itemBuilder: (context, index) {
                    Constants.list = Constants.items[index] as Map;
                    final id = Constants.items[index]['_id'] as String;
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            "${index + 1}",
                          ),
                        ),
                        title: Text(Constants.items[index]['title'].toString()),
                        subtitle: Text(
                            Constants.items[index]['description'].toString()),
                        trailing: PopupMenuButton(
                          onSelected: (value) {
                            if (value == 'edit') {
                              Constants.objectIndex = index;
                              Constants.objectId =
                                  Constants.items[index]['_id'];
                              Constants.isEdited = true;
                              Constants.mapEdit.addAll({
                                "title": Constants.items[index]['title'],
                                "description": Constants.items[index]
                                    ['description']
                              });

                              Navigator.pushNamed(
                                  context, RouteName.addPageRoute);
                            } else if (value == 'delete') {
                              deleteTask(id: id);
                            }
                          },
                          itemBuilder: (context) {
                            return [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text("Edit"),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text("Delete"),
                              ),
                            ];
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
        child: const LinearProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    await ApiHandler.getData();
    setState(() {
      Constants.isLoading = false;
    });
  }

  Future<void> deleteTask({required id}) async {
    if (await ApiHandler.deleteById(id)) {
      setState(() {
        customSnackBar(message: "Item Deleted", context: context);
        Constants.items =
            Constants.items.where((element) => element['_id'] != id).toList();
      });
    } else {
      customSnackBar(
          message: "Deletion Failed", color: Colors.red, context: context);
    }
  }
}
