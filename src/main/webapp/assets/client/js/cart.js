/**
 * Cart Management using localStorage
 */
const CartManager = {
    STORAGE_KEY: 'shopping_cart',
    
    /**
     * Get all cart items from localStorage
     */
    getCart: function() {
        try {
            const cartData = localStorage.getItem(this.STORAGE_KEY);
            return cartData ? JSON.parse(cartData) : {};
        } catch (e) {
            console.error('Error reading cart from localStorage:', e);
            return {};
        }
    },
    
    /**
     * Save cart to localStorage
     */
    saveCart: function(cart) {
        try {
            localStorage.setItem(this.STORAGE_KEY, JSON.stringify(cart));
            this.updateCartDisplay();
            return true;
        } catch (e) {
            console.error('Error saving cart to localStorage:', e);
            return false;
        }
    },
    
    /**
     * Add product to cart
     * @param {Object} product - Product object with id, name, price, image_url, slug
     * @param {number} quantity - Quantity to add (default: 1)
     */
    addToCart: function(product, quantity = 1) {
        if (!product || !product.id) {
            console.error('Invalid product data');
            return false;
        }
        
        const cart = this.getCart();
        const productId = product.id.toString();
        
        if (cart[productId]) {
            // Product already in cart, update quantity
            cart[productId].quantity += quantity;
        } else {
            // New product, add to cart
            cart[productId] = {
                id: product.id,
                name: product.name || '',
                price: product.price || 0,
                image_url: product.image_url || '',
                slug: product.slug || '',
                quantity: quantity
            };
        }
        
        // Ensure quantity is positive
        if (cart[productId].quantity <= 0) {
            cart[productId].quantity = 1;
        }
        
        return this.saveCart(cart);
    },
    
    /**
     * Remove product from cart
     */
    removeFromCart: function(productId) {
        const cart = this.getCart();
        delete cart[productId.toString()];
        return this.saveCart(cart);
    },
    
    /**
     * Update product quantity in cart
     */
    updateQuantity: function(productId, quantity) {
        if (quantity <= 0) {
            return this.removeFromCart(productId);
        }
        
        const cart = this.getCart();
        const id = productId.toString();
        
        if (cart[id]) {
            cart[id].quantity = quantity;
            return this.saveCart(cart);
        }
        
        return false;
    },
    
    /**
     * Get total quantity of items in cart
     */
    getTotalQuantity: function() {
        const cart = this.getCart();
        let total = 0;
        for (let productId in cart) {
            if (cart.hasOwnProperty(productId)) {
                total += cart[productId].quantity || 0;
            }
        }
        return total;
    },
    
    /**
     * Get subtotal of cart
     */
    getSubtotal: function() {
        const cart = this.getCart();
        let subtotal = 0;
        for (let productId in cart) {
            if (cart.hasOwnProperty(productId)) {
                const item = cart[productId];
                subtotal += (item.price || 0) * (item.quantity || 0);
            }
        }
        return subtotal;
    },
    
    /**
     * Clear entire cart
     */
    clearCart: function() {
        localStorage.removeItem(this.STORAGE_KEY);
        this.updateCartDisplay();
    },
    
    /**
     * Get all cart items as array
     */
    getCartItems: function() {
        const cart = this.getCart();
        return Object.values(cart);
    },
    
    /**
     * Update cart display in header
     */
    updateCartDisplay: function() {
        const cart = this.getCart();
        const cartItems = this.getCartItems();
        const totalQuantity = this.getTotalQuantity();
        const subtotal = this.getSubtotal();
        
        // Update cart badge
        const cartBadge = document.querySelector('.shopping-cart span');
        if (cartBadge) {
            cartBadge.textContent = totalQuantity;
        }
        
        // Update cart menu
        const cartProducts = document.querySelector('.cart-products');
        if (cartProducts) {
            if (cartItems.length === 0) {
                cartProducts.innerHTML = '<div class="product"><p style="text-align: center; padding: 20px;">Giỏ hàng của bạn đang trống.</p></div>';
            } else {
                let html = '';
                // Get context path from global variable or calculate
                let contextPath = window.APP_CONTEXT_PATH || '';
                if (!contextPath) {
                    // Fallback: calculate from current path
                    const pathParts = window.location.pathname.split('/').filter(p => p);
                    if (pathParts.length > 0 && pathParts[0] !== '') {
                        contextPath = '/' + pathParts[0];
                    }
                }
                
                cartItems.forEach(item => {
                    let productImage = item.image_url || '';
                    if (!productImage || productImage === '') {
                        productImage = contextPath + '/assets/client/images/shop/cart-4.png';
                    } else if (productImage.startsWith('http')) {
                        // Already full URL
                    } else if (productImage.startsWith('/')) {
                        productImage = contextPath + productImage;
                    } else {
                        productImage = contextPath + '/' + productImage;
                    }
                    
                    const productLink = item.slug 
                        ? contextPath + '/product?slug=' + item.slug
                        : contextPath + '/product?id=' + item.id;
                    
                    const price = this.formatCurrency(item.price || 0);
                    
                    html += '';
                    html += '<div class="product">';
                    html += '<figure class="image-box">';
                    html += '<a href="' + productLink + '">';
                    html += '<img src="' + productImage + '" alt="'+ item.name +'">';
                    html += '</a>';
                    html += '</figure>';
                    html += '<h5><a href="' + productLink + '">'+ item.name +'</a></h5>';
                    html += '<span>'+ price +' <span class="quentity">x '+ item.quantity +'</span></span>';
                    html += '<button type="button" class="remove-btn" data-product-id="'+ item.id +'">';
                    html += '<i class="icon-9"></i>';
                    html += '</button>';
                    html += '</div>';
                });
                
                cartProducts.innerHTML = html;
            }
        }
        
        // Update cart total
        const cartTotalPrice = document.querySelector('.cart-total-price');
        if (cartTotalPrice) {
            cartTotalPrice.textContent = this.formatCurrency(subtotal);
        }
        
        // Update checkout button
        const checkoutBtn = document.querySelector('.cart-action .btn-one');
        if (checkoutBtn) {
            let contextPath = window.APP_CONTEXT_PATH || '';
            if (!contextPath) {
                const pathParts = window.location.pathname.split('/').filter(p => p);
                if (pathParts.length > 0 && pathParts[0] !== '') {
                    contextPath = '/' + pathParts[0];
                }
            }
            
            if (cartItems.length === 0) {
                checkoutBtn.style.opacity = '0.5';
                checkoutBtn.style.cursor = 'not-allowed';
                checkoutBtn.href = contextPath + '/cart';
            } else {
                checkoutBtn.style.opacity = '1';
                checkoutBtn.style.cursor = 'pointer';
                checkoutBtn.href = contextPath + '/checkout';
            }
        }
    },
    
    /**
     * Format currency to Vietnamese format
     */
    formatCurrency: function(amount) {
        return new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        }).format(amount);
    },
    
    /**
     * Sync cart from localStorage to server session
     */
    syncToServer: function(callback) {
        try {
            const cartItems = this.getCartItems();
            if (cartItems.length === 0) {
                if (callback) {
                    try {
                        callback(true);
                    } catch (e) {
                        console.error('Error in sync callback:', e);
                    }
                }
                return;
            }
            
            // Get context path
            let contextPath = window.APP_CONTEXT_PATH || '';
            if (!contextPath) {
                const pathParts = window.location.pathname.split('/').filter(p => p);
                if (pathParts.length > 0 && pathParts[0] !== '') {
                    contextPath = '/' + pathParts[0];
                }
            }
            
            // Prepare data
            const data = {
                items: cartItems.map(item => ({
                    id: item.id,
                    quantity: item.quantity
                }))
            };
            
            // Send AJAX request with URL-encoded form data
            const params = new URLSearchParams();
            params.append('action', 'sync');
            params.append('cartData', JSON.stringify(data));
            
            fetch(contextPath + '/cart', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: params.toString()
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('HTTP error! status: ' + response.status);
                }
                return response.json();
            })
            .then(result => {
                if (result && result.success) {
                    console.log('Cart synced to server:', result.itemCount, 'items');
                    if (callback) {
                        try {
                            callback(true);
                        } catch (e) {
                            console.error('Error in sync callback:', e);
                        }
                    }
                } else {
                    console.error('Failed to sync cart:', result ? result.message : 'Unknown error');
                    if (callback) {
                        try {
                            callback(false);
                        } catch (e) {
                            console.error('Error in sync callback:', e);
                        }
                    }
                }
            })
            .catch(error => {
                console.error('Error syncing cart:', error);
                if (callback) {
                    try {
                        callback(false);
                    } catch (e) {
                        console.error('Error in sync callback:', e);
                    }
                }
            });
        } catch (error) {
            console.error('Error in syncToServer:', error);
            if (callback) {
                try {
                    callback(false);
                } catch (e) {
                    console.error('Error in sync callback:', e);
                }
            }
        }
    }
};

// Initialize cart display when page loads
document.addEventListener('DOMContentLoaded', function() {
    CartManager.updateCartDisplay();
});

// Listen for storage events to sync across tabs
window.addEventListener('storage', function(e) {
    if (e.key === CartManager.STORAGE_KEY) {
        CartManager.updateCartDisplay();
    }
});

