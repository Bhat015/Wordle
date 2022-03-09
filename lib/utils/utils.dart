import 'package:wordle/utils/textfield_utils.dart';

class Utils {
  static List<String> getWordList(index) {
    List<String> list = [];
    switch (index) {
      case 4:
        {
          list = [
            TextFieldUtils.instance.getController(0).text,
            TextFieldUtils.instance.getController(1).text,
            TextFieldUtils.instance.getController(2).text,
            TextFieldUtils.instance.getController(3).text,
            TextFieldUtils.instance.getController(4).text
          ];
          return list;
        }

      case 9:
        {
          list = [
            TextFieldUtils.instance.getController(5).text,
            TextFieldUtils.instance.getController(6).text,
            TextFieldUtils.instance.getController(7).text,
            TextFieldUtils.instance.getController(8).text,
            TextFieldUtils.instance.getController(9).text
          ];
          return list;
        }
      case 14:
        {
          list = [
            TextFieldUtils.instance.getController(10).text,
            TextFieldUtils.instance.getController(11).text,
            TextFieldUtils.instance.getController(12).text,
            TextFieldUtils.instance.getController(13).text,
            TextFieldUtils.instance.getController(14).text
          ];
          return list;
        }
      case 19:
        {
          list = [
            TextFieldUtils.instance.getController(15).text,
            TextFieldUtils.instance.getController(16).text,
            TextFieldUtils.instance.getController(17).text,
            TextFieldUtils.instance.getController(18).text,
            TextFieldUtils.instance.getController(19).text
          ];
          return list;
        }
      case 24:
        {
          list = [
            TextFieldUtils.instance.getController(20).text,
            TextFieldUtils.instance.getController(21).text,
            TextFieldUtils.instance.getController(22).text,
            TextFieldUtils.instance.getController(23).text,
            TextFieldUtils.instance.getController(24).text
          ];
          return list;
        }
      case 29:
        {
          list = [
            TextFieldUtils.instance.getController(25).text,
            TextFieldUtils.instance.getController(26).text,
            TextFieldUtils.instance.getController(27).text,
            TextFieldUtils.instance.getController(28).text,
            TextFieldUtils.instance.getController(29).text
          ];
          return list;
        }
      default:
        return [];
    }
  }

  static bool isFocusShift(int index, String value) {
    return (index != 4 &&
        index != 9 &&
        index != 14 &&
        index != 19 &&
        index != 24 &&
        index != 29 &&
        value.isNotEmpty);
  }

  static bool isRowCompleted(int index, String value) {
    return ((index == 4 ||
            index == 9 ||
            index == 14 ||
            index == 19 ||
            index == 24 ||
            index == 29) &&
        value.isNotEmpty);
  }
}
