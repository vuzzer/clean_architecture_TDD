library serializers;


import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:clarchtdd/features/number_trivia/data/models/number_trivia_model.dart';


part 'serializers.g.dart';

@SerializersFor([
  NumberTriviaModel
])

final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
