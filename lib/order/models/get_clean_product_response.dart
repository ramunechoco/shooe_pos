import 'package:equatable/equatable.dart';

class GetCleanProductResponse extends Equatable {
  final List<CleanProductCategoryModel> categories;
  final int coins;

  const GetCleanProductResponse({
    required this.categories,
    required this.coins,
  });

  GetCleanProductResponse.fromJson(Map<String, dynamic> json)
      : categories = (json["categories"] as List)
            .map((model) => CleanProductCategoryModel.fromJson(model))
            .toList(),
        coins = json["coins"];

  GetCleanProductResponse changeQuantity(
    String categoryId,
    String productId,
    int quantity,
  ) {
    return GetCleanProductResponse(
      coins: coins,
      categories: categories.map((category) {
        if (category.id == categoryId) {
          return category.changeProductQuantity(
            productId,
            quantity,
          );
        }

        return category;
      }).toList(),
    );
  }

  @override
  List<Object?> get props => [coins, categories];
}

class CleanProductCategoryModel extends Equatable {
  final String id;
  final String categoryName;
  final String? infoMessage;
  final String? comingSoonMessage;
  final int? numberOfItemsToGetFree;
  final int? numberOfFreeItemPerMultiple;
  final List<CleanProductDetailModel> products;

  CleanProductCategoryModel({
    required this.id,
    required this.categoryName,
    this.infoMessage,
    this.comingSoonMessage,
    this.numberOfItemsToGetFree,
    this.numberOfFreeItemPerMultiple,
    required this.products,
  });

  CleanProductCategoryModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        categoryName = json["categoryName"],
        infoMessage = json["infoMessage"],
        comingSoonMessage = json["comingSoonMessage"],
        numberOfItemsToGetFree = json["numberOfItemsToGetFree"],
        numberOfFreeItemPerMultiple = json["numberOfFreeItemPerMultiple"],
        products = (json["products"] as List)
            .map((model) => CleanProductDetailModel.fromJson(model))
            .toList();

  CleanProductCategoryModel changeProductQuantity(
    String productId,
    int quantity,
  ) {
    return CleanProductCategoryModel(
      id: id,
      categoryName: categoryName,
      infoMessage: infoMessage,
      comingSoonMessage: comingSoonMessage,
      numberOfItemsToGetFree: numberOfItemsToGetFree,
      numberOfFreeItemPerMultiple: numberOfFreeItemPerMultiple,
      products: products.map((product) {
        if (product.id == productId) {
          return product.changeQuantity(quantity);
        }

        return product;
      }).toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        categoryName,
        infoMessage,
        comingSoonMessage,
        numberOfItemsToGetFree,
        numberOfFreeItemPerMultiple,
        products,
      ];
}

class CleanProductDetailModel extends Equatable {
  final String id;
  final String name;
  final String? imageUrl;
  final String duration;
  final int pricePerItem;
  final bool isHidden;
  final int quantity;
  final String? infoDetail;

  CleanProductDetailModel({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.duration,
    required this.pricePerItem,
    required this.isHidden,
    this.quantity = 0,
    this.infoDetail,
  });

  CleanProductDetailModel changeQuantity(int value) {
    return CleanProductDetailModel(
      id: this.id,
      name: this.name,
      imageUrl: this.imageUrl,
      duration: this.duration,
      pricePerItem: this.pricePerItem,
      isHidden: this.isHidden,
      quantity: value,
      infoDetail: infoDetail,
    );
  }

  CleanProductDetailModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        imageUrl = json["imageUrl"] ?? "",
        duration = json["duration"],
        pricePerItem = json["pricePerItem"],
        isHidden = json["isHidden"],
        quantity = 0,
        infoDetail = json["infoDetail"];

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        duration,
        pricePerItem,
        isHidden,
        quantity,
      ];
}
