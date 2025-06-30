public class Main {
    public static void main(String[] args) {
        Product[] catalog = {
            new Product(101, "Shoes", "Footwear"),
            new Product(102, "T-shirt", "Clothing"),
            new Product(103, "Laptop", "Electronics"),
            new Product(104, "Watch", "Accessories")
        };

        // Linear Search
        Product result1 = SearchUtility.linearSearch(catalog, "Watch");
        System.out.println("Linear Search: " + (result1 != null ? result1 : "Not Found"));

        // Sort for Binary Search
        SearchUtility.sortProducts(catalog);

        // Binary Search
        Product result2 = SearchUtility.binarySearch(catalog, "Laptop");
        System.out.println("Binary Search: " + (result2 != null ? result2 : "Not Found"));
    }
}
