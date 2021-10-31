import 'package:flutter_test/flutter_test.dart';

main() {
  test("testing", () {
    // Arange
    int expectedNumber = 1;

    // Act
    expectedNumber += 1;

    //Assert
    expect(expectedNumber, 2);
  });
}
