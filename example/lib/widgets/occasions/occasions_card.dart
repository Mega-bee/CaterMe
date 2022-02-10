import 'package:CaterMe/model/occasion.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OccasionsCard extends StatelessWidget {
  Occasion occasions;
  OccasionsCard(this.occasions);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(children: [
      SizedBox(
        width: mediaQuery.size.width * 0.8,
        height: mediaQuery.size.height * 0.15,
        child: Card(
          shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                         Radius.circular(20),
                      ),
                    ),
          child: Row(
            children: [
              SizedBox(
                height: mediaQuery.size.height * 0.15,
                      width: mediaQuery.size.width * 0.23,
                child: Card(
                  color: Theme.of(context).primaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                         Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${DateFormat.MMM().format(DateTime.parse(this.occasions.date))}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            '${DateFormat.d().format(DateTime.parse(this.occasions.date))}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold))
                      ],
                    )),
              ),
               SizedBox(
        width: mediaQuery.size.width * 0.1,),
              Text(
                '${this.occasions.name}',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
