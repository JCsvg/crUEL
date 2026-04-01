#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

// Definir a estrutura da fila
struct Queue {
    int frente, tras, tamanho;
    unsigned capacidade;
    char* array;
};

// Função para criar uma nova fila
struct Queue* createQueue(unsigned capacidade) {
    struct Queue* queue = (struct Queue*)malloc(sizeof(struct Queue));
    queue->capacidade = capacidade;
    queue->frente = queue->tamanho = 0;
    queue->tras = capacidade - 1;
    queue->array = (char*)malloc(queue->capacidade * sizeof(char));
    return queue;
}

// Função para verificar se a fila está cheia
bool isFull(struct Queue* queue) {
    return (queue->tamanho == queue->capacidade);
}

// Função para verificar se a fila está vazia
bool isEmpty(struct Queue* queue) {
    return (queue->tamanho == 0);
}

// Função para enfileirar um caractere
void enqueue(struct Queue* queue, char item) {
    if (isFull(queue)) {
        printf("A fila está cheia.\n");
        return;
    }
    queue->tras = (queue->tras + 1) % queue->capacidade;
    queue->array[queue->tras] = item;
    queue->tamanho++;
}

// Função para desenfileirar um caractere
char dequeue(struct Queue* queue) {
    if (isEmpty(queue)) {
        printf("A fila está vazia.\n");
        return '\0';
    }
    char item = queue->array[queue->frente];
    queue->frente = (queue->frente + 1) % queue->capacidade;
    queue->tamanho--;
    return item;
}

// Função para verificar se os caracteres de abertura e fechamento coincidem
bool arePair(char opening, char closing) {
    if (opening == '(' && closing == ')')
        return true;
    if (opening == '[' && closing == ']')
        return true;
    if (opening == '{' && closing == '}')
        return true;
    return false;
}

// Função para verificar se a equação está bem formada
bool isBalanced(char* equation) {
    int len = strlen(equation);
    struct Queue* queue = createQueue(len);

    for (int i = 0; i < len; i++) {
        if (equation[i] == '(' || equation[i] == '[' || equation[i] == '{') {
            enqueue(queue, equation[i]);
        } else if (equation[i] == ')' || equation[i] == ']' || equation[i] == '}') {
            if (isEmpty(queue) || !arePair(dequeue(queue), equation[i])) {
                free(queue->array);
                free(queue);
                return false; // A equação não está bem formada
            }
        }
    }

    // Se a fila estiver vazia, a equação está bem formada
    bool result = isEmpty(queue);
    free(queue->array);
    free(queue);
    return result;
}

int main() {
    char equation[100];

    printf("Digite uma equação: ");
    scanf("%s", equation);

    if (isBalanced(equation)) {
        printf("A equação está bem formada.\n");
    } else {
        printf("A equação não está bem formada.\n");
    }

    return 0;
}
