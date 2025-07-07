using System;
using System.Threading.Tasks;

using RetailInventory.Models;

class Program
{
    static async Task Main(string[] args)
    {
        using var context = new AppDbContext();

        // Creating categories
        var electronics = new Category { Name = "Electronics" };
        var groceries = new Category { Name = "Groceries" };

        // Adding categories
        await context.Categories.AddRangeAsync(electronics, groceries);

        // Creating products with reference to categories
        var product1 = new Product { Name = "Laptop", Price = 75000, Category = electronics };
        var product2 = new Product { Name = "Rice Bag", Price = 1200, Category = groceries };

        // Adding products
        await context.Products.AddRangeAsync(product1, product2);

        // Saving all changes to DB
        await context.SaveChangesAsync();

        Console.WriteLine("Initial data inserted successfully!");
    }
}
