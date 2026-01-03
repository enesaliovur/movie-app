import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String period;
  final String weeklyPrice;
  final String price;
  final bool isBestValue;

  /// Tier level: 0 = Weekly, 1 = Monthly, 2 = Yearly
  final int tier;

  const ProductEntity({
    required this.id,
    required this.period,
    required this.weeklyPrice,
    required this.price,
    required this.tier,
    this.isBestValue = false,
  });

  factory ProductEntity.weeklyDummy() {
    return const ProductEntity(
      id: 0,
      period: 'Weekly',
      weeklyPrice: '\$4.99',
      price: '\$4.99',
      tier: 0,
      isBestValue: false,
    );
  }

  factory ProductEntity.monthlyDummy() {
    return const ProductEntity(
      id: 1,
      period: 'Monthly',
      weeklyPrice: '\$2.99',
      price: '\$11.99',
      tier: 1,
      isBestValue: false,
    );
  }

  factory ProductEntity.yearlyDummy() {
    return const ProductEntity(
      id: 2,
      period: 'Yearly',
      weeklyPrice: '\$0.96',
      price: '\$49.99',
      tier: 2,
      isBestValue: true,
    );
  }

  @override
  List<Object?> get props => [
    id,
    period,
    weeklyPrice,
    price,
    tier,
    isBestValue,
  ];
}
