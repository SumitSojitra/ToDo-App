import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo/modules/app/Helper/FireStoreHelper/fireStoreHelper.dart';
import 'package:my_todo/modules/app/utils/colors/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController taskCtrl = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    DateTime? newDate;
    TimeOfDay? newTime;

    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do App"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: const Size(150, 40),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            FireStoreHelper.fireStoreHelper.addTasks(tasks: {
                              "task": taskCtrl.text,
                              "date": "${newDate}".split(" ")[0],
                              "time": "${newTime}".split("(")[1].split(")")[0],
                            });

                            log(taskCtrl.text);
                            log("${newDate}");
                            log("${newTime}");

                            taskCtrl.clear();
                            newTime = null;
                            newDate = null;

                            Get.back();
                          }
                        },
                        child: const Text("Confirm"),
                      ),
                    ],
                    title: const Text("Add Task"),
                    content: Container(
                      height: 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: formKey,
                            child: TextFormField(
                              controller: taskCtrl,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Your Task',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your task title';
                                }
                                return null;
                              },
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  newDate = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2023, 1),
                                    lastDate: DateTime(2024, 7),
                                    helpText: 'Select a date',
                                  );
                                },
                                icon: Icon(Icons.calendar_month_outlined),
                              ),
                              Text("Pick Task Date")
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  newTime = await showTimePicker(
                                    initialTime: TimeOfDay.now(),
                                    context: context,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: child!,
                                      );
                                    },
                                  );
                                },
                                icon: Icon(CupertinoIcons.clock_fill),
                              ),
                              Text("Pick Task Time")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ));
        },
        label: const Text("Add Task"),
        icon: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FireStoreHelper.fireStoreHelper.fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>>? allData =
                snapshot.data?.docs;

            return (allData!.isEmpty)
                ? Center(
                    child: Text("No Data"),
                  )
                : GridView.builder(
                    padding: EdgeInsets.all(14),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 110,
                        mainAxisSpacing: 8),
                    shrinkWrap: true,
                    itemCount: allData.length,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, i) => Container(
                      decoration: BoxDecoration(
                          color: AppColor.kWhite,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Text(
                            "${allData[i]['task']}",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                "DATE :",
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                " ${allData[i]['date']}",
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Gap(10),
                          Row(
                            children: [
                              Text(
                                "TIME :",
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                " ${allData[i]['time']}",
                                style: GoogleFonts.roboto(fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
