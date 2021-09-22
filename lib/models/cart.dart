import 'package:e_commerce/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';
import '../core/store.dart';



class CartModel {



  // catalog field
  CatalogModel? _catalog;

  // Collection of IDs - store Ids of each item
  final List<int> _itemIds = [];

  //   return _catalog;
  CatalogModel get catalog {
    return _catalog as CatalogModel;
  }

  set catalog(CatalogModel newCatalog) {
    if (newCatalog != null) {
      _catalog = newCatalog;
    } else
      print("null");
  }

  // Get items in the cart
  List<Item> get items => _itemIds.map((e) => _catalog!.getById(e)).toList();

  // Get total price
  num get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  // Add Item



  // Remove Item

 
}

class AddMutation extends VxMutation {
  final Item item;

  AddMutation({required this.item});
  @override
  perform() {
       (VxState.store).cart._itemIds.add(item.id);
  }
}

class RemoveMutation extends VxMutation<MyStore> {
  final Item item;

  RemoveMutation(this.item);
  @override
  perform() {
    (VxState.store).cart._itemIds.remove(item.id);
  }
}