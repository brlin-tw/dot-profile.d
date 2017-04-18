# .profile.d<br>分散式的 profile 設定檔管理專案
<https://github.com/Lin-Buo-Ren/.profile.d>

.profile 為類 Unix 作業系統中使用者登入後會一次性載入並執行的設定檔，主要用來設定使用者的環境變數（包含作為可執行檔搜索路徑的 `PATH` 環境變數）。

本專案是用來放置原本使用者會放置於`〈家目錄〉/.profile` 個人設定檔的腳本片段，這樣就可以最小程度地讓使用者自訂的 .profile 片段汙染 GNU/Linux 作業系統散佈版本提供的版本且讓該片段可以被重複利用。

您需要在家目錄中新建 .profile.d 目錄（如果該目錄原本還沒存在的話），然後將您的 profile 個人設定檔片段以 .source.sh 副檔名寫進 .profile.d 目錄中，.profile 中的程式會自動引入(source)並執行。

## 特色<br>Features
* 備有將指定目錄插入 shell 可執行檔搜尋路徑(`PATH` 環境變數）中的工具函式
* 如果指定目錄不存在或是 `PATH` 中已有相同路徑將不會添加，避免增加搜尋路徑的多餘時間

## 設定<br>Setup
1. 將本版控庫拓製(clone)或下載解開到家目錄中的 .profile.d 目錄，確定 `README.setup` 與其他檔案位於 ~/.profile.d 目錄中
1. 在 ~/.profile 設定檔中加入下列內容：

```shell
# Setup .profile.d/
# https://github.com/Lin-Buo-Ren/.profile.d
. .profile.d/README.setup
```

您需要重新登出再登入才能讓設定生效

## 注意<br>Remark
.profile 為通用的 script 程式，應使用 [POSIX.1-2008 規範的 shell script 語法](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html)而非 Bash 等殼層程式的專有語法撰寫

## 授權條款<br>License
GPLv3+
