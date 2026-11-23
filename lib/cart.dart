import 'models/product.dart';

/// Позиція кошика: товар і його кількість.
class CartItem {
  CartItem({required this.product, this.quantity = 1});

  final Product product;
  int quantity;

  int get sum => product.price * quantity;
}

/// Кошик — список позицій, спільний для всіх екранів.
class Cart {
  final List<CartItem> items = [];

  /// Якщо товар уже є в кошику — збільшує кількість, інакше додає позицію.
  void add(Product product, int quantity) {
    for (final item in items) {
      if (item.product.id == product.id) {
        item.quantity += quantity;
        return;
      }
    }
    items.add(CartItem(product: product, quantity: quantity));
  }

  void remove(CartItem item) => items.remove(item);

  /// Загальна кількість одиниць товару (для позначки на іконці кошика).
  int get count => items.fold<int>(0, (total, item) => total + item.quantity);

  /// Загальна сума замовлення в гривнях.
  int get total => items.fold<int>(0, (total, item) => total + item.sum);
}

// Один спільний кошик для всіх екранів застосунку
final cart = Cart();
