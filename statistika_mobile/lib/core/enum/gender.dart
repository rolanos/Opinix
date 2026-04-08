import '../model/named_type.dart';

enum Gender implements NamedType {
  male('Мужчина'),
  female('Женщина');

  const Gender(this._name);

  final String _name;

  bool? isMan() {
    switch (this) {
      case male:
        return true;
      case female:
        return false;
    }
  }

  static Gender? tryParse(bool? isMan) {
    switch (isMan) {
      case true:
        return Gender.male;
      case false:
        return Gender.female;
      case null:
        return null;
    }
  }

  @override
  String get name => _name;
}
