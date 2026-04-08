import re

def update_index():
    with open('index.html', 'r', encoding='utf-8') as f:
        content = f.read()

    # 1. Update HTML: Replace <img class="hero-bg"> with <video>
    old_hero_img = r'<img src="images/hero-faucet-steel\.png" alt="Luxury Steel Faucet" class="hero-bg">'
    new_hero_video = '''<video class="hero-bg" autoplay muted loop playsinline poster="images/hero-faucet-steel.png">
            <source src="images/hero-video.webm" type="video/webm">
            <source src="images/hero-video.mp4" type="video/mp4">
            <img src="images/hero-faucet-steel.png" alt="Fallback luxury faucet image">
        </video>'''
    content = re.sub(old_hero_img, new_hero_video, content)

    # 2. Update CSS: Add media queries for mobile hero & update CSS if needed
    # We will inject a block of CSS into the <style> right before </style>
    new_css = '''
        /* --- GSAP & HERO MOBILE UPDATES --- */
        @media screen and (max-width: 768px) {
            .hero::before {
                background: rgba(0, 0, 0, 0.65) !important;
            }
            .hero-bg {
                width: 100% !important;
                left: 0;
            }
            .hero .container {
                justify-content: center;
                text-align: center;
            }
            .hero-content {
                margin: 0 auto;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
        }
'''
    content = content.replace('    </style>', new_css + '    </style>')

    # 3. Update JS: Remove old parallax, Add GSAP CDNs + logic
    old_parallax = r'/\* ===== PARALLAX HERO IMAGE ===== \*/.*?(?=</script>)'
    
    gsap_cdns = '''<!-- GSAP -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js"></script>
'''

    new_gsap_js = '''/* ===== GSAP HERO ANIMATIONS ===== */
        gsap.registerPlugin(ScrollTrigger);

        let mm = gsap.matchMedia();

        // Load Animation (All Screens)
        gsap.fromTo(".hero-content", 
            { opacity: 0, y: 50 }, 
            { opacity: 1, y: 0, duration: 1.5, ease: "power2.out", delay: 0.2 }
        );

        mm.add("(min-width: 769px)", () => {
            // Desktop: Subtle parallax effect on scroll
            gsap.to(".hero-bg", {
                yPercent: 20,
                ease: "none",
                scrollTrigger: {
                    trigger: ".hero",
                    start: "top top",
                    end: "bottom top",
                    scrub: 1
                }
            });
        });

        mm.add("(max-width: 768px)", () => {
            // Mobile: Slow zoom in animation + Parallax override
            gsap.fromTo(".hero-bg", 
                { scale: 1 },
                { 
                    scale: 1.1,
                    ease: "none",
                    scrollTrigger: {
                        trigger: ".hero",
                        start: "top top",
                        end: "bottom top",
                        scrub: 1
                    }
                }
            );
        });
    '''

    content = re.sub(old_parallax, new_gsap_js, content, flags=re.DOTALL)
    content = content.replace('</body>', gsap_cdns + '</body>')

    with open('index.html', 'w', encoding='utf-8') as f:
        f.write(content)

if __name__ == '__main__':
    update_index()
