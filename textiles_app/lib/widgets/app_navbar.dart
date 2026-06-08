import 'package:flutter/material.dart';
import '../l10n/locale_manager.dart';

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    final route = ModalRoute.of(context);
    final currentRouteName = route?.settings.name ?? '/';
    final currentArguments = route?.settings.arguments;

    // Active state checks
    final isHomeActive = currentRouteName == '/' && currentArguments != 'about' && currentArguments != 'contact';
    final isCatalogActive = currentRouteName.startsWith('/catalog') || currentRouteName.startsWith('/product');
    final isAboutActive = currentArguments == 'about';
    final isContactActive = currentArguments == 'contact';

    return ValueListenableBuilder<String>(
      valueListenable: localeManager.languageNotifier,
      builder: (context, currentLang, _) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1F3A2E), // Deep Forest Green
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFC7A86B), // Muted Gold
                width: 1.5,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: Row(
                    children: [
                      const Text(
                        'NALLAM ',
                        style: TextStyle(
                          fontFamily: 'Cormorant Garamond',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC7A86B), // Muted Gold
                          letterSpacing: 1.5,
                        ),
                      ),
                      Text(
                        tr('TEXTILES', 'テキスタイル'),
                        style: const TextStyle(
                          fontFamily: 'Cormorant Garamond',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Navigation Links
                if (!isMobile)
                  Row(
                    children: [
                      _NavBarLink(
                        title: tr('Home', 'ホーム'),
                        onTap: () => Navigator.pushNamed(context, '/'),
                        isActive: isHomeActive,
                      ),
                      const SizedBox(width: 24),
                      _NavBarLink(
                        title: tr('Textile Catalog', 'カタログ'),
                        onTap: () => Navigator.pushNamed(context, '/catalog', arguments: 'All'),
                        isActive: isCatalogActive,
                      ),
                      const SizedBox(width: 24),
                      _NavBarLink(
                        title: tr('About Us', '会社概要'),
                        onTap: () => Navigator.pushNamed(context, '/', arguments: 'about'),
                        isActive: isAboutActive,
                      ),
                      const SizedBox(width: 24),
                      _NavBarLink(
                        title: tr('Contact', 'お問い合わせ'),
                        onTap: () => Navigator.pushNamed(context, '/', arguments: 'contact'),
                        isActive: isContactActive,
                      ),
                      const SizedBox(width: 32),
                      // Language Switcher
                      TextButton(
                        onPressed: () {
                          localeManager.setLanguage(currentLang == 'en' ? 'ja' : 'en');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFFC7A86B),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          side: const BorderSide(color: Color(0xFFC7A86B), width: 1.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Text(
                          currentLang == 'en' ? '日本語' : 'English',
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      // Language Switcher (Mobile)
                      TextButton(
                        onPressed: () {
                          localeManager.setLanguage(currentLang == 'en' ? 'ja' : 'en');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFFC7A86B),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          side: const BorderSide(color: Color(0xFFC7A86B), width: 1.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(
                          currentLang == 'en' ? '日本語' : 'English',
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NavBarLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isActive;

  const _NavBarLink({
    required this.title,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
            color: isActive ? const Color(0xFFC7A86B) : Colors.white70,
          ),
          child: Text(title),
        ),
      ),
    );
  }
}
