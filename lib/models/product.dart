import 'package:material_ui/material_ui.dart';

/// Товар меню кав'ярні. Усі поля незмінні, тому список товарів — const.
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.icon,
    required this.color,
  });

  final int id;
  final String name;
  final int price; // ціна в гривнях
  final String category;
  final String description;
  final IconData icon;
  final Color color; // індивідуальне тло товару (табл. 1.1)
}

const products = <Product>[
  Product(
    id: 1,
    name: 'Капучино',
    price: 65,
    category: 'Кава',
    description:
        'Еспресо зі збитим молоком і ніжною молочною пінкою. Об\'єм 250 мл.',
    icon: Icons.coffee,
    color: Color(0xFFD7CCC8),
  ),
  Product(
    id: 2,
    name: 'Лате',
    price: 70,
    category: 'Кава',
    description: 'Багато молока, трохи еспресо. Об\'єм 300 мл.',
    icon: Icons.local_cafe,
    color: Color(0xFFFFE0B2),
  ),
  Product(
    id: 3,
    name: 'Американо',
    price: 50,
    category: 'Кава',
    description: 'Еспресо, розбавлений гарячою водою. Об\'єм 250 мл.',
    icon: Icons.free_breakfast,
    color: Color(0xFFBCAAA4),
  ),
  Product(
    id: 4,
    name: 'Круасан',
    price: 55,
    category: 'Десерти',
    description: 'Листкове тісто на вершковому маслі.',
    icon: Icons.bakery_dining,
    color: Color(0xFFFFECB3),
  ),
  Product(
    id: 5,
    name: 'Чізкейк',
    price: 90,
    category: 'Десерти',
    description: 'Класичний чізкейк Нью-Йорк із ягідним соусом.',
    icon: Icons.cake,
    color: Color(0xFFF8BBD0),
  ),
  Product(
    id: 6,
    name: 'Чай',
    price: 45,
    category: 'Напої',
    description: 'Зелений чай із жасмином. Об\'єм 400 мл.',
    icon: Icons.emoji_food_beverage,
    color: Color(0xFFC8E6C9),
  ),
];
