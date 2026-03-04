import 'package:flutter/material.dart';

class ShopsPage extends StatelessWidget {
  const ShopsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample shops data
    final List<Map<String, dynamic>> shops = [
      {'name': 'Tech Store', 'products': 120, 'rating': 4.5},
      {'name': 'Fashion Hub', 'products': 85, 'rating': 4.2},
      {'name': 'Home Decor', 'products': 200, 'rating': 4.8},
      {'name': 'Sports Gear', 'products': 95, 'rating': 4.3},
      {'name': 'Book Paradise', 'products': 500, 'rating': 4.7},
      {'name': 'Pet Supplies', 'products': 150, 'rating': 4.4},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Shops')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Tablet/Desktop layout - grid view
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: shops.length,
              itemBuilder: (context, index) {
                return _buildShopCard(
                  context,
                  shops[index],
                  constraints.maxWidth > 900,
                );
              },
            );
          } else {
            // Mobile layout - list view
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: shops.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.store,
                            size: 35,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                shops[index]['name'],
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${shops[index]['products']} products',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${shops[index]['rating']}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        FilledButton(
                          onPressed: () {},
                          child: const Text('Visit'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildShopCard(
    BuildContext context,
    Map<String, dynamic> shop,
    bool isWide,
  ) {
    if (isWide) {
      // Wide card for larger screens
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.store,
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      shop['name'],
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${shop['products']} products available',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 24),
                        const SizedBox(width: 4),
                        Text(
                          '${shop['rating']}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Rating',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FilledButton(
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text('Visit Shop'),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Standard card
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.store,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                shop['name'],
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                '${shop['products']} products',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text('${shop['rating']}'),
                ],
              ),
              const SizedBox(height: 12),
              FilledButton(onPressed: () {}, child: const Text('Visit')),
            ],
          ),
        ),
      );
    }
  }
}
