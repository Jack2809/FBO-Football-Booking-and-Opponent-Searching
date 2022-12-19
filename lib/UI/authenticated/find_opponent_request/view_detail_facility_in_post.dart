import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/view_detail_facility_in_post_bloc/view_detail_facility_in_post_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/view_detail_facility_in_post_bloc/view_detail_facility_in_post_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/view_detail_facility_in_post_bloc/view_detail_facility_in_post_state.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class ViewFieldDetail extends StatefulWidget{
   int facilityId;

  ViewFieldDetail({required this.facilityId});

  @override
  State<ViewFieldDetail> createState() => _ViewFieldDetailState();
}

class _ViewFieldDetailState extends State<ViewFieldDetail> {
  List<String> imageList = [
    'https://daihoc.fpt.edu.vn/wp-content/uploads/2020/05/89354889_2726704134050019_4494620933813698560_o.jpg',
    'https://dnuni.fpt.edu.vn/wp-content/uploads/2020/03/COF_5460-1536x864.png',
    'https://hcmuni.fpt.edu.vn/Data/Sites/1/media/2020-kim-vi/seo/campus/1-truong-dai-hoc-fpt-tphcm/truong-dai-hoc-fpt-tp-hcm-(1).jpg'
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ViewDetailFacilityBloc>(context).add(FetchDetailFacility(facilityId: widget.facilityId));
  }


  @override
  Widget build(BuildContext context) {
    Size size= getSize(context);
    return Scaffold(
      body:SafeArea(
        child: Material(
          type: MaterialType.transparency,
          child: BlocBuilder<ViewDetailFacilityBloc,ViewDetailFacilityState>(
              builder:(context,state){
                if(state is LoadingDetailFacility){
                  return Center(child: CircularProgressIndicator(),);
                }
                else if(state is LoadedDetailFacility){
                  return CustomScrollView(
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
                                autoPlayInterval: Duration(seconds:5),
                              ),
                              itemCount: imageList.length,
                              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                                  Image.network(imageList[itemIndex],fit: BoxFit.cover,width: size.height),
                            )
                        ),
                        bottom: PreferredSize(
                          child: Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                color:  Colors.white,
                                borderRadius: BorderRadius.only(topRight:Radius.circular(20.0),topLeft:Radius.circular(20.0) ),
                              ),
                              child: Center(child: Text(state.field.name,style: HeadLine1(context),))
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
                                  Text('Địa chỉ',style:HeadLine1(context),),
                                  FieldInformationDetail(Icons.place_outlined,state.field.address +" "+ state.field.districtName),
                                  SizedBox(height: 5.0,),
                                  Text('Giờ Hoạt Động',style:HeadLine1(context),),
                                  FieldInformationDetail(Icons.access_time,timeFormat(state.field.openTime)+"-"+timeFormat(state.field.closeTime)),
                                  SizedBox(height: 5.0,),
                                  Text('SĐT',style:HeadLine1(context),),
                                  FieldInformationDetail(Icons.phone,'1234567890'),
                                  SizedBox(height: 5.0,),
                                  Divider(color: Colors.black45,),
                                  Text('Mô tả',style:HeadLine1(context),),
                                  FieldInformationDetail(Icons.description, state.field.description),
                                  Text('Tiện ích của sân: ',style: HeadLine1(context)),
// FieldConvenient(field.convenienceList),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  );
                }
                else {
                  return Center(child: Text('Something wrong!!'),);
                }
              }
          ),
        ),
      ),

    );
  }

  Widget FieldInformationDetail(IconData title,String info){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(title,color: Colors.green,),
        SizedBox(width: 5.0,),
        Expanded(child: Text(info,style:TextLine3(context,false),)),
      ],
    );
  }

  Widget FieldConvenient (List<String> list){
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



