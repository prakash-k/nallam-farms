import 'package:flutter/material.dart';
import '../l10n/locale_manager.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return ValueListenableBuilder<String>(
      valueListenable: localeManager.languageNotifier,
      builder: (context, _, __) {
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
                        Text(
                          tr(
                            'Delivering pure farm products and crafting premium yarn-dyed home textiles. Authentic quality and trust.',
                            '純粋な農産物をお届けし、プレミアムな先染めホームテキスタイルをクラフトします。本物の品質と信頼。',
                          ),
                          style: const TextStyle(
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
                      Text(
                        tr('Nallam Farms', 'ナラム・ファーム'),
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFFC7A86B),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _FooterLink(
                        title: tr('Farm Fresh Vegetables', '新鮮な農園野菜'),
                        onTap: () => Navigator.pushNamed(context, '/'),
                      ),
                      _FooterLink(
                        title: tr('Agricultural Grains', '農産穀物'),
                        onTap: () => Navigator.pushNamed(context, '/'),
                      ),
                      _FooterLink(
                        title: tr('Natural Food Products', '自然食品'),
                        onTap: () => Navigator.pushNamed(context, '/'),
                      ),
                    ],
                  ),

                  // Links Col - Textiles
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('Nallam Textiles', 'ナラム・テキスタイル'),
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFFC7A86B),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _FooterLink(
                        title: tr('Table Linen', 'テーブルリネン'),
                        onTap: () => Navigator.pushNamed(context, '/catalog', arguments: 'Table Linen'),
                      ),
                      _FooterLink(
                        title: tr('Cushions', 'クッション'),
                        onTap: () => Navigator.pushNamed(context, '/catalog', arguments: 'Cushions'),
                      ),
                      _FooterLink(
                        title: tr('Upholstery Fabrics', 'インテリア生地'),
                        onTap: () => Navigator.pushNamed(context, '/catalog', arguments: 'Fabrics'),
                      ),
                    ],
                  ),

                  // Support Col
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('Contact & Support', '連絡先＆サポート'),
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFFC7A86B),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _FooterText(title: '${tr('Phone', '電話')}: +91 75 9191 9910'),
                      _FooterText(title: '${tr('Email', 'メール')}: info@nallamfarms.com'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Divider(color: Colors.white24),
              const SizedBox(height: 16),
              Text(
                tr(
                  '© 2026 NALLAM GROUP. All Rights Reserved. Crafted with Purity & Trust.',
                  '© 2026 NALLAM GROUP. All Rights Reserved. 純粋さと信頼を込めて。',
                ),
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Colors.white38,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
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
