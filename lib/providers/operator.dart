import 'package:flutter/foundation.dart';

class Operator with ChangeNotifier {
  Operator(this.token, this.userId);
  final String token, userId;
  
}
