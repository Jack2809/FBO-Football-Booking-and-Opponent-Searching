import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'package:intl/intl.dart';

List<String> list = <String>["7:30","8:00","8:30","9:00","9:30","10:00","10:30","11:00","11:30","12:00"];

class PickingBookingTimePage extends StatefulWidget{

  @override
  State<PickingBookingTimePage> createState() => _PickingBookingTimePageState();
}

class _PickingBookingTimePageState extends State<PickingBookingTimePage> {

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Chọn ngày và loại sân'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: MyPaddingAll(),
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/gradient_background.png'),
          fit: BoxFit.fill,
        )
        ),
        child: SafeArea(
          child: Container(
            padding: MyPaddingAll(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white.withOpacity(0.7),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  DynamicTimeline(
                    firstDateTime: DateTime(1970, 1, 1, 7),
                    lastDateTime: DateTime(1970, 1, 1, 23),
                    labelBuilder: DateFormat('HH:mm').format,
                    intervalDuration: const Duration(minutes: 30),

                    items: [
                      TimelineItem(
                        startDateTime: DateTime(1970, 1, 1, 7),
                        endDateTime: DateTime(1970, 1, 1, 8),
                        child:  Container(
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red,
                          ),
                            child: Text('event 1'),
                        ),
                      ),
                      TimelineItem(
                        startDateTime: DateTime(1970, 1, 1, 9),
                        endDateTime: DateTime(1970, 1, 1, 10),
                        child: Container(
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red,
                          ),
                          child: Text('event 2'),
                        ),
                      ),
                      TimelineItem(
                        startDateTime: DateTime(1970, 1, 1, 22),
                        endDateTime: DateTime(1970, 1, 1, 23,30),
                        child: Container(
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red,
                          ),
                          child: Text('event 3'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: size.width * 0.9,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if(states.contains(MaterialState.pressed)){
                return Colors.redAccent;
              }
              return Colors.green;
            }
            ),
          ),
          child: Text("Chọn thời điểm đá",style: MyButtonText()),
          onPressed: (){
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Chọn giờ đá'),
                  content: Column(
                  children: <Widget>[
                  DropdownButton<String>(
                  value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String ? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Đặt sân'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Hủy bỏ'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}