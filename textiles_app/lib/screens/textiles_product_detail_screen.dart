import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/app_navbar.dart';
import '../widgets/app_footer.dart';
import '../widgets/product_card.dart';
import '../data/textile_products_data.dart';
import '../models/textile_product.dart';
import 'dart:html' as html if (dart.library.io) 'dart:io';
import '../l10n/locale_manager.dart';

class TextilesProductDetailScreen extends StatefulWidget {
  const TextilesProductDetailScreen({super.key});

  @override
  State<TextilesProductDetailScreen> createState() => _TextilesProductDetailScreenState();
}

class _TextilesProductDetailScreenState extends State<TextilesProductDetailScreen> {
  String? _productId;
  TextileProduct? _product;
  String _selectedFabric = 'Cotton Canvas';
  String _selectedFilling = 'Recycled PP Cotton';

  final List<String> _fabricOptions = [
    'Cotton Canvas',
    'PV Plush / Faux Fur',
    'Oxford (Waterproof)',
    'Corduroy',
    'Lambswool',
  ];

  final List<String> _fillingOptions = [
    'Recycled PP Cotton',
    'Memory Foam',
    'Shredded Sponge',
    'Cooling Gel Foam',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    final String targetId = (args is String && args.isNotEmpty) ? args : '';
    if (_productId != targetId) {
      setState(() {
        _productId = targetId;
        _product = textileProducts.firstWhere(
          (p) => p.id == _productId,
          orElse: () => textileProducts.first,
        );
        _selectedFabric = 'Cotton Canvas';
        _selectedFilling = 'Recycled PP Cotton';
      });
    }
  }

  String _getFabricTranslation(String fabric) {
    switch (fabric) {
      case 'Cotton Canvas': return tr('Cotton Canvas', 'コットンキャンバス');
      case 'PV Plush / Faux Fur': return tr('PV Plush / Faux Fur', 'フェイクファー');
      case 'Oxford (Waterproof)': return tr('Oxford (Waterproof)', 'オックスフォード (防水)');
      case 'Corduroy': return tr('Corduroy', 'コーデュロイ');
      case 'Lambswool': return tr('Lambswool', 'ラムズウール');
      default: return fabric;
    }
  }

  String _getFillingTranslation(String filling) {
    switch (filling) {
      case 'Recycled PP Cotton': return tr('Recycled PP Cotton', '再生PP綿');
      case 'Memory Foam': return tr('Memory Foam', 'メモリーフォーム');
      case 'Shredded Sponge': return tr('Shredded Sponge', 'チップウレタン');
      case 'Cooling Gel Foam': return tr('Cooling Gel Foam', '冷感ジェルフォーム');
      default: return filling;
    }
  }

