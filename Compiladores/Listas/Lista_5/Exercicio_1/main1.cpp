#include <iostream>
#include <string>

using namespace std;

// Matriz de transição
// O valor 0 indica que não há transição válida (fim do token ou erro)
const int T[9][40] = {
         // +, -, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, e, a, b, c, d, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z, ERRO
   /*0*/ {  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
   /*1*/ {  3, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0 },
   /*2*/ {  0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0 },
   /*3*/ {  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
   /*4*/ {  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
   /*5*/ {  0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
   /*6*/ {  7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
   /*7*/ {  0, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
   /*8*/ {  0, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } 
};


int obter_coluna(char c) {
    if (c == '+') return 0;
    if (c == '-') return 1;
    if (c == '0') return 2;
    if (c == '1') return 3;
    if (c == '2') return 4;
    if (c == '3') return 5;
    if (c == '4') return 6;
    if (c == '5') return 7;
    if (c == '6') return 8;
    if (c == '7') return 9;
    if (c == '8') return 10;
    if (c == '9') return 11;
    if (c == 'e') return 12;
    if (c == 'a') return 13;
    if (c == 'b') return 14;
    if (c == 'c') return 15;
    if (c == 'd') return 16;
    if (c == 'f') return 17;
    if (c == 'g') return 18;
    if (c == 'h') return 19;
    if (c == 'i') return 20;
    if (c == 'j') return 21;
    if (c == 'k') return 22;
    if (c == 'l') return 23;
    if (c == 'm') return 24;
    if (c == 'n') return 25;
    if (c == 'o') return 26;
    if (c == 'p') return 27;
    if (c == 'q') return 28;
    if (c == 'r') return 29;
    if (c >= 's') return 30;
    if (c >= 't') return 31;
    if (c >= 's') return 32;
    if (c >= 'u') return 33;
    if (c >= 'v') return 34;
    if (c >= 'w') return 35;
    if (c >= 'x') return 36;
    if (c >= 'y') return 37;
    if (c >= 'z') return 38;
    return 39; 
}

bool eh_estado_final(int estado) {
    return (estado == 2 || estado == 3 || estado == 4 || estado == 5 || estado == 8);
}

int main() {
    char c;
    int estado = 1;
    string lexema = "";

    while (cin.get(c)) {
        
        if (c == '\n' || c == '\r') {
            if (estado != 1) { 
                if (eh_estado_final(estado)) cout << lexema << "\n";
                else cout << "ERRO\n";
                
                estado = 1; 
                lexema = "";
            }
            continue;
        }

        int col = obter_coluna(c);
        int proximo_estado = T[estado][col];

        if (proximo_estado == 0) {
            if (estado == 1) { 
                cout << "ERRO\n";
            } else {
                if (eh_estado_final(estado)) {
                    cout << lexema << "\n";
                } else {
                    cout << "ERRO\n";
                }
                cin.unget();
            }
            
            estado = 1;
            lexema = "";
        } else {
            estado = proximo_estado;
            lexema += c;
        }
    }

    if (estado != 1) {
        if (eh_estado_final(estado)) {
            cout << lexema << "\n";
        } else {
            cout << "ERRO\n";
        }
    }

    return 0;
}