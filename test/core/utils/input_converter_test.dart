import 'package:clarchtdd/core/utils/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group("stringToUnsignedInteger", () {
    test(
        "Should return an integer when the string represents an unsigned integer",
        () async {
      //arrange
      const str = "1999";
      //act
      final result = inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, right(1999));
    });

    test(
        "Should return a Failure when the string represents is not an unsigned integer",
        () async {
      //arrange
      const str = "legenddev";
      //act
      final result = inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()) );
    });

        test(
        "Should return a Failure when the string represents a negative integer",
        () async {
      //arrange
      const str = "-1999";
      //act
      final result = inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure() ) );
    });


  });
}
