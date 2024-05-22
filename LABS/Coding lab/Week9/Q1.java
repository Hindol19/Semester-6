package Week9;

public class Q1 {

    public static void primeFactors(int n) {

        while (n % 2 == 0) {
            System.out.print(2 + " ");
            n = n / 2;
        }

        for (int i = 3; i * i <= n; i = i + 2) {
            while (n % i == 0) {
                System.out.print(i + " ");
                n = n / i;
            }
        }

        if (n > 2) {
            System.out.print(n + " ");
        }
    }

    public static void main(String[] args) {

        // Check Test Cases:
        if (args.length != 1) {
            System.out.println("No arguments");
            return;
        }
        for (int i = 0; i < args[0].length(); i++) {
            if (!Character.isDigit(args[0].charAt(i))) {
                System.out.println("Characters other than integer!");
                return;
            }
        }
        int n = Integer.parseInt(args[0]);
        System.out.print("Prime factors of " + n + " are: ");
        primeFactors(n);
        System.out.println();
    }
}
