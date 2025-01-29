document.addEventListener("DOMContentLoaded", () => {
    const categoryFilter = document.getElementById("category-filter");
    const productCheckboxes = document.querySelectorAll(".product-checkbox");
    const productItems = document.querySelectorAll(".product-item");
    const totalPriceField = document.getElementById("total-price");

    // Update the total price when products are selected
    const updateTotalPrice = () => {
        let total = 0;
        productCheckboxes.forEach((checkbox) => {
            if (checkbox.checked) {
                total += parseFloat(checkbox.dataset.price);
            }
        });
        totalPriceField.value = `$${total.toFixed(2)}`;
    };

    // Filter products by category
    const filterProducts = () => {
        const selectedCategory = categoryFilter.value;
        productItems.forEach((item) => {
            if (selectedCategory === "" || item.dataset.categoryId === selectedCategory) {
                item.style.display = "block";
            } else {
                item.style.display = "none";
            }
        });
    };

    // Attach event listeners
    productCheckboxes.forEach((checkbox) => checkbox.addEventListener("change", updateTotalPrice));
    categoryFilter.addEventListener("change", filterProducts);

    // Initialize total price
    updateTotalPrice();
});
