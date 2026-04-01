/*
 * Construa uma IMC (Indice de Massa Corpiral).
 * A formula do IMC e apresentada abaixo:
 * Peso (Kg) / Altura (metros)^2
 * */

import java.util.Scanner;

public class Ex9 {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		float peso, altura, imc;
		System.out.println("Informe o peso: ");
		peso = sc.nextFloat();
		System.out.println("informe a altura: ");
		altura = sc.nextFloat();
		imc = peso/(altura*altura);
		System.out.println("IMC: " + imc);

	}

}
