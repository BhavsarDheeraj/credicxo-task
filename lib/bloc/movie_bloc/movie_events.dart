import 'package:flutter/foundation.dart';

abstract class MovieEvents {}

class GetDetails extends MovieEvents {
  final int id;

  GetDetails({@required this.id});
}
