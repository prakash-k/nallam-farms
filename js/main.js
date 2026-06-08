/* -------------------------------------------------------------
 * NALLAM FARMS PREMIUM BUSINESS JAVASCRIPT
 * Custom logic for high-end interactions, reveals, carousel, and lightbox
 * ------------------------------------------------------------- */

document.addEventListener('DOMContentLoaded', () => {

    /* ==========================================
       1. STICKY HEADER & SCROLL STATE
       ========================================== */
    const header = document.getElementById('site-header');
    
    const handleScroll = () => {
        if (window.scrollY > 50) {
            header.classList.add('sticky');
        } else {
            header.classList.remove('sticky');
        }
    };
    
    window.addEventListener('scroll', handleScroll);
    handleScroll(); // Initial check


    /* ==========================================
       2. MOBILE DRAWER NAVIGATION
       ========================================== */
    const menuToggle = document.getElementById('menu-toggle');
    const mobileDrawer = document.getElementById('mobile-drawer');
    const drawerClose = document.getElementById('drawer-close');
    const drawerLinks = document.querySelectorAll('.drawer-link');
    
    const openDrawer = () => {
        mobileDrawer.classList.add('open');
        document.body.style.overflow = 'hidden'; // Prevent background scroll
    };
    
    const closeDrawer = () => {
        mobileDrawer.classList.remove('open');
        document.body.style.overflow = ''; // Restore scroll
    };
    
    menuToggle.addEventListener('click', openDrawer);
    drawerClose.addEventListener('click', closeDrawer);
    
    drawerLinks.forEach(link => {
        link.addEventListener('click', closeDrawer);
    });


    /* ==========================================
       3. ACTIVE NAV LINK ACCORDING TO SCROLL
       ========================================== */
    const sections = document.querySelectorAll('section[id]');
    const navLinks = document.querySelectorAll('.nav-link');
    
    const highlightNav = () => {
        let scrollY = window.pageYOffset;
        
        sections.forEach(current => {
            const sectionHeight = current.offsetHeight;
            const sectionTop = current.offsetTop - 120; // Offset for sticky header
            const sectionId = current.getAttribute('id');
            
            if (scrollY > sectionTop && scrollY <= sectionTop + sectionHeight) {
                navLinks.forEach(link => {
                    link.classList.remove('active');
                    if (link.getAttribute('href') === `#${sectionId}`) {
                        link.classList.add('active');
                    }
                });
            }
        });
    };
    
    window.addEventListener('scroll', highlightNav);


    /* ==========================================
       4. SCROLL REVEAL (INTERSECTION OBSERVER)
       ========================================== */
    const revealItems = document.querySelectorAll('.reveal-item, .reveal-item-up, .reveal-item-left, .reveal-item-right');
    
    const revealCallback = (entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('active');
                observer.unobserve(entry.target); // Reveal only once
            }
        });
    };
    
    const revealObserver = new IntersectionObserver(revealCallback, {
        root: null,
        threshold: 0.15,
        rootMargin: '0px 0px -50px 0px'
    });
    
    revealItems.forEach(item => {
        revealObserver.observe(item);
    });


    /* ==========================================
       5. PREMIUM TESTIMONIALS CAROUSEL
       ========================================== */
    const slides = document.querySelectorAll('.testimonial-slide');
    const prevBtn = document.getElementById('carousel-prev');
    const nextBtn = document.getElementById('carousel-next');
    let currentSlide = 0;
    let carouselInterval;
    
    const showSlide = (index) => {
        slides.forEach(slide => slide.classList.remove('active'));
        slides[index].classList.add('active');
    };
    
    const nextSlide = () => {
        currentSlide = (currentSlide + 1) % slides.length;
        showSlide(currentSlide);
    };
    
    const prevSlide = () => {
        currentSlide = (currentSlide - 1 + slides.length) % slides.length;
        showSlide(currentSlide);
    };
    
    const startAutoplay = () => {
        carouselInterval = setInterval(nextSlide, 7000); // 7s auto shift
    };
    
    const resetAutoplay = () => {
        clearInterval(carouselInterval);
        startAutoplay();
    };
    
    if (slides.length > 0) {
        // Init
        showSlide(currentSlide);
        startAutoplay();
        
        nextBtn.addEventListener('click', () => {
            nextSlide();
            resetAutoplay();
        });
        
        prevBtn.addEventListener('click', () => {
            prevSlide();
            resetAutoplay();
        });
    }


    /* ==========================================
       6. IMMERSIVE LIGHTBOX GALLERY
       ========================================== */
    const galleryItems = document.querySelectorAll('.gallery-item');
    const lightboxModal = document.getElementById('lightbox-modal');
    const lightboxClose = document.getElementById('lightbox-close');
    const lightboxImg = document.getElementById('lightbox-img');
    const lightboxCat = document.getElementById('lightbox-cat');
    const lightboxTtl = document.getElementById('lightbox-ttl');
    const lbPrev = document.getElementById('lb-prev');
    const lbNext = document.getElementById('lb-next');
    
    let activeGalleryIndex = 0;
    const galleryData = [];
    
    // Collect gallery information
    galleryItems.forEach((item, index) => {
        const fullImg = item.getAttribute('data-image');
        const imgEl = item.querySelector('.gallery-img');
        const cat = item.querySelector('.gallery-category').textContent;
        const ttl = item.querySelector('.gallery-title').textContent;
        
        galleryData.push({
            imgSrc: fullImg,
            category: cat,
            title: ttl
        });
        
        item.addEventListener('click', () => {
            activeGalleryIndex = index;
            openLightbox(activeGalleryIndex);
        });
    });
    
    const openLightbox = (index) => {
        const item = galleryData[index];
        lightboxImg.src = item.imgSrc;
        lightboxCat.textContent = item.category;
        lightboxTtl.textContent = item.title;
        
        lightboxModal.style.display = 'flex';
        setTimeout(() => lightboxModal.classList.add('show'), 10);
        document.body.style.overflow = 'hidden';
    };
    
    const closeLightbox = () => {
        lightboxModal.classList.remove('show');
        setTimeout(() => lightboxModal.style.display = 'none', 300);
        document.body.style.overflow = '';
    };
    
    const showNextLightbox = () => {
        activeGalleryIndex = (activeGalleryIndex + 1) % galleryData.length;
        openLightbox(activeGalleryIndex);
    };
    
    const showPrevLightbox = () => {
        activeGalleryIndex = (activeGalleryIndex - 1 + galleryData.length) % galleryData.length;
        openLightbox(activeGalleryIndex);
    };
    
    if (lightboxModal) {
        lightboxClose.addEventListener('click', closeLightbox);
        lbNext.addEventListener('click', showNextLightbox);
        lbPrev.addEventListener('click', showPrevLightbox);
        
        // Close on clicking modal background
        lightboxModal.addEventListener('click', (e) => {
            if (e.target === lightboxModal) {
                closeLightbox();
            }
        });
        
        // Keyboard controls
        document.addEventListener('keydown', (e) => {
            if (!lightboxModal.classList.contains('show')) return;
            
            if (e.key === 'Escape') closeLightbox();
            if (e.key === 'ArrowRight') showNextLightbox();
            if (e.key === 'ArrowLeft') showPrevLightbox();
        });
    }


    /* ==========================================
       7. CONTACT FORM HANDLER & VALIDATION
       ========================================== */
    const inquiryForm = document.getElementById('farm-inquiry-form');
    const formSuccessAlert = document.getElementById('form-success-alert');
    const resetSuccessBtn = document.getElementById('reset-success-btn');
    
    if (inquiryForm) {
        inquiryForm.addEventListener('submit', (e) => {
            e.preventDefault();
            
            // Collect Form Values for logging/checking if needed
            const name = document.getElementById('full-name').value;
            const email = document.getElementById('email').value;
            const phone = document.getElementById('phone').value;
            const type = document.getElementById('inquiry-type').value;
            const message = document.getElementById('message').value;
            
            console.log('Nallam Farms Form Submission:', { name, email, phone, type, message });
            
            // Emulate premium API request time
            const submitBtn = document.getElementById('form-submit-btn');
            submitBtn.textContent = 'Sending Inquiry...';
            submitBtn.disabled = true;
            submitBtn.style.opacity = '0.7';
            
            setTimeout(() => {
                // Fade out form, fade in success block
                inquiryForm.style.display = 'none';
                formSuccessAlert.style.display = 'flex';
                
                submitBtn.textContent = 'Send Message';
                submitBtn.disabled = false;
                submitBtn.style.opacity = '';
            }, 1200);
        });
        
        resetSuccessBtn.addEventListener('click', () => {
            inquiryForm.reset();
            formSuccessAlert.style.display = 'none';
            inquiryForm.style.display = 'flex';
        });
    }


    /* ==========================================
       8. FOOTER NEWSLETTER SUBMIT
       ========================================== */
    const newsletterForm = document.getElementById('newsletter-form');
    
    if (newsletterForm) {
        newsletterForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const input = newsletterForm.querySelector('input');
            const originalPlaceholder = input.placeholder;
            
            input.value = '';
            input.placeholder = 'Subscribed Successfully! ✓';
            input.disabled = true;
            newsletterForm.querySelector('button').disabled = true;
            
            setTimeout(() => {
                input.disabled = false;
                newsletterForm.querySelector('button').disabled = false;
                input.placeholder = originalPlaceholder;
            }, 4000);
        });
    }


    /* =============================================================
       9. FLOATING WHATSAPP CHAT WIDGET & MOBILE NAV SCROLL HIGHLIGHT
       ============================================================= */
    const waWidgetBtn = document.getElementById('whatsapp-floating-btn');
    const waChatBubble = document.getElementById('whatsapp-chat-bubble');
    const waBubbleClose = document.getElementById('whatsapp-bubble-close');
    
    // Toggle Chat Bubble
    if (waWidgetBtn && waChatBubble) {
        waWidgetBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            waChatBubble.classList.toggle('show');
        });
        
        if (waBubbleClose) {
            waBubbleClose.addEventListener('click', (e) => {
                e.stopPropagation();
                waChatBubble.classList.remove('show');
            });
        }
        
        // Hide on click outside
        document.addEventListener('click', (e) => {
            if (!waChatBubble.contains(e.target) && e.target !== waWidgetBtn) {
                waChatBubble.classList.remove('show');
            }
        });
        
        // Auto-show bubble after 4 seconds
        setTimeout(() => {
            // Check if user already opened it
            if (!waChatBubble.classList.contains('show')) {
                waChatBubble.classList.add('show');
            }
        }, 4000);
    }
    
    // Mobile Bottom Sticky Bar Highlighting on Scroll
    const bottomNavItems = document.querySelectorAll('.bottom-nav-item:not(.bottom-nav-chat)');
    
    const highlightBottomNav = () => {
        let scrollY = window.pageYOffset;
        
        sections.forEach(current => {
            const sectionHeight = current.offsetHeight;
            const sectionTop = current.offsetTop - 150; // Offset for screen center
            const sectionId = current.getAttribute('id');
            
            if (scrollY > sectionTop && scrollY <= sectionTop + sectionHeight) {
                bottomNavItems.forEach(item => {
                    item.classList.remove('active');
                    const href = item.getAttribute('href');
                    if (href === `#${sectionId}`) {
                        item.classList.add('active');
                    }
                });
            }
        });
    };
    
    window.addEventListener('scroll', highlightBottomNav);
    highlightBottomNav(); // Run once initially


    /* =============================================================
       10. TOP-LEVEL TABS SWITCHER & PRODUCTS SUB-TABS FILTERING
       ============================================================= */
    const farmsTab = document.getElementById('farms-tab-content');
    const textilesTab = document.getElementById('textiles-tab-content');
    const textilesIframe = document.getElementById('textiles-iframe');
    const tabLinks = document.querySelectorAll('[data-tab-main]');

    const switchToTab = (tabName, productId = '') => {
        if (tabName === 'textiles') {
            farmsTab.classList.remove('active');
            farmsTab.style.display = 'none';
            textilesTab.classList.add('active');
            textilesTab.style.display = 'block';

            // Point iframe to specific product if ID is provided
            const timestamp = Date.now();
            if (productId) {
                textilesIframe.src = `textiles_app/build/web/index.html?t=${timestamp}#/product?id=${productId}`;
            } else {
                textilesIframe.src = `textiles_app/build/web/index.html?t=${timestamp}#/catalog`;
            }

            // Sync locale state with iframe when it loads
            textilesIframe.onload = () => {
                textilesIframe.contentWindow.postMessage({ type: 'setLocale', locale: currentLang }, '*');
            };

            // Sync menu highlight
            tabLinks.forEach(link => {
                link.classList.remove('active');
                if (link.getAttribute('data-tab-main') === 'textiles') {
                    link.classList.add('active');
                }
            });
            window.scrollTo({ top: 0, behavior: 'smooth' });
        } else {
            textilesTab.classList.remove('active');
            textilesTab.style.display = 'none';
            farmsTab.classList.add('active');
            farmsTab.style.display = 'block';

            // Sync menu highlight
            tabLinks.forEach(link => {
                link.classList.remove('active');
                if (link.getAttribute('data-tab-main') === 'farms' && link.getAttribute('href') === '#home') {
                    link.classList.add('active');
                }
            });
        }
    };

    // Bind navigation tab clicks (header links and drawer links)
    tabLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            const targetTab = link.getAttribute('data-tab-main');
            const targetHref = link.getAttribute('href');

            if (targetTab === 'textiles') {
                e.preventDefault();
                switchToTab('textiles');
            } else {
                // If switching back to Farms and clicking a section link
                switchToTab('farms');
                if (targetHref.startsWith('#') && targetHref.length > 1) {
                    const targetEl = document.querySelector(targetHref);
                    if (targetEl) {
                        e.preventDefault();
                        const headerOffset = 80;
                        const elementPosition = targetEl.getBoundingClientRect().top;
                        const offsetPosition = elementPosition + window.pageYOffset - headerOffset;
                        
                        window.scrollTo({
                            top: offsetPosition,
                            behavior: "smooth"
                        });

                        // Set active link visually
                        tabLinks.forEach(lnk => lnk.classList.remove('active'));
                        link.classList.add('active');
                    }
                }
            }
        });
    });

    // Sub-Tabs Product Filtering inside the Products Section
    const prodTabBtns = document.querySelectorAll('.prod-tab-btn');
    const productCards = document.querySelectorAll('.products-grid .product-card');

    prodTabBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            // Toggle button states
            prodTabBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            const category = btn.getAttribute('data-prod-tab');

            // Toggle card visibility
            productCards.forEach(card => {
                const cardCategory = card.getAttribute('data-category');
                if (category === 'home') {
                    card.classList.remove('hidden');
                } else if (category === 'farms') {
                    if (cardCategory === 'farms') {
                        card.classList.remove('hidden');
                    } else {
                        card.classList.add('hidden');
                    }
                } else if (category === 'textiles') {
                    if (cardCategory === 'textiles') {
                        card.classList.remove('hidden');
                    } else {
                        card.classList.add('hidden');
                    }
                }
            });
        });
    });

    // Bind Textile Product Card clicks to switch top level tab and route details
    const textileDetailBtns = document.querySelectorAll('.view-textile-btn');
    textileDetailBtns.forEach(btn => {
        btn.addEventListener('click', (e) => {
            e.preventDefault();
            const productId = btn.getAttribute('data-product-id');
            switchToTab('textiles', productId);
        });
    });

    /* =============================================================
       11. PURE VANILLA JAVASCRIPT LOCALIZATION (l10n) SYSTEM
       ============================================================= */
    const l10nDict = {
        en: {
            "lang_btn": "JA",
            "lang_btn_mobile": "日本語",
            "logo_text": "<span class=\"logo-accent\">NALLAM</span> FARMS",
            "logo_text_drawer": "NALLAM FARMS",
            "nav_home": "Home",
            "nav_about": "About",
            "nav_products": "Products",
            "nav_why": "Why Us",
            "nav_textiles": "Textiles",
            "nav_contact": "Contact",
            "nav_inquire": "Inquire Now",
            "nav_products_drawer": "Products & Services",
            "nav_textiles_drawer": "Nallam Textiles",
            "nav_contact_drawer": "Contact Us",
            "drawer_tagline": "Pure food from trusted farms.",
            "hero_subtitle": "Authentic & Naturally Grown",
            "hero_title": "Pure Farm Freshness,<br>Delivered with Trust",
            "hero_desc": "Premium naturally sourced agricultural and food products cultivated with care, authenticity, and quality standards directly from our fields to your home.",
            "hero_btn_explore": "Explore Products",
            "hero_btn_contact": "Contact Us",
            "hero_badge_purity": "100% Certified Purity",
            "hero_badge_source": "Direct Farm Source",
            "strip_quality": "Quality Assured",
            "strip_natural": "Naturally Sourced",
            "strip_fresh": "Farm Fresh",
            "strip_trusted": "Trusted Supplier",
            "strip_premium": "Premium Quality",
            "about_subtitle": "Our Heritage & Mission",
            "about_title": "Rooted in Tradition, Cultivated for Tomorrow",
            "about_lead": "“NALLAM FARMS is committed to delivering naturally sourced farm products with uncompromising quality and freshness. Rooted in agricultural values and driven by customer trust, we bring healthy and authentic farm products closer to every household and business.”",
            "about_body": "Our journey began with a simple belief: that everyone deserves access to clean, chemical-free food. By honoring ancient natural farming wisdom and integrating rigorous quality standards, we ensure that every harvest retains its natural vitamins, authentic taste, and absolute freshness.",
            "about_val1_title": "Pure Purity",
            "about_val1_desc": "Strictly chemical-free, natural growing practices from the ground up.",
            "about_val2_title": "Absolute Trust",
            "about_val2_desc": "Complete transparency and tracing from our farm rows to your table.",
            "about_btn": "Our Farming Philosophy",
            "prod_subtitle": "Premium Categories",
            "prod_title": "Naturally Sourced Offerings",
            "prod_desc": "Every category represents our dedication to organic freshness, traditional quality, and reliable supply. Hand-selected for retail and wholesale partners.",
            "prod_tab_all": "Home (All Products)",
            "prod_tab_farms": "Farms Products",
            "prod_tab_textiles": "Textile Products",
            "card_farms_quote": "Request Quote",
            "card_farms_bulk": "Request Bulk Plan",
            "card_textiles_view": "View Details",
            "card_farm_p1_title": "Organic Farm Products",
            "card_farm_p1_desc": "Fresh heirloom vegetables, crisp leafy greens, and handpicked organic fruits grown with certified organic fertilizers.",
            "card_farm_p2_title": "Agricultural Produce",
            "card_farm_p2_desc": "High-grade raw grains, ancient millets, golden wheat, and hand-selected legumes packed with nutritious wholeness.",
            "card_farm_p3_title": "Natural Food Products",
            "card_farm_p3_desc": "Artisanal small-batch raw wild honey, cold-pressed culinary oils, and sun-dried farm spices preserved without additives.",
            "card_farm_p4_title": "Wholesale Supply",
            "card_farm_p4_desc": "Custom packaging, reliable bulk logistics, and highly consistent supply agreements for restaurants and luxury grocers.",
            "card_farm_p5_title": "Farm Fresh Goods",
            "card_farm_p5_desc": "Farm-laid cage-free brown eggs, pure raw dairy items, and fresh farm-ground flours processed with extreme hygienic care.",
            "card_textile_p6_title": "Aqua Blue Ribbed Woven Placemat",
            "card_textile_p6_desc": "100% yarn-dyed pure cotton ribbed placemat. Elegant bordered trim, heavy weight weave protecting dining tables.",
            "card_textile_p7_title": "Off White & Forest Green Cushion Cover",
            "card_textile_p7_desc": "Woven cotton canvas throw pillow cover with YKK invisible side zipper closure and matching piped borders.",
            "card_textile_p8_title": "Barnyard Striped Upholstery Fabric",
            "card_textile_p8_desc": "Heavy-duty pure cotton double-ply yarn fabric. Premium abrasion resistance for sofa, drapery, and headboards.",
            "card_textile_p9_title": "Organic Pure Cotton Kitchen Apron",
            "card_textile_p9_desc": "Adjustable neck straps and waist ties with double front utility pockets, heavy-duty stain-resistant canvas.",
            "card_textile_p10_title": "Navy Checkered Cotton Pet Bed",
            "card_textile_p10_desc": "Durable 100% heavy cotton canvas pet bed. Removable zippered cover and supportive eco-polyester filling.",
            "card_textile_p11_title": "Blue & Off White Checkered Pet Mat",
            "card_textile_p11_desc": "Premium yarn-dyed cotton floor cooling mat. Highly durable, fully machine washable, ideal for crates and carriers.",
            "card_textile_p12_title": "Multicolored Snuffle Forage Dog Mat",
            "card_textile_p12_desc": "Interactive slow-feeding snuffle mat. Conceals treats in dense cotton folds to stimulate foraging instincts.",
            "card_textile_p13_title": "Foldable Rattan Dog Canopy Bed",
            "card_textile_p13_desc": "Premium hand-woven PE rattan dog sofa bed with foldable weather-resistant canopy, elevated base, and customizable cushions.",
            "card_textile_p14_title": "Ultimate Cooling Nest Cat Bed",
            "card_textile_p14_desc": "Instant cooling gel-infused mesh bed with orthopedic bumper rim, high-density comfort foam, and durable Oxford shell.",
            "why_subtitle": "Our Competence",
            "why_title": "A Higher Standard of Farm-to-Home",
            "why_desc": "We merge age-old traditional farming integrity with rigorous modern sanitization and testing standards. Here is why premium retail buyers and wholesale partners choose Nallam Farms as their permanent source.",
            "why_stat_chem": "Chemical Free",
            "why_stat_harvest": "Harvest to Pack",
            "why_stat_trust": "Trust Score",
            "why_f1_title": "Naturally Sourced Products",
            "why_f1_desc": "Grown in natural soil enriched with eco-friendly organic compost, ensuring maximum nutrient density.",
            "why_f2_title": "Premium Quality Standards",
            "why_f2_desc": "Every single harvest undergoes visual checkups, weight-sorting, and hygiene evaluations before dispatch.",
            "why_f3_title": "Trusted Farm Network",
            "why_f3_desc": "We work in perfect coordination with experienced organic agricultural experts to secure the finest farm crops.",
            "why_f4_title": "Fresh & Hygienic Handling",
            "why_f4_desc": "Packed under strict contamination-free protocols in eco-friendly, food-grade biodegradable packages.",
            "why_f5_title": "Reliable Supply",
            "why_f5_desc": "Fast packaging times, consistent stock buffers, and smooth delivery channels minimize delays completely.",
            "why_f6_title": "Customer Satisfaction",
            "why_f6_desc": "Dedicated personal support representatives available to assist both our retail customers and bulk cargo buyers.",
            "exp_subtitle": "Immersive Farm Story",
            "exp_title": "True Agricultural Authenticity",
            "exp_desc": "Get closer to the origin of pure living. Explore the beautiful daily operations, fertile lands, meticulous harvest routines, and natural packaging at Nallam Farms.",
            "exp_gal_landscape": "Landscape",
            "exp_gal_experience": "Experience",
            "exp_gal_packaging": "Packaging",
            "exp_gal_t1": "Sunrise Fields",
            "exp_gal_t2": "Pure Farm-to-Table Living",
            "exp_gal_t3": "Direct Crating System",
            "test_subtitle": "Real Client Voices",
            "test_title": "Highly Trusted by Families & Partners",
            "test_desc": "We serve thousands of health-conscious families and major commercial food venues. Read what our retail consumers and wholesale procurement managers have to say about the Nallam Farms quality guarantee.",
            "test_s1_text": "“Excellent quality products with authentic freshness. Nallam Farms is a highly reliable supplier and offers a truly great customer experience. Their organic leafy greens arrive perfectly crisp!”",
            "test_s1_author": "Priya Sharma",
            "test_s1_role": "Health-Conscious Parent",
            "test_s2_text": "“As a chef, purity and taste are everything. The cold-pressed oils and raw honey from Nallam Farms are absolutely unmatched in depth of flavor. Their bulk logistics are flawless.”",
            "test_s2_author": "Chef Rajesh Nair",
            "test_s2_role": "Executive Chef, Green Garden Bistro",
            "test_s3_text": "“Finding chemical-free grains for my family was a chore until we discovered Nallam. The quality of their farm millets and pure pulses is pristine. The subscription package is a life-saver.”",
            "test_s3_author": "Amit Verma",
            "test_s3_role": "Premium Grocery Buyer",
            "cta_subtitle": "Join the Clean Food Movement",
            "cta_title": "Experience Authentic Farm Fresh Quality",
            "cta_desc": "Connect with NALLAM FARMS today for premium, chemical-free agricultural produce, natural food products, and wholesale supply plans custom-tailored to your standards.",
            "cta_call": "Call Now",
            "cta_inquiry": "Send Inquiry",
            "cta_whatsapp": "WhatsApp",
            "contact_subtitle": "Reach Out to Us",
            "contact_title": "Let's Connect for Purity & Freshness",
            "contact_desc": "Have a question about our retail subscriptions or commercial crop wholesale options? Send us an inquiry, and our organic farming logistics experts will get in touch with you shortly.",
            "contact_card_office": "Main Farm Office",
            "contact_card_phone": "Phone Support",
            "contact_card_email": "Inquiries & Email",
            "contact_card_hours": "Business Hours",
            "contact_hours_text": "Monday – Saturday: 7:00 AM – 6:00 PM (IST)<br>Sunday: Harvesting & Maintenance Only",
            "contact_form_title": "Send Us an Inquiry",
            "contact_form_lead": "Fill out this secure form and a customer representative will respond within 4 business hours.",
            "form_label_name": "Full Name",
            "form_label_email": "Email Address",
            "form_label_phone": "Phone Number",
            "form_label_type": "Inquiry Type",
            "form_label_message": "Your Message",
            "form_placeholder_name": "e.g. Priya Sharma",
            "form_placeholder_email": "e.g. priya@gmail.com",
            "form_placeholder_phone": "e.g. +91 98765 43210",
            "form_placeholder_message": "Explain your bulk needs, questions, or requirements...",
            "form_opt_select": "Select an option...",
            "form_opt_retail": "Retail Subscriptions (Fresh Veggies/Fruit)",
            "form_opt_wholesale": "Commercial Bulk Wholesale (Hotel/Grocer)",
            "form_opt_products": "Custom Food Products (Honey/Cold Oils)",
            "form_opt_visit": "Farm Visit & Visual Tour Scheduling",
            "form_opt_other": "General Partnership Inquiries",
            "form_submit": "Send Message",
            "form_sending": "Sending Inquiry...",
            "form_success_title": "Inquiry Sent Successfully!",
            "form_success_desc": "Thank you for connecting with Nallam Farms. Our organic trade specialist will reach out to you within 4 hours at the provided contact details.",
            "form_success_btn": "Send Another Inquiry",
            "map_title": "NALLAM FARMS COIMBATORE",
            "map_desc": "Premium farm products fresh from soil.",
            "map_link": "Get Directions &rarr;",
            "footer_tagline": "Providing pure food from trusted farms, direct to households and wholesale buyers since 2011.",
            "footer_links_title": "Quick Links",
            "footer_link_about": "About Our Farm",
            "footer_link_offerings": "Premium Offerings",
            "footer_link_support": "Contact Support",
            "footer_cats_title": "Farm Categories",
            "footer_cat_veggies": "Organic Farm Veggies",
            "footer_cat_grains": "Agricultural Grains",
            "footer_cat_honey": "Premium Honey & Spices",
            "footer_cat_supplies": "Wholesale Supplies",
            "footer_cat_daily": "Daily Fresh Goods",
            "footer_cat_compost": "Natural Compost Practice",
            "footer_news_title": "Stay Updated",
            "footer_news_desc": "Subscribe to receive organic health tips, harvest calendars, and fresh catalog updates directly.",
            "footer_news_placeholder": "Your Email Address",
            "footer_news_success": "Subscribed Successfully! ✓",
            "footer_news_disclaimer": "Zero spam. Pure agricultural news only.",
            "footer_copyright": "&copy; 2026 NALLAM FARMS. All Rights Reserved. Designed with Purity & Trust.",
            "footer_bottom_privacy": "Privacy Policy",
            "footer_bottom_terms": "Terms of Service",
            "footer_bottom_wholesale": "Wholesale T&C",
            "wa_title": "Nallam Helpdesk",
            "wa_status": "Online",
            "wa_text": "Need customized home textiles or organic products? Chat with our expert!",
            "wa_btn": "Start Chat",
            "wa_tooltip": "Chat with us!",
            "bottom_nav_home": "Home",
            "bottom_nav_about": "About",
            "bottom_nav_products": "Products",
            "bottom_nav_contact": "Contact",
            "bottom_nav_chat": "Chat"
        },
        ja: {
            "lang_btn": "EN",
            "lang_btn_mobile": "English",
            "logo_text": "<span class=\"logo-accent\">ナラム</span> 農園",
            "logo_text_drawer": "ナラム農園",
            "nav_home": "ホーム",
            "nav_about": "農園について",
            "nav_products": "製品紹介",
            "nav_why": "選ばれる理由",
            "nav_textiles": "テキスタイル",
            "nav_contact": "お問い合わせ",
            "nav_inquire": "今すぐお問い合わせ",
            "nav_products_drawer": "取扱製品・サービス",
            "nav_textiles_drawer": "ナラム・テキスタイル",
            "nav_contact_drawer": "お問い合わせ",
            "drawer_tagline": "信頼できる農場からの純粋な食品。",
            "hero_subtitle": "本物志向・自然栽培",
            "hero_title": "信頼でお届けする、<br>農場直送の純粋な新鮮さ",
            "hero_desc": "当農場からご家庭へ直接、愛情と本物へのこだわり、そして厳格な品質基準のもとで栽培されたプレミアムな自然派農産物・食品をお届けします。",
            "hero_btn_explore": "製品を見る",
            "hero_btn_contact": "お問い合わせ",
            "hero_badge_purity": "100%認証純度",
            "hero_badge_source": "農場直送",
            "strip_quality": "品質保証",
            "strip_natural": "自然由来",
            "strip_fresh": "新鮮な農産物",
            "strip_trusted": "信頼できる供給元",
            "strip_premium": "プレミアム品質",
            "about_subtitle": "私たちの伝統と使命",
            "about_title": "伝統に根ざし、未来に向けて栽培する",
            "about_lead": "「ナラム農園は、一切の妥協のない品質と新鮮さをもって、自然由来 of 農産物をお届けすることをお約束します。農業の価値観に根ざし、お客様の信頼を原動力として、健康的で本物の農産物をすべてのご家庭や企業に身近にお届けします。」",
            "about_body": "私たちの旅は、「誰もがクリーンで化学物質を含まない食品を手にする権利がある」というシンプルな信念から始まりました。古くからの自然農法の知恵を尊重し、厳格な品質基準を統合することで、すべての収穫物が自然のビタミン、本物の味、そして絶対的な新鮮さを保てるようにしています。",
            "about_val1_title": "純粋な清らかさ",
            "about_val1_desc": "土づくりから始める、化学物質を一切使用しない完全自然栽培。",
            "about_val2_title": "絶対的な信頼",
            "about_val2_desc": "農場の畝から食卓まで、完全な透明性とトレーサビリティを確保。",
            "about_btn": "私たちの農業哲学",
            "prod_subtitle": "プレミアムカテゴリー",
            "prod_title": "自然由来の製品ラインナップ",
            "prod_desc": "すべてのカテゴリーは、オーガニックな新鮮さ、伝統的な品質、そして信頼できる供給への私たちの献身を表しています。小売店や卸売パートナーのために厳選されました。",
            "prod_tab_all": "ホーム (全製品)",
            "prod_tab_farms": "農産物製品",
            "prod_tab_textiles": "テキスタイル製品",
            "card_farms_quote": "見積もりを依頼",
            "card_farms_bulk": "一括プランを依頼",
            "card_textiles_view": "詳細を見る",
            "card_farm_p1_title": "オーガニック農産物",
            "card_farm_p1_desc": "認証オーガニック肥料で育てられた、新鮮な固定種の野菜、みずみずしい葉物野菜、厳選されたオーガニックフルーツ。",
            "card_farm_p2_title": "一般農産物",
            "card_farm_p2_desc": "栄養価の高いホールフードを詰め込んだ、高品質な生の穀物、古代の雑穀、黄金色の小麦、厳選された豆類。",
            "card_farm_p3_title": "自然食品",
            "card_farm_p3_desc": "添加物を一切使用せずに保存された、職人による小ロットの生の野生ハチミツ、コールドプレス（低温圧搾）の調理用オイル、天日干しのスパイス。",
            "card_farm_p4_title": "卸売・一括供給",
            "card_farm_p4_desc": "レストランや高級食料品店向けの、カスタムパッケージ、信頼性の高いバルク物流、非常に安定した供給契約。",
            "card_farm_p5_title": "農場直送品",
            "card_farm_p5_desc": "衛生管理を徹底して加工された、平飼いの有精茶卵、純粋な生乳製品、挽きたての小麦粉。",
            "card_textile_p6_title": "アクアブルー・リブ織プレースマット",
            "card_textile_p6_desc": "100%糸染めの純綿リブプレースマット。エレガントな縁取り、食卓を守る厚手の織り。",
            "card_textile_p7_title": "オフホワイト＆フォレストグリーン クッションカバー",
            "card_textile_p7_desc": "YKKコンシールファスナー（隠しジッパー）とマッチングパイピング仕様のコットンキャンバス製クッションカバー。",
            "card_textile_p8_title": "バーンヤードストライプ・家具用張地",
            "card_textile_p8_desc": "頑丈な純綿2本撚り糸の生地。ソファ、ドレープカーテン、ヘッドボード用の優れた耐摩耗性。",
            "card_textile_p9_title": "オーガニック純綿キッチンエプロン",
            "card_textile_p9_desc": "調節可能なネックストラップと腰紐、ダブルフロントユーティリティポケット付き、頑丈で防汚性に優れたキャンバス生地。",
            "card_textile_p10_title": "ネイビー市松模様コットンペットベッド",
            "card_textile_p10_desc": "丈夫な100%厚手コットンキャンバスのペットベッド。取り外し可能なジッパー付きカバーとサポート力のあるエコポリエステル中綿。",
            "card_textile_p11_title": "ブルー＆オフホワイト市松模様ペットマット",
            "card_textile_p11_desc": "高級糸染めコットンのフロアクーリングマット。耐久性が高く、洗濯機で丸洗い可能、クレートやキャリーに最適。",
            "card_textile_p12_title": "マルチカラー嗅覚トレーニング犬用マット",
            "card_textile_p12_desc": "知育・スローフード用スナッフルマット。密なコットンのひだにおやつを隠し、採餌本能を刺激します。",
            "card_textile_p13_title": "ペット用キャノピーベッド 折りたたみ式ラタン ドッグソファベッド",
            "card_textile_p13_desc": "高級人工PEラタンを手編みし、頑丈なスチールフレームで支えたドッグベッド。折りたたみ可能な耐候性ポリエステル製キャノピーが日差しや小雨から守ります。",
            "card_textile_p14_title": "進化冷感スクエアペットベッド 丸リビング究極ひんやりネスト",
            "card_textile_p14_desc": "愛猫や小型犬に究極の夏の快適さを。瞬間冷却ジェルを配合した進化系冷感メッシュの寝床面と、サポート力の高い高密度ウレタンの縁取りを採用。",
            "why_subtitle": "私たちの強み",
            "why_title": "農場からご家庭へ届ける高水準な品質",
            "why_desc": "私たちは、古くから伝わる伝統的な農業への誠実さと、現代の厳格な衛生・検査基準を融合させています。プレミアム小売バイヤーや卸売パートナーが、ナラム農園を永続的な仕入れ先として選ぶ理由はここにあります。",
            "why_stat_chem": "化学物質不使用",
            "why_stat_harvest": "収穫から梱包まで",
            "why_stat_trust": "信頼スコア",
            "why_f1_title": "自然由来の製品",
            "why_f1_desc": "環境に優しいオーガニック堆肥で豊かにされた自然の土壌で栽培され、最大限の栄養密度を確保しています。",
            "why_f2_title": "プレミアムな品質基準",
            "why_f2_desc": "すべての収穫物は、出荷前に目視検査、重量選別、および衛生評価を受けます。",
            "why_f3_title": "信頼できる農場ネットワーク",
            "why_f3_desc": "私たちは、経験豊富な有機農業の専門家と完璧に連携し、最高品質の農作物を確保しています。",
            "why_f4_title": "新鮮で衛生的な取り扱い",
            "why_f4_desc": "環境に優しい食品グレードの生分解性パッケージに、汚染のない厳格なプロトコルのもとで梱包されています。",
            "why_f5_title": "信頼できる供給",
            "why_f5_desc": "迅速な梱包時間、安定した在庫バッファー、およびスムーズな配送ルートにより、遅延を完全に最小限に抑えます。",
            "why_f6_title": "顧客満足度の向上",
            "why_f6_desc": "小売のお客様とバルク（大量）バイヤーの両方を支援するため、専任の個人サポート担当者が待機しています。",
            "exp_subtitle": "農園の没入ストーリー",
            "exp_title": "真の農業の信頼性",
            "exp_desc": "純粋な暮らしの起源に近づいてみてください。ナラム農園の美しい日常業務、肥沃な土地、細心の注意を払った収穫手順、および自然なパッケージングをご覧ください。",
            "exp_gal_landscape": "風景",
            "exp_gal_experience": "体験",
            "exp_gal_packaging": "梱包",
            "exp_gal_t1": "朝日の当たる畑",
            "exp_gal_t2": "農場から食卓への純粋な暮らし",
            "exp_gal_t3": "直接クレーティングシステム",
            "test_subtitle": "お客様の生の声",
            "test_title": "ご家族やパートナー企業からの高い信頼",
            "test_desc": "私たちは、何千もの健康志向のご家族や主要な商業向け食品施設に対応しています。ナラム農園の品質保証について、小売消費者や卸売調達マネージャーの意見をお聞きください。",
            "test_s1_text": "「本物の新鮮さを伴う優れた品質の製品。ナラム農園は非常に信頼できるサプライヤーであり、真に優れたカスタマーエクスペリエンスを提供してくれます。彼らの有機葉物野菜は完全にパリッとした状態で届きます！」",
            "test_s1_author": "プリヤ・シャルマ",
            "test_s1_role": "健康志向の保護者",
            "test_s2_text": "「シェフとして、純度と味こそがすべてです。ナラム農園のコールドプレスオイルと生のハチミツは、味の深みにおいて絶対に他の追随を許しません。彼らの一括物流は完璧です。」",
            "test_s2_author": "シェフ ラジェシュ・ナイル",
            "test_s2_role": "エグゼクティブシェフ、グリーンガーデンビストロ",
            "test_s3_text": "「家族のために化学物質を含まない穀物を見つけるのは大変でしたが、ナラムに出会ってから変わりました。彼らの農場産雑穀と純粋な豆類の品質は極めてクリーンです。定期購入パッケージは命の恩人です。」",
            "test_s3_author": "アミット・ヴェルマ",
            "test_s3_role": "プレミアム食品バイヤー",
            "cta_subtitle": "クリーンフード運動に参加する",
            "cta_title": "本物の農場直送クリーン品質を体験",
            "cta_desc": "プレミアムで化学物質を含まない農産物、自然食品、およびあなたの基準に合わせてカスタマイズされた卸売供給プランについては、今すぐナラム農園にお問い合わせください。",
            "cta_call": "電話をかける",
            "cta_inquiry": "問い合わせを送る",
            "cta_whatsapp": "WhatsAppで相談",
            "contact_subtitle": "お問い合わせ",
            "contact_title": "清らかさと新鮮さのために繋がりましょう",
            "contact_desc": "小売定期購入や商業用作物の卸売オプションについて質問がありますか？お問い合わせをお送りください。私たちの有機農業物流のエキスパートがまもなくご連絡いたします。",
            "contact_card_office": "メインオフィス",
            "contact_card_phone": "電話サポート",
            "contact_card_email": "問い合わせ＆Eメール",
            "contact_card_hours": "営業時間",
            "contact_hours_text": "月曜日〜土曜日：午前7:00〜午後6:00 (インド時間)<br>日曜日：収穫およびメンテナンスのみ",
            "contact_form_title": "お問い合わせを送信",
            "contact_form_lead": "このセキュアなフォームに入力してください。カスタマー担当者が4営業時間以内に返信いたします。",
            "form_label_name": "氏名",
            "form_label_email": "メールアドレス",
            "form_label_phone": "電話番号",
            "form_label_type": "お問い合わせ種別",
            "form_label_message": "メッセージ",
            "form_placeholder_name": "例：プリヤ・シャルマ",
            "form_placeholder_email": "例：priya@gmail.com",
            "form_placeholder_phone": "例：+91 98765 43210",
            "form_placeholder_message": "一括購入のご要望、ご質問、要件などを入力してください...",
            "form_opt_select": "選択してください...",
            "form_opt_retail": "小売定期購入（新鮮な野菜・果物）",
            "form_opt_wholesale": "商業用バルク卸売（ホテル・食品店）",
            "form_opt_products": "カスタム食品（ハチミツ・生油）",
            "form_opt_visit": "農園訪問およびツアーの予約",
            "form_opt_other": "一般的なパートナーシップの問い合わせ",
            "form_submit": "メッセージを送信",
            "form_sending": "送信中...",
            "form_success_title": "お問い合わせが正常に送信されました！",
            "form_success_desc": "ナラム農園へのお問い合わせありがとうございます。当社の有機調達専門家が、ご提供いただいた連絡先に4時間以内にご連絡いたします。",
            "form_success_btn": "別のお問い合わせを送信",
            "map_title": "ナラム農園 コインバトール",
            "map_desc": "土壌から採れた新鮮なプレミアム農産物。",
            "map_link": "ルート検索 &rarr;",
            "footer_tagline": "2011年以来、信頼できる農場からの純粋な食品をご家庭や卸売バイヤーに直接提供しています。",
            "footer_links_title": "クイックリンク",
            "footer_link_about": "農場について",
            "footer_link_offerings": "プレミアム製品",
            "footer_link_support": "サポート窓口",
            "footer_cats_title": "農園カテゴリー",
            "footer_cat_veggies": "有機農産野菜",
            "footer_cat_grains": "農作物穀物",
            "footer_cat_honey": "高級蜂蜜＆スパイス",
            "footer_cat_supplies": "卸売品供給",
            "footer_cat_daily": "日替わり新鮮食品",
            "footer_cat_compost": "自然堆肥の実践",
            "footer_news_title": "最新情報を受け取る",
            "footer_news_desc": "オーガニックな健康のコツ、収穫カレンダー、新鮮な製品カタログの最新情報を受け取るために購読してください。",
            "footer_news_placeholder": "メールアドレスを入力",
            "footer_news_success": "購読に成功しました！ ✓",
            "footer_news_disclaimer": "スパムはありません。純粋な農業情報のみ配信します。",
            "footer_copyright": "&copy; 2026 NALLAM FARMS. All Rights Reserved. Designed with Purity & Trust.",
            "footer_bottom_privacy": "プライバシーポリシー",
            "footer_bottom_terms": "利用規約",
            "footer_bottom_wholesale": "卸売取引条件",
            "wa_title": "ナラム・ヘルプデスク",
            "wa_status": "オンライン",
            "wa_text": "特注ホームテキスタイルやオーガニック製品が必要ですか？専門家に相談しましょう！",
            "wa_btn": "チャットを開始",
            "wa_tooltip": "チャットはこちら！",
            "bottom_nav_home": "ホーム",
            "bottom_nav_about": "概要",
            "bottom_nav_products": "製品",
            "bottom_nav_contact": "連絡",
            "bottom_nav_chat": "チャット"
        }
    };

    const l10nSelectorMap = {
        "#logo-link": "logo_text",
        ".drawer-logo": "logo_text_drawer",
        "nav a[href='#home']": "nav_home",
        "nav a[href='#about']": "nav_about",
        "nav a[href='#products']": "nav_products",
        "nav a[href='#why-choose-us']": "nav_why",
        "nav a[href='#textiles']": "nav_textiles",
        "nav a[href='#contact']": "nav_contact",
        ".btn-nav-cta": "nav_inquire",
        ".drawer-links a[href='#home']": "nav_home",
        ".drawer-links a[href='#about']": "nav_about",
        ".drawer-links a[href='#products']": "nav_products_drawer",
        ".drawer-links a[href='#why-choose-us']": "nav_why",
        ".drawer-links a[href='#textiles']": "nav_textiles_drawer",
        ".drawer-links a[href='#contact']": "nav_contact_drawer",
        ".drawer-footer p": "drawer_tagline",
        ".hero-subtitle": "hero_subtitle",
        ".hero-title": "hero_title",
        ".hero-description": "hero_desc",
        ".hero-actions a[href='#products']": "hero_btn_explore",
        ".hero-actions a[href='#contact']": "hero_btn_contact",
        ".hero-trust-badges .badge-item:nth-child(1) span": "hero_badge_purity",
        ".hero-trust-badges .badge-item:nth-child(2) span": "hero_badge_source",
        ".strip-grid .strip-item:nth-child(1) .strip-text": "strip_quality",
        ".strip-grid .strip-item:nth-child(2) .strip-text": "strip_natural",
        ".strip-grid .strip-item:nth-child(3) .strip-text": "strip_fresh",
        ".strip-grid .strip-item:nth-child(4) .strip-text": "strip_trusted",
        ".strip-grid .strip-item:nth-child(5) .strip-text": "strip_premium",
        "#about .section-subtitle": "about_subtitle",
        "#about .section-title": "about_title",
        ".about-text-lead": "about_lead",
        ".about-text-body": "about_body",
        ".about-values .value-card:nth-child(1) h3": "about_val1_title",
        ".about-values .value-card:nth-child(1) p": "about_val1_desc",
        ".about-values .value-card:nth-child(2) h3": "about_val2_title",
        ".about-values .value-card:nth-child(2) p": "about_val2_desc",
        "#about .btn-secondary-outline": "about_btn",
        "#products .section-subtitle": "prod_subtitle",
        "#products .section-title": "prod_title",
        "#products .section-description": "prod_desc",
        ".products-tabs button:nth-child(1)": "prod_tab_all",
        ".products-tabs button:nth-child(2)": "prod_tab_farms",
        ".products-tabs button:nth-child(3)": "prod_tab_textiles",
        ".products-grid .product-card:nth-child(1) h3": "card_farm_p1_title",
        ".products-grid .product-card:nth-child(1) p": "card_farm_p1_desc",
        ".products-grid .product-card:nth-child(1) .btn": "card_farms_quote",
        ".products-grid .product-card:nth-child(2) h3": "card_farm_p2_title",
        ".products-grid .product-card:nth-child(2) p": "card_farm_p2_desc",
        ".products-grid .product-card:nth-child(2) .btn": "card_farms_quote",
        ".products-grid .product-card:nth-child(3) h3": "card_farm_p3_title",
        ".products-grid .product-card:nth-child(3) p": "card_farm_p3_desc",
        ".products-grid .product-card:nth-child(3) .btn": "card_farms_quote",
        ".products-grid .product-card:nth-child(4) h3": "card_farm_p4_title",
        ".products-grid .product-card:nth-child(4) p": "card_farm_p4_desc",
        ".products-grid .product-card:nth-child(4) .btn": "card_farms_bulk",
        ".products-grid .product-card:nth-child(5) h3": "card_farm_p5_title",
        ".products-grid .product-card:nth-child(5) p": "card_farm_p5_desc",
        ".products-grid .product-card:nth-child(5) .btn": "card_farms_quote",
        ".products-grid .product-card:nth-child(6) h3": "card_textile_p6_title",
        ".products-grid .product-card:nth-child(6) p": "card_textile_p6_desc",
        ".products-grid .product-card:nth-child(6) .view-textile-btn": "card_textiles_view",
        ".products-grid .product-card:nth-child(7) h3": "card_textile_p7_title",
        ".products-grid .product-card:nth-child(7) p": "card_textile_p7_desc",
        ".products-grid .product-card:nth-child(7) .view-textile-btn": "card_textiles_view",
        ".products-grid .product-card:nth-child(8) h3": "card_textile_p8_title",
        ".products-grid .product-card:nth-child(8) p": "card_textile_p8_desc",
        ".products-grid .product-card:nth-child(8) .view-textile-btn": "card_textiles_view",
        ".products-grid .product-card:nth-child(9) h3": "card_textile_p9_title",
        ".products-grid .product-card:nth-child(9) p": "card_textile_p9_desc",
        ".products-grid .product-card:nth-child(9) .view-textile-btn": "card_textiles_view",
        ".products-grid .product-card:nth-child(10) h3": "card_textile_p10_title",
        ".products-grid .product-card:nth-child(10) p": "card_textile_p10_desc",
        ".products-grid .product-card:nth-child(10) .view-textile-btn": "card_textiles_view",
        ".products-grid .product-card:nth-child(11) h3": "card_textile_p11_title",
        ".products-grid .product-card:nth-child(11) p": "card_textile_p11_desc",
        ".products-grid .product-card:nth-child(11) .view-textile-btn": "card_textiles_view",
        ".products-grid .product-card:nth-child(12) h3": "card_textile_p12_title",
        ".products-grid .product-card:nth-child(12) p": "card_textile_p12_desc",
        ".products-grid .product-card:nth-child(12) .view-textile-btn": "card_textiles_view",
        ".products-grid .product-card:nth-child(13) h3": "card_textile_p13_title",
        ".products-grid .product-card:nth-child(13) p": "card_textile_p13_desc",
        ".products-grid .product-card:nth-child(13) .view-textile-btn": "card_textiles_view",
        ".products-grid .product-card:nth-child(14) h3": "card_textile_p14_title",
        ".products-grid .product-card:nth-child(14) p": "card_textile_p14_desc",
        ".products-grid .product-card:nth-child(14) .view-textile-btn": "card_textiles_view",
        "#why-choose-us .section-subtitle": "why_subtitle",
        "#why-choose-us .section-title": "why_title",
        "#why-choose-us .section-description": "why_desc",
        ".why-stats .stat-box:nth-child(1) .stat-lbl": "why_stat_chem",
        ".why-stats .stat-box:nth-child(2) .stat-lbl": "why_stat_harvest",
        ".why-stats .stat-box:nth-child(3) .stat-lbl": "why_stat_trust",
        ".why-grid .feature-block:nth-child(1) h3": "why_f1_title",
        ".why-grid .feature-block:nth-child(1) p": "why_f1_desc",
        ".why-grid .feature-block:nth-child(2) h3": "why_f2_title",
        ".why-grid .feature-block:nth-child(2) p": "why_f2_desc",
        ".why-grid .feature-block:nth-child(3) h3": "why_f3_title",
        ".why-grid .feature-block:nth-child(3) p": "why_f3_desc",
        ".why-grid .feature-block:nth-child(4) h3": "why_f4_title",
        ".why-grid .feature-block:nth-child(4) p": "why_f4_desc",
        ".why-grid .feature-block:nth-child(5) h3": "why_f5_title",
        ".why-grid .feature-block:nth-child(5) p": "why_f5_desc",
        ".why-grid .feature-block:nth-child(6) h3": "why_f6_title",
        ".why-grid .feature-block:nth-child(6) p": "why_f6_desc",
        "#experience .section-subtitle": "exp_subtitle",
        "#experience .section-title": "exp_title",
        "#experience .section-description": "exp_desc",
        ".gallery-item:nth-child(1) .gallery-category": "exp_gal_landscape",
        ".gallery-item:nth-child(1) .gallery-title": "exp_gal_t1",
        ".gallery-item:nth-child(2) .gallery-category": "exp_gal_experience",
        ".gallery-item:nth-child(2) .gallery-title": "exp_gal_t2",
        ".gallery-item:nth-child(3) .gallery-category": "exp_gal_packaging",
        ".gallery-item:nth-child(3) .gallery-title": "exp_gal_t3",
        ".gallery-item:nth-child(4) .gallery-category": "exp_gal_experience",
        ".gallery-item:nth-child(4) .gallery-title": "exp_gal_t2",
        "#testimonials .section-subtitle": "test_subtitle",
        "#testimonials .section-title": "test_title",
        "#testimonials .section-description": "test_desc",
        ".testimonials-carousel .testimonial-slide:nth-child(1) .testimonial-text": "test_s1_text",
        ".testimonials-carousel .testimonial-slide:nth-child(1) .testimonial-author h4": "test_s1_author",
        ".testimonials-carousel .testimonial-slide:nth-child(1) .testimonial-author p": "test_s1_role",
        ".testimonials-carousel .testimonial-slide:nth-child(2) .testimonial-text": "test_s2_text",
        ".testimonials-carousel .testimonial-slide:nth-child(2) .testimonial-author h4": "test_s2_author",
        ".testimonials-carousel .testimonial-slide:nth-child(2) .testimonial-author p": "test_s2_role",
        ".testimonials-carousel .testimonial-slide:nth-child(3) .testimonial-text": "test_s3_text",
        ".testimonials-carousel .testimonial-slide:nth-child(3) .testimonial-author h4": "test_s3_author",
        ".testimonials-carousel .testimonial-slide:nth-child(3) .testimonial-author p": "test_s3_role",
        ".cta-section .cta-subtitle": "cta_subtitle",
        ".cta-section .cta-title": "cta_title",
        ".cta-section .cta-description": "cta_desc",
        ".cta-buttons a[href^='tel'] span": "cta_call",
        ".cta-buttons a[href='#contact']": "cta_inquiry",
        ".cta-buttons a[href^='https://wa.me'] span": "cta_whatsapp",
        "#contact .section-subtitle": "contact_subtitle",
        "#contact .section-title": "contact_title",
        "#contact .section-description": "contact_desc",
        ".contact-cards .contact-card:nth-child(1) h4": "contact_card_office",
        ".contact-cards .contact-card:nth-child(2) h4": "contact_card_phone",
        ".contact-cards .contact-card:nth-child(3) h4": "contact_card_email",
        ".contact-cards .contact-card:nth-child(4) h4": "contact_card_hours",
        ".contact-cards .contact-card:nth-child(4) p": "contact_hours_text",
        ".contact-form-panel h3": "contact_form_title",
        ".form-lead-text": "contact_form_lead",
        "label[for='full-name']": "form_label_name",
        "label[for='email']": "form_label_email",
        "label[for='phone']": "form_label_phone",
        "label[for='inquiry-type']": "form_label_type",
        "label[for='message']": "form_label_message",
        "input#full-name": "form_placeholder_name",
        "input#email": "form_placeholder_email",
        "input#phone": "form_placeholder_phone",
        "select#inquiry-type option:disabled": "form_opt_select",
        "select#inquiry-type option[value='retail']": "form_opt_retail",
        "select#inquiry-type option[value='wholesale']": "form_opt_wholesale",
        "select#inquiry-type option[value='products']": "form_opt_products",
        "select#inquiry-type option[value='visit']": "form_opt_visit",
        "select#inquiry-type option[value='other']": "form_opt_other",
        "textarea#message": "form_placeholder_message",
        "#form-submit-btn": "form_submit",
        "#form-success-alert h4": "form_success_title",
        "#form-success-alert p": "form_success_desc",
        "#reset-success-btn": "form_success_btn",
        ".map-card h5": "map_title",
        ".map-card p": "map_desc",
        ".map-card-link": "map_link",
        ".footer-brand-col p": "footer_tagline",
        ".footer-grid .footer-nav-col:nth-of-type(1) h4": "footer_links_title",
        ".footer-grid .footer-nav-col:nth-of-type(1) a[href='#home']": "nav_home",
        ".footer-grid .footer-nav-col:nth-of-type(1) a[href='#about']": "footer_link_about",
        ".footer-grid .footer-nav-col:nth-of-type(1) a[href='#products']": "footer_link_offerings",
        ".footer-grid .footer-nav-col:nth-of-type(1) a[href='#why-choose-us']": "nav_why",
        ".footer-grid .footer-nav-col:nth-of-type(1) a[href='#experience']": "exp_subtitle",
        ".footer-grid .footer-nav-col:nth-of-type(1) a[href='#testimonials']": "test_subtitle",
        ".footer-grid .footer-nav-col:nth-of-type(1) a[href='#contact']": "footer_link_support",
        ".footer-grid .footer-nav-col:nth-of-type(2) h4": "footer_cats_title",
        ".footer-grid .footer-nav-col:nth-of-type(2) li:nth-child(1) a": "footer_cat_veggies",
        ".footer-grid .footer-nav-col:nth-of-type(2) li:nth-child(2) a": "footer_cat_grains",
        ".footer-grid .footer-nav-col:nth-of-type(2) li:nth-child(3) a": "footer_cat_honey",
        ".footer-grid .footer-nav-col:nth-of-type(2) li:nth-child(4) a": "footer_cat_supplies",
        ".footer-grid .footer-nav-col:nth-of-type(2) li:nth-child(5) a": "footer_cat_daily",
        ".footer-grid .footer-nav-col:nth-of-type(2) li:nth-child(6) a": "footer_cat_compost",
        ".footer-newsletter-col h4": "footer_news_title",
        ".footer-newsletter-col p:nth-of-type(1)": "footer_news_desc",
        ".footer-newsletter-form input": "footer_news_placeholder",
        ".newsletter-disclaimer": "footer_news_disclaimer",
        ".copyright": "footer_copyright",
        ".footer-bottom-links a:nth-child(1)": "footer_bottom_privacy",
        ".footer-bottom-links a:nth-child(2)": "footer_bottom_terms",
        ".footer-bottom-links a:nth-child(3)": "footer_bottom_wholesale",
        "#whatsapp-chat-bubble .bubble-title": "wa_title",
        "#whatsapp-chat-bubble .bubble-status": "wa_status",
        "#whatsapp-chat-bubble .bubble-text": "wa_text",
        "#whatsapp-chat-bubble .bubble-btn": "wa_btn",
        ".whatsapp-tooltip": "wa_tooltip",
        "#bottom-nav-home span": "bottom_nav_home",
        "#bottom-nav-about span": "bottom_nav_about",
        "#bottom-nav-products span": "bottom_nav_products",
        "#bottom-nav-contact span": "bottom_nav_contact",
        ".bottom-nav-chat span": "bottom_nav_chat",
        "#lang-switch-btn": "lang_btn",
        "#mobile-lang-switch-btn": "lang_btn_mobile"
    };

    let currentLang = localStorage.getItem('selectedLanguage') || 'en';

    const translatePage = (lang) => {
        currentLang = lang;
        localStorage.setItem('selectedLanguage', lang);
        
        const dict = l10nDict[lang];
        
        // Loop over the map and translate elements
        for (const selector in l10nSelectorMap) {
            const key = l10nSelectorMap[selector];
            const text = dict[key];
            if (!text) continue;
            
            const elements = document.querySelectorAll(selector);
            elements.forEach(el => {
                if (el.tagName === 'INPUT' || el.tagName === 'TEXTAREA') {
                    el.placeholder = text;
                } else if (el.tagName === 'OPTION') {
                    el.text = text;
                } else {
                    el.innerHTML = text;
                }
            });
        }
        
        // Update data attribute on buttons
        const desktopBtn = document.getElementById('lang-switch-btn');
        const mobileBtn = document.getElementById('mobile-lang-switch-btn');
        if (desktopBtn) desktopBtn.setAttribute('data-lang', lang);
        if (mobileBtn) mobileBtn.setAttribute('data-lang', lang);
        
        // Sync with iframe
        const iframe = document.getElementById('textiles-iframe');
        if (iframe && iframe.contentWindow) {
            iframe.contentWindow.postMessage({ type: 'setLocale', locale: lang }, '*');
        }
    };

    const initL10n = () => {
        const desktopBtn = document.getElementById('lang-switch-btn');
        const mobileBtn = document.getElementById('mobile-lang-switch-btn');
        
        const handleToggle = () => {
            const nextLang = currentLang === 'en' ? 'ja' : 'en';
            translatePage(nextLang);
        };
        
        if (desktopBtn) desktopBtn.addEventListener('click', handleToggle);
        if (mobileBtn) mobileBtn.addEventListener('click', handleToggle);
        
        // Listen for iframe locale updates (bidirectional sync)
        window.addEventListener('message', (event) => {
            const data = event.data;
            if (data && data.type === 'syncLocale') {
                const locale = data.locale;
                if (locale === 'en' || locale === 'ja') {
                    if (locale !== currentLang) {
                        currentLang = locale;
                        localStorage.setItem('selectedLanguage', locale);
                        
                        const dict = l10nDict[locale];
                        for (const selector in l10nSelectorMap) {
                            const key = l10nSelectorMap[selector];
                            const text = dict[key];
                            if (!text) continue;
                            
                            const elements = document.querySelectorAll(selector);
                            elements.forEach(el => {
                                if (el.tagName === 'INPUT' || el.tagName === 'TEXTAREA') {
                                    el.placeholder = text;
                                } else if (el.tagName === 'OPTION') {
                                    el.text = text;
                                } else {
                                    el.innerHTML = text;
                                }
                            });
                        }
                        
                        if (desktopBtn) desktopBtn.setAttribute('data-lang', locale);
                        if (mobileBtn) mobileBtn.setAttribute('data-lang', locale);
                    }
                }
            }
        });

        // Initialize translations on load
        translatePage(currentLang);
    };

    // Run localization initialization
    initL10n();

});


