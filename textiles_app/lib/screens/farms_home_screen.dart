import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:html' as html if (dart.library.io) 'dart:io';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import '../widgets/app_navbar.dart';
import '../widgets/app_footer.dart';
import '../l10n/locale_manager.dart';

class FarmsHomeScreen extends StatefulWidget {
  const FarmsHomeScreen({super.key});

  @override
  State<FarmsHomeScreen> createState() => _FarmsHomeScreenState();
}

class _FarmsHomeScreenState extends State<FarmsHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _productsKey = GlobalKey();
  bool _isFounderHovered = false;

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (args == 'about') {
            _scrollToKey(_aboutKey);
          } else if (args == 'contact') {
            _scrollToKey(_contactKey);
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: localeManager.languageNotifier,
      builder: (context, _, __) {
        return Scaffold(
          backgroundColor: const Color(0xFFFCFBF8),
          appBar: const AppNavbar(),
          endDrawer: Drawer(
            child: Container(
              color: const Color(0xFF1F3A2E),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'NALLAM GROUP',
                        style: TextStyle(
                          fontFamily: 'Cormorant Garamond',
                          color: Color(0xFFC7A86B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  _DrawerLink(
                    title: tr('Farms (Home)', 'ファーム (ホーム)'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                  _DrawerLink(
                    title: tr('Textiles Catalog', 'カタログ'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/catalog', arguments: 'All');
                    },
                  ),
                  _DrawerLink(
                    title: tr('About Us', '会社概要'),
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToKey(_aboutKey);
                    },
                  ),
                  _DrawerLink(
                    title: tr('Contact', 'お問い合わせ'),
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToKey(_contactKey);
                    },
                    isAccent: true,
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Hero Section
            _buildHeroSection(context),
            
            // Trust Strip
            _buildTrustStrip(context),

            // About Section
            _buildAboutSection(context),

            // Products Section
            _buildProductsSection(context),
            
            // Contact Section
            _buildContactSection(context),

            // Shared Footer
            const AppFooter(),
          ],
        ),
      ),
    );
      },
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Container(
      width: double.infinity,
      height: isMobile ? 500 : 700,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('web/farms/assets/hero_background.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black45,
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tr('Authentic & Naturally Grown', 'オーセンティック＆ナチュラル栽培'),
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Color(0xFFC7A86B),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0.0, curve: Curves.easeOut),
              const SizedBox(height: 16),
              Text(
                tr('Pure Farm Freshness,\nDelivered with Trust', '信頼と共にお届けする、\n純粋な農場の新鮮さ'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  color: Colors.white,
                  fontSize: isMobile ? 40 : 64,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 800.ms).slideY(begin: 0.15, end: 0.0, curve: Curves.easeOut),
              const SizedBox(height: 24),
              Text(
                tr('Premium naturally sourced agricultural and food products cultivated with care,\nauthenticity, and quality standards directly from our fields to your home.', '私たちの畑からあなたのご家庭へ直接、愛情、本物であること、品質基準をもって栽培されたプレミアムな自然由来の農産物および食品をお届けします。'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.5,
                ),
              ).animate().fadeIn(delay: 400.ms, duration: 800.ms).slideY(begin: 0.1, end: 0.0, curve: Curves.easeOut),
              const SizedBox(height: 48),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC7A86B),
                  foregroundColor: const Color(0xFF1F3A2E),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => _scrollToKey(_productsKey),
                child: Text(
                  tr('Explore Products', '商品を見る'),
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ).animate().fadeIn(delay: 600.ms, duration: 800.ms).scale(begin: const Offset(0.95, 0.95), curve: Curves.easeOut),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrustStrip(BuildContext context) {

    return Container(
      width: double.infinity,
      color: const Color(0xFF1F3A2E),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 48,
        runSpacing: 24,
        children: [
          _buildTrustItem(Icons.verified_outlined, tr('Quality Assured', '品質保証')),
          _buildTrustItem(Icons.eco_outlined, tr('Naturally Sourced', '自然由来')),
          _buildTrustItem(Icons.nature_people_outlined, tr('Farm Fresh', '農場直送')),
          _buildTrustItem(Icons.handshake_outlined, tr('Trusted Supplier', '信頼のサプライヤー')),
        ],
      ),
    );
  }

  Widget _buildTrustItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFFC7A86B), size: 28),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Container(
      key: _aboutKey,
      color: const Color(0xFFFCFBF8),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Founder Profile Column
              Expanded(
                flex: isMobile ? 0 : 4,
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isFounderHovered = true),
                  onExit: (_) => setState(() => _isFounderHovered = false),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE8E2D5), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: _isFounderHovered 
                              ? const Color(0x1A1F3A2E) 
                              : Colors.black.withOpacity(0.04),
                          blurRadius: _isFounderHovered ? 20 : 10,
                          offset: Offset(0, _isFounderHovered ? 8 : 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                          child: SizedBox(
                            height: isMobile ? 350 : 450,
                            child: AnimatedScale(
                              scale: _isFounderHovered ? 1.04 : 1.0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              child: Image.asset(
                                'web/farms/assets/nallam_founder.jpeg',
                                fit: BoxFit.cover,
                                height: isMobile ? 350 : 450,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: isMobile ? 350 : 450,
                                    color: const Color(0xFF1F3A2E),
                                    child: const Icon(Icons.person, color: Color(0xFFC7A86B), size: 100),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              Text(
                                tr('SRI NALLAM', 'スリ・ナラム'),
                                style: const TextStyle(
                                  fontFamily: 'Cormorant Garamond',
                                  color: Color(0xFF1F3A2E),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                tr('Founder, Nallam Group', 'ナラム・グループ創業者'),
                                style: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFFC7A86B),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const Gap(16),
                              const Divider(color: Color(0xFFE8E2D5)),
                              const Gap(16),
                              Text(
                                tr(
                                  '"Our mission is to bring the purity of nature into your home, whether through the organic food you eat or the premium textiles you live with. Trust is our foundation."',
                                  '"私たちの使命は、食べるオーガニック食品であれ、共に暮らすプレミアムなテキスタイルであれ、自然の純粋さをあなたのご家庭にお届けすることです。信頼こそが私たちの基盤です。"',
                                ),
                                style: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF555555),
                                  fontSize: 14,
                                  height: 1.5,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1, end: 0.0, curve: Curves.easeOut),
              ),
              
              SizedBox(width: isMobile ? 0 : 64, height: isMobile ? 48 : 0),
              
              // Information Column
              Expanded(
                flex: isMobile ? 0 : 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr('Our Heritage & Mission', '私たちの伝統と使命'),
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Color(0xFFC7A86B),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0.0),
                    const SizedBox(height: 12),
                    Text(
                      tr('Rooted in Tradition, Cultivated for Tomorrow', '伝統に根ざし、未来へ向けて耕す'),
                      style: const TextStyle(
                        fontFamily: 'Cormorant Garamond',
                        color: Color(0xFF1F3A2E),
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0.0),
                    const SizedBox(height: 24),
                    Text(
                      tr(
                        'Nallam Group was founded with a singular vision: to bridge the gap between traditional heritage and modern sustainable living. Combining our rich farming legacy with a state-of-the-art textile manufacturing process, we deliver absolute purity and craftsmanship under one roof.',
                        'ナラム・グループは、伝統的な遺産と現代の持続可能な暮らしの架け橋となるという唯一のビジョンを持って設立されました。豊かな農業の伝統と最先端のテキスタイル製造プロセスを組み合わせ、絶対的な純度と職人技を一つの屋根の下で提供しています。',
                      ),
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Color(0xFF555555),
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0.0),
                    const SizedBox(height: 36),
                    
                    // Pillar 1: What We Have
                    _buildPillarTile(
                      icon: Icons.eco_outlined,
                      title: tr('What We Have', '私たちが保有するもの'),
                      description: tr(
                        '100+ acres of certified organic farmlands in the foothills of Coimbatore, Tamil Nadu, and a fully integrated, state-of-the-art handloom and yarn-dyed home textile manufacturing unit.',
                        'タミル・ナードゥ州コインバトールの麓にある100エーカー以上の認証オーガニック農地、および完全に統合された最先端の手織り・先染めホームテキスタイル製造ユニット。',
                      ),
                    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0.0),
                    const SizedBox(height: 24),
                    
                    // Pillar 2: What We Have Done
                    _buildPillarTile(
                      icon: Icons.workspace_premium_outlined,
                      title: tr('What We Have Done', '実績'),
                      description: tr(
                        'Successfully harvested and distributed chemical-free heritage grains and vegetables to over 10,000 families, and manufactured premium yarn-dyed linens exported to discerning global markets.',
                        '1万世帯以上の家庭に無化学農薬の伝統的な穀物や野菜の収穫と流通を成功させ、厳しい世界市場に輸出されるプレミアムな先染めリネンを製造してきました。',
                      ),
                    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0.0),
                    const SizedBox(height: 24),
                    
                    // Pillar 3: Our Location
                    _buildPillarTile(
                      icon: Icons.location_on_outlined,
                      title: tr('Our Location', '所在地'),
                      description: tr(
                        'Coimbatore, Tamil Nadu, India\nMain Farm & Office Address: Nallam Farms Estate, Plot No. 42, Green Agro Valley, Near River Basin, Coimbatore - 641001 (Click to view map)',
                        'インド、タミル・ナードゥ州コインバトール\nメイン農場＆オフィス住所：Nallam Farms Estate, Plot No. 42, Green Agro Valley, Near River Basin, Coimbatore - 641001 (クリックして地図を表示)',
                      ),
                      onTap: () {
                        if (kIsWeb) {
                          html.window.open('https://maps.app.goo.gl/uSCEMsqrB6uq1hde7', '_blank');
                        }
                      },
                    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPillarTile({
    required IconData icon,
    required String title,
    required String description,
    VoidCallback? onTap,
  }) {
    Widget content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF1F3A2E).withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFFC7A86B), size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Cormorant Garamond',
                  color: Color(0xFF1F3A2E),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: const Color(0xFF555555),
                  fontSize: 14,
                  height: 1.5,
                  decoration: onTap != null ? TextDecoration.underline : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: content,
        ),
      );
    }

    return content;
  }

  Widget _buildProductsSection(BuildContext context) {

    return Container(
      key: _productsKey,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            tr('Premium Categories', 'プレミアム・カテゴリー'),
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: Color(0xFFC7A86B),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            tr('Naturally Sourced Offerings', '自然由来の提供品'),
            style: const TextStyle(
              fontFamily: 'Cormorant Garamond',
              color: Color(0xFF1F3A2E),
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _CategoryCard(
                title: tr('Organic Farm Products', 'オーガニック農産物'),
                description: tr(
                  'Fresh heirloom vegetables, crisp leafy greens, and handpicked organic fruits grown with certified organic fertilizers.',
                  '認証オーガニック肥料で栽培された、新鮮な伝統野菜、シャキシャキした葉物野菜、厳選されたオーガニック果物。',
                ),
                imagePath: 'web/farms/assets/category_organic.png',
                tag: tr('Premium', 'プレミアム'),
              ),
              _CategoryCard(
                title: tr('Agricultural Produce', '農産品'),
                description: tr(
                  'High-grade raw grains, ancient millets, golden wheat, and hand-selected legumes packed with nutritious wholeness.',
                  '栄養豊富な高品質の生穀物、古代の雑穀、黄金色の小麦、手作業で厳選されたマメ科植物。',
                ),
                imagePath: 'web/farms/assets/category_produce.png',
                tag: tr('Natural', 'ナチュラル'),
              ),
              _CategoryCard(
                title: tr('Natural Food Products', '自然食品'),
                description: tr(
                  'Artisanal small-batch raw wild honey, cold-pressed culinary oils, and sun-dried farm spices preserved without additives.',
                  '添加物不使用で保存された、手作りの小ロットの生野生ハチミツ、コールドプレス調理油、天日干しの農場スパイス。',
                ),
                imagePath: 'web/farms/assets/groundnut.png',
                tag: tr('Pure', 'ピュア'),
              ),
            ],
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1F3A2E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/catalog', arguments: 'All');
            },
            child: Text(
              tr('View Textiles Catalog', 'テキスタイルカタログを見る'),
              style: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Container(
      key: _contactKey,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: const Color(0xFFF5F1E8),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            tr('Reach Out to Us', 'お問い合わせ'),
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: Color(0xFFC7A86B),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            tr('Let\'s Connect for Purity & Freshness', '純粋さと新鮮さのために繋がりましょう'),
            style: const TextStyle(
              fontFamily: 'Cormorant Garamond',
              color: Color(0xFF1F3A2E),
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            tr(
              'Have a question about our retail subscriptions or commercial crop wholesale options?\nContact us today.',
              '個人向けサブスクリプションや商業用作物の卸売オプションについてご質問はありますか？今すぐお問い合わせください。',
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: Color(0xFF555555),
              fontSize: 16,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 48),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF25D366),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            icon: const Icon(Icons.chat_bubble_outline),
            label: Text(
              tr('WhatsApp Inquiry', 'WhatsAppでお問い合わせ'),
              style: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;
  final String tag;

  const _CategoryCard({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.tag,
  });

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 340,
        decoration: BoxDecoration(
          color: const Color(0xFFFCFBF8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? const Color(0xFFC7A86B) : const Color(0xFFE8E2D5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered ? const Color(0x1A1F3A2E) : Colors.black.withOpacity(0.02),
              blurRadius: _isHovered ? 20 : 8,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: AnimatedScale(
                  scale: _isHovered ? 1.05 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC7A86B),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.tag,
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontFamily: 'Cormorant Garamond',
                      color: Color(0xFF1F3A2E),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF555555),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isAccent;

  const _DrawerLink({
    required this.title,
    required this.onTap,
    this.isAccent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: isAccent ? const Color(0xFFC7A86B) : Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
