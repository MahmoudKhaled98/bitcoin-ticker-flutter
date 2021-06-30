import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io'show Platform;
import 'Networking.dart';
import 'dart:convert';


class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  var cryptoPrice='0';
  DropdownButton androidDropdownButton(){

      List<DropdownMenuItem> currenceis=[];
      for(String currency in currenciesList){
        var newItem=DropdownMenuItem(child: Text(currency),value:currency);
        currenceis.add(newItem);
    }
   var dB= DropdownButton(
value: selectedCurrency,
items: currenceis,
onChanged: (value) {getData();
setState(() {
selectedCurrency = value;
 cryptoPrice=price;

});
},
);
      return dB;
  }




CupertinoPicker iosPicker(){


    List<Widget> pickerItems = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }

   var cP= CupertinoPicker(
      itemExtent: 35,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
    return cP;
}
  var cryptoCurrency;
  var price;

 getData()async{

  Networking networking=Networking(currency: selectedCurrency);
  var data= await networking.getLiveData();
  if(data==null){
    cryptoCurrency='Error';
    return;
  }else{
    cryptoCurrency=jsonDecode(data)[0]['id'];
    price=jsonDecode(data)[0]['price'];
    print(price);
  }

}
@override

  void initState() { getData();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $cryptoPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS? iosPicker():androidDropdownButton(),
            ),

        ],
      ),
    );
  }
}


