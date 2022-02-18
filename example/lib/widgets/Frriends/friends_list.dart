import 'package:CaterMe/Providers/friend.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/model/friend_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'editfriend.dart';

class FriendsList extends StatefulWidget {
  final List<FriendModel> friend;

  FriendsList(this.friend);

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
bool loading = true ;
void _EditFriend(BuildContext ctx,FriendModel a ) {
  showModalBottomSheet(
      isScrollControlled:true,
      context: ctx,
      builder: (_) {
        return GestureDetector(

          child: editfriend(a),
          behavior: HitTestBehavior.opaque,
        );
      });
}
  @override
  Widget build(BuildContext context) {

    final friends = Provider.of<FriendsProvider>(context, listen: true);
    var _mediaQuery = MediaQuery.of(context).size.height;
    var _mediaQueryWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SizedBox(
        height: _mediaQuery * 0.9,
        child: widget.friend.isEmpty
            ? Center(
             child: Container(
               child: Image.asset('images/NoFriendsYet.png'),
             ),
              )
            : loading?ListView.builder(
                itemCount: widget.friend.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    color: LightColors.kLightYellow2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: _mediaQuery * 0.02,
                              horizontal: _mediaQuery * 0.01),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25.0,
                                child: ClipRRect(
                                  child: Image.network(
                                     widget.friend[index].image,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              SizedBox(width:_mediaQueryWidth * 0.025 ,),
                              Container(
                                width: _mediaQueryWidth*0.6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.friend[index].name,

                                      style: const TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.friend[index].email,
                                      style: const TextStyle(
                                          fontSize: 15, fontWeight: FontWeight.normal),
                                    ),
                                    // SizedBox(height: _mediaQuery * 0.01),
                                    Text(
                                      widget.friend[index].phoneNumber,
                                      style: const TextStyle(
                                          fontSize: 13, fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          IconButton(onPressed: (){
                            //edit
                            _EditFriend(context,widget.friend[index]);
                          }, icon: Icon(FontAwesomeIcons.solidEdit,color: Color(0xFF3F5521),size: 20)
                          ),
                            IconButton(onPressed: ()async{
                              loading=false;
                              setState(() {

                              });
                              bool state=await  friends.deleteFreind(widget.friend[index].id);
                              if(state){
                                loading=true;

                                friends.listFriends.remove(widget.friend[index]);

                              }else{
                                loading=true;

                              }

setState(() {

});

                            }, icon: Icon(FontAwesomeIcons.trash,color: redColor
                              ,size: 20,)
                            ),

                          ],)
                      ],
                    ),
                  );
                }):Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
