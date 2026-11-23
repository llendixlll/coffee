import 'package:material_ui/material_ui.dart';

import '../cart.dart';
import '../models/product.dart';

/// Екран «Деталі товару». Товар приходить через конструктор.
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.product});

  final Product product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int _quantity = 1;

  void _addToCart() {
    cart.add(widget.product, _quantity);
    // ScaffoldMessenger належить усьому застосунку — SnackBar видно й на «Меню»
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.product.name} × $_quantity додано до кошика'),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: 'product-${product.id}',
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                color: product.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(product.icon, size: 120, color: Colors.brown),
            ),
          ),
          const SizedBox(height: 16),
          Text(product.name, style: textTheme.headlineSmall),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: textTheme.titleMedium,
              children: [
                const TextSpan(text: 'Ціна: '),
                TextSpan(
                  text: '${product.price} грн',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(product.description, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 24),
          // вибір кількості: стан _quantity змінюється тільки через setState
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Кількість', style: TextStyle(fontSize: 16)),
              Row(
                children: [
                  IconButton.outlined(
                    tooltip: 'Менше',
                    onPressed: _quantity > 1
                        ? () => setState(() => _quantity--)
                        : null,
                    icon: const Icon(Icons.remove),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '$_quantity',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton.outlined(
                    tooltip: 'Більше',
                    onPressed: () => setState(() => _quantity++),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _addToCart,
            icon: const Icon(Icons.add_shopping_cart),
            label: Text('Додати за ${product.price * _quantity} грн'),
          ),
        ],
      ),
    );
  }
}
