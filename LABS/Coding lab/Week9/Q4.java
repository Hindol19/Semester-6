package Week9;

import java.util.*;

public class Q4 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter your String");
        String str = sc.nextLine();
        System.out.println("Enter the String to be replaced");
        String s1 = sc.nextLine();
        System.out.println("Enter the character u want to replace with");
        String s2 = sc.nextLine();

        str = str.replaceAll(s1, s2);
        System.out.println(str);
    }
}