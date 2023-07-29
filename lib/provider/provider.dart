import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/employees.dart';

final GetDataFuture =
    ChangeNotifierProvider<GetDataFromJson>((ref) => GetDataFromJson());

class GetDataFromJson extends ChangeNotifier {
  List EmployeeList = [];
  List EmployeeListInfinite = [];
  bool isloading = true;
  ScrollController scrollController = ScrollController();

  GetDataFromJson() {
    readJson();
    scrollController.addListener(_loadMoreData);
    notifyListeners();
  }


  // added pagination
  Future<dynamic> _loadMoreData() async {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !isloading) {
      print("new data");
      readJson();
      notifyListeners();
    }
  }


  // Fetch data from json file
  Future<void> readJson() async {
    isloading = true;
    final String response =
        await rootBundle.loadString('assets/employees.json');

    EmployeeList = json
        .decode(response)
        .map((data) => EmployeesData.fromJson(data))
        .toList();

    print("EmployeeList ${EmployeeList.length}");


    // generate list of 50 items
    List EmployeeListnew1 = EmployeeListInfinite.length >= EmployeeList.length
        ? []
        : List.generate(50, (index) => "${EmployeeList[index]}");

    isloading = false;
    notifyListeners();

    if (EmployeeListnew1.isNotEmpty) {
      EmployeeListInfinite.addAll(EmployeeListnew1);
      print("EmployeeListInfinite ${EmployeeListInfinite.length}");
    }

    isloading = false;

  }
}
