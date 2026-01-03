import 'package:equatable/equatable.dart';

class ProductData extends Equatable {
  final int id;
  final String period;
  final String weeklyPrice;
  final String priceText;
  final String price;
  final bool isBestValue;

  /// Tier level: 0 = Weekly, 1 = Monthly, 2 = Yearly
  final int tier;

  const ProductData({
    required this.id,
    required this.period,
    required this.weeklyPrice,
    required this.priceText,
    required this.price,
    required this.tier,
    this.isBestValue = false,
  });

  factory ProductData.weeklyDummy() {
    return const ProductData(
      id: 0,
      period: 'Weekly',
      weeklyPrice: '\$4.99',
      priceText: '\$4.99 / week',
      price: '\$4.99',
      tier: 0,
      isBestValue: false,
    );
  }

  factory ProductData.monthlyDummy() {
    return const ProductData(
      id: 1,
      period: 'Monthly',
      weeklyPrice: '\$2.99',
      priceText: '\$11.99 / month',
      price: '\$11.99',
      tier: 1,
      isBestValue: false,
    );
  }

  factory ProductData.yearlyDummy() {
    return const ProductData(
      id: 2,
      period: 'Yearly',
      weeklyPrice: '\$0.96',
      priceText: '\$49.99 / year',
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
    priceText,
    price,
    tier,
    isBestValue,
  ];
}
