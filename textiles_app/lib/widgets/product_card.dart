import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../models/textile_product.dart';
import '../l10n/locale_manager.dart';

class ProductCard extends StatefulWidget {
  final TextileProduct product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: localeManager.languageNotifier,
      builder: (context, _, __) {
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isHovered ? const Color(0xFFC7A86B) : const Color(0xFFE8E2D5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered 
                      ? const Color(0x1A1F3A2E) 
                      : const Color(0x0A000000),
                    blurRadius: _isHovered ? 20 : 8,
                    offset: Offset(0, _isHovered ? 8 : 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image section
                  Expanded(
                    child: Stack(
                      children: [
                        // Product Image
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
                          child: Container(
                            width: double.infinity,
                            color: const Color(0xFFFCFBF8),
                            child: AnimatedScale(
                              scale: _isHovered ? 1.05 : 1.0,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeOut,
                              child: widget.product.imageUrl.startsWith('http')
                                  ? CachedNetworkImage(
                                      imageUrl: widget.product.imageUrl,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          color: Colors.white,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => const Center(
                                        child: Icon(Icons.error, color: Colors.red),
                                      ),
                                    )
                                  : Image.asset(
                                      widget.product.imageUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                            ),
                          ),
                        ),

                        // Discount Tag
                        if (widget.product.discountPercentage > 0)
                          Positioned(
                            top: 12,
                            left: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1F3A2E), // Forest Green
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '-${widget.product.discountPercentage.toInt()}%',
                                style: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFFC7A86B), // Gold
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Info section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category
                        Text(
                          widget.product.localizedCategory.toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF8A5A3B), // Warm Earth Brown
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Title
                        Text(
                          widget.product.localizedTitle,
                          style: const TextStyle(
                            fontFamily: 'Cormorant Garamond',
                            color: Color(0xFF1F3A2E),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),

                        // Login to See Prices placeholder (Ranjini Textiles Style)
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/auth');
                          },
                          child: Text(
                            tr('Login to see prices', 'ログインして価格を表示'),
                            style: const TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Color(0xFFC7A86B),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Quick View Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr('Quick view →', 'クイック表示 →'),
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: _isHovered ? const Color(0xFF1F3A2E) : const Color(0xFF8A5A3B),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
