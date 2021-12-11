import 'package:calculadora_divisas/core/services/api_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String dropdownValue = 'USD';
  String dropdownValue2 = 'MXN';
  var _textThinq = TextEditingController();
  var _textThinq2 = TextEditingController();
  var listCoin = <String>['USD', 'MXN','EUR','BTC','JPY','ETH'];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
      key: _formKey,
      child: Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          height: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  DropdownButton(
                    value: dropdownValue,
                    iconSize: 15,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    style: TextStyle(color: Colors.grey),
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: listCoin
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Container(
                    margin: EdgeInsets.all(1),
                    child: TextFormField(
                      controller: _textThinq,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(6, 8, 6, 8),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                        ),
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                        hintText: '0.00',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Agrega algun digito....';
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Icon(Icons.wifi_protected_setup_rounded, color: Colors.grey),
              Column(
                children: [
                  DropdownButton(
                    value: dropdownValue2,
                    iconSize: 15,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    style: TextStyle(color: Colors.grey),
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue2 = newValue!;
                      });
                    },
                    items: listCoin
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Container(
                    margin: EdgeInsets.all(1),
                    child: TextFormField(
                      controller: _textThinq2,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(6, 8, 6, 8),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                        ),
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                        hintText: '0.00',
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Container(
                child: Material(
                    child: InkWell(
                  onTap: () async{
                    if (_formKey.currentState!.validate()) {
                      //Verificar los Combo
                      if (dropdownValue != dropdownValue2) {
                        //Api
                        var res = await apiGetCoins(dropdownValue, dropdownValue2, "1");
                        var value = res['result']['value'];

                        var convert = double.parse(_textThinq.value.text) * value;

                        _textThinq2.text = convert.toString();

                      } else {
                        _textThinq2.text = _textThinq.value.text;
                      }
                    }
                  },
                  child: Ink(
                      width: 100,
                      height: 28,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Convertir',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      )),
                )),
              )
            ],
          )),
    ));
  }
}
