import 'dart:async';
import 'dart:convert';
import 'package:crud_app/Constants/Widgets/constants.dart';
import 'package:crud_app/Utils/Routes/routenames.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../Constants/Widgets/customwidgets.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String buttonTitle = "Submit";
  TextEditingController titleControler = TextEditingController();
  TextEditingController descriptionControler = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (Constants.mapEdit.isNotEmpty && Constants.isEdited) {
      final title = Constants.mapEdit['title'];
      final description = Constants.mapEdit['description'];
      titleControler.text = title;
      descriptionControler.text = description;
    }
  }

  Future<void> submitData() async {
    //get data from user
    String title = titleControler.text;
    String description = descriptionControler.text;

    Map body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    //push on server
    Response response = await http.post(
        Uri.parse('https://api.nstack.in/v1/todos'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body));

    if (response.statusCode == 201) {
      Timer(const Duration(seconds: 2), () {
        setState(() {
          buttonTitle = "Submit";
          titleControler.text = "";
          descriptionControler.text = "";
        });
      });
      setState(() {
        buttonTitle = "Submitted";
      });
      customSnackBar(message: "Data Uploaded", context: context);
    } else {
      customSnackBar(
          message: "Submission Failed", color: Colors.red, context: context);
    }

    //show success , feedback
  }

  Future<void> updateData() async {
    String title = titleControler.text;
    String description = descriptionControler.text;

    Map body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };

    Response response = await http.put(
        Uri.parse('https://api.nstack.in/v1/todos/${Constants.objectId}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      Constants.isUpdated = true;
      buttonTitle = "Update";
      Timer(const Duration(seconds: 2), () {
        Constants.isUpdated = false;
        setState(() {
          buttonTitle = "Update";
        });
      });
      setState(() {
        buttonTitle = "Updated";
        customSnackBar(
          message: "Data Modified Successfuly",
          context: context,
        );
      });
    } else {
      Constants.isUpdated = false;
      buttonTitle = "Update";
      setState(() {
        customSnackBar(
            message: "Updation failed", context: context, color: Colors.red);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Constants.isEdited
            ? const Text("Edit Item")
            : const Text("Add Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(children: [
          TextFormField(
            controller: titleControler,
            decoration: const InputDecoration(hintText: "title"),
          ),
          TextFormField(
            controller: descriptionControler,
            decoration: const InputDecoration(
              hintText: "Description",
            ),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 10,
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  Constants.isLoading = true;
                  Constants.isEdited = false;
                  Constants.isUpdated = false;
                  Navigator.pushNamed(context, RouteName.homePageRoute);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 21, 210, 210),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: const Text("Back"),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  Constants.isEdited ? updateData() : submitData();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 21, 210, 210),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Text(Constants.isEdited
                      ? Constants.isUpdated
                          ? buttonTitle
                          : "Update"
                      : buttonTitle),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
