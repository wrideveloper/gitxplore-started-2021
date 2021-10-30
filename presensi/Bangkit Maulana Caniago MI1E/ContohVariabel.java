class ContohVariabel{
	public static void main(String[] args) {
		String hobi = "Bermain layangan";
		boolean pandai = true;
		char jenisKelamin = 'L';
		byte umur = 20;
		double ipk = 3.24 , tinggi = 1.78;
		System.out.println("Hobi saya : " + hobi);
		System.out.println("Apakah pandai? : " + pandai);
		System.out.println("Jenis kelamin : " + jenisKelamin);
		System.out.println("Umurku saat ini : " + umur);
		System.out.println(String.format("Saya Ber ipk %s, dengan tinggi badan %s",ipk, tinggi));
	}
}