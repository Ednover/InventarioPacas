class Provider {
  String _name;
  String _locale;
  int _phone;

  Provider({
    String name,
    String locale,
    int phone,
  }) {
    this._name = name;
    this._locale = locale;
    this._phone = (phone) ?? 0;
  }

  String getName() {
    return this._name;
  }

  String getLocale() {
    return this._locale;
  }

  int getPhone() {
    return this._phone;
  }

  void setName(String name) {
    this._name = name;
  }

  void setLocale(String locale) {
    this._locale = locale;
  }

  void setPhone(int phone) {
    this._phone = phone;
  }
}
