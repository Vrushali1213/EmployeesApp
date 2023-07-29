import 'package:cached_network_image/cached_network_image.dart';
import 'package:employeeinformation/provider/provider.dart';
import 'package:employeeinformation/view/employeedetails.dart';
import 'package:employeeinformation/widget/appfont.dart';
import 'package:employeeinformation/widget/custom_color.dart';
import 'package:employeeinformation/widget/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeList extends ConsumerStatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends ConsumerState<EmployeeList> {
  double? scrWidth, scrHeight;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    scrWidth = MediaQuery.of(context).size.width;
    scrHeight = MediaQuery.of(context).size.height;
    return SafeArea(child: Consumer(builder: (context, WidgetRef ref, _) {
      final viewEmployeedata = ref.watch(GetDataFuture);

      return Scaffold(
          backgroundColor: CustomColor.white1,
          appBar: AppBar(
            title: const Text('Employee List'),
          ),
          body: SingleChildScrollView(
            controller: viewEmployeedata.scrollController,
            child: Column(
              children: [
                SizedBox(
                  height: scrHeight! * 0.027,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: scrWidth! * 0.02),
                  child: employeesListview(viewEmployeedata),
                ),
              ],
            ),
          ));
    }));
  }

  //listview to show list of employees
  Widget employeesListview(var viewEmployeedata) {
    return viewEmployeedata.isloading == false
        ? viewEmployeedata.EmployeeListInfinite.isEmpty
            ? Center(
                child: Text(
                "No Data",
                style: TextStyle(
                    color: CustomColor.black,
                    fontSize: scrWidth! * 0.045,
                    fontFamily: AppFont.robotoMedium),
              ))
            : Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewEmployeedata.EmployeeListInfinite.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = viewEmployeedata.EmployeeList[index];
                      return InkWell(
                        onTap: () {
                          //sending dat to next page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmployeeDetails(
                                firstname: item.firstName,
                                lastname: item.lastName,
                                imgurl: item.imageUrl,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: scrHeight! * 0.013,
                                    ),
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              scrWidth! * 0.2),
                                          child: item.imageUrl == null
                                              ? Container()
                                              : CachedNetworkImage(
                                                  imageUrl:
                                                      item.imageUrl.toString(),
                                                  fit: BoxFit.cover,
                                                  height: scrHeight! * 0.1,
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                        child:
                                                            Icon(Icons.image),
                                                      ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Center(
                                                        child:
                                                            Icon(Icons.error),
                                                      )),
                                        ),
                                        SizedBox(
                                          width: scrWidth! * 0.05,
                                        ),
                                        Text(
                                          "${item.firstName}  ${item.lastName}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: scrWidth! * 0.05,
                                            fontFamily: AppFont.robotoMedium,
                                            color: CustomColor.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      );
                    }))
        : const Center(child: CircularProgressIndicator());
  }
}
