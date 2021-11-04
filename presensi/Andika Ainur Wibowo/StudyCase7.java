
import java.util.Scanner;
public class StudyCase7{
	public static void main(String[] args) {
		Scanner x= new Scanner(System.in);
		boolean ipk, prestasi, skill;
		System.out.println("Apakah Ipk Anda dia atas 3.5?");
		ipk= x.nextBoolean();
		if (ipk==true){
			System.out.println("Selamat anda Lulus");
		} else if (ipk==false){
		System.out.println("Apakah anda memiliki sertif Nasional?");
		prestasi= x.nextBoolean();
		System.out.println("Skill apa yang kamu miliki?");
		skill= x.nextBoolean();
		boolean kondisi = (ipk||prestasi)&&skill;
		String jawab=kondisi?"Selamat anda Lulus":"Coba Lagi";
		System.out.println("\n" + jawab);
		};

		}
	}


		
			
		
		

	
	
