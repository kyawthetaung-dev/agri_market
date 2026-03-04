import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample orders data
    final List<Map<String, dynamic>> orders = [
      {
        'id': 'ORD-001',
        'date': '2024-03-01',
        'status': 'Delivered',
        'total': 45.99,
      },
      {
        'id': 'ORD-002',
        'date': '2024-03-02',
        'status': 'Processing',
        'total': 125.50,
      },
      {
        'id': 'ORD-003',
        'date': '2024-03-03',
        'status': 'Shipped',
        'total': 89.00,
      },
      {
        'id': 'ORD-004',
        'date': '2024-03-04',
        'status': 'Pending',
        'total': 35.75,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Tablet/Desktop layout - table view
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Order ID')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Total')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: orders.map((order) {
                    return DataRow(
                      cells: [
                        DataCell(Text(order['id'])),
                        DataCell(Text(order['date'])),
                        DataCell(_buildStatusChip(context, order['status'])),
                        DataCell(
                          Text('\$${order['total'].toStringAsFixed(2)}'),
                        ),
                        DataCell(
                          TextButton(
                            onPressed: () {},
                            child: const Text('View Details'),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          } else {
            // Mobile layout - list view
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              orders[index]['id'],
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            _buildStatusChip(context, orders[index]['status']),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date: ${orders[index]['date']}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '\$${orders[index]['total'].toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: const Text('View Details'),
                          ),
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

  Widget _buildStatusChip(BuildContext context, String status) {
    Color chipColor;
    switch (status) {
      case 'Delivered':
        chipColor = Colors.green;
        break;
      case 'Shipped':
        chipColor = Colors.blue;
        break;
      case 'Processing':
        chipColor = Colors.orange;
        break;
      case 'Pending':
        chipColor = Colors.grey;
        break;
      default:
        chipColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: chipColor),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: chipColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
