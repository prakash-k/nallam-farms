import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Container(
      color: const Color(0xFF1F3A2E), // Deep Forest Green
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        children: [
          Wrap(
            spacing: 48,
            runSpacing: 32,
            alignment: WrapAlignment.spaceBetween,
            children: [
              // Brand Col
              SizedBox(
                width: isMobile ? width : 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'NALLAM ',
                          style: TextStyle(
                            fontFamily: 'Cormorant Garamond',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFC7A86B),
                          ),
                        ),
                        Text(
                          'GROUP',
                          style: TextStyle(
                            fontFamily: 'Cormorant Garamond',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Delivering pure farm products and crafting premium yarn-dyed home textiles. Authentic quality and trust.',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Links Col - Farms
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nallam Farms',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFFC7A86B),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _FooterLink(
                    title: 'Farm Fresh Vegetables',
                    onTap: () => Navigator.pushNamed(context, '/'),
                  ),
                  _FooterLink(
                    title: 'Agricultural Grains',
                    onTap: () => Navigator.pushNamed(context, '/'),
                  ),
                  _FooterLink(
                    title: 'Natural Food Products',
                    onTap: () => Navigator.pushNamed(context, '/'),
                  ),
                ],
              ),

              // Links Col - Textiles
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nallam Textiles',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFFC7A86B),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _FooterLink(
                    title: 'Table Linen',
                    onTap: () => Navigator.pushNamed(context, '/catalog', arguments: 'Table Linen'),
                  ),
                  _FooterLink(
                    title: 'Cushions',
                    onTap: () => Navigator.pushNamed(context, '/catalog', arguments: 'Cushions'),
                  ),
                  _FooterLink(
                    title: 'Upholstery Fabrics',
                    onTap: () => Navigator.pushNamed(context, '/catalog', arguments: 'Fabrics'),
                  ),
                ],
              ),

              // Support Col
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact & Support',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFFC7A86B),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const _FooterText(title: 'Phone: +91 75 9191 9910'),
                  const _FooterText(title: 'Email: info@nallamfarms.com'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),
          const Text(
            '© 2026 NALLAM GROUP. All Rights Reserved. Crafted with Purity & Trust.',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: Colors.white38,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _FooterLink({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterText extends StatelessWidget {
  final String title;

  const _FooterText({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          color: Colors.white54,
          fontSize: 13,
        ),
      ),
    );
  }
}
