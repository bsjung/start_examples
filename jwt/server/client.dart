import 'dart:convert'; // json
import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  var url = 'http://localhost:3000/api/v1/auth';

  // Await the http get response, then decode the json-formatted response.
  var data = {'type' : 'login', 'email' : 'bsjung@gmail.com', 'password' : 'xxxx'};
  var res = await http.post(url, body : jsonEncode(data),
                                 headers: {'Content-Type': "application/json"},
           );
  if (res.statusCode == 200) {
    var j = jsonDecode(res.body);
    print ( j );
  } else {
    print('Request failed with status: ${res.statusCode}.');
  }
}
