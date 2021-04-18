// Lambda 用ダミーデータ
data "archive_file" "dummy" {
  type = "zip"
  source {
    content  = "dummy"
    filename = "dummy.txt"
  }
  output_path = "tmp/dummy.zip"
}