  void _inquireOnWhatsApp(TextileProduct product) {
    String messageText = localeManager.isJapanese
        ? 'ナラム・テキスタイル様、商品「${product.localizedTitle}」(ID: ${product.id})について問い合わせいたします。'
        : 'Hi Nallam Textiles, I am interested in inquiring about your product: "${product.title}" (ID: ${product.id}).';
    if (product.category == 'Pet Linen') {
      messageText += localeManager.isJapanese
          ? ' 選択された生地: ${_getFabricTranslation(_selectedFabric)}、選択された中綿: ${_getFillingTranslation(_selectedFilling)}。'
          : ' Selected Fabric: $_selectedFabric, Selected Filling: $_selectedFilling.';
    }
    messageText += localeManager.isJapanese
        ? ' カタログ価格と卸売のリードタイムを教えてください。'
        : ' Please provide catalog prices and wholesale lead times.';
    
    final message = Uri.encodeComponent(messageText);
    final url = 'https://wa.me/917591919910?text=$message';
    if (kIsWeb) {
      html.window.open(url, '_blank');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_product == null) {
      return Scaffold(
        appBar: const AppNavbar(),
        body: Center(child: CircularProgressIndicator(color: const Color(0xFF1F3A2E))),
      );
    }

    final product = _product!;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    final relatedProducts = textileProducts.where(
      (p) => product.relatedProductIds.contains(p.id) && p.id != product.id,
    ).toList();

    return ValueListenableBuilder<String>(
      valueListenable: localeManager.languageNotifier,
      builder: (context, _, __) {
        return Scaffold(
          backgroundColor: const Color(0xFFFCFBF8),
          appBar: const AppNavbar(),
          endDrawer: isMobile ? Drawer(
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
                        'NALLAM',
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
                    title: tr('Home', 'ホーム'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                  _DrawerLink(
                    title: tr('Table Linen', 'テーブルリネン'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/catalog', arguments: 'Table Linen');
                    },
                  ),
                  _DrawerLink(
                    title: tr('Cushions', 'クッション'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/catalog', arguments: 'Cushions');
                    },
                  ),
                  _DrawerLink(
                    title: tr('Fabrics', 'ファブリック生地'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/catalog', arguments: 'Fabrics');
                    },
                  ),
                  _DrawerLink(
                    title: tr('Back to Farms Site', 'ファームサイトへ戻る'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/');
                    },
                    isAccent: true,
                  ),
                ],
              ),
            ),
          ) : null,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: const Color(0xFFF5F1E8),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, '/'),
                        child: Text(
                          tr('Home', 'ホーム'),
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF8A5A3B),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text('  /  ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, '/catalog'),
                        child: Text(
                          tr('Catalogue', 'カタログ'),
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF8A5A3B),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text('  /  ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, '/catalog', arguments: product.category),
                        child: Text(
                          product.localizedCategory,
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF8A5A3B),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text('  /  ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Expanded(
                        child: Text(
                          product.localizedTitle,
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF1F3A2E),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
                  child: width > 992
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 6,
                              child: _buildGallerySection(product),
                            ),
                            const SizedBox(width: 48),
                            Expanded(
                              flex: 5,
                              child: _buildProductOverview(product),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            _buildGallerySection(product),
                            const SizedBox(height: 36),
                            _buildProductOverview(product),
                          ],
                        ),
                ),

                if (relatedProducts.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(color: Color(0xFFE8E2D5)),
                        const SizedBox(height: 36),
                        Text(
                          tr('You may also like', 'おすすめ商品'),
                          style: const TextStyle(
                            fontFamily: 'Cormorant Garamond',
                            color: Color(0xFF1F3A2E),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isMobile ? 1 : 4,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 24,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: relatedProducts.length,
                          itemBuilder: (context, index) {
                            final relProduct = relatedProducts[index];
                            return ProductCard(
                              product: relProduct,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/product',
                                  arguments: relProduct.id,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 64),
                const AppFooter(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGallerySection(TextileProduct product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8E2D5)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 1.2,
              child: product.imageUrl.startsWith('http')
                  ? CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(color: Colors.white),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    )
                  : Image.asset(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
            ),
            if (product.discountPercentage > 0)
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F3A2E),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '-${product.discountPercentage.toInt()}%',
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFFC7A86B),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductOverview(TextileProduct product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.localizedCategory.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Color(0xFF8A5A3B),
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          product.localizedTitle,
          style: const TextStyle(
            fontFamily: 'Cormorant Garamond',
            color: Color(0xFF1F3A2E),
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/auth');
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F1E8),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE8E2D5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_outline, color: Color(0xFF8A5A3B), size: 16),
                const SizedBox(width: 8),
                Text(
                  tr('Login to see wholesale prices', 'ログインして卸売価格を表示'),
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color(0xFF8A5A3B),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          product.localizedDescription,
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Color(0xFF555555),
            fontSize: 15,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),

        if (product.category == 'Pet Linen') ...[
          _buildFabricSelector(),
          const SizedBox(height: 20),
          _buildFillingSelector(),
          const SizedBox(height: 20),
          _buildMaterialPreviewSection(),
          const SizedBox(height: 28),
        ],

        Text(
          tr('Key Highlights', '主な特長'),
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Color(0xFF1F3A2E),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...product.localizedKeyFeatures.map((feature) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(color: Color(0xFFC7A86B), fontSize: 16, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Text(
                    feature,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF555555),
                      fontSize: 13.5,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 32),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF25D366),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 4,
            ),
            icon: const Icon(Icons.chat_bubble_outline),
            label: Text(
              tr('INQUIRE VIA WHATSAPP', 'WHATSAPPでお問い合わせ'),
              style: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            onPressed: () => _inquireOnWhatsApp(product),
          ),
        ),
        const SizedBox(height: 36),
        _buildTabsSection(product),
      ],
    );
  }

  Widget _buildTabsSection(TextileProduct product) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            labelColor: const Color(0xFF1F3A2E),
            unselectedLabelColor: Colors.grey,
            indicatorColor: const Color(0xFFC7A86B),
            indicatorWeight: 3,
            labelStyle: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            tabs: [
              Tab(text: tr('Description', '商品説明')),
              Tab(text: tr('Specifications', '製品仕様')),
              Tab(text: tr('Care Instructions', '取扱説明')),
            ],
          ),
          Container(
            height: 300,
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Text(
                    product.localizedDescription,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF555555),
                      fontSize: 14,
                      height: 1.7,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Table(
                    columnWidths: const {
                      0: FixedColumnWidth(180),
                      1: FlexColumnWidth(),
                    },
                    border: TableBorder.all(
                      color: const Color(0xFFE8E2D5),
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    children: product.localizedSpecifications.entries.map((entry) {
                      return TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                entry.key,
                                style: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF1F3A2E),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                entry.value,
                                style: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF555555),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: product.localizedCareInstructions.map((instruction) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle_outline, color: Color(0xFFC7A86B), size: 16),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                instruction,
                                style: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF555555),
                                  fontSize: 13.5,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFabricSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('FABRIC OPTION', '生地オプション'),
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Color(0xFF1F3A2E),
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _fabricOptions.map((fabric) {
            final isSelected = _selectedFabric == fabric;
            return ChoiceChip(
              label: Text(
                _getFabricTranslation(fabric),
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: isSelected ? Colors.white : const Color(0xFF1F3A2E),
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              selectedColor: const Color(0xFF1F3A2E),
              backgroundColor: const Color(0xFFF5F1E8),
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedFabric = fabric;
                  });
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFillingSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('FILLING OPTION', '中綿オプション'),
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Color(0xFF1F3A2E),
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _fillingOptions.map((filling) {
            final isSelected = _selectedFilling == filling;
            return ChoiceChip(
              label: Text(
                _getFillingTranslation(filling),
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: isSelected ? Colors.white : const Color(0xFF1F3A2E),
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              selectedColor: const Color(0xFF1F3A2E),
              backgroundColor: const Color(0xFFF5F1E8),
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedFilling = filling;
                  });
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Map<String, String> get _fabricAssetMap => {
    'Cotton Canvas': 'assets/images/pet_fabric_canvas.png',
    'PV Plush / Faux Fur': 'assets/images/pet_fabric_plush.png',
    'Oxford (Waterproof)': 'assets/images/pet_fabric_oxford.png',
    'Corduroy': 'assets/images/pet_fabric_corduroy.png',
    'Lambswool': 'assets/images/pet_fabric_lambswool.png',
  };

  Map<String, String> get _fillingAssetMap => {
    'Recycled PP Cotton': 'assets/images/pet_fill_cotton.png',
    'Memory Foam': 'assets/images/pet_fill_foam.png',
    'Shredded Sponge': 'assets/images/pet_fill_sponge.png',
    'Cooling Gel Foam': 'assets/images/pet_fill_gel.png',
  };

  Map<String, String> get _fabricDescMap => {
    'Cotton Canvas': tr('Classic checkered, 100% pure yarn-dyed cotton canvas.', 'クラシックな格子柄、100%純先染めコットンキャンバス。'),
    'PV Plush / Faux Fur': tr('Ultra-soft fluffy pile designed for premium winter warmth.', '極細の柔らかい起毛で、冬でも暖かく快適な最高級の肌触り。'),
    'Oxford (Waterproof)': tr('Durable weave that is scratch, bite, and liquid resistant.', '引っ掻きや噛みつき、水分に強い高耐久の織り。'),
    'Corduroy': tr('Velvety straight ridges providing premium warmth and luxury feel.', 'ベロア調の畝（うね）が特徴の、暖かく贅沢な質感。'),
    'Lambswool': tr('Curly fleece texture offering natural thermal comfort.', '自然な温もりを提供する、カールしたフリース生地。'),
  };

  Map<String, String> get _fillingDescMap => {
    'Recycled PP Cotton': tr('Hypoallergenic eco-friendly polyester fiber filling.', '低刺激で環境に優しいポリエステル中綿。'),
    'Memory Foam': tr('Orthopedic contouring foam for optimal joint support.', '関節を優しくサポートする、体にフィットする低反発ウレタン。'),
    'Shredded Sponge': tr('High-density foam pieces providing resilient bounce and loft.', '弾力性とクッション性に優れた高密度チップウレタン。'),
    'Cooling Gel Foam': tr('Infused gel memory foam layer providing heat relief.', '熱を逃がすジェル配合の低反発フォーム。'),
  };

  Widget _buildMaterialPreviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('MATERIAL PREVIEW', '素材プレビュー'),
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Color(0xFF1F3A2E),
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE8E2D5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        _fabricAssetMap[_selectedFabric]!,
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getFabricTranslation(_selectedFabric),
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Color(0xFF1F3A2E),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _fabricDescMap[_selectedFabric]!,
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Color(0xFF777777),
                        fontSize: 11,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE8E2D5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        _fillingAssetMap[_selectedFilling]!,
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getFillingTranslation(_selectedFilling),
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Color(0xFF1F3A2E),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _fillingDescMap[_selectedFilling]!,
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Color(0xFF777777),
                        fontSize: 11,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
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
