import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/model/address_model.dart';
import 'package:CaterMe/widgets/Addresses/addresses_list.dart';
import 'package:CaterMe/widgets/Addresses/addresses_textField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  List<Addresses> _address = [];

  void _addNewAddress(
    String contactName,
    String email,
    String phoneNumber,
    String country,
    String city,
    String addressTitle,
    // String id,
  ) {
    final newAddress = Addresses(
      // image: image,
      contactName: contactName,
      email: email,
      phoneNumber: phoneNumber,
      country: country,
      city: city,
      addressTitle: addressTitle,
      id: DateTime.now().toString(),
    );

    setState(() {
      _address.add(newAddress);
    });
  }

  void _startAddNewAddress(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled:true,
        context: ctx,
        builder: (_) {
          return AddressesTextField(_addNewAddress,ctx);
        });
  }

  void deleteAddress(String id) {
    setState(() {
      _address.removeWhere(
        (element) => element.id == id,
      );
    });
  }

  bool loading = true;

  getData() async {
    final adress = Provider.of<AdressProvider>(context, listen: false);
    await adress.getAllAddress();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final adress = Provider.of<AdressProvider>(context, listen: true);
    final mediaQuery = MediaQuery.of(context);
    var _mediaQuery = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          height: mediaQuery.size.height * 0.6,
          child: SingleChildScrollView(
            child:!loading? Column(
              children: [
                // !loading
                //     ?
                AddressesList(adress.listaddress, deleteAddress)
                    // : Container(
                    //     color: LightColors.kLightYellow,
                    //     child: Center(
                    //       child: CircularProgressIndicator(
                    //         color: Color(0xFF3F5521),
                    //       ),
                    //     )),
              ],
            ):Center(child:CircularProgressIndicator()),
          ),
        ),

      ],
    );
  }
}
