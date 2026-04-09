/* ===================================================
   LENORE — Shared Cart + WhatsApp Engine
   Include this in catalog.html, product.html, index.html
   =================================================== */

const WHATSAPP_NUMBER = '917025485733'; // ← CHANGE THIS to your real number

/* ── Cart State ── */
function getCart() {
    try { return JSON.parse(localStorage.getItem('lenore_cart') || '[]'); } 
    catch { return []; }
}
function saveCart(cart) {
    localStorage.setItem('lenore_cart', JSON.stringify(cart));
    updateCartUI();
}

/* ── Add to Cart ── */
function addToCart(id, name, price, image, category) {
    const cart = getCart();
    const existing = cart.find(i => i.id === id);
    if (existing) {
        existing.qty++;
    } else {
        cart.push({ id, name, price, image, category, qty: 1 });
    }
    saveCart(cart);
    showCartToast(name);
}

/* ── Remove from Cart ── */
function removeFromCart(id) {
    saveCart(getCart().filter(i => i.id !== id));
}

/* ── Update Qty ── */
function updateQty(id, delta) {
    const cart = getCart();
    const item = cart.find(i => i.id === id);
    if (item) {
        item.qty = Math.max(1, item.qty + delta);
        saveCart(cart);
    }
}

/* ── Clear Cart ── */
function clearCart() {
    localStorage.removeItem('lenore_cart');
    updateCartUI();
}

/* ── Update all UI ── */
function updateCartUI() {
    const cart = getCart();
    const total = cart.reduce((s, i) => s + i.qty, 0);

    /* Badge count */
    document.querySelectorAll('.cart-badge').forEach(el => {
        el.textContent = total;
        el.style.display = total > 0 ? 'flex' : 'none';
    });

    /* Drawer items */
    const list = document.getElementById('cartItemsList');
    const empty = document.getElementById('cartEmpty');
    const footer = document.getElementById('cartFooter');
    if (!list) return;

    if (cart.length === 0) {
        list.innerHTML = '';
        if (empty) empty.style.display = 'flex';
        if (footer) footer.style.display = 'none';
        return;
    }

    if (empty) empty.style.display = 'none';
    if (footer) footer.style.display = 'block';

    list.innerHTML = cart.map(item => `
        <div class="cart-item" data-id="${item.id}">
            <img src="${item.image}" alt="${item.name}" onerror="this.src='images/hero-faucet-steel.png'">
            <div class="cart-item-info">
                <div class="cart-item-name">${item.name}</div>
                <div class="cart-item-cat">${item.category}</div>
                <div class="cart-item-controls">
                    <button class="qty-btn" onclick="updateQty('${item.id}', -1)">−</button>
                    <span class="qty-val">${item.qty}</span>
                    <button class="qty-btn" onclick="updateQty('${item.id}', 1)">+</button>
                    <button class="remove-btn" onclick="removeFromCart('${item.id}')">
                        <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" width="14" height="14"><path d="M18 6L6 18M6 6l12 12"/></svg>
                    </button>
                </div>
            </div>
        </div>
    `).join('');
}

/* ── WhatsApp Order from Cart ── */
function orderCartViaWhatsapp() {
    const cart = getCart();
    if (!cart.length) return;
    let msg = '🛁 *LENORE — Order Enquiry*\n\n';
    msg += '*Selected Items:*\n';
    cart.forEach((item, i) => {
        msg += `${i+1}. *${item.name}* (${item.category}) × ${item.qty}\n`;
    });
    msg += '\nPlease assist me with pricing and availability. Thank you!';
    window.open(`https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(msg)}`, '_blank');
}

/* ── WhatsApp Order Single Product ── */
function orderProductViaWhatsapp(name, category) {
    const msg = `🛁 *LENORE — Product Enquiry*\n\nI am interested in:\n*${name}* (${category})\n\nPlease assist me with pricing and availability. Thank you!`;
    window.open(`https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(msg)}`, '_blank');
}

/* ── Toast Notification ── */
function showCartToast(name) {
    let toast = document.getElementById('cartToast');
    if (!toast) return;
    toast.textContent = `"${name}" added to cart`;
    toast.classList.add('show');
    setTimeout(() => toast.classList.remove('show'), 2500);
}

/* ── Cart Drawer Toggle ── */
function openCart() {
    const drawer = document.getElementById('cartDrawer');
    const overlay = document.getElementById('cartOverlay');
    if (drawer) drawer.classList.add('open');
    if (overlay) overlay.classList.add('open');
    document.body.style.overflow = 'hidden';
    updateCartUI();
}
function closeCart() {
    const drawer = document.getElementById('cartDrawer');
    const overlay = document.getElementById('cartOverlay');
    if (drawer) drawer.classList.remove('open');
    if (overlay) overlay.classList.remove('open');
    document.body.style.overflow = '';
}

/* ── Init on page load ── */
document.addEventListener('DOMContentLoaded', () => {
    updateCartUI();
});
