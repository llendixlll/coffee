import 'package:material_ui/material_ui.dart';

import '../cart.dart';

/// Екран «Кошик»: позиції, видалення свайпом, підсумкова сума.
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Достатній рівень: оформлення лише підтверджується повідомленням
  void _checkout() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Замовлення прийнято!')));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Кошик')),
      body: cart.items.isEmpty
          ? const Center(
              child: Text('Кошик порожній', style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return Dismissible(
                  key: ValueKey(item.product.id),
                  direction: DismissDirection.endToStart, // свайп ліворуч
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 24),
                    color: Colors.red.shade100,
                    child: const Icon(Icons.delete),
                  ),
                  onDismissed: (_) => setState(() => cart.remove(item)),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: item.product.color,
                        child: Icon(item.product.icon, color: Colors.brown),
                      ),
                      title: Text(item.product.name),
                      subtitle: Text(
                        '${item.quantity} × ${item.product.price} грн',
                      ),
                      trailing: Text(
                        '${item.sum} грн',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: textTheme.titleLarge,
                          children: [
                            const TextSpan(text: 'Разом: '),
                            TextSpan(
                              text: '${cart.total} грн',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _checkout,
                      child: const Text('Оформити'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
