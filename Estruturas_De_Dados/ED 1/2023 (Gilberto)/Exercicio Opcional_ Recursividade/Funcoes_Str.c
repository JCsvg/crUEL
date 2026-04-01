#include <stdio.h>


int strlen_recursiva(const char *str) {
    
    if (*str == '\0') {
        return 0;
    }

    return 1 + strlen_recursiva(str + 1);
}


int strcmp_recursiva(const char *str1, const char *str2) {
    
    if (*str1 == '\0' && *str2 == '\0') {
        return 0;
    } else if (*str1 == *str2) {
        
        return strcmp_recursiva(str1 + 1, str2 + 1);
    } else {
       
        return *str1 - *str2;
    }
}

const char *strchr_recursiva(const char *str, char ch) {
    
    if (*str == '\0' || *str == ch) {
        return (*str == ch) ? str : NULL;
    }

   
    return strchr_recursiva(str + 1, ch);
}

int main() {
    

    const char *exemplo1 = "Hello, World!";
    printf("strlen: %d\n", strlen_recursiva(exemplo1));

    const char *exemplo2 = "abc";
    const char *exemplo3 = "abcd";
    printf("strcmp: %d\n", strcmp_recursiva(exemplo2, exemplo3));

    
    const char *exemplo4 = "This is a test";
    char caracterProcurado = 'a';
    const char *resultado = strchr_recursiva(exemplo4, caracterProcurado);
    if (resultado != NULL) {
        printf("strchr: O caractere '%c' foi encontrado na posição %ld\n", caracterProcurado, resultado - exemplo4);
    } else {
        printf("strchr: O caractere '%c' não foi encontrado na string.\n", caracterProcurado);
    }

    return 0;
}
