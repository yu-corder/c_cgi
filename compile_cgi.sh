#!/bin/bash

# CGIプログラムの出力ディレクトリ
CGI_BIN_DIR="/usr/lib/cgi-bin"
# CGIソースコードの入力ディレクトリ（コンテナ内の一時的な場所）
CGI_SRC_DIR="/tmp/cgi-bin"

echo "Compiling CGI programs from ${CGI_SRC_DIR}..."

# /usr/lib/cgi-bin ディレクトリが存在することを確認
mkdir -p "${CGI_BIN_DIR}"

# cgi-src ディレクトリ内の .c ファイルをループ処理
for src_file in "${CGI_SRC_DIR}"/*.c; do
    if [ -f "$src_file" ]; then
        # ファイル名から拡張子を除いた部分を取得
        base_name=$(basename "$src_file" .c)
        # 出力ファイル名 (.cgi 拡張子を付与)
        output_file="${CGI_BIN_DIR}/${base_name}.cgi"

        echo "  Compiling ${src_file} to ${output_file}..."

        # 個々のファイルが独立しているため、別々にコンパイル
        gcc "${src_file}" -o "${output_file}"

        # コンパイルが成功したかチェック
        if [ $? -eq 0 ]; then
            echo "    Compilation successful. Setting execute permissions."
            chmod +x "${output_file}"
        else
            echo "    Error: Compilation failed for ${src_file}"
            exit 1 # エラーが発生したらスクリプトを終了
        fi
    fi
done

echo "All CGI programs compiled and configured."