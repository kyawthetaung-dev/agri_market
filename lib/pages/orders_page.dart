import 'package:flutter/material.dart';
import '../models/models.dart' as models;
import '../theme/app_theme.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersList(
            models.OrderStatus.pending,
            models.OrderStatus.onTheWay,
          ),
          _buildOrdersList(models.OrderStatus.delivered),
          _buildOrdersList(models.OrderStatus.cancelled),
        ],
      ),
    );
  }

  Widget _buildOrdersList(
    models.OrderStatus status, [
    models.OrderStatus? status2,
  ]) {
    // Sample orders data
    final List<Map<String, dynamic>> allOrders = [
      {
        'id': 'ORD-001',
        'shop': models.SampleData.shops[0],
        'status': models.OrderStatus.onTheWay,
        'orderDate': DateTime.now().subtract(const Duration(hours: 2)),
        'items': '2 bags Urea + 1 liter Glyphosate',
        'total': 82000.0,
        'estimatedTime': '15 min',
      },
      {
        'id': 'ORD-002',
        'shop': models.SampleData.shops[1],
        'status': models.OrderStatus.preparing,
        'orderDate': DateTime.now().subtract(const Duration(minutes: 30)),
        'items': '5 liters Carbofuran',
        'total': 42500.0,
        'estimatedTime': '25 min',
      },
      {
        'id': 'ORD-003',
        'shop': models.SampleData.shops[2],
        'status': models.OrderStatus.delivered,
        'orderDate': DateTime.now().subtract(const Duration(days: 1)),
        'items': '25kg Paddy Seeds (Sin Thukha)',
        'total': 25000.0,
      },
      {
        'id': 'ORD-004',
        'shop': models.SampleData.shops[3],
        'status': models.OrderStatus.delivered,
        'orderDate': DateTime.now().subtract(const Duration(days: 2)),
        'items': '1 set Farming Tools',
        'total': 55000.0,
      },
      {
        'id': 'ORD-005',
        'shop': models.SampleData.shops[4],
        'status': models.OrderStatus.cancelled,
        'orderDate': DateTime.now().subtract(const Duration(days: 3)),
        'items': '3 bags NPK 20-20-20',
        'total': 135000.0,
      },
    ];

    final filteredOrders = allOrders.where((order) {
      if (status2 != null) {
        return order['status'] == status || order['status'] == status2;
      }
      return order['status'] == status;
    }).toList();

    if (filteredOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.grass, size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'No orders yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start shopping to see your orders here',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        return _buildOrderCard(order);
      },
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final shop = order['shop'] as models.Shop;
    final status = order['status'] as models.OrderStatus;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          _showOrderDetails(order);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order['id'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  _buildStatusChip(status),
                ],
              ),
              const SizedBox(height: 12),

              // Shop Info
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.store,
                      color: AppTheme.primaryColor.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shop.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${order['items']} • ${order['total'].toStringAsFixed(0)} MMK',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Tracking Progress (for active orders)
              if (status != models.OrderStatus.delivered &&
                  status != models.OrderStatus.cancelled) ...[
                const SizedBox(height: 16),
                _buildTrackingProgress(status),
              ],

              const Divider(height: 24),

              // Order Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatDate(order['orderDate']),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      if (order['estimatedTime'] != null)
                        Text(
                          'ETA: ${order['estimatedTime']}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      if (status == models.OrderStatus.onTheWay)
                        OutlinedButton.icon(
                          onPressed: () {
                            _showDeliveryTracking(order);
                          },
                          icon: const Icon(Icons.location_on, size: 16),
                          label: const Text('Track'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.primaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () {
                          _showOrderDetails(order);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primaryColor,
                        ),
                        child: const Text('Details'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(models.OrderStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: status.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: status.color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTrackingProgress(models.OrderStatus status) {
    final currentStep = int.parse(status.step);

    return Column(
      children: [
        Row(
          children: [
            _buildProgressDot(1, currentStep),
            Expanded(child: _buildProgressLine(1, currentStep)),
            _buildProgressDot(2, currentStep),
            Expanded(child: _buildProgressLine(2, currentStep)),
            _buildProgressDot(3, currentStep),
            Expanded(child: _buildProgressLine(3, currentStep)),
            _buildProgressDot(4, currentStep),
            Expanded(child: _buildProgressLine(4, currentStep)),
            _buildProgressDot(5, currentStep),
            Expanded(child: _buildProgressLine(5, currentStep)),
            _buildProgressDot(6, currentStep),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ordered',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
            Text(
              'Confirmed',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
            Text(
              'Preparing',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
            Text(
              'Ready',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
            Text(
              'On Way',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
            Text(
              'Delivered',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressDot(int step, int currentStep) {
    final isActive = step <= currentStep;
    final isCurrent = step == currentStep;

    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primaryColor : Colors.grey.shade300,
        shape: BoxShape.circle,
        border: isCurrent
            ? Border.all(color: AppTheme.primaryColor, width: 2)
            : null,
      ),
    );
  }

  Widget _buildProgressLine(int step, int currentStep) {
    final isActive = step < currentStep;

    return Container(
      height: 2,
      color: isActive ? AppTheme.primaryColor : Colors.grey.shade300,
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hours ago';
    } else {
      return '${diff.inDays} days ago';
    }
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return _OrderDetailsSheet(
              order: order,
              scrollController: scrollController,
            );
          },
        );
      },
    );
  }

  void _showDeliveryTracking(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return _DeliveryTrackingSheet(order: order);
      },
    );
  }
}

class _OrderDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> order;
  final ScrollController scrollController;

  const _OrderDetailsSheet({
    required this.order,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final shop = order['shop'] as models.Shop;
    final status = order['status'] as models.OrderStatus;

    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView(
        controller: scrollController,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Order ID
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order['id'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: status.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  status.displayName,
                  style: TextStyle(
                    color: status.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Shop Info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.store, color: AppTheme.primaryColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shop.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          shop.address,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Order Items
          const Text(
            'Order Items',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildOrderItem('Classic Cheeseburger', 2, 8.99),
                  const Divider(),
                  _buildOrderItem('French Fries', 1, 3.99),
                  const Divider(),
                  _buildOrderItem('Soft Drink', 2, 1.99),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Payment Summary
          const Text(
            'Payment Summary',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSummaryRow(
                    'Subtotal',
                    '${order['total'].toStringAsFixed(0)} MMK',
                  ),
                  const SizedBox(height: 8),
                  _buildSummaryRow('Delivery Fee', '3000 MMK'),
                  const SizedBox(height: 8),
                  _buildSummaryRow(
                    'Service Fee',
                    '${(order['total'] * 0.02).toStringAsFixed(0)} MMK',
                  ),
                  const Divider(),
                  _buildSummaryRow(
                    'Total',
                    '${(order['total'] + 3000 + order['total'] * 0.02).toStringAsFixed(0)} MMK',
                    isTotal: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Delivery Address
          const Text(
            'Delivery Address',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: AppTheme.primaryColor,
                ),
              ),
              title: const Text('Home'),
              subtitle: const Text('123 ABC Street, Yangon'),
            ),
          ),
          const SizedBox(height: 20),

          // Action Buttons
          if (status == models.OrderStatus.delivered)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.replay),
                    label: const Text('Reorder'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.star),
                    label: const Text('Review'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),

          if (status == models.OrderStatus.cancelled)
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Order Again'),
            ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(String name, int qty, double price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text('$qty x $name'), Text('${price * qty} MMK')],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            fontSize: isTotal ? 16 : 14,
            color: isTotal ? AppTheme.primaryColor : null,
          ),
        ),
      ],
    );
  }
}

class _DeliveryTrackingSheet extends StatefulWidget {
  final Map<String, dynamic> order;

  const _DeliveryTrackingSheet({required this.order});

  @override
  State<_DeliveryTrackingSheet> createState() => _DeliveryTrackingSheetState();
}

class _DeliveryTrackingSheetState extends State<_DeliveryTrackingSheet> {
  double _driverLat = 16.85;
  double _driverLng = 96.18;

  // Simulated driver location updates
  void _updateDriverLocation() {
    setState(() {
      _driverLat -= 0.001;
      _driverLng -= 0.001;
    });
  }

  @override
  void initState() {
    super.initState();
    // Simulate driver movement
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) _updateDriverLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final shop = widget.order['shop'] as models.Shop;

    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Header
          Row(
            children: [
              const Text(
                'Track Delivery',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(Icons.circle, color: Colors.green, size: 8),
                    const SizedBox(width: 4),
                    const Text(
                      'On the way',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Map Placeholder
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  // Grid lines for map effect
                  CustomPaint(painter: _MapGridPainter(), child: Container()),

                  // Shop location
                  Positioned(
                    top: 40,
                    left: 40,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.store,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 30,
                          color: AppTheme.primaryColor,
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppTheme.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Delivery destination
                  Positioned(
                    bottom: 60,
                    right: 40,
                    child: Column(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(width: 2, height: 30, color: Colors.red),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Driver location (simulated)
                  Positioned(
                    top: _driverLat * 10,
                    left: _driverLng * 10,
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Driver',
                            style: TextStyle(color: Colors.white, fontSize: 8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Delivery Person Info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'John Doe',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber.shade700,
                              size: 14,
                            ),
                            const SizedBox(width: 2),
                            const Text('4.9', style: TextStyle(fontSize: 12)),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.motorcycle,
                              size: 14,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              'Motorcycle',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.phone, color: Colors.green),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.chat, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ETA Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.access_time, color: AppTheme.primaryColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Estimated Arrival',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        widget.order['estimatedTime'] ?? '15 minutes',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  '1.2 km away',
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 0.5;

    // Draw vertical lines
    for (double i = 0; i < size.width; i += 20) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    // Draw horizontal lines
    for (double i = 0; i < size.height; i += 20) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
