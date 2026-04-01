/* Faca um programa que percorra todos os numeros de 1 a 100.
 * Para os numeros impares, deve ser impresso um "*",
 * e para os numeros pares, devem ser impressos dois "**"
 * */
public class Ex4 {

	public static void main(String[] args) {
		for (int i = 0; i < 100; i++) {
			if(i%2 == 0) {
				System.out.println(i + ": *");
			}else{
				System.out.println(i + ": **");
			}
		}

	}

}
