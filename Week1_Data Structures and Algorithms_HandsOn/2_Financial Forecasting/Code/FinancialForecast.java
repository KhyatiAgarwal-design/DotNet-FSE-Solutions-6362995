public class FinancialForecast {

    // Recursive function to calculate future value
    public static double forecast(double presentValue, double rate, int years) {
        if (years == 0) return presentValue;
        return forecast(presentValue, rate, years - 1) * (1 + rate);
    }
    //Iterative Approach for Comparison
    public static double forecastIterative(double presentValue, double rate, int years) {
        for (int i = 0; i < years; i++) {
            presentValue *= (1 + rate);
        }
        return presentValue;
    }

    public static void main(String[] args) {
        double initialValue = 10000; 
        double growthRate = 0.08;     // 8% annual growth
        int years = 5;                // Forecast period

        double result = forecast(initialValue, growthRate, years);
        System.out.printf("Projected value after %d years: %.2f\n", years, result);

        double result2 = forecastIterative(initialValue, growthRate, years);
        System.out.printf("Iterative result: %.2f\n", result2);

    }
}


