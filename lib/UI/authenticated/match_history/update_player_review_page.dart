

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/review_player_in_match_bloc/review_player_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/review_player_in_match_bloc/review_player_event.dart';
import 'package:football_booking_fbo_mobile/Models/player_review.dart';
import 'package:football_booking_fbo_mobile/Validator/player_review_validator.dart';

import '../../../constants.dart';

class UpdatePlayerReviewPage extends StatefulWidget{

  final int matchId;
  final int myTeamId;
  final PlayerReview playerReview;

  UpdatePlayerReviewPage({required this.matchId,required this.myTeamId,required this.playerReview});

  @override
  State<UpdatePlayerReviewPage> createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<UpdatePlayerReviewPage> with InputPlayerReviewValidation{

  @override
  void dispose() {
    commentC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _star = widget.playerReview.star;
    commentC.text = widget.playerReview.comment;
  }

  int _star = 1;

  final commentC = TextEditingController();

  void _dropdownStarCallBack(int? selectedStar){
    if(selectedStar is int){
      setState(() {
        _star = selectedStar;
      });
    }
  }

  final formGlobalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cập nhật đánh giá cầu thủ',style: WhiteTitleText()),
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.02),
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.white),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Form(
        key: formGlobalKey,
        child: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Container(
                padding: MyPaddingAll(),
                // height:size.height,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.02),
                  // borderRadius: BorderRadius.circular(20.0)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Biểu hiện cầu thủ này',style: HeadLine1(context),),
                    SizedBox(height: 10.0,),
                    Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              isExpanded: true,
                              value: _star,
                              items:[
                                DropdownMenuItem(child: Center(child: Text('Xấu',textAlign:TextAlign.center)),value: -1),
                                DropdownMenuItem(child: Center(child: Text('Tốt',textAlign:TextAlign.center)),value: 1),
                              ] ,
                              onChanged:_dropdownStarCallBack),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: "Nhận xét",
                              hintText: 'Nhập nhận xét ở đây'
                          ),
                          controller: commentC,
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          validator: (comment){
                            if(isValidComment(comment)){
                              return null;
                            }
                            return "đánh giá cầu thủ phải trên 25 ký tự !";

                          },
                        )
                    ),

                    SizedBox(height: size.height * 0.05,),

                    Container(
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.green,
                      ),
                      child: TextButton.icon(
                        onPressed: () {
                          if(formGlobalKey.currentState!.validate()) {
                            int star = _star;
                            String comment = commentC.text;
                            BlocProvider.of<PlayerReviewsBloc>(context).
                            add(UpdatePlayerReview(matchId:widget.matchId,teamId: widget.myTeamId,reviewId:widget.playerReview.reviewId,comment:comment,star: star));
                            Navigator.of(context).pop();
                          }
                        },
                        icon: Icon(Icons.comment,color:Colors.white),
                        label: Text('Xác nhận đánh giá',style: MyButtonText()),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),

        ),
      ),

    );
  }
}