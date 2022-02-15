import 'package:CaterMe/Providers/occasion.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/model/friend_model.dart';
import 'package:CaterMe/model/occasion.dart';
import 'package:CaterMe/model/occasions/occasiontype.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../add_new_occasion.dart';

class OccasionListView extends StatefulWidget {
  @override
  State<OccasionListView> createState() => _OccasionListViewState();
}

class _OccasionListViewState extends State<OccasionListView> {
  bool loading = false;

  getData() async {
    final occasion = Provider.of<PackagesProvider>(context, listen: false);
    await occasion.getalloccasions();
    final occa = Provider.of<OccasionProvider>(context, listen: false);
    occa.listoccasiontype.add(OccassionType(id: -700,name: "Add occation",image: ''));
    await occa.getAllOccasionType();


  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  Future refreshocasionData() async {
    final occasion = Provider.of<PackagesProvider>(context, listen: false);
    final occa = Provider.of<OccasionProvider>(context, listen: false);

    occa.all.clear();
    await occa.getallnewoccasion();
    return;
  }

  @override
  Widget build(BuildContext context) {
    final occasion = Provider.of<PackagesProvider>(context, listen: true);
    final occa = Provider.of<OccasionProvider>(context, listen: true);
    var _mediaQuery = MediaQuery
        .of(context)
        .size
        .height;
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
      centerTitle: true,
      title: Text(
        'My Occasions',
        // style: Theme.of(context).textTheme.headline1,
      ),
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      // actions: [
      //   IconButton(
      //       onPressed: () {

      //       },
      //       icon: Icon(Icons.add))
      // ],
    ),
    body: RefreshIndicator(
    onRefresh: refreshocasionData,
    child: CustomScrollView(
    slivers: [
    SliverAppBar(
    pinned: false,
    floating: false,
    expandedHeight: MediaQuery.of(context).size.height * 0.4,
    backgroundColor: Colors.transparent,
    flexibleSpace: FlexibleSpaceBar(
    background: SizedBox(
    height: MediaQuery.of(context).size.height * 0.4,
    width: double.maxFinite,
    child: Container(
    height: MediaQuery.of(context).size.height * 0.5,
    child: ListView(
    scrollDirection: Axis.horizontal,
    children:
      List.generate(occa.listoccasiontype.length, (int index) {

        return    Card(
          child: Row(
            children: [
              Column(
                children: [
                  occa.listoccasiontype[index].id==-700?
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                          const AddNewOccasion(),
                        ),
                      );
                    },
                    icon: Icon(Icons.add),
                  ):NetworkImage(occa.listoccasiontype[index].image),
                  Text(occa.listoccasiontype[index].name)
                ],
              ),
            ],
          ),
        ); }),



    ),
    )



    // return  Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text('Quick add'),
    //     Card(
    //       child: Row(
    //         children: [
    //           Column(
    //             children: [
    //               IconButton(
    //                 onPressed: () {
    //                   Navigator.of(context).push(
    //                     MaterialPageRoute(
    //                       builder: (context) =>
    //                       const AddNewOccasion(),
    //                     ),
    //                   );
    //                 },
    //                 icon: Icon(Icons.add),
    //               ),
    //               Text('Add Occasion')
    //             ],
    //           ),
    //         ],
    //       ),
    //     )
    //   ],
    // );


  ,

  // scrollDirection: Axis.horizontal,

  ),
  ),
  ),
  // leading: Card(
  //   child: ,
  // ),

  ],
  )

  ,

  )

  ,

//
//           !loading? Column(
//             children: [
//               SizedBox(
//                 height: _mediaQuery * 0.80,
//                 child:occa.all.isEmpty
//                     ? Center(
//                   child: Container(
//                     child: Image.asset('images/NoOccassionsYet.png'),
//                   ),
//                 )
//                     : ListView.builder(
//                   // dragStartBehavior: DragStartBehavior.start,
//                   // reverse: true,
//                     itemCount: occa.all.length,
//                     itemBuilder: (ctx, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Card(
// elevation: 3,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(20),
//                             ),
//                           ),
//                           child: Row(
// crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height: mediaQuery.size.height * 0.17,
//                                 width: mediaQuery.size.width * 0.25,
//                                 child: Container(
//
//
//                                   color: Colors.amber,
//
//
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         '${DateFormat.MMM().format(DateTime.parse(occa.all[index].date))}',
//                                         style: const TextStyle(
//                                             color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
//                                       ),
//                                       Text(
//                                           '${DateFormat.d().format(DateTime.parse(occa.all[index].date))}',
//                                           style: const TextStyle(
//                                               color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold))
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               // SizedBox(
//                               //   width: mediaQuery.size.width * 0.1,),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       '${occa.all[index].name}',
//                                       style: Theme.of(context).textTheme.headline2,
//                                     ),
//                                     SizedBox(height: 65,),
//                                     Text(
//                                       '${occa.all[index].type}',
//                                       style: Theme.of(context).textTheme.headline2,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//
//
//
//                     }),
//
//               ),
//
//
//             ],
//           ):Center(child: CircularProgressIndicator()
  )

  ,

  );
}}
