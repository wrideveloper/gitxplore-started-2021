public class Mahasiswa07 {
	
	public static void main (String[] args){
		String kampus 			= "Polinema";
		int tingkat 			= 1;
		char kelas				= 'B';
		int bilanganBulat		= 10;
		float bilanganPecahan	= 3.33333F;
		char karakter			= 'C';
		
		System.out.println("Saya Mahasiswa " + kampus + " Kelas " + kelas);
		System.out.println("Saya sedang belajar menampilkan : ");
		System.out.println("Bilangan Bulat " + bilanganBulat);
		System.out.println(String.format("Bilangan Pecahan %.2f", bilanganPecahan));
		System.out.println("Karakter " + karakter);
		
	}
}