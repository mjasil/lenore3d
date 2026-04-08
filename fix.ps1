$catalogPath = "catalog.html"
$productPath = "product.html"

# Fix catalog.html
$c = Get-Content $catalogPath -Raw
$pattern = '(?s)<!-- ===== HERO SECTION ===== -->.*?<!-- ===== FOOTER ===== -->'
$replacement = @"
<!-- ===== CATALOG HERO ===== -->
    <section class="catalog-hero" id="hero">
        <div class="container">
            <h1 class="catalog-title fade-in">Collections</h1>
            <p class="catalog-desc fade-in" style="transition-delay:0.15s">Explore our distinct collections of luxurious sanitary ware—crafted to elevate your everyday routines into a timeless ritual.</p>
            
            <div class="catalog-filters fade-in" style="transition-delay:0.3s">
                <button class="filter-btn active">All</button>
                <button class="filter-btn">Faucets</button>
                <button class="filter-btn">Showers</button>
                <button class="filter-btn">Hygiene</button>
            </div>
        </div>
    </section>

    <!-- ===== CATALOG GRID ===== -->
    <section class="catalog-main" id="catalog">
        <div class="container">
            <div class="catalog-grid">
                <!-- Product 1 -->
                <div class="gallery-card fade-in">
                    <img src="images/gallery-faucet-steel.png" alt="Onyx Brushed Steel Faucet">
                    <div class="gallery-card-overlay">
                        <h3 class="gallery-card-title">Onyx Edition</h3>
                        <p style="color:#aaa; font-size:12px; margin-bottom:12px;">Faucets</p>
                        <a href="product.html" class="gallery-card-link">
                            View Details
                            <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M17 8l4 4m0 0l-4 4m4-4H3"/></svg>
                        </a>
                    </div>
                </div>
                <!-- Product 2 -->
                <div class="gallery-card fade-in" style="transition-delay:0.1s">
                    <img src="images/gallery-shower-steel.png" alt="Aura Rain Shower">
                    <div class="gallery-card-overlay">
                        <h3 class="gallery-card-title">Aura Rain System</h3>
                        <p style="color:#aaa; font-size:12px; margin-bottom:12px;">Showers</p>
                        <a href="product.html" class="gallery-card-link">
                            View Details
                            <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M17 8l4 4m0 0l-4 4m4-4H3"/></svg>
                        </a>
                    </div>
                </div>
                <!-- Product 3 -->
                <div class="gallery-card fade-in" style="transition-delay:0.2s">
                    <img src="images/gallery-hygiene-steel.png" alt="Eclipse Hygiene System">
                    <div class="gallery-card-overlay">
                        <h3 class="gallery-card-title">Eclipse Hygiene</h3>
                        <p style="color:#aaa; font-size:12px; margin-bottom:12px;">Hygiene</p>
                        <a href="product.html" class="gallery-card-link">
                            View Details
                            <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M17 8l4 4m0 0l-4 4m4-4H3"/></svg>
                        </a>
                    </div>
                </div>
                <!-- Product 4 -->
                <div class="gallery-card fade-in" style="transition-delay:0.3s">
                    <img src="images/heritage-steel.png" alt="Heritage Faucet">
                    <div class="gallery-card-overlay">
                        <h3 class="gallery-card-title">Heritage Classic</h3>
                        <p style="color:#aaa; font-size:12px; margin-bottom:12px;">Faucets</p>
                        <a href="product.html" class="gallery-card-link">
                            View Details
                            <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M17 8l4 4m0 0l-4 4m4-4H3"/></svg>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- ===== FOOTER ===== -->
"@
$c = [regex]::Replace($c, $pattern, $replacement)
Set-Content -Path $catalogPath -Value $c

# Fix product.html
$p = Get-Content $productPath -Raw
$pReplacement = @"
<!-- ===== PRODUCT HERO ===== -->
    <section class="product-presentation" id="hero" style="padding: 140px 0 80px; background:#0a0a0a;">
        <div class="container">
            <div style="display:flex; gap:60px; align-items:center; flex-wrap:wrap;">
                
                <div style="flex:1; min-width:300px;" class="fade-in-left">
                    <img src="images/hero-faucet-steel.png" alt="Onyx Brushed Steel Faucet" style="width:100%; border:1px solid rgba(184,150,46,0.15);">
                    <div style="display:flex; gap:12px; margin-top:16px;">
                        <img src="images/gallery-faucet-steel.png" style="width:80px; height:80px; object-fit:cover; border:1px solid rgba(184,150,46,0.4); cursor:pointer;">
                    </div>
                </div>

                <div style="flex:1; min-width:300px;" class="fade-in-right">
                    <div style="color:#b8962e; font-size:12px; font-weight:700; letter-spacing:2px; text-transform:uppercase; margin-bottom:12px;">Faucets Collection</div>
                    <h1 style="font-size:clamp(32px, 4vw, 48px); font-weight:600; font-family:'Playfair Display', serif; margin-bottom:24px;">Onyx Edition Faucet</h1>
                    
                    <p style="color:#888; line-height:1.8; margin-bottom:32px; font-size:15px;">A stunning embodiment of contemporary design. The Onyx Edition in Brushed Steel offers a sophisticated silhouette paired with cutting-edge water flow engineering, establishing the ultimate sanctuary experience.</p>
                    
                    <div style="border-top:1px solid rgba(184,150,46,0.1); border-bottom:1px solid rgba(184,150,46,0.1); padding:24px 0; margin-bottom:40px;">
                        <div style="display:flex; justify-content:space-between; margin-bottom:12px;">
                            <span style="color:#666;">Finish</span>
                            <span style="color:#fff; font-weight:700;">Brushed Steel</span>
                        </div>
                        <div style="display:flex; justify-content:space-between; margin-bottom:12px;">
                            <span style="color:#666;">Installation</span>
                            <span style="color:#fff; font-weight:700;">Deck Mounted</span>
                        </div>
                        <div style="display:flex; justify-content:space-between;">
                            <span style="color:#666;">Warranty</span>
                            <span style="color:#fff; font-weight:700;">10 Years</span>
                        </div>
                    </div>

                    <div style="display:flex; gap:16px; flex-wrap:wrap;">
                        <a href="https://wa.me/919800000000" target="_blank" class="btn-whatsapp" style="flex:1; justify-content:center;">Chat on WhatsApp</a>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <div class="section-divider"></div>

    <section class="whatsapp" id="whatsapp">
        <div class="container">
            <h2 class="whatsapp-title fade-in">Have Custom Requirements?</h2>
            <div class="whatsapp-actions fade-in" style="transition-delay:0.25s">
                <a href="https://wa.me/919800000000" target="_blank" class="btn-whatsapp">Chat on WhatsApp</a>
            </div>
        </div>
    </section>
    
    <!-- ===== FOOTER ===== -->
"@
$p = [regex]::Replace($p, $pattern, $pReplacement)
Set-Content -Path $productPath -Value $p

Write-Host "Replacement Complete!"
