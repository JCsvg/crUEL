#include <stdio.h>
#include <stdlib.h>

struct Interval {
    int low;
    int high;
};

void swap(int* a, int* b) {
    int t = *a;
    *a = *b;
    *b = t;
}

int partition(int arr[], int low, int high) {
    int pivot = arr[high];
    int i = (low - 1);

    for (int j = low; j <= high - 1; j++) {
        if (arr[j] <= pivot) {
            i++;
            swap(&arr[i], &arr[j]);
        }
    }

    swap(&arr[i + 1], &arr[high]);
    return (i + 1);
}

void quickSortIterative(int arr[], int l, int h) {

    struct Interval stack[h - l + 1];
    int top = -1;


    stack[++top].low = l;
    stack[top].high = h;


    while (top >= 0) {

        h = stack[top].high;
        l = stack[top--].low;


        int p = partition(arr, l, h);


        if (p - 1 > l) {
            stack[++top].low = l;
            stack[top].high = p - 1;
        }


        if (p + 1 < h) {
            stack[++top].low = p + 1;
            stack[top].high = h;
        }
    }
}

int main() {
    int arr[] = {10, 7, 8, 9, 1, 5};
    int arr_size = sizeof(arr) / sizeof(arr[0]);

    printf("Array original:\n");
    for (int i = 0; i < arr_size; i++)
        printf("%d ", arr[i]);

    quickSortIterative(arr, 0, arr_size - 1);

    printf("\n\nArray ordenado:\n");
    for (int i = 0; i < arr_size; i++)
        printf("%d ", arr[i]);

    return 0;
}
