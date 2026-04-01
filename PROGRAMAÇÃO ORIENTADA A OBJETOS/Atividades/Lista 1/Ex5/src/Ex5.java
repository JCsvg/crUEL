/*
 * Faca um programa que percorra todos os numeros de 1 a 100.
 * Para os numeros multiplos de 4, imprima a palavra "PI", e para os outros,
 * imprima o proprio numero.
 * */
public class Ex5 {

	public static void main(String[] args) {
		for (int i = 0; i < 100; i++) {
			if(i % 4 == 0) {
				System.out.println("PI");
			}else {
				System.out.println(i);
			}
		}

	}

}
