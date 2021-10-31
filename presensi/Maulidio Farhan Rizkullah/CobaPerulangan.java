import java.util.Scanner;

public class CobaPerulangan {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int pass, passB = 2019;

        System.out.print("Masukkan password");
        pass = sc.nextInt();

        for (; pass != passB;){
            System.out.print("masukkan ulang password : ");
            pass = sc.nextInt();

        }
        System.out.println("Password anda benar");
    }
    
}
