import 'package:flutter/material.dart';

// Product Model
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final bool isAvailable;
  final double rating;
  final int reviewCount;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isAvailable = true,
    this.rating = 0.0,
    this.reviewCount = 0,
  });
}

// Category Model
class Category {
  final String id;
  final String name;
  final String icon;
  final int itemCount;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.itemCount,
  });
}

// Shop Model
class Shop {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final int productCount;
  final String deliveryTime;
  final double deliveryFee;
  final double minimumOrder;
  final bool isOpen;
  final String address;

  const Shop({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.productCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.minimumOrder,
    this.isOpen = true,
    required this.address,
  });
}

// Cart Item Model
class CartItem {
  final Product product;
  int quantity;
  String? specialInstructions;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.specialInstructions,
  });

  double get totalPrice => product.price * quantity;
}

// Order Status Model
enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  onTheWay,
  delivered,
  cancelled,
}

extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.ready:
        return 'Ready for Pickup';
      case OrderStatus.onTheWay:
        return 'On the Way';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get step {
    switch (this) {
      case OrderStatus.pending:
        return '1';
      case OrderStatus.confirmed:
        return '2';
      case OrderStatus.preparing:
        return '3';
      case OrderStatus.ready:
        return '4';
      case OrderStatus.onTheWay:
        return '5';
      case OrderStatus.delivered:
        return '6';
      case OrderStatus.cancelled:
        return '0';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.confirmed:
        return Colors.blue;
      case OrderStatus.preparing:
        return Colors.purple;
      case OrderStatus.ready:
        return Colors.teal;
      case OrderStatus.onTheWay:
        return Colors.indigo;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }
}

// Order Model
class Order {
  final String id;
  final String orderNumber;
  final Shop shop;
  final List<CartItem> items;
  final OrderStatus status;
  final DateTime orderDate;
  final DateTime? estimatedDeliveryTime;
  final double subtotal;
  final double deliveryFee;
  final double serviceFee;
  final double discount;
  final double total;
  final String deliveryAddress;
  final DeliveryPerson? deliveryPerson;

  const Order({
    required this.id,
    required this.orderNumber,
    required this.shop,
    required this.items,
    required this.status,
    required this.orderDate,
    this.estimatedDeliveryTime,
    required this.subtotal,
    required this.deliveryFee,
    required this.serviceFee,
    this.discount = 0,
    required this.total,
    required this.deliveryAddress,
    this.deliveryPerson,
  });
}

// Delivery Person Model
class DeliveryPerson {
  final String id;
  final String name;
  final String photoUrl;
  final String phoneNumber;
  final String vehicleType;
  final String vehiclePlate;
  final double rating;
  final double latitude;
  final double longitude;

  const DeliveryPerson({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.phoneNumber,
    required this.vehicleType,
    required this.vehiclePlate,
    required this.rating,
    required this.latitude,
    required this.longitude,
  });
}

// Crop Yield Information Model
class CropYield {
  final String id;
  final String name;
  final String season;
  final double currentYield; // per hectare in kg
  final double previousYield;
  final double averageYield;
  final String unit;
  final double pricePerUnit;
  final String status; // 'up', 'down', 'stable'
  final String region;

  const CropYield({
    required this.id,
    required this.name,
    required this.season,
    required this.currentYield,
    required this.previousYield,
    required this.averageYield,
    required this.unit,
    required this.pricePerUnit,
    required this.status,
    required this.region,
  });

  double get fluctuation =>
      ((currentYield - previousYield) / previousYield) * 100;
}

// Fertilizer Product Model
class Fertilizer {
  final String id;
  final String name;
  final String description;
  final String
  type; // 'nitrogen', 'phosphorus', 'potassium', 'organic', 'compound'
  final double price;
  final String unit; // 'kg', 'bag'
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final bool isAvailable;
  final String manufacturer;

  const Fertilizer({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.price,
    required this.unit,
    required this.imageUrl,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isAvailable = true,
    required this.manufacturer,
  });
}

// Pesticide Product Model
class Pesticide {
  final String id;
  final String name;
  final String description;
  final String type; // 'insecticide', 'herbicide', 'fungicide', 'rodenticide'
  final double price;
  final String unit; // 'liter', 'kg', 'bottle'
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final bool isAvailable;
  final String manufacturer;
  final String targetPests;

  const Pesticide({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.price,
    required this.unit,
    required this.imageUrl,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isAvailable = true,
    required this.manufacturer,
    required this.targetPests,
  });
}

