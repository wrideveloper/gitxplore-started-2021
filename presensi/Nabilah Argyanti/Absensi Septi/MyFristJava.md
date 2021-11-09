import java.util.Scanner;

public class Gaji{
	public static void main(String[] args){
		Scanner sc = new Scanner(System.in);
		long gajiPokok, komisi;
		int persen = 15 / 100;
		long gaji;
		
		System.out.print("Masukkan gaji pokok: ");
		gajiPokok = sc.nextInt();
		
		komisi = gajiPokok * persen;
		gaji = gajiPokok + komisi;
		System.out.println("Gaji yang diterima pak Budi sejumlah " + gaji);
	}
}