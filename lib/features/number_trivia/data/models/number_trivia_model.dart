import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:clarchtdd/core/interfaces/trivia.dart';
import 'package:built_value/serializer.dart';
import 'package:clarchtdd/core/serializer/serializers.dart';
import 'package:clarchtdd/features/number_trivia/domain/entities/number_trivia.dart';

part 'number_trivia_model.g.dart';

abstract class NumberTriviaModel
    implements Trivia,
        
        Built<NumberTriviaModel, NumberTriviaModelBuilder> {


  NumberTriviaModel._();

  factory NumberTriviaModel([void Function(NumberTriviaModelBuilder) updates]) =
      _$NumberTriviaModel;
  
    static NumberTriviaModel fromJson(Map<String, dynamic> data) {
    return serializers.deserializeWith(NumberTriviaModel.serializer, {
      "number": (data["number"] as num).toInt(),
      "text": data["text"]
    } ) as NumberTriviaModel;
  }

    Map<String, dynamic> toJson() {
    var numberTriviaModelFormatTojson =
        json.encode(serializers.serializeWith(NumberTriviaModel.serializer, this));
    Map<String, dynamic> numberTriviaModel = json.decode(numberTriviaModelFormatTojson);
    return numberTriviaModel;
  }

    static Serializer<NumberTriviaModel> get serializer =>
      _$numberTriviaModelSerializer;

}
