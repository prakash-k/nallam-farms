import '../models/textile_product.dart';

final List<TextileProduct> textileProducts = [
  TextileProduct(
    id: 'aqua-blue-placemat',
    title: 'Aqua Blue Dotted with Bordered Yarn-Dyed Cotton Ribbed Placemat',
    category: 'Table Linen',
    imageUrl: 'assets/images/aqua_blue_placemat.png',
    description: 'Nallam Textiles presents the Aqua Blue Dotted with Bordered Pure Cotton Ribbed Placemat. Designed with a stylish ribbed texture and measuring 33 x 45 cm, it is meticulously crafted from 100% cotton for premium softness and long-lasting durability. It adds a sophisticated, elegant touch to any dining table, blending seamlessly with both modern and traditional decor.',
    discountPercentage: 83,
    keyFeatures: [
      'Pure Cotton: Made from 100% high-quality, breathable cotton for a soft, natural feel and durability.',
      'Elegant Design: Features a stylish Ribbed pattern that adds a sophisticated touch.',
      'Customizable Options: Choose your preferred size, color, or design to fit your exact branding needs.'
    ],
    specifications: {
      'Material': '100% Yarn-Dyed Pure Cotton',
      'Size': '33 x 45 cm (Custom sizes available)',
      'Weave Pattern': 'Ribbed Dotted with Border',
      'Thread Count': 'Premium heavy weight GSM',
      'Manufacturer': 'NALLAM TEXTILES',
      'Origin': 'India'
    },
    careInstructions: [
      'Machine wash separately in cold water on gentle cycle.',
      'Use mild detergent. Do not bleach.',
      'Tumble dry low or line dry in shade.',
      'Medium iron if required. Do not dry clean (may cause shrinkage).'
    ],
    relatedProductIds: ['lime-green-placemat', 'coastal-sands-placemat', 'cushion-cover'],
  ),
  TextileProduct(
    id: 'lime-green-placemat',
    title: 'Lime Green Dotted with Bordered Yarn-Dyed Cotton Ribbed Placemat',
    category: 'Table Linen',
    imageUrl: 'assets/images/lime_green_placemat.png',
    description: 'Bright and refreshing, the Lime Green Dotted pure cotton ribbed placemat brings organic color and vibrant energy to your dining tables. Handcrafted in India from 100% premium cotton threads, it features an elegant bordering trim and ribbed texture.',
    discountPercentage: 90,
    keyFeatures: [
      '100% Pure Woven Cotton',
      'Eco-Friendly non-toxic herbal dyes',
      'Durable ribbed weaving protects wood surfaces',
      'Ideal for spring and summer indoor/outdoor dining'
    ],
    specifications: {
      'Material': '100% Woven Cotton',
      'Size': '33 x 45 cm',
      'Color Dye': 'Certified non-toxic Lime Green',
      'Texture': 'Yarn-Dyed Ribbed with Borders',
      'Manufacturer': 'NALLAM TEXTILES'
    },
    careInstructions: [
      'Gentle machine wash cold.',
      'Wash with similar colors to preserve green brightness.',
      'Do not bleach. Warm iron on reverse side.'
    ],
    relatedProductIds: ['aqua-blue-placemat', 'coastal-sands-placemat'],
  ),
  TextileProduct(
    id: 'coastal-sands-placemat',
    title: 'Coastal Sands Striped Yarn-Dyed Cotton Ribbed Placemat',
    category: 'Table Linen',
    imageUrl: 'assets/images/coastal_sands_placemat.png',
    description: 'Inspired by beachside coastal sands, this striped yarn-dyed pure cotton ribbed placemat blends warm beige, off-white, and neutral grey tones. Crafted from thick, double-ply cotton yarns for high thermal resistance.',
    discountPercentage: 25,
    keyFeatures: [
      'Neutral earth-toned stripes blend with any table setting',
      'Thick double-ply cotton yarn construction',
      'Heat resistant - protects table from hot plates',
      'Preshrunk fabric construction'
    ],
    specifications: {
      'Material': '100% Preshrunk Cotton',
      'Size': '33 x 45 cm',
      'Design': 'Coastal Sandy Stripe',
      'Thickness': 'Heavy Duty 320 GSM',
      'Manufacturer': 'NALLAM TEXTILES'
    },
    careInstructions: [
      'Cold wash inside a wash bag.',
      'Dry flat in shade. Do not tumble dry to minimize any shrinkage.',
      'Steam iron for crisp restaurant-style finish.'
    ],
    relatedProductIds: ['aqua-blue-placemat', 'lime-green-placemat'],
  ),
  TextileProduct(
    id: 'upholstery-fabric',
    title: 'Barnyard Striped Yarn-Dyed Pure Cotton Upholstery Fabric',
    category: 'Fabrics',
    imageUrl: 'assets/images/upholstery_fabric.png',
    description: 'A heavy-duty, premium cotton upholstery fabric boasting a classic barnyard stripe pattern. Soft to the touch yet extremely durable, it is perfect for reupholstering furniture, sofas, dining chairs, headboards, and crafting premium drapery.',
    discountPercentage: 68,
    keyFeatures: [
      'Industrial strength: Heavy weave suitable for high-use furniture.',
      'Breathable fibers: Pure cotton fibers stay cool in summer and warm in winter.',
      'Yarn-dyed: Stripes are woven directly into the fabric (not printed) for long-lasting color.'
    ],
    specifications: {
      'Material': '100% Pure Cotton',
      'Width': '54 inches (137 cm)',
      'Weight': '350 GSM (Heavyweight Upholstery)',
      'Dye Method': 'Yarn-Dyed before weaving',
      'Abrasion Resistance': 'High Rub-test certified'
    },
    careInstructions: [
      'Spot clean with water-free solvent or professional dry clean only.',
      'Vacuum regularly with soft brush attachment to remove dust.',
      'Keep away from direct sunlight to prevent fiber fading.'
    ],
    relatedProductIds: ['cushion-cover', 'curtain'],
  ),
  TextileProduct(
    id: 'cushion-cover',
    title: 'Off White / Green Striped Yarn-Dyed Cotton Cushion Cover',
    category: 'Cushions',
    imageUrl: 'assets/images/cushion_cover.png',
    description: 'Add comfort and a clean organic look to your living space with our Off-White and Forest Green striped cotton cushion covers. Features a premium hidden brass zipper closure and thick overlocked interior seams.',
    discountPercentage: 75,
    keyFeatures: [
      'Invisible side zipper closure for a clean, sleek appearance.',
      'Double-stitched stress points prevent tearing.',
      'Classic matching piping details along all edges.'
    ],
    specifications: {
      'Material': '100% Woven Cotton Canvas',
      'Size': '45 x 45 cm (Standard throw size)',
      'Closure': 'YKK Hidden Zipper',
      'Insert': 'Cover only (Insert not included)',
      'Manufacturer': 'NALLAM TEXTILES'
    },
    careInstructions: [
      'Wash inside out in cold water on gentle cycle.',
      'Close zippers before washing.',
      'Tumble dry low. Cool iron on reverse.'
    ],
    relatedProductIds: ['upholstery-fabric', 'pet-bed'],
  ),
  TextileProduct(
    id: 'apron',
    title: 'Organic Pure Cotton Woven Kitchen Apron with Pockets',
    category: 'Kitchen Linen',
    imageUrl: 'assets/images/apron.png',
    description: 'Designed for passionate home cooks and professional chefs, this premium Nallam textiles kitchen apron is woven from thick, stain-resistant organic cotton. Features adjustable neck straps, long waist ties, and spacious double front pockets.',
    discountPercentage: 50,
    keyFeatures: [
      'Thick woven cotton shield protects clothing from splatters and heat.',
      'Spacious double front pockets for kitchen tools and recipe notes.',
      'Reinforced rivet stitching at all pockets and strap attachments.'
    ],
    specifications: {
      'Material': '100% Organic Cotton Canvas',
      'Dimensions': '85 cm height x 70 cm width (Universal fit)',
      'Strap Style': 'Adjustable Neck Buckle & Waist Ties',
      'Pockets': '2 Front Utility Pockets',
      'Manufacturer': 'NALLAM TEXTILES'
    },
    careInstructions: [
      'Machine wash warm with like colors.',
      'Pre-treat oil stains before washing.',
      'Tumble dry medium. High iron if needed.'
    ],
    relatedProductIds: ['aqua-blue-placemat', 'upholstery-fabric'],
  ),
  TextileProduct(
    id: 'curtain',
    title: 'Solid Color Pencil Pleated Woven Curtains (Pair)',
    category: 'Curtains',
    imageUrl: 'assets/images/curtain.png',
    description: 'Drape your windows in luxury with our solid color pencil pleated cotton curtains. Woven from rich, light-filtering cotton fibers that provide excellent privacy while diffusing natural light beautifully.',
    discountPercentage: 70,
    keyFeatures: [
      'Pencil Pleat header allows adjustable fullness and custom hooks.',
      'Heavy drape provides natural insulation against cold drafts and warm heat.',
      'Generous 3-inch bottom hem for a clean, weighted fall.'
    ],
    specifications: {
      'Material': '100% Woven Cotton Slub',
      'Header Type': 'Pencil Pleat Tape',
      'Size': '140 cm width x 220 cm height per panel',
      'Pack Contents': '2 Curtain Panels (Hooks and rods not included)',
      'Light Filtration': 'Semi-Opaque (Light-filtering)'
    },
    careInstructions: [
      'Dry clean recommended to preserve pleat tape integrity.',
      'If machine washing, use cold water, gentle cycle, and laundry bag.',
      'Hang to dry immediately. Steam iron on low while hanging.'
    ],
    relatedProductIds: ['upholstery-fabric', 'cushion-cover'],
  ),
  TextileProduct(
    id: 'pet-bed',
    title: 'Navy Blue / Off White Checkered Pure Cotton Pet Bed',
    category: 'Pet Linen',
    imageUrl: 'assets/images/pet_bed.png',
    description: 'Give your furry friends the ultimate luxury sleep. Our premium pet bed features a removable, machine-washable outer cover crafted from 100% heavy cotton canvas, stuffed with hypoallergenic eco-fill.',
    discountPercentage: 60,
    keyFeatures: [
      'Durable bite-resistant and scratch-resistant heavy cotton cover.',
      'Removable zippered cover makes cleaning fast and easy.',
      'Stuffed with high-loft recycled polyester fibers for support.'
    ],
    specifications: {
      'Cover Material': '100% Heavy Cotton Canvas',
      'Fill Material': 'Hypoallergenic Recycled Eco-Polyester Fill',
      'Size': '75 x 55 x 15 cm (Suitable for small to medium pets)',
      'Pattern': 'Classic Checkered Navy / Off White',
      'Manufacturer': 'NALLAM TEXTILES'
    },
    careInstructions: [
      'Remove outer cover and machine wash cover on cold.',
      'Tumble dry cover on low heat or line dry.',
      'Inner cushion insert should be hand washed and air dried only.'
    ],
    relatedProductIds: ['pet-mat', 'snuffle-mat', 'rattan-canopy-bed', 'cat-cooling-bed'],
  ),
  TextileProduct(
    id: 'pet-mat',
    title: 'Blue / Off White Checkered Pure Cotton Pet Mat',
    category: 'Pet Linen',
    imageUrl: 'assets/images/pet_mat.png',
    description: 'A premium-grade, breathable, and highly durable 100% pure cotton pet mat featuring a classic blue and off-white checkered grid. Perfect for crates, carriers, or as a standalone cooling floor mat for dogs and cats.',
    discountPercentage: 55,
    keyFeatures: [
      '100% Pure Premium Cotton for a soft, breathable surface.',
      'Reversible design with durable dual-stitch borders.',
      'Protects flooring and keeps pet hair off carpets/upholstery.'
    ],
    specifications: {
      'Material': '100% Yarn-Dyed Cotton',
      'Size': '60 x 90 cm (Ideal for medium-sized dogs)',
      'Pattern': 'Checkered Blue / Off White',
      'Washable': 'Fully Machine Washable',
      'Origin': 'India'
    },
    careInstructions: [
      'Machine wash cold on gentle cycle.',
      'Line dry or tumble dry low. Do not bleach.'
    ],
    relatedProductIds: ['pet-bed', 'snuffle-mat', 'rattan-canopy-bed', 'cat-cooling-bed'],
  ),
  TextileProduct(
    id: 'snuffle-mat',
    title: 'Play & Forage Multicolored Cotton Snuffle Dog Mat',
    category: 'Pet Linen',
    imageUrl: 'assets/images/snuffle_mat.png',
    description: 'An interactive dog snuffle mat crafted from soft, thick cotton felt fabric folds and loops. Specially designed to stimulate your dog\'s natural foraging instincts, slow down feeding, and reduce anxiety.',
    discountPercentage: 40,
    keyFeatures: [
      'Dense fabric layers conceal treats and kibble effectively.',
      'Anti-slip backing keeps the mat in place during playtime.',
      'Eco-friendly, durable, and fully machine-washable cotton construction.'
    ],
    specifications: {
      'Material': '100% Cotton Felt & Anti-slip backing',
      'Size': '50 x 50 cm',
      'Color Style': 'Multicolor (Forest Green, Mustard, Clay Red)',
      'Utility': 'Mental stimulation and slow feeding',
      'Manufacturer': 'NALLAM TEXTILES'
    },
    careInstructions: [
      'Machine wash cold weekly on delicate cycle.',
      'Air dry flat. Do not tumble dry to prevent loop distortion.'
    ],
    relatedProductIds: ['pet-bed', 'pet-mat', 'rattan-canopy-bed', 'cat-cooling-bed'],
  ),
  TextileProduct(
    id: 'rattan-canopy-bed',
    title: 'Dog Canopy Bed Foldable Rattan Multifunctional Dog Sofa Bed',
    category: 'Pet Linen',
    imageUrl: 'assets/images/pet_canopy_bed.png',
    description: 'Nallam Textiles presents the Dog Canopy Bed Foldable Rattan Multifunctional Dog Sofa Bed. Meticulously hand-woven from high-grade artificial PE rattan and supported by a solid steel frame, it is paired with a foldable weather-resistant polyester canopy to shield your pets from sun and light rain. Inside is a plush, thick, customizable cushion, offering the ultimate indoor/outdoor cooling sofa lounge experience.',
    discountPercentage: 45,
    keyFeatures: [
      'PE Rattan Frame: Hand-woven artificial PE rattan is durable, water-resistant, bite-proof, and easy to clean.',
      'Foldable Canopy: Smart foldable weather-resistant polyester canopy provides customizable sunshade and wind shelter.',
      'Elevated Base Design: Elevated structure promotes optimal 360-degree airflow to keep your dog cool and dry.',
      'Multifunctional Comfort: Serves as a luxury outdoor patio bed, indoor sofa, or cozy shaded hideaway.'
    ],
    specifications: {
      'Material': 'Artificial PE Rattan & Steel Frame',
      'Canopy Fabric': 'Premium Weather-Resistant Polyester',
      'Cushion Material': 'Customizable Fabric & Filling Options',
      'Size': '99 x 99 x 78 cm (Custom sizes available)',
      'Model': 'YF122252',
      'Color': 'Beige Rattan / Brown Canopy',
      'Manufacturer': 'NALLAM TEXTILES'
    },
    careInstructions: [
      'Wipe rattan frame with a damp cloth or rinse with garden hose.',
      'Unzip cushion cover and machine wash cover in cold water on gentle cycle.',
      'Spot clean canopy fabric with mild soap and water.',
      'Store cushion indoors during heavy rain or extreme winter weather.'
    ],
    relatedProductIds: ['pet-bed', 'pet-mat', 'snuffle-mat', 'cat-cooling-bed'],
    titleJa: 'ペット用キャノピーベッド 折りたたみ式ラタン 多機能ドッグソファベッド',
    categoryJa: 'ペット用リネン',
    descriptionJa: 'ナラム・テキスタイルがお届けする、折りたたみ式ラタン多機能ペット用キャノピーベッド。高級人工PEラタンを手編みし、頑丈なスチールフレームで支えた、耐久性、耐水性、噛み防止機能に優れた犬用ベッドです。折りたたみ可能な耐候性ポリエステル製キャノピーが、日差しや小雨からペットを守ります。中には厚手でふわふわのクッション（カスタム可能）が付属し、屋内外での最高級のくつろぎスペースを提供します。',
    keyFeaturesJa: [
      'PEラタンフレーム: 手編みの人工PEラタンは耐久性、耐水性、噛み防止に優れ、お手入れも簡単です。',
      '折りたたみ式キャノピー: スマートな折りたたみ式の耐候性ポリエステル製キャノピーが、日よけや風よけを調整できます。',
      '高床式デザイン: 地面から浮かせた構造により、360度最適な通気性を確保し、ペットを涼しくドライに保ちます。',
      '多機能な快適さ: 高級屋外パティオベッド、屋内ソファ、または居心地の良い日陰の隠れ家として活躍します。'
    ],
    specificationsJa: {
      '素材': '人工PEラタン＆スチールフレーム',
      'キャノピー生地': 'プレミアム耐候性ポリエステル',
      'クッション素材': 'カスタマイズ可能な生地と中綿のオプション',
      'サイズ': '99 x 99 x 78 cm (カスタムサイズ対応可)',
      'モデル': 'YF122252',
      'カラー': 'beige/brown',
      '製造元': 'NALLAM TEXTILES'
    },
    careInstructionsJa: [
      'ラタンフレームは湿らせた布で拭くか、園芸用ホースで洗い流してください。',
      'クッションカバーのジッパーを開け、冷水・弱水流で洗濯機洗いしてください。',
      'キャノピー生地はマイルドな石鹸と水でスポットクリーニングしてください。',
      '大雨や厳冬期には、クッションを屋内に保管してください。'
    ],
  ),
  TextileProduct(
    id: 'cat-cooling-bed',
    title: 'Ultimate Cooling Gel Nest Cat Bed',
    category: 'Pet Linen',
    imageUrl: 'assets/images/cat_cooling_bed.png',
    description: 'Provide your cat or small dog with the ultimate summer comfort. Featuring an evolutionary instant-cooling gel-infused mesh sleeping surface and a supportive high-density foam bumper rim, wrapped in a bite-resistant printed Oxford exterior. Keep your pets cool and comfortable during hot seasons.',
    discountPercentage: 50,
    keyFeatures: [
      'Instant Cooling Tech: Features advanced heat-diffusing cooling fibers that lower body temperature instantly.',
      'Orthopedic Bumper Rim: Raised bolster edges provide excellent neck and head support for nesting cats.',
      'Durable Oxford Shell: Scratch-resistant and bite-resistant heavy duty Oxford fabric outer shell.',
      'Anti-Slip Bottom: Rubberized grip backing keeps the bed securely in place on tile or hardwood floors.'
    ],
    specifications: {
      'Material': 'Cool-Feeling Mesh & Printed Oxford Fabric',
      'Fill Material': 'High-Density Comfort Foam & Recycled PP Cotton',
      'Size': '55 x 45 x 18 cm (Ideal for cats and small dogs)',
      'Color': 'Cool Blue / Deep Navy Border',
      'Manufacturer': 'NALLAM TEXTILES (MARU LIVING Collaboration)'
    },
    careInstructions: [
      'Wipe clean with a damp cloth or soft brush.',
      'Hand wash with cold water and mild detergent if necessary.',
      'Air dry in shade. Do not tumble dry, bleach, or iron.'
    ],
    relatedProductIds: ['pet-bed', 'pet-mat', 'snuffle-mat', 'rattan-canopy-bed'],
    titleJa: '進化冷感スクエアペットベッド 丸リビング究極ひんやりネスト',
    categoryJa: 'ペット用リネン',
    descriptionJa: '愛猫や小型犬に究極の夏の快適さを。瞬間冷却ジェルを配合した進化系冷感メッシュの寝床面と、サポート力の高い高密度ウレタンの縁取り（バンパー）を採用。外側は耐久性・噛み防止に優れたプリントオックスフォード生地で仕上げました。暑い季節でもペットを涼しく快適に保ちます。',
    keyFeaturesJa: [
      '瞬間接触冷感: 体温を素早く拡散させる高度な冷感繊維を使用し、触れた瞬間にひんやり心地よい冷感を提供します。',
      'エルゴノミクス・バンパー: 高反発ウレタンの縁取りが、あご乗せしやすく、愛猫の頭部や首元を優しくサポートします。',
      '高耐久オックスフォード: 爪研ぎや噛みつきに強い、厚手で丈夫なオックスフォード生地を外周部に使用。',
      '滑り止め底面: 底面には滑り止め加工のラバーグリップを採用し、フローリングの上でもズレを防ぎます。'
    ],
    specificationsJa: {
      '素材': '冷感メッシュ生地＆プリントオックスフォード',
      '中綿素材': '高密度快適ウレタン＆再生PPコットン',
      'サイズ': '55 x 45 x 18 cm (猫・小型犬用)',
      'カラー': 'クールブルー / ディープネイビー',
      '製造元': 'NALLAM TEXTILES (MARU LIVING 共同開発)'
    },
    careInstructionsJa: [
      '日常のお手入れは、濡らした布で拭き取るか柔らかいブラシを使用してください。',
      '必要に応じて、中性洗剤を使用し、冷水で手洗いしてください。',
      '陰干しで自然乾燥させてください。乾燥機、漂白剤、アイロンの使用は避けてください。'
    ],
  ),
];
