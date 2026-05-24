/* -------------------------------------------------------------
 * NALLAM FARMS PREMIUM BUSINESS JAVASCRIPT
 * Custom logic for high-end interactions, reveals, carousel, and lightbox
 * ------------------------------------------------------------- */

document.addEventListener('DOMContentLoaded', () => {

    /* ==========================================
       0. EMAILJS INITIALIZATION
       ========================================== */
    // Initialize EmailJS with your public key
    // Get your public key from https://dashboard.emailjs.com/
    emailjs.init("CR_ByoZ6vz4ZxQ-3j");

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
            
            // Collect Form Values
            const name = document.getElementById('full-name').value;
            const email = document.getElementById('email').value;
            const phone = document.getElementById('phone').value;
            const type = document.getElementById('inquiry-type').value;
            const message = document.getElementById('message').value;
            
            console.log('Nallam Farms Form Submission:', { name, email, phone, type, message });
            
            // Show loading state
            const submitBtn = document.getElementById('form-submit-btn');
            submitBtn.textContent = 'Sending Inquiry...';
            submitBtn.disabled = true;
            submitBtn.style.opacity = '0.7';
            
            // Send email via EmailJS
            emailjs.send(
                'service_rdy6q9h',      // Replace with your EmailJS Service ID
                'template_vj5ij5x',     // Replace with your EmailJS Template ID
                {
                    to_email: 'nallamfarms@gmail.com',
                    from_name: name,
                    from_email: email,
                    phone_number: phone,
                    inquiry_type: type,
                    message: message
                }
            ).then(
                function(response) {
                    console.log('Email sent successfully!', response);
                    
                    // Show success message
                    inquiryForm.style.display = 'none';
                    formSuccessAlert.style.display = 'flex';
                    
                    // Reset button state
                    submitBtn.textContent = 'Send Message';
                    submitBtn.disabled = false;
                    submitBtn.style.opacity = '';
                },
                function(error) {
                    console.error('Failed to send email:', error);
                    alert('Sorry, there was an error sending your inquiry. Please try again.');
                    
                    // Reset button state on error
                    submitBtn.textContent = 'Send Message';
                    submitBtn.disabled = false;
                    submitBtn.style.opacity = '';
                }
            );
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

});
