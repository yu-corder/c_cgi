#include <stdio.h>

int main(void) {
    // HTTPレスポンスヘッダ
    printf("Content-Type: text/html\n\n");

    // HTML本文
    printf("<!DOCTYPE html>\n");
    printf("<html><head><title>Hello</title></head><body>\n");
    printf("<h1>Hello, CGI</h1>\n");
    printf("</body></html>\n");

    return 0;
}