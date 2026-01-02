import 'package:equatable/equatable.dart';

class ProductData extends Equatable {
  final int id;
  final String period;
  final String weeklyPrice;
  final String priceText;
  final bool isBestValue;

  /// Tier level: 0 = Weekly, 1 = Monthly, 2 = Yearly
  final int tier;

  const ProductData({
    required this.id,
    required this.period,
    required this.weeklyPrice,
    required this.priceText,
    required this.tier,
    this.isBestValue = false,
  });

  factory ProductData.weeklyDummy() {
    return const ProductData(
      id: 0,
      period: 'Weekly',
      weeklyPrice: '\$4.99',
      priceText: '\$4.99 / week',
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
    tier,
    isBestValue,
  ];
}
