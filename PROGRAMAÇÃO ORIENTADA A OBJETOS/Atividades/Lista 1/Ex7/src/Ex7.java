/*
 * Faca um programa que leia varios triangulos de "*".
 * O numero de niveis do triangulo e a quantidade de triangulos devem ser lidos do teclado.
 * Veja um exemplo abaixo com dois triangulos de tres niveis cada:
 * 
 * *
 * **
 * ***
 * *
 * **
 * ***
 * */

import java.util.Scanner;
public class Ex7 {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n, m;
		System.out.println("informe a quantidade de triangulos: ");
		n = sc.nextInt();
		System.out.println("informe a quantidade de niveis: ");
		m = sc.nextInt();
		for (int i = 0; i <= n; i++) {
			for (int j = 0; j <= m; j++) {
				for (int k = 0; k <= j; k++) {
					System.out.print("*");
				}
				System.out.print("\n");
			}
			System.out.print("\n");
		}
		sc.close();

	}

}