// Promo Banner Model
class PromoBanner {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String? actionUrl;
  final bool isActive;

  const PromoBanner({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.actionUrl,
    this.isActive = true,
  });
}

// Address Model
class Address {
  final String id;
  final String label;
  final String fullAddress;
  final String street;
  final String city;
  final String zipCode;
  final double latitude;
  final double longitude;
  final bool isDefault;

  const Address({
    required this.id,
    required this.label,
    required this.fullAddress,
    required this.street,
    required this.city,
    required this.zipCode,
    required this.latitude,
    required this.longitude,
    this.isDefault = false,
  });
}

// Sample Data
class SampleData {
  static const List<Category> categories = [
    Category(id: '1', name: 'Fertilizers', icon: 'science', itemCount: 150),
    Category(id: '2', name: 'Pesticides', icon: 'bug_report', itemCount: 300),
    Category(id: '3', name: 'Seeds', icon: 'grass', itemCount: 80),
    Category(id: '4', name: 'Tools', icon: 'hardware', itemCount: 45),
    Category(id: '5', name: 'Crops', icon: 'agriculture', itemCount: 120),
    Category(id: '6', name: 'Equipment', icon: 'construction', itemCount: 200),
    Category(id: '7', name: 'Irrigation', icon: 'water_drop', itemCount: 250),
    Category(id: '8', name: 'Animal Feed', icon: 'pets', itemCount: 500),
  ];

  static const List<Shop> shops = [
    Shop(
      id: '1',
      name: 'Green Valley Agri Shop',
      description: 'Quality fertilizers and seeds for all crops',
      imageUrl: '',
      rating: 4.5,
      reviewCount: 230,
      productCount: 45,
      deliveryTime: '25-35 min',
      deliveryFee: 1500.0,
      minimumOrder: 50000.0,
      address: '123 Farmer Road, Mandalay',
    ),
    Shop(
      id: '2',
      name: 'AgriCare Solutions',
      description: 'Premium pesticides and crop protection products',
      imageUrl: '',
      rating: 4.7,
      reviewCount: 450,
      productCount: 30,
      deliveryTime: '30-40 min',
      deliveryFee: 2000.0,
      minimumOrder: 80000.0,
      address: '456 Market Street, Yangon',
    ),
    Shop(
      id: '3',
      name: 'Golden Harvest Seeds',
      description: 'High-quality seeds for paddy, beans, and vegetables',
      imageUrl: '',
      rating: 4.3,
      reviewCount: 180,
      productCount: 500,
      deliveryTime: '45-60 min',
      deliveryFee: 1000.0,
      minimumOrder: 100000.0,
      address: '789 Agriculture Ave, Sagaing',
    ),
    Shop(
      id: '4',
      name: 'Farm Tools Center',
      description: 'Quality farming tools and equipment',
      imageUrl: '',
      rating: 4.6,
      reviewCount: 120,
      productCount: 200,
      deliveryTime: '20-30 min',
      deliveryFee: 500.0,
      minimumOrder: 30000.0,
      address: '321 Equipment Road, Bago',
    ),
    Shop(
      id: '5',
      name: 'Organic Farm Supplies',
      description: 'Natural fertilizers and organic farming products',
      imageUrl: '',
      rating: 4.8,
      reviewCount: 95,
      productCount: 50,
      deliveryTime: '35-45 min',
      deliveryFee: 2500.0,
      minimumOrder: 150000.0,
      address: '654 Green Lane, Shan State',
    ),
    Shop(
      id: '6',
      name: 'Myanmar Agro Tech',
      description: 'Modern agricultural solutions and products',
      imageUrl: '',
      rating: 4.4,
      reviewCount: 310,
      productCount: 25,
      deliveryTime: '15-25 min',
      deliveryFee: 1000.0,
      minimumOrder: 40000.0,
      address: '987 Tech Park, Naypyidaw',
    ),
  ];

