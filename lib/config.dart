import 'package:firebase_remote_config/firebase_remote_config.dart';

class Config {
  //Remote config
  static setupRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    const defaultValue = {'newWord': []};
    final defaults = <String, dynamic>{'words': defaultValue};
    await remoteConfig.setDefaults(defaults);
    await remoteConfig.fetchAndActivate();
  }

  static Map<String, List<String>> getWords() {
    return {
      "newWord": [
        "World",
        "Peace",
        "Pizza",
        "Happy",
        "Sixty",
        "Month",
        "Music",
        "Earth",
        "River",
        "Money",
        "Smile",
        "Abate",
        "Forty",
        "House",
        "Alone",
        "Admin",
        "After",
        "South",
        "Fruit",
        "Kevin",
        "Truck",
        "Panda",
        "Field",
        "Radio",
        "Dance",
        "Smith",
        "Sorry",
        "Honey",
        "Bread",
        "Alive",
        "place",
        "scarf",
        "table",
        "cross",
        "worth",
        "badge",
        "paper",
        "chair",
        "clear",
        "march",
        "belly",
        "ocean",
        "young",
        "space",
        "clock",
        "beach",
        "sound",
        "fever",
        "sleep",
        "catch",
        "cupid",
        "storm",
        "rhyme",
        "organ",
        "album",
        "think",
        "witch",
        "guard",
        "leave",
        "brave",
        "onion",
        "globe",
        "alley",
        "spain",
        "lucky",
        "glove",
        "meter",
        "nancy",
        "video",
        "pain"
      ]
    };
  }
}
