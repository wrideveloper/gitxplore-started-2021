import 'package:buka_hero_academia/core/models/address/address_model.dart';
import 'package:buka_hero_academia/core/models/base_widget.dart';
import 'package:buka_hero_academia/core/services/address_service.dart';
import 'package:buka_hero_academia/utils/palette.dart';
import 'package:buka_hero_academia/widgets/app_bar.dart';
import 'package:buka_hero_academia/widgets/container_widget_scroll.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormAddress extends StatefulWidget {
  @override
  _FormAddressState createState() => _FormAddressState();
}

class _FormAddressState extends State<FormAddress> {
  final _formKey = GlobalKey<FormState>();
  String addressDetail = '';
  String addressLabel = '';
  String receiverName = '';
  String phoneNumber = '';

  _saveAddress(model) async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FocusScope.of(context).unfocus();
      try {
        AddressModel addressModel = AddressModel(
          address_label: addressLabel,
          receiver_name: receiverName,
          phone_number: phoneNumber,
          address_detail: addressDetail
        );
        await model.createAddressData(addressModel);
      } catch(err) {
        print('$err ==== error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarModule(title: 'Tambah Alamat'),
        body: BaseWidget<AddressService>(
          model: AddressService(),
          builder: (context, model, _) {
            return ContainerWidgetScroll(
              padding: EdgeInsets.symmetric(horizontal: 41),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 35),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Detail Alamat',
                            ),
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            validator: (value) {
                              if (value == '')
                                return 'Detail Alamat tidak boleh kosong';
                              return null;
                            },
                            onSaved: (value) => addressDetail = value,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 35),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              hintText: 'Label Alamat',
                            ),
                            validator: (value) {
                              if (value == '')
                                return 'Label Alamat tidak boleh kosong';
                              return null;
                            },
                            onSaved: (value) => addressLabel = value,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 35),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              hintText: 'Nama Penerima',
                            ),
                            validator: (value) {
                              if (value == '')
                                return 'Nama Penerima tidak boleh kosong';
                              return null;
                            },
                            onSaved: (value) => receiverName = value,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 35),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'No Ponsel',
                            ),
                            validator: (value) {
                              if (value == '')
                                return 'No Ponsel tidak boleh kosong';
                              return null;
                            },
                            onSaved: (value) => phoneNumber = value,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 35),
                          height: 44.0,
                          child: RaisedButton(
                              color: Palette.primary,
                              onPressed: () => _saveAddress(model),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: model.busy ?
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Palette.white,
                                      valueColor: AlwaysStoppedAnimation(Palette.primary),
                                    ),
                                  )
                                  :
                                  Text(
                                    'Simpan',
                                    style: TextStyle(color: Colors.white)
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
