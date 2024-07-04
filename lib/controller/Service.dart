import 'package:movil_censo/controller/Connection.dart';
import 'package:movil_censo/models/ResponseGeneric.dart';
import 'package:movil_censo/models/Session.dart';

class Service {
  final Connection _con = Connection();

  Future<Session> session(Map<String, dynamic> map) async {
    ResponseGeneric rg = await _con.post("sesion", map);
    Session s = Session();
    s.add(rg);
    if (rg.code == "200") {
      s.token = s.datos["token"];
      s.user = s.datos["user"];
    }
    return s;
  }
}
