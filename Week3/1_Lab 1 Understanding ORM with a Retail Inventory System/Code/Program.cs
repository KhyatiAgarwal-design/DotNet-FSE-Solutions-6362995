using System;

namespace RetailInventory
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Retail Inventory System Starting...");

            using var context = new RetailContext();
            context.Database.EnsureCreated(); // Auto-create DB if not exists

            Console.WriteLine("Database created successfully.");
        }
    }
}
