import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/Models/field_model.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'field_booking1.dart';

class DateAndFieldTypePage extends StatefulWidget{
  Field field;

  DateAndFieldTypePage({required this.field});


  @override
  State<DateAndFieldTypePage> createState() => _DateAndFieldTypePageState();
}

class _DateAndFieldTypePageState extends State<DateAndFieldTypePage> {

  var _selectedDate = DateTime.now();
  String _chosenFieldType = "";

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
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: MyPaddingAll(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Chọn ngày đá",style: HeadLine(context),),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SizedBox(
                    height: size.height * 0.2,
                    child: ScrollDatePicker(
                      minimumDate: DateTime.now(),
                      maximumDate: DateTime.now().add(Duration(days: 365)),
                      selectedDate: _selectedDate,
                      locale: Locale('en'),
                      onDateTimeChanged: (DateTime value) {
                        setState(() {
                          _selectedDate = value;
                        });
                      },
                    ),
                  ),
                ),

                Text("Chọn loại sân",style: HeadLine(context),),

                SizedBox(height: size.height * 0.01),

                GestureDetector(
                  onTap: (){
                    setState(() {
                      _chosenFieldType = "5vs5";
                    });
                  },
                  child: Container(
                    height: size.height * 0.2,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      // color: _chosenFieldType == "5vs5" ? Colors.green : Colors.white,
                      gradient: _chosenFieldType == "5vs5" ?LinearGradient(
                        colors: [
                          Colors.green,
                          Colors.yellow,
                        ],
                        // stops: [0.9,0.5],
                      ):LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white70
                        ],
                        // stops: [0.9,0.5],
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(child: Text('5 vs 5',style:HeadLine(context))),
                  ),
                ),

                SizedBox(height:size.height * 0.01,),

                GestureDetector(
                  onTap: (){
                    setState(() {
                      _chosenFieldType = "7vs7";
                    });
                  },
                  child: Container(
                    height: size.height * 0.2,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      // color: _chosenFieldType == "7vs7" ? Colors.green : Colors.white,
                      gradient: _chosenFieldType == "7vs7" ?LinearGradient(
                        colors: [
                          Colors.green,
                          Colors.yellow,
                        ],
                        // stops: [0.9,0.5],
                      ):LinearGradient(
                    colors: [
                    Colors.white,
                      Colors.white70
                      ],
                      // stops: [0.9,0.5],
                    ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(child: Text('7 vs 7',style:HeadLine(context))),
                  ),
                ),





              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: size.width * 0.9,
        child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (_chosenFieldType == ""){
                  return Colors.grey;
                }
                return Colors.green;
              }
              ),
            ),
            child: Text("Tiến tục",style: MyButtonText()),
            onPressed: _chosenFieldType == "" ? (){
              showFieldTypeChoosenAndTimeAlert();
            } : (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PickingBookingTimePage(
                  field:widget.field,bookingDate: convertDate(_selectedDate.toString()),fieldTypeName:_chosenFieldType,)),
              );
            }
        ),
      ),
    );
  }


  void showFieldTypeChoosenAndTimeAlert(){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Loại sân và ngày đá',
      desc: "Bạn vui lòng chọn sân và ngày đá để tiếp tục",
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnOkOnPress: () {

      },
    ).show();
  }

}