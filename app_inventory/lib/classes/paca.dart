class Paca {
  String _name;
  double _price;
  int _amount;
  String _provider;

  
  //Paca(this._name, this._price, this._amount, this._provider,);
  Paca({String name, double price, int amount, String provider,}){
    this._name = name;
    this._price = (price!=null) ? price : 0;
    this._amount = (amount!=null) ? amount : 0;
    this._provider = provider;
  }

  String getName() {
    return this._name;
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

  void setName(String name) {
    this._name = name;
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
