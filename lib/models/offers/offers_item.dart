class OfferItem {
  String? itemName;
  String? itemPrice;
  String? itemPhoto;
  String? itemDescription;

  OfferItem(
      {this.itemName, this.itemPrice, this.itemPhoto, this.itemDescription});

  OfferItem.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    itemPrice = json['itemPrice'];
    itemPhoto = json['itemPhoto'];
    itemDescription = json['itemDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['itemName'] = itemName;
    data['itemPrice'] = itemPrice;
    data['itemPhoto'] = itemPhoto;
    data['itemDescription'] = itemDescription;
    return data;
  }
}
