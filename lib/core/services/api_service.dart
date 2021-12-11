import 'package:http/http.dart' as http;
import 'dart:convert';

var urlWeb = "https://api.cambio.today/v1";
var apiKey = "14890|sDTD7WGRpU_gnUW~93Cfqpd~gZnWmqMq";

Future<Map> apiGetCoins(String fromCoin, String toCoin, String quantity) async {
  var url = Uri.parse("$urlWeb/quotes/$fromCoin/$toCoin/json?quantity=$quantity&key=$apiKey");
  var response = await http.get(url);
  Map data = jsonDecode(response.body);
  return data;
}