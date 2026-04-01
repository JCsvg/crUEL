/******************************************************************************

                            Online C Compiler.
                Code, Compile, Run and Debug C program online.
Write your code in this editor and press "Run" button to compile and execute it.

*******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Definir a estrutura da pilha
struct Stack {
    int top;
    unsigned capacity;
    char* array;
};

// Função para criar uma nova pilha
struct Stack* createStack(unsigned capacity) {
    struct Stack* stack = (struct Stack*)malloc(sizeof(struct Stack));
    stack->capacity = capacity;
    stack->top = -1;
    stack->array = (char*)malloc(stack->capacity * sizeof(char));
    return stack;
}

// Função para verificar se a pilha está cheia
int isFull(struct Stack* stack) {
    return stack->top == stack->capacity - 1;
}

// Função para verificar se a pilha está vazia
int isEmpty(struct Stack* stack) {
    return stack->top == -1;
}

// Função para empilhar um caractere na pilha
void push(struct Stack* stack, char item) {
    if (isFull(stack)) {
        printf("A pilha está cheia.\n");
        return;
    }
    stack->array[++stack->top] = item;
}

// Função para desempilhar um caractere da pilha
char pop(struct Stack* stack) {
    if (isEmpty(stack)) {
        printf("A pilha está vazia.\n");
        return '\0';
    }
    return stack->array[stack->top--];
}

// Função para inverter uma string usando uma pilha
void reverseString(char* str) {
    int len = strlen(str);
    struct Stack* stack = createStack(len);

    // Empilhar os caracteres da string
    for (int i = 0; i < len; i++) {
        push(stack, str[i]);
    }

    // Desempilhar os caracteres para inverter a string
    for (int i = 0; i < len; i++) {
        str[i] = pop(stack);
    }

    free(stack->array);
    free(stack);
}

int main() {
    char input[100];
    
    printf("Digite uma string: ");
    scanf("%s", input);

    reverseString(input);

    printf("String invertida: %s\n", input);

    return 0;
}
