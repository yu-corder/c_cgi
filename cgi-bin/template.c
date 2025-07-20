#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    const char *key;
    const char *value;
} TemplateItem;

// テンプレートファイルを読み込み、動的に内容を置換して出力する関数
void render_template(const char *filename, TemplateItem *context, int context_size, FILE *out) {
    FILE *fp = fopen(filename, "r");
    if (!fp) {
        fprintf(out, "<p>Template not found: %s</p>", filename);
        return;
    }

    fseek(fp, 0, SEEK_END);
    long file_size = ftell(fp);
    rewind(fp);

    char *template_buffer = (char *)malloc(file_size + 1);
    if (!template_buffer) {
        fprintf(out, "<p>Memory allocation failed for template buffer.</p>");
        fclose(fp);
        return;
    }
    fread(template_buffer, 1, file_size, fp);
    template_buffer[file_size] = '\0'; // ヌル終端
    fclose(fp);

    size_t current_output_buffer_size = file_size * 4;
    char *output_buffer = (char *)malloc(current_output_buffer_size);
    if (!output_buffer) {
        fprintf(out, "<p>Memory allocation failed for output buffer.</p>");
        free(template_buffer);
        return;
    }
    output_buffer[0] = '\0';
    size_t current_output_len = 0;

    char *current_processed_buffer = strdup(template_buffer);

    for (int i = 0; i < context_size; i++) {
        char placeholder[64];
        snprintf(placeholder, sizeof(placeholder), "{{%s}}", context[i].key);

        char *pos;
        char *temp_input_buffer = current_processed_buffer;
        size_t temp_input_len = strlen(temp_input_buffer);
        current_output_len = 0;
        size_t last_pos = 0;

        while ((pos = strstr(temp_input_buffer + last_pos, placeholder)) != NULL) {
            size_t len_before_placeholder = pos - (temp_input_buffer + last_pos);
            if (current_output_len + len_before_placeholder + strlen(context[i].value) + 1 > current_output_buffer_size) {
                fprintf(out, "<p>Error: Output buffer too small. Needs realloc.</p>");
                free(template_buffer);
                free(output_buffer);
                free(current_processed_buffer);
                return;
            }
            strncat(output_buffer + current_output_len, temp_input_buffer + last_pos, len_before_placeholder);
            current_output_len += len_before_placeholder;

            strcat(output_buffer + current_output_len, context[i].value);
            current_output_len += strlen(context[i].value);

            last_pos = (pos - temp_input_buffer) + strlen(placeholder);
        }

        strcat(output_buffer + current_output_len, temp_input_buffer + last_pos);

        free(current_processed_buffer);
        current_processed_buffer = strdup(output_buffer);
        output_buffer[0] = '\0';
        current_output_len = 0;
    }

    fprintf(out, "%s", current_processed_buffer);

    free(template_buffer);
    free(output_buffer);
    free(current_processed_buffer);
}

int main(void) {
    TemplateItem context[] = {
        { "title", "Hello Page" },
        { "message", "こんにちは、世界！" }
    };

    printf("Content-Type: text/html\n\n");
    render_template("/var/www/html/template.html", context, 2, stdout);
    return 0;
}