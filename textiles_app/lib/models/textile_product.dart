import '../l10n/locale_manager.dart';

class TextileProduct {
  final String id;
  final String title;
  final String category;
  final String imageUrl;
  final String description;
  final double discountPercentage;
  final List<String> keyFeatures;
  final Map<String, String> specifications;
  final List<String> careInstructions;
  final List<String> relatedProductIds;

  // Japanese translations
  final String? titleJa;
  final String? categoryJa;
  final String? descriptionJa;
  final List<String>? keyFeaturesJa;
  final Map<String, String>? specificationsJa;
  final List<String>? careInstructionsJa;

  TextileProduct({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.discountPercentage,
    required this.keyFeatures,
    required this.specifications,
    required this.careInstructions,
    required this.relatedProductIds,
    this.titleJa,
    this.categoryJa,
    this.descriptionJa,
    this.keyFeaturesJa,
    this.specificationsJa,
    this.careInstructionsJa,
  });

  String get localizedTitle => (localeManager.isJapanese && titleJa != null) ? titleJa! : title;
  String get localizedCategory => (localeManager.isJapanese && categoryJa != null) ? categoryJa! : category;
  String get localizedDescription => (localeManager.isJapanese && descriptionJa != null) ? descriptionJa! : description;
  List<String> get localizedKeyFeatures => (localeManager.isJapanese && keyFeaturesJa != null) ? keyFeaturesJa! : keyFeatures;
  Map<String, String> get localizedSpecifications => (localeManager.isJapanese && specificationsJa != null) ? specificationsJa! : specifications;
  List<String> get localizedCareInstructions => (localeManager.isJapanese && careInstructionsJa != null) ? careInstructionsJa! : careInstructions;

  double get originalPricePlaceholder => 499.0;
  double get discountedPricePlaceholder => originalPricePlaceholder * (1 - discountPercentage / 100);
}
