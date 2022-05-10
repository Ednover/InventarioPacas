class Client {
  String _id;
  String _name;
  String _lastName;
  String _locale;
  int _phone;

  Client({
    String id,
    String name,
    String lastName,
    String locale,
    int phone,
  }) {
    this._id = id;
    this._name = name;
    this._lastName = lastName;
    this._locale = locale;
    this._phone = (phone) ?? 0;
  }

  String getId() {
    return this._id;
  }

  String getName() {
    return this._name;
  }

  String getLastName() {
    return this._lastName;
  }

  String getLocale() {
    return this._locale;
  }

  int getPhone() {
    return this._phone;
  }

  void setId(String id) {
    this._id = id;
  }

  void setName(String name) {
    this._name = name;
  }

  void setLastName (String lastName) {
    this._lastName = lastName;
  }

  void setLocale(String locale) {
    this._locale = locale;
  }

  void setPhone(int phone) {
    this._phone = phone;
  }
}