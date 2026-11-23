import 'package:material_ui/material_ui.dart';

import '../cart.dart';
import '../models/product.dart';
import 'cart_screen.dart';
import 'details_screen.dart';

/// Головний екран: AppBar з кошиком, привітання, фільтр категорій, сітка товарів.
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  static const _categories = ['Усі', 'Кава', 'Десерти', 'Напої'];
  String _category = 'Усі';

  List<Product> get _visible => _category == 'Усі'
      ? products
      : products.where((p) => p.category == _category).toList();

  // Відкриває екран і після повернення оновлює лічильник кошика
  void _open(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Кав\'ярня «Зерно»'),
        actions: [
          IconButton(
            tooltip: 'Кошик',
            onPressed: () => _open(const CartScreen()),
            icon: Badge(
              isLabelVisible: cart.count > 0,
              label: Text('${cart.count}'),
              child: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // блок привітання з даними виконавця
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Доброго дня!', style: textTheme.titleLarge),
                const SizedBox(height: 4),
                const Text('Виконав: Коваль Д. В., гр. ІПЗ-42'),
              ],
            ),
          ),
          // фільтр категорій
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final c in _categories)
                  ChoiceChip(
                    label: Text(c),
                    selected: _category == c,
                    onSelected: (_) => setState(() => _category = c),
                  ),
              ],
            ),
          ),
          // сітка карток; Expanded обмежує висоту прокручуваної області
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: _visible.length,
              itemBuilder: (context, index) {
                final product = _visible[index];
                return ProductCard(
                  product: product,
                  onTap: () => _open(DetailsScreen(product: product)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Картка товару в сітці меню.
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // спільний елемент для анімації переходу на «Деталі товару»
              child: Hero(
                tag: 'product-${product.id}',
                child: Container(
                  width: double.infinity,
                  color: product.color,
                  child: Icon(product.icon, size: 56, color: Colors.brown),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    '${product.price} грн',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
