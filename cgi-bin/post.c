#include <stdio.h>
#include <stdlib.h>

int main(void) {
    char *lenstr = getenv("CONTENT_LENGTH");
    int len = lenstr ? atoi(lenstr) : 0;

    printf("Content-Type: text/plain\n\n");

    if (len > 0) {
        char *data = malloc(len + 1);
        if (data == NULL) {
            printf("Memory allocation failed.\n");
            return 1;
        }

        fread(data, 1, len, stdin);
        data[len] = '\0';

        printf("POST data: %s\n", data);
        free(data);
    } else {
        printf("No POST data received.\n");
    }

    return 0;
}