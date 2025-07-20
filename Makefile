# # コンパイラ
# CC = gcc
# # CGIファイルの出力先ディレクトリ
# CGI_BIN_DIR = /usr/lib/cgi-bin

# # 全てのCGIプログラムのリスト（.c 拡張子なし）
# # hello.c と another_cgi.c をCGIとしてビルドする場合
# TARGETS = hello another_cgi

# # オブジェクトファイルのリスト
# OBJS_HELLO = $(CGI_BIN_DIR)/hello.o $(CGI_BIN_DIR)/some_util.o
# OBJS_ANOTHER = $(CGI_BIN_DIR)/another_cgi.o $(CGI_BIN_DIR)/some_util.o

# .PHONY: all clean

# all: $(foreach target, $(TARGETS), $(CGI_BIN_DIR)/$(target).cgi)

# # 各CGIプログラムのビルドルール
# $(CGI_BIN_DIR)/hello.cgi: $(CGI_BIN_DIR)/hello.o $(CGI_BIN_DIR)/some_util.o
# 	$(CC) $(CGI_BIN_DIR)/hello.o $(CGI_BIN_DIR)/some_util.o -o $@
# 	chmod +x $@

# $(CGI_BIN_DIR)/another_cgi.cgi: $(CGI_BIN_DIR)/another_cgi.o $(CGI_BIN_DIR)/some_util.o
# 	$(CC) $(CGI_BIN_DIR)/another_cgi.o $(CGI_BIN_DIR)/some_util.o -o $@
# 	chmod +x $@

# # .c ファイルから .o ファイルへの汎用ルール
# # %.o: %.c は、すべての .c ファイルを対応する .o ファイルにコンパイルするルール
# $(CGI_BIN_DIR)/%.o: cgi-src/%.c
# 	$(CC) -c $< -o $@

# clean:
# 	rm -f $(CGI_BIN_DIR)/*.o $(CGI_BIN_DIR)/*.cgi