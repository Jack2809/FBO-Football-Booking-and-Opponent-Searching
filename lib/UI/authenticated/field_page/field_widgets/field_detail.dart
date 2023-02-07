import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/field_page/field_widgets/field_booking.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import '../../../../Models/field_model.dart';

List<String> imageList = [
  'https://daihoc.fpt.edu.vn/wp-content/uploads/2020/05/89354889_2726704134050019_4494620933813698560_o.jpg',
  'https://dnuni.fpt.edu.vn/wp-content/uploads/2020/03/COF_5460-1536x864.png',
  'https://hcmuni.fpt.edu.vn/Data/Sites/1/media/2020-kim-vi/seo/campus/1-truong-dai-hoc-fpt-tphcm/truong-dai-hoc-fpt-tp-hcm-(1).jpg'
];

class FieldDetail extends StatelessWidget{
  Field field;

  FieldDetail({required this.field});

  @override
  Widget build(BuildContext context) {
    Size size= getSize(context);
    return Scaffold(
      body:SafeArea(
        child: Hero(
          tag: field.name,
          child: Material(
            type: MaterialType.transparency,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 0.0,
                  shadowColor: Colors.white,
                  pinned: true,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios,color: Colors.white),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  backgroundColor: Colors.green,
                  centerTitle: true,
                  expandedHeight: size.height * 0.3,
                  flexibleSpace: FlexibleSpaceBar(
                    background:  CarouselSlider.builder(
                      options: CarouselOptions(
                        initialPage: 0,
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                        height: size.height * 0.3,
                        viewportFraction: 1.0,
                        // autoPlayInterval: Duration(seconds:5),
                      ),
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                          Image.network(field.image,fit: BoxFit.cover,width: size.height),
                    )
                  ),
                  bottom: PreferredSize(
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        color:  Colors.white,
                        borderRadius: BorderRadius.only(topRight:Radius.circular(20.0),topLeft:Radius.circular(20.0) ),
                      ),
                        child: Center(child: Text(field.name,style: TextLine(context),))
                    ),
                    preferredSize: Size.fromHeight(20.0),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: MyPaddingAll(),
                        height:size.height,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            // borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(Icons.place_outlined,color: Colors.green),
                                SizedBox(width:size.width * 0.01 ,),
                                Text('Địa chỉ',style:HeadLine1(context),),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: size.width * 0.06,),
                                FieldInformationDetail(context,field.address +" "+ field.districtName),
                              ],
                            ),
                            SizedBox(height: 5.0,),
                            Row(
                              children: [
                                Icon(Icons.access_time,color: Colors.green),
                                SizedBox(width:size.width * 0.01 ,),
                                Text('Giờ Hoạt Động',style:HeadLine1(context),),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: size.width * 0.06,),
                                FieldInformationDetail(context,timeFormat(field.openTime)+"-"+timeFormat(field.closeTime)),
                              ],
                            ),
                            SizedBox(height: 5.0,),
                            Row(
                              children: [
                                Icon(Icons.phone,color: Colors.green),
                                SizedBox(width:size.width * 0.01 ,),
                                Text('SĐT',style:HeadLine1(context),),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: size.width * 0.06,),
                                FieldInformationDetail(context,field.phone),
                              ],
                            ),
                            SizedBox(height: 5.0,),
                            Divider(color: Colors.black45,),
                            Row(
                              children: [
                                Icon(Icons.description,color: Colors.green),
                                SizedBox(width:size.width * 0.01 ,),
                                Text('Mô tả',style:HeadLine1(context),),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: size.width * 0.06,),
                                FieldInformationDetail(context, field.description),
                              ],
                            ),
                            // FieldConvenient(field.convenienceList),
                          ],
                        ),
                      ),
                    ),
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
              if(states.contains(MaterialState.pressed)){
                return Colors.redAccent;
              }
              return Colors.green;
            }
            ),
          ),
          child: Text("Tiến hành đặt sân",style: MyButtonText()),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DateAndFieldTypePage(field: field,)),
            );
          },
        ),
      ),
    );
  }

  Widget FieldInformationDetail(BuildContext context,String info){
    return Expanded(child: Text(info,style:TextLine3(context,false),));
  }

  Widget FieldConvenient (BuildContext context,List<String> list){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(list.length, (index) => Row(children: [
        Icon(Icons.check_circle_outline,color: Colors.green),
      SizedBox(width: 5.0,),
      Text(list[index],style: TextLine1(context,false),),
    ],),
    )
    );
  }

}