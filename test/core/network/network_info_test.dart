import 'package:clarchtdd/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockInternetConnnectionChecker;

  setUp(() {
    mockInternetConnnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockInternetConnnectionChecker);
  });

  group("isConnected", () {
    test("Should forward the call to the InternetconnectionChecker.hasConnection",
        () async {
      final tHasConnection = Future.value(true);
      //arrange
      when(mockInternetConnnectionChecker.hasConnection)
          .thenAnswer((_)  => tHasConnection );
      //act
      final result = networkInfoImpl.isConnected;
      //assert
      expect(result, tHasConnection);
    });
  });
}