  static const List<Product> featuredProducts = [
    Product(
      id: '1',
      name: 'Urea 46-0-0 Fertilizer',
      description:
          'High nitrogen content fertilizer for vegetative growth - 50kg bag',
      price: 35000.0,
      imageUrl: '',
      category: 'Fertilizers',
      rating: 4.5,
      reviewCount: 120,
    ),
    Product(
      id: '2',
      name: 'DAP 18-46-0 Fertilizer',
      description: 'Phosphate fertilizer for root development - 50kg bag',
      price: 42000.0,
      imageUrl: '',
      category: 'Fertilizers',
      rating: 4.7,
      reviewCount: 250,
    ),
    Product(
      id: '3',
      name: 'Glyphosate Herbicide',
      description: 'Non-selective herbicide for weed control - 1 liter',
      price: 12000.0,
      imageUrl: '',
      category: 'Pesticides',
      rating: 4.3,
      reviewCount: 80,
    ),
    Product(
      id: '4',
      name: 'Carbofuran 3G',
      description: 'Granular insecticide for soil pests - 1kg',
      price: 8500.0,
      imageUrl: '',
      category: 'Pesticides',
      rating: 4.6,
      reviewCount: 150,
    ),
    Product(
      id: '5',
      name: 'Paddy Seeds (Sin Thukha)',
      description: 'High-yield paddy seeds for monsoon season - 25kg',
      price: 25000.0,
      imageUrl: '',
      category: 'Seeds',
      rating: 4.9,
      reviewCount: 45,
    ),
    Product(
      id: '6',
      name: 'NPK 20-20-20 Balanced',
      description: 'Balanced fertilizer for all-round plant growth - 50kg',
      price: 45000.0,
      imageUrl: '',
      category: 'Fertilizers',
      rating: 4.4,
      reviewCount: 200,
    ),
  ];

  static const List<PromoBanner> promoBanners = [
    PromoBanner(
      id: '1',
      title: '50% OFF',
      subtitle: 'On fertilizers for first order',
      imageUrl: '',
      isActive: true,
    ),
    PromoBanner(
      id: '2',
      title: 'Free Delivery',
      subtitle: 'On orders above 100,000 MMK',
      imageUrl: '',
      isActive: true,
    ),
    PromoBanner(
      id: '3',
      title: 'New Users',
      subtitle: 'Get 20% off on pesticides',
      imageUrl: '',
      isActive: true,
    ),
  ];

  // Alias for backward compatibility
  static List<PromoBanner> get banners => promoBanners;

  // Crop Yield Data
  static const List<CropYield> cropYields = [
    CropYield(
      id: '1',
      name: 'Rice',
      season: 'Monsoon 2026',
      currentYield: 4200,
      previousYield: 3800,
      averageYield: 4000,
      unit: 'kg/ha',
      pricePerUnit: 150,
      status: 'up',
      region: 'Ayeyarwady',
    ),
    CropYield(
      id: '2',
      name: 'Beans',
      season: 'Winter 2025',
      currentYield: 1800,
      previousYield: 1950,
      averageYield: 1900,
      unit: 'kg/ha',
      pricePerUnit: 280,
      status: 'down',
      region: 'Sagaing',
    ),
    CropYield(
      id: '3',
      name: 'Corn',
      season: 'Summer 2025',
      currentYield: 5200,
      previousYield: 5100,
      averageYield: 5000,
      unit: 'kg/ha',
      pricePerUnit: 180,
      status: 'up',
      region: 'Mandalay',
    ),
    CropYield(
      id: '4',
      name: 'Paddy',
      season: 'Monsoon 2026',
      currentYield: 3500,
      previousYield: 3500,
      averageYield: 3600,
      unit: 'kg/ha',
      pricePerUnit: 160,
      status: 'stable',
      region: 'Bago',
    ),
    CropYield(
      id: '5',
      name: 'Sesame',
      season: 'Winter 2025',
      currentYield: 850,
      previousYield: 780,
      averageYield: 800,
      unit: 'kg/ha',
      pricePerUnit: 450,
      status: 'up',
      region: 'Magway',
    ),
    CropYield(
      id: '6',
      name: 'Potato',
      season: 'Winter 2025',
      currentYield: 15000,
      previousYield: 16200,
      averageYield: 15500,
      unit: 'kg/ha',
      pricePerUnit: 80,
      status: 'down',
      region: 'Shan State',
    ),
  ];

