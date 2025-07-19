#include <stdio.h>
#include <stdlib.h>

int main(void) {
    char *query = getenv("QUERY_STRING");

    printf("Content-Type: text/plain\n\n");
    if (query) {
        printf("GET data: %s\n", query);
    } else {
        printf("No GET data received.\n");
    }

    return 0;
}
