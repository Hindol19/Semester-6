package Week9;

import java.util.Scanner;
import java.util.Arrays;

public class Q2 {

    static void rotateAray(int[] ar, int n, int d) {

        d = d % n;
        int temp[] = new int[n];

        int k = 0;

        for (int i = d; i < n; i++) {
            temp[k] = ar[i];
            k++;
        }

        for (int i = 0; i < d; i++) {
            temp[k] = ar[i];
            k++;
        }

        for (int i = 0; i < n; i++) {
            ar[i] = temp[i];
        }

    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter length of array:");
        int n = sc.nextInt();

        int[] ar = new int[n];

        System.out.println("Enter Array");
        for (int i = 0; i < n; i++) {
            ar[i] = sc.nextInt();
        }

        System.out.println("Enter d:");
        int d = sc.nextInt();

        System.out.println("Original aray => " + Arrays.toString(ar));

        rotateAray(ar, n, d);

        System.out.println("Rotated aray => " + Arrays.toString(ar));

        sc.close();
    }
}
