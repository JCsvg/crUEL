/*
 * Crie um programa que receba como entrada um valor n e responda na saida o valor da n-esima posicao de Fibonacci
 * */

import java.util.Scanner;

public class Ex8 {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n, sum = 0, n1 = 1, n2 = 1;
		System.out.println("Informe a posicao da sequencia de fibonacci: ");
		n = sc.nextInt();
		for (int i = 0; i < n; i++) {
			if(i == 0 || i == 1) {
				System.out.println("1");
			}else {
				sum = n1 + n2;
				System.out.println(sum);
				n1 = n2;
				n2 = sum;
			}
		}
		sc.close();

	}

}
