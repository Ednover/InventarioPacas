class Paca {
  String _id;
  String _name;
  String _label;
  double _price;
  int _amount;
  String _provider;

  Paca({
    String id,
    String name,
    String label,
    double price,
    int amount,
    String provider,
  }) {
    this._id = id;
    this._name = name;
    this._label = label;
    this._price = (price) ?? 0;
    this._amount = (amount) ?? 0;
    this._provider = provider;
  }

  String getId() {
    return this._id;
  }

  String getName() {
    return this._name;
  }

  String getLabel() {
    return this._label;
  }

  double getPrice() {
    return this._price;
  }

  int getAmount() {
    return this._amount;
  }

  String getProvider() {
    return this._provider;
  }

  void setId(String id) {
    this._id = id;
  }

  void setName(String name) {
    this._name = name;
  }

  void setLabel(String label) {
    this._label = label;
  }

  void setPrice(double price) {
    this._price = price;
  }

  void setAmount(int amount) {
    this._amount = amount;
  }

  void setProvider(String provider) {
    this._provider = provider;
  }
}
