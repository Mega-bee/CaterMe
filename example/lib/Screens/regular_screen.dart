import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/friend.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Screens/widgets/custom_cupertino_picker.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/model/friend_model.dart';
import 'package:CaterMe/widgets/Frriends/friends_list.dart';
import 'package:CaterMe/widgets/custom_daily_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../custom_date_picker_form_field.dart';
import 'occasion/theme/colors/light_colors.dart';

class ReguarScreen extends StatefulWidget {
  ReguarScreen(List<FriendModel> friends);

  // final List<FriendModel> Friends;
  //  ReguarScreen(this.Friends);

  @override
  _ReguarScreenState createState() => _ReguarScreenState();
}

class _ReguarScreenState extends State<ReguarScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool validate() {
    if (formkey.currentState != null) {
      if (formkey.currentState.validate()) {
        print('Validated');
        return true;
      } else {
        // ignore: avoid_print
        print('Not validated');
        return false;
      }
    }
    return false;
  }

  DateTime _selectedDay = DateTime.utc(2000, 10, 16);
bool form = false;
  getData() async {
    final address = Provider.of<AdressProvider>(context, listen: false);
    await address.getRegular();
    final occasion = Provider.of<FriendsProvider>(context, listen: false);
    if (occasion.listFriends.length == 0) await occasion.getAllFriends();
    List<String> l = [];
    for (int i = 0; i < occasion.listFriends.length; i++) {
      l.add(occasion.listFriends[i].name);
    }
    setState(() {
      listFriendssearch = l;
    });
    // controllersearch.text="p";
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  int _value = -1;
  bool loading = true;

  List<String> listFriendssearch = [];

  Future<bool> _onWillPop() async {
    final frnd = Provider.of<FriendsProvider>(context, listen: true);

    return (await showDialog(
            context: context,
            builder: (context) =>
                setupAlertDialoadContainer(context, frnd.listFriends))) ??
        false;
  }

  TextEditingController controllersearch = TextEditingController();

  Widget setupAlertDialoadContainer(context, List<FriendModel> l) {
    final frnd = Provider.of<FriendsProvider>(context, listen: true);
    final details = Provider.of<OrderCaterProvider>(context, listen: true);
    return SingleChildScrollView(
      child: Container(
        // color: LightColors.kLightYellow2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              // color: Colors.white,
              height: 400.0, // Change as per your requirement
              width: 400.0, // Change as per your requirement
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: frnd.listFriends.length,
                itemBuilder: (BuildContext context, int index) {
                  return listFriendssearch[index]
                          .contains(controllersearch.text.toLowerCase())
                      ? CheckboxListTile(
                          activeColor: Theme.of(context).primaryColor,
                          value: details.choosebillFriend
                              .contains(frnd.listFriends[index]),
                          onChanged: (val) {
                            if (val == true)
                              details.addfriend(frnd.listFriends[index]);
                            else
                              details.removefriend(frnd.listFriends[index]);
                          },
                          title: Card(
                            color: LightColors.kLightYellow2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 25.0,
                                    child: ClipRRect(
                                      child: Image.network(l[index].image),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                  Text(l[index].name),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final address = Provider.of<AdressProvider>(context, listen: true);
    var screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        color: LightColors.kLightYellow,
        height: screenHeight * 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.03),
              Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      // onSaved: (value) => name = value,
                      controller: address.eventnamecontroller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: screenHeight * 0.04),
                        // prefixIcon:Icon(Icons.event),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            // borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: new BorderSide(color: colorCustom)),
                        hintText: 'Event Name',
                        hintStyle: Theme.of(context).textTheme.headline4,
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    // TextFormField(
                    //   controller: address.eventnamecontroller,
                    //   decoration: const InputDecoration(
                    //     labelText: 'Event Name',
                    //     contentPadding: EdgeInsets.only(left: 20),
                    //   ),
                    //   autovalidateMode: AutovalidateMode.onUserInteraction,
                    //   validator: MultiValidator([
                    //     RequiredValidator(errorText: 'Required *'),
                    //     // EmailValidator(errorText: 'Not a valid email'),
                    //   ]),
                    //
                    // ),
                    SizedBox(height: screenHeight * 0.02),

                    Container(
                      height: MediaQuery.of(context).size.height / 8,
                      child: CustomDatePickerFormField(
                        label: "Event Date",
                        controller: address.evendatecontroller,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      height: MediaQuery.of(context).size.height / 8,
                      child: CustomDailyDate(
                        label: "Event Time",
                        controller: address.DailyDatecontroller,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),
                    CustomCupertinoPicker(
                      label: "Numbers Of Guests",
                      items: address.listnamenumber,
                      numberOfGuests: address.regular.numberOfGuests,
                      selectedValue: 1,
                      inputType: TextInputType.number,
                      controller: address.numberofguestcontrollerstring,
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    CustomCupertinoPicker(
                      label: "Type Of Event",
                      items: address.listnameevent,
                      events: address.regular.events,
                      selectedValue: 0,
                      inputType: TextInputType.number,
                      controller: address.typeofeventcontrollerstring,
                    ),

//                     Radio(
//                       toggleable: true,
//                       groupValue: address.value2Index,
//                       //  value: i,
//                       onChanged: (value) {
//                         setState(() {
// //    _value = i;
//                           address.value2Index ;
//                         });
//                         address.value ;
//                       },
//                     ),
                    SizedBox(height: screenHeight * 0.03),
                    Center(
                      child: Text(
                        'Contact Person',
                        style: TextStyle(
                            color: Color(0xFF3F5521),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          toggleable: true,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => colorCustom),
                          // value: 'female',
                          value: 0,
                          groupValue: address.value2Index,
                          onChanged: (value) {
                            setState(() {
                              address.value2Index = value;
                            });
                          },
                        ),

                        Text('Me'),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 10,
                        ),
                        Radio(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => colorCustom),
                          toggleable: true,
                          // value: 'female',
                          value: 1,
                          groupValue: address.value2Index,
                          onChanged: (value) {
                            setState(() {
form = true;
                              address.value2Index = value;
                            });
                          },
                        ),
                        Text('Others'),

                        //       ListTile(
                        //         leading: Radio(
                        //       toggleable: true,
                        //           // value: 'female',
                        //           value:0 ,
                        //           groupValue:address.value2Index,
                        //           onChanged: (value) {
                        //             setState(() {
                        //
                        // address.value2Index = value;
                        //             });
                        //           },
                        //         ),
                        //         title: const Text('Me'),
                        //       ),

                        // ListTile(
                        //   leading: Radio(
                        //     // value: 'female',
                        //     toggleable: true,
                        //     value:1 ,
                        //
                        //
                        //     groupValue: address.value2Index,
                        //     onChanged: (value) {
                        //       setState(() {
                        //
                        //         address.value2Index = value;
                        //       });
                        //     },
                        //   ),
                        //   title: const Text('Other'),
                        // ),
                        // Text('Me',style: TextStyle(
                        //     color: Color(0xFF3F5521),
                        //     fontWeight: FontWeight.normal,
                        //     fontSize: 20
                        // ),),
                        //
                        // Text('Other',style: TextStyle(
                        //     color: Color(0xFF3F5521),
                        //     fontWeight: FontWeight.normal,
                        //     fontSize: 20
                        // ),),
                      ],
                    ),

//                   ListView.builder(
//                       padding: const EdgeInsets.all(8),
//                       itemCount: 1,
//                       itemBuilder: (BuildContext context, int i) {
//                         return Row(
//                           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             // SizedBox(
//                             //   width: 45,
//                             // ),
//                             Radio(
//                               toggleable: true,
//                               groupValue: address.value2Index,
//                               //  value: i,
//                               onChanged: (value) {
//                                 setState(() {
// //    _value = i;
//                                   address.value2Index = i;
//                                 });
//                                 address.value = address.Friends[i];
//                               },
//                             ),
//                             Row(
//
//                               children: [
//                                 Text('Me',style: TextStyle(
//                                     color: Color(0xFF3F5521),
//                                     fontWeight: FontWeight.normal,
//                                     fontSize: 20
//                                 ),),
//                                 SizedBox(width:MediaQuery.of(context).size.width*0.28),
//                                 Radio(
//                                   toggleable: true,
//                                   groupValue: address.value1Index,
//                                   //  value: i,
//                                   onChanged: (value) {
//                                     setState(() {
// //    _value = i;
//                                       address.value2Index = i;
//                                     });
//                                     address.value = address.Friends[i];
//                                   },
//                                 ),
//                                 Text('Other',style: TextStyle(
//                                     color: Color(0xFF3F5521),
//                                     fontWeight: FontWeight.normal,
//                                     fontSize: 20
//                                 ),),
//
//
//                               ],
//                             ),
//
//                           ],
//                         );
//                       }
//                   ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
