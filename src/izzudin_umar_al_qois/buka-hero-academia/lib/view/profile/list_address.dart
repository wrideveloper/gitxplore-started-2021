import 'package:buka_hero_academia/core/services/address_service.dart';
import 'package:buka_hero_academia/utils/transition_page.dart';
import 'package:buka_hero_academia/view/profile/form_address.dart';
import 'package:buka_hero_academia/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ListAddress extends StatefulWidget {
  @override
  _ListAddressState createState() => _ListAddressState();
}

class _ListAddressState extends State<ListAddress> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () => getData());
  }


  getData() async {
    Provider.of<AddressService>(context).getAddressData();
  }

  _redirectFormAddress() {
    Navigator.push(context, PageTransition(child: FormAddress(), type: PageTransitionType.leftToRight));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarModule(
        title: 'Pengaturan Alamat',
        action: [
          InkWell(
            onTap: () => _redirectFormAddress(),
            child: Container(
              margin: EdgeInsets.only(right: 15),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: Consumer<AddressService>(
        builder: (context, model, _) {
          return Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset('lib/assets/img/empty_address.png')
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                  child: Text(
                    'belum ada alamat nih untuk mencapai posisi kamu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}