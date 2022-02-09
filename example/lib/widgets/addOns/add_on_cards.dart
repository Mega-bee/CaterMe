import 'package:CaterMe/model/add_on.dart';
import 'package:CaterMe/widgets/items_details.dart';
import 'package:flutter/material.dart';

class AddOnCards extends StatelessWidget {
  AddOn addOn;

  AddOnCards(this.addOn);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Center(
        child: InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AdsitemDetail(addOn)));
      },
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Container(
          // width: mediaQuery.size.width*0.8 ,
          height: mediaQuery.size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.3,
          child: Column(
            children: [
              Image.network(
                this.addOn.image,
                height: 100,
                width: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        '${this.addOn.title}',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '\$${this.addOn.price}',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF3F5521),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
