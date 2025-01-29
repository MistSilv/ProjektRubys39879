document.addEventListener("DOMContentLoaded", () => {
    const categoryFilter = document.getElementById("category-filter");
    const productCheckboxes = document.querySelectorAll(".product-checkbox");
    const productItems = document.querySelectorAll(".product-item");
    const totalPriceField = document.getElementById("total-price");

    // Update total price
    const updateTotalPrice = () => {
        let total = 0;
        productCheckboxes.forEach((checkbox) => {
            if (checkbox.checked) {
                const quantity = parseInt(checkbox.closest(".product-item").querySelector(".quantity-input").value);
                total += parseFloat(checkbox.dataset.price) * quantity;
            }
        });
        totalPriceField.value = `$${total.toFixed(2)}`;
    };

    // Enable/disable quantity input
    productCheckboxes.forEach((checkbox) => {
        checkbox.addEventListener("change", (event) => {
            const quantityInput = event.target.closest(".product-item").querySelector(".quantity-input");
            quantityInput.disabled = !event.target.checked;
            if (!event.target.checked) {
                quantityInput.value = 1; // Reset quantity when unchecked
            }
            updateTotalPrice();
        });
    });

    // Update total price when quantity changes
    document.querySelectorAll(".quantity-input").forEach((input) => {
        input.addEventListener("input", updateTotalPrice);
    });

    // Filter products by category
    categoryFilter.addEventListener("change", () => {
        const selectedCategory = categoryFilter.value;
        productItems.forEach((item) => {
            if (selectedCategory === "" || item.dataset.categoryId === selectedCategory) {
                item.style.display = "block";
            } else {
                item.style.display = "none";
            }
        });
    });

    // Initialize total price
    updateTotalPrice();
});
