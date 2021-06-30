import 'package:http/http.dart'as http;
const kAPI='b8dbc8b8bc9c4566d652145027736fb2';
class Networking{
  Networking({this.currency});
  String currency;


  Future getLiveData()async{
    var data;
    var Qparameters={
      'key':kAPI,
      'ids':'BTC',
      'convert':'$currency',
    };
    Uri url=Uri.https('api.nomics.com','/v1/currencies/ticker',Qparameters);

    http.Response response=await http.get(url);
    if(response.statusCode==200){
      data=response.body;

      return data;}
    else{
      print(response.statusCode);
    }
return data;
}
}