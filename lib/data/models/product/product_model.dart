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
