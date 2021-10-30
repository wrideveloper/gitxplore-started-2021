import java.util.Scanner;
public class ngoding {
public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("batas bilangan: ");
        int angka = sc.nextInt();
        int awal=1;

        for (int i = 1, spasi=0; awal <=angka ; i++) {
            System.out.print(awal+" ");
            awal+=i;
            i++;
            spasi++;
            if(spasi%10==0){
                System.out.println("");
            }
	System.out.print("");
        }
}}

