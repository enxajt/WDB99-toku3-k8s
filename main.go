package main

import (
  "io"
  "net/http"
  "os"
)

func main() {
	// 出力メッセージの内容は環境変数から受け取るか、デフォルトの
	// "Hello, World!"を使う
  message := os.Getenv("WDPRESS_MESSAGE")
  if message == "" {
    message = "Hello, World!"
  }

  http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "text/plain")
    io.WriteString(w, message)
  })

  http.ListenAndServe(":8080", nil)
}

