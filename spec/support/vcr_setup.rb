VCR.configure do |config|
  # 設定儲存 API 檔案的目錄位置
  config.cassette_library_dir = "spec/fixtures/vcr"
  # 設定假造 API 的函式庫
  config.hook_into :webmock
end
