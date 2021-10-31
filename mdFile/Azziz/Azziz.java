public class Azziz{
	public static void main(String[]args){
		int i, j, b, k;
		for(i=0;i<10;i++){
			for(j=0;j<10;j++){
				System.out.print("* ");
				if((i+j)==9)break;
			}
			System.out.print("\n");
		}
	}
}