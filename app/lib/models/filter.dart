class Filter {
  String query;
  SkillsFilter skills = SkillsFilter();
  TablewaresFilter tablewares = TablewaresFilter();
  int personas = 0;
  TimesFilter times = TimesFilter();
  TypesFilter types = TypesFilter();

  Map<String, dynamic> toMap() {
    return {
      'query': query,
      'personas': personas,
      'skills': skills.toMap(),
      'tablewares': tablewares.toMap(),
      'times': times.toMap(),
      'types': types.toMap()
    };
  }
}

class SkillsFilter {
  bool get isEnabled => isEasy || isMedium || isHard;
  bool isEasy = false;
  bool isMedium = false;
  bool isHard = false;

  Map<String, dynamic> toMap() {
    return {
      'isEasy': isEasy,
      'isMedium': isMedium,
      'isHard': isHard,
    };
  }
}

class TablewaresFilter {
  bool get isEnabled => hasPan || hasOven || hasFryingPan;
  bool hasPan = false;
  bool hasOven = false;
  bool hasFryingPan = false;

  Map<String, dynamic> toMap() {
    return {
      'hasPan': hasPan,
      'hasOven': hasOven,
      'hasFryingPan': hasFryingPan,
    };
  }
}

class TimesFilter {
  bool get isEnabled => is10Min || isFrom10To30Min || isMoreThan30Min;
  bool is10Min = false;
  bool isFrom10To30Min = false;
  bool isMoreThan30Min = false;

  Map<String, dynamic> toMap() {
    return {
      'is10Min': is10Min,
      'isFrom10To30Min': isFrom10To30Min,
      'isMoreThan30Min': isMoreThan30Min,
    };
  }
}

class TypesFilter {
  bool get isEnabled => isSweet || isMeat || isVegan;
  bool isSweet = false;
  bool isMeat = false;
  bool isVegan = false;

  Map<String, dynamic> toMap() {
    return {
      'isSweet': isSweet,
      'isMeat': isMeat,
      'isVegan': isVegan,
    };
  }
}
