#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdbool.h>
#include "pilha.h"

typedef struct solution
{
    int x, y;
} solution;

void print(int z, int maze[z][z])
{
    system("clear || cls");
    for (int i = 0; i < z; i++)
    {
        for (int j = 0; j < z; j++)
        {
            if (maze[i][j] == 0 )
            {
                printf("  ");
            }

            if (maze[i][j] == 1)
            {
                printf("# ");
            }

            if (maze[i][j] == 2)
            {
                printf("o ");
            }

            if (maze[i][j] == 3)
            {
                printf("@ ");
            }

            if (maze[i][j] == 4)
            {
                printf(". ");
            }
        }
        printf("\n");
    }
    system("sleep 0.2 || Start-Sleep -Seconds 0.2 || timeout /t 0.2 || sleep 0.2");
}

// backtracking para encontrar o caminho no labirinto
bool solveMaze(int z, solution solve, int maze[z][z], int x, int y, bool memo[z][z], Pilha *theWay)
{
    int a, b;
    // encerra a recursão
    if (solve.x == x && solve.y == y)
    {
        return true;
    }
    else if (maze[solve.x - 1][solve.y] == 0 || maze[solve.x - 1][solve.y] == 3 && memo[solve.x - 1][solve.y] == false)
    {
        push(theWay, solve.x, solve.y);
        maze[solve.x][solve.y] = 4;
        memo[solve.x][solve.y] = true;
        maze[solve.x - 1][solve.y] = 2;
        solve.x--;
        push(theWay, solve.x, solve.y);
        print(z, maze);
        return solveMaze(z, solve, maze, x, y, memo, theWay);
    }
    else if((maze[solve.x][solve.y + 1] == 0 || maze[solve.x][solve.y + 1] == 3) && memo[solve.x][solve.y + 1] == false){
        maze[solve.x][solve.y] = 4;
        memo[solve.x][solve.y] = true;
        maze[solve.x][solve.y + 1] = 2;
        solve.y++;
        push(theWay, solve.x, solve.y);
        print(z, maze);
        return solveMaze(z, solve, maze, x, y, memo, theWay);
    }
    else if((maze[solve.x][solve.y - 1] == 0 || maze[solve.x][solve.y - 1] == 3) && memo[solve.x][solve.y - 1] == false){
        maze[solve.x][solve.y] = 4;
        memo[solve.x][solve.y] = true;
        maze[solve.x][solve.y - 1] = 2;
        solve.y--;
        push(theWay, solve.x, solve.y);
        print(z, maze);
        return solveMaze(z, solve, maze, x, y, memo, theWay);
    }
    else if (maze[solve.x + 1][solve.y] == 0 || maze[solve.x + 1][solve.y] == 3 && memo[solve.x + 1][solve.y] == false)
        {
            maze[solve.x][solve.y] = 4;
            maze[solve.x + 1][solve.y] = 2;
            memo[solve.x][solve.y] = true;
            solve.x++;
            push(theWay, solve.x, solve.y);
            print(z, maze);
            return solveMaze(z, solve, maze, x, y, memo, theWay);
    }
    else if ((maze[solve.x - 1][solve.y] == 1 || memo[solve.x - 1][solve.y]) || (maze[solve.x][solve.y + 1] == 1 || memo[solve.x][solve.y + 1]) || (maze[solve.x][solve.y - 1] == 1 || memo[solve.x][solve.y - 1]) || (maze[solve.x + 1][solve.y] == 1 || memo[solve.x + 1][solve.y]))
    {
        if (!isEmpty(theWay))
        {
            pop(theWay, &a, &b);
            maze[solve.x][solve.y] = 4;
            solve.x = a;
            solve.y = b;
            maze[solve.x][solve.y] = 2;
            print(z, maze);
            return solveMaze(z, solve, maze, x, y, memo, theWay);
        }
    }else{
        return false;
    }
}

int main()
{
    solution solve;
    Pilha *theWay;
    FILE *labirinto = fopen("labirinto.txt", "r");
    int z, x, y;
    fscanf(labirinto, "%d", &z);
    int maze[z][z];
    bool memo[z][z];
    for (int i = 0; i < z; i++)
    {
        for (int j = 0; j < z; j++)
        {
            fscanf(labirinto, "%d", &maze[i][j]);
            if (maze[i][j] == 2)
            {
                solve.x = i;
                solve.y = j;
            }

            if (maze[i][j] == 3)
            {
                x = i;
                y = j;
            }
        }
    }

    theWay = criaPilha();
    push(theWay, solve.x, solve.y);
    bool kaka = solveMaze(z, solve, maze, x, y, memo, theWay);
    memo[solve.x][solve.y] = true;
    printf(kaka ? "O caminho foi encontrado!\n" : "O caminho não foi encontrado!\n");
    if(kaka){
        imprimePilha(theWay);
    }
    while (!isEmpty(theWay))
    {
        pop(theWay, &x, &y);
    }
    
    
}