using System;
using RetailInventory;
using RetailInventory.Models;

class Program
{
    static void Main(string[] args)
    {
        using var context = new AppDbContext();

        // Create the database and tables (if they don’t exist)
        context.Database.EnsureCreated();   // <<<<<<✅ Important line

        // Add a category
        var electronics = new Category { Name = "Electronics" };
        context.Categories.Add(electronics);
        context.SaveChanges();

        // Add a product
        var laptop = new Product
        {
            Name = "Laptop",
            Price = 50000,
            CategoryId = electronics.Id
        };
        context.Products.Add(laptop);
        context.SaveChanges();

        Console.WriteLine("Data saved successfully!");
    }
}
