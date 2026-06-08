import 'package:flutter/material.dart';
import '../widgets/app_navbar.dart';
import '../widgets/app_footer.dart';
import '../widgets/product_card.dart';
import '../data/textile_products_data.dart';
import '../models/textile_product.dart';
import '../l10n/locale_manager.dart';

class TextilesCatalogScreen extends StatefulWidget {
  const TextilesCatalogScreen({super.key});

  @override
  State<TextilesCatalogScreen> createState() => _TextilesCatalogScreenState();
}

class _TextilesCatalogScreenState extends State<TextilesCatalogScreen> {
  String _searchQuery = '';
  String? _selectedCategory;
  String _sortBy = 'default';
  bool _isInitialized = false;

  final List<String> _categories = [
    'All Products',
    'Table Linen',
    'Cushions',
    'Fabrics',
    'Kitchen Linen',
    'Curtains',
    'Pet Linen',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is String && args.isNotEmpty) {
        if (args.toLowerCase() == 'all') {
          _selectedCategory = null;
        } else {
          _selectedCategory = args;
        }
      }
      _isInitialized = true;
    }
  }

  String _getCategoryTranslation(String cat) {
    switch (cat) {
      case 'All Products': return tr('All Products', 'すべての商品');
      case 'Table Linen': return tr('Table Linen', 'テーブルリネン');
      case 'Cushions': return tr('Cushions', 'クッション');
      case 'Fabrics': return tr('Fabrics', 'ファブリック生地');
      case 'Kitchen Linen': return tr('Kitchen Linen', 'キッチンリネン');
      case 'Curtains': return tr('Curtains', 'カーテン');
      case 'Pet Linen': return tr('Pet Linen', 'ペット用リネン');
      default: return cat;
    }
  }

  List<TextileProduct> _getFilteredProducts() {
    List<TextileProduct> products = List.from(textileProducts);

    // Apply category filter
    if (_selectedCategory != null && _selectedCategory != 'All Products') {
      products = products.where((p) => p.category.toLowerCase() == _selectedCategory!.toLowerCase()).toList();
    }

    // Apply search query filter
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      products = products.where((p) {
        return p.title.toLowerCase().contains(query) ||
               p.description.toLowerCase().contains(query) ||
               p.category.toLowerCase().contains(query);
      }).toList();
    }

    // Apply sorting
    if (_sortBy == 'title-asc') {
      products.sort((a, b) => a.title.compareTo(b.title));
    } else if (_sortBy == 'title-desc') {
      products.sort((a, b) => b.title.compareTo(a.title));
    } else if (_sortBy == 'discount-desc') {
      products.sort((a, b) => b.discountPercentage.compareTo(a.discountPercentage));
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final filteredProducts = _getFilteredProducts();

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
                        'NALLAM TEXTILES',
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
                      setState(() {
                        _selectedCategory = 'Table Linen';
                      });
                    },
                  ),
                  _DrawerLink(
                    title: tr('Cushions', 'クッション'),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _selectedCategory = 'Cushions';
                      });
                    },
                  ),
                  _DrawerLink(
                    title: tr('Fabrics', 'ファブリック生地'),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _selectedCategory = 'Fabrics';
                      });
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
              children: [
                // Page Title Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                  color: const Color(0xFF1F3A2E),
                  child: Column(
                    children: [
                      Text(
                        tr('TEXTILE CATALOGUE', 'テキスタイルカタログ'),
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFFC7A86B),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        tr('Our Organic Collections', 'オーガニックコレクション'),
                        style: const TextStyle(
                          fontFamily: 'Cormorant Garamond',
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Catalog Layout
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
                  child: width > 992 
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Sidebar Filters
                          SizedBox(
                            width: 250,
                            child: _buildSidebar(),
                          ),
                          const SizedBox(width: 48),
                          // Main Content Area
                          Expanded(
                            child: _buildCatalogContent(filteredProducts, false),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          // Category Filter horizontal bar for mobile/tablet
                          _buildMobileCategoryPills(),
                          const SizedBox(height: 24),
                          _buildCatalogContent(filteredProducts, true),
                        ],
                      ),
                ),

                // Footer
                const AppFooter(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSidebar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('CATEGORIES', 'カテゴリー'),
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Color(0xFF1F3A2E),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 16),
        ..._categories.map((category) {
          final isSelected = (_selectedCategory == null && category == 'All Products') || 
                             (_selectedCategory == category);
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedCategory = category == 'All Products' ? null : category;
                });
              },
              borderRadius: BorderRadius.circular(6),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1F3A2E).withOpacity(0.08) : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border(
                    left: BorderSide(
                      color: isSelected ? const Color(0xFFC7A86B) : Colors.transparent,
                      width: 4,
                    ),
                  ),
                ),
                child: Text(
                  _getCategoryTranslation(category),
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: isSelected ? const Color(0xFF1F3A2E) : const Color(0xFF555555),
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 32),
        const Divider(color: Color(0xFFE8E2D5)),
        const SizedBox(height: 24),
        const Text(
          'QUALITY PROMISE',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Color(0xFF1F3A2E),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Nallam Textiles guarantees 100% premium woven cotton without chemical processing dyes. Premium quality manufactured in sustainable environments.',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Color(0xFF555555),
            fontSize: 12,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileCategoryPills() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = (_selectedCategory == null && category == 'All Products') || 
                             (_selectedCategory == category);
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(
                _getCategoryTranslation(category),
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: isSelected ? Colors.white : const Color(0xFF1F3A2E),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              selectedColor: const Color(0xFF1F3A2E),
              backgroundColor: const Color(0xFFF5F1E8),
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category == 'All Products' ? null : category;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildCatalogContent(List<TextileProduct> products, bool isMobile) {
    return Column(
      children: [
        // Controls Row: Search & Sort
        Row(
          children: [
            // Search Input
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color(0xFFE8E2D5)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: tr('Search products...', '商品を検索...'),
                    hintStyle: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    icon: const Icon(Icons.search, color: Color(0xFF1F3A2E)),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Sorting Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xFFE8E2D5)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _sortBy,
                  icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF1F3A2E)),
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color(0xFF1F3A2E),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _sortBy = newValue;
                      });
                    }
                  },
                  items: [
                    DropdownMenuItem(value: 'default', child: Text(tr('Sort by: Default', '並び替え: デフォルト'))),
                    DropdownMenuItem(value: 'title-asc', child: Text(tr('Alphabetical A-Z', '名前順 A-Z'))),
                    DropdownMenuItem(value: 'title-desc', child: Text(tr('Alphabetical Z-A', '名前順 Z-A'))),
                    DropdownMenuItem(value: 'discount-desc', child: Text(tr('Highest Discount', '割引率の高い順'))),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),

        // Grid Content
        products.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 64.0),
                child: Column(
                  children: [
                    const Icon(Icons.search_off, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      tr('No products found matching your criteria.', '該当する商品が見つかりませんでした。'),
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Color(0xFF555555),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _searchQuery = '';
                          _selectedCategory = null;
                          _sortBy = 'default';
                        });
                      },
                      child: Text(tr('Reset Filters', 'フィルターをリセット')),
                    ),
                  ],
                ),
              ),
            )
          : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 1 : 3,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 0.72,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/product',
                      arguments: product.id,
                    );
                  },
                );
              },
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