  // Fertilizer Products
  static const List<Fertilizer> fertilizers = [
    Fertilizer(
      id: '1',
      name: 'Urea 46-0-0',
      description: 'High nitrogen content fertilizer for vegetative growth',
      type: 'nitrogen',
      price: 35000,
      unit: 'bag',
      imageUrl: '',
      rating: 4.5,
      reviewCount: 120,
      manufacturer: 'Myanmar Fertilizer Co.',
    ),
    Fertilizer(
      id: '2',
      name: 'DAP 18-46-0',
      description: 'Phosphate fertilizer for root development',
      type: 'phosphorus',
      price: 42000,
      unit: 'bag',
      imageUrl: '',
      rating: 4.7,
      reviewCount: 85,
      manufacturer: 'Myanmar Fertilizer Co.',
    ),
    Fertilizer(
      id: '3',
      name: 'Potash 0-0-60',
      description: 'Potassium fertilizer for crop maturity',
      type: 'potassium',
      price: 38000,
      unit: 'bag',
      imageUrl: '',
      rating: 4.3,
      reviewCount: 60,
      manufacturer: 'Agrochem Myanmar',
    ),
    Fertilizer(
      id: '4',
      name: 'NPK 20-20-20',
      description: 'Balanced fertilizer for all-round plant growth',
      type: 'compound',
      price: 45000,
      unit: 'bag',
      imageUrl: '',
      rating: 4.8,
      reviewCount: 200,
      manufacturer: 'Green Growth Ltd.',
    ),
    Fertilizer(
      id: '5',
      name: 'Compost Organic',
      description: 'Natural organic fertilizer for soil improvement',
      type: 'organic',
      price: 15000,
      unit: 'bag',
      imageUrl: '',
      rating: 4.6,
      reviewCount: 150,
      manufacturer: 'Earth Care Myanmar',
    ),
    Fertilizer(
      id: '6',
      name: 'Ammonium Sulfate',
      description: 'Nitrogen and sulfur fertilizer for paddy fields',
      type: 'nitrogen',
      price: 28000,
      unit: 'bag',
      imageUrl: '',
      rating: 4.4,
      reviewCount: 95,
      manufacturer: 'Myanmar Fertilizer Co.',
    ),
  ];

  // Pesticide Products
  static const List<Pesticide> pesticides = [
    Pesticide(
      id: '1',
      name: 'Carbofuran 3G',
      description: 'Granular insecticide for soil pests',
      type: 'insecticide',
      price: 8500,
      unit: 'kg',
      imageUrl: '',
      rating: 4.5,
      reviewCount: 80,
      manufacturer: 'Crop Protection Myanmar',
      targetPests: 'Stem borers, leafhoppers',
    ),
    Pesticide(
      id: '2',
      name: 'Glyphosate 41%',
      description: 'Non-selective herbicide for weed control',
      type: 'herbicide',
      price: 12000,
      unit: 'liter',
      imageUrl: '',
      rating: 4.7,
      reviewCount: 250,
      manufacturer: 'Agrochem Myanmar',
      targetPests: 'Annual and perennial weeds',
    ),
    Pesticide(
      id: '3',
      name: 'Carbendazim 50%',
      description: 'Systemic fungicide for crop diseases',
      type: 'fungicide',
      price: 15000,
      unit: 'kg',
      imageUrl: '',
      rating: 4.6,
      reviewCount: 120,
      manufacturer: 'Crop Protection Myanmar',
      targetPests: 'Rice blast, leaf spot, powdery mildew',
    ),
    Pesticide(
      id: '4',
      name: 'Chlorpyrifos 40%',
      description: 'Broad spectrum insecticide',
      type: 'insecticide',
      price: 18000,
      unit: 'liter',
      imageUrl: '',
      rating: 4.4,
      reviewCount: 90,
      manufacturer: 'Green Crop Solutions',
      targetPests: 'Aphids, mites, thrips',
    ),
    Pesticide(
      id: '5',
      name: 'Butachlor 50%',
      description: 'Pre-emergence herbicide for paddy',
      type: 'herbicide',
      price: 9500,
      unit: 'liter',
      imageUrl: '',
      rating: 4.3,
      reviewCount: 65,
      manufacturer: 'Agrochem Myanmar',
      targetPests: 'Grassy weeds in paddy',
    ),
    Pesticide(
      id: '6',
      name: 'Metaldehyde 5%',
      description: 'Snail and slug killer',
      type: 'rodenticide',
      price: 6500,
      unit: 'kg',
      imageUrl: '',
      rating: 4.2,
      reviewCount: 45,
      manufacturer: 'Pest Control Myanmar',
      targetPests: 'Snails, slugs',
    ),
  ];

  static const List<Address> savedAddresses = [
    Address(
      id: '1',
      label: 'Home',
      fullAddress: '123 ABC Street, Yangon',
      street: '123 ABC Street',
      city: 'Yangon',
      zipCode: '11181',
      latitude: 16.8661,
      longitude: 96.1951,
      isDefault: true,
    ),
    Address(
      id: '2',
      label: 'Office',
      fullAddress: '456 XYZ Building, Downtown',
      street: '456 XYZ Building',
      city: 'Yangon',
      zipCode: '11141',
      latitude: 16.7806,
      longitude: 96.1493,
      isDefault: false,
    ),
  ];
}
