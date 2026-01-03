import 'package:equatable/equatable.dart';

class PaywallFeature extends Equatable {
  final String name;
  final bool freeAccess;

  /// Minimum tier required (0 = all, 1 = monthly+, 2 = yearly only)
  final int minTierRequired;

  const PaywallFeature({
    required this.name,
    required this.freeAccess,
    required this.minTierRequired,
  });

  /// Check if feature is available for given product tier
  bool isAvailableForTier(int productTier) => productTier >= minTierRequired;

  @override
  List<Object?> get props => [name, freeAccess, minTierRequired];
}

/// Central source of paywall features.
///
/// Tier levels:
/// - 0 = Weekly (basic)
/// - 1 = Monthly (standard)
/// - 2 = Yearly (premium)
class PaywallFeatures {
  static const List<PaywallFeature> all = [
    PaywallFeature(
      name: 'Daily Movie Suggestions',
      freeAccess: true,
      minTierRequired: 0, // All tiers
    ),
    PaywallFeature(
      name: 'AI-Powered Movie Insights',
      freeAccess: false,
      minTierRequired: 0, // All tiers
    ),
    PaywallFeature(
      name: 'Personalized Watchlist',
      freeAccess: false,
      minTierRequired: 1, // Monthly+ only
    ),
    PaywallFeature(
      name: 'Ad-Free Experience',
      freeAccess: false,
      minTierRequired: 2, // Yearly only
    ),
  ];
}
