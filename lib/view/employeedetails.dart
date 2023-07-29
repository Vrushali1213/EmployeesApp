import 'package:cached_network_image/cached_network_image.dart';
import 'package:employeeinformation/widget/appfont.dart';
import 'package:employeeinformation/widget/custom_color.dart';
import 'package:employeeinformation/widget/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeDetails extends ConsumerStatefulWidget {
  String? firstname;
  String? lastname;
  String? imgurl;
  EmployeeDetails({Key? key, this.firstname, this.lastname, this.imgurl})
      : super(key: key);

  @override
  _EmployeeDetailsState createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends ConsumerState<EmployeeDetails> {
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
    return SafeArea(
        child: Scaffold(
            backgroundColor: CustomColor.bgcolor,
            appBar: AppBar(
              title: const Text('Employee Details'),
            ),
            body: SingleChildScrollView(
              child: employeeDetails(),
            )));
  }

  Widget employeeDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: scrHeight! * 0.05,
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(scrWidth! * 0.2),
            child: widget.imgurl == null
                ? Container()
                : CachedNetworkImage(
                    imageUrl: widget.imgurl.toString(),
                    fit: BoxFit.cover,
                    height: scrHeight! * 0.1,
                    placeholder: (context, url) => const Center(
                          child: Icon(Icons.image),
                        ),
                    errorWidget: (context, url, error) => const Center(
                          child: Icon(Icons.error),
                        )),
          ),
        ),
        SizedBox(
          height: scrHeight! * 0.02,
        ),
        widget.firstname != null && widget.lastname != null
            ? Text(
                "${widget.firstname}  ${widget.lastname}",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: scrWidth! * 0.05,
                  fontFamily: AppFont.robotoMedium,
                  color: CustomColor.black,
                  fontWeight: FontWeight.w500,
                ),
              )
            : Container()
      ],
    );
  }
}
