/* Faca um programa que imprima na tela o seu nome n vezes.
 * Tanto o seu nome como o valor de n devem serlidos do teclado.
 * */

import java.util.Scanner;

public class Ex3 {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n;
		String nome = new String();
		System.out.println("Informe seu nome: ");
		nome = sc.nextLine();
		System.out.println("Informe quantas vezes deseja que seu nome seja repetido: ");
		n = sc.nextInt();
		for(int i = 0; i < n; i++) {
			System.out.println(nome);
		}
		sc.close();
	}

}
