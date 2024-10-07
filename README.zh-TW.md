# .profile.d

分散式的 profile 設定檔管理解決方案  
<https://github.com/brlin-tw/dot-profile.d>  
[![GitHub Actions 作業流程狀態標誌](https://github.com/brlin-tw/dot-profile.d/actions/workflows/check-potential-problems.yml/badge.svg "GitHub Actions 作業流程狀態")](https://github.com/brlin-tw/dot-profile.d/actions/workflows/check-potential-problems.yml) [![pre-commit 啟用狀態標誌](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white "本專案使用 pre-commit 框架檢查潛在問題")](https://pre-commit.com/) [![REUSE 規範遵循狀態標誌](https://api.reuse.software/badge/github.com/brlin-tw/dot-profile.d "本專案遵循 REUSE 規範以減少軟體授權成本")](https://api.reuse.software/info/github.com/brlin-tw/dot-profile.d)

\[[English](README.md)\] \[台灣中文\]

.profile 為類 Unix 作業系統中使用者登入後會一次性載入並執行的設定檔，主要用來設定使用者的環境變數（包含作為可執行檔搜索路徑的 `PATH` 環境變數）。

本專案是用來放置原本使用者會放置於`〈家目錄〉/.profile` 個人設定檔的腳本片段，這樣就可以最小程度地讓使用者自訂的 .profile 片段汙染 GNU/Linux 作業系統散佈版本提供的版本且讓該片段可以被重複利用。

您需要在家目錄中新建 .profile.d 目錄（如果該目錄原本還沒存在的話），然後將您的 profile 個人設定檔片段以 .source.sh 副檔名寫進 .profile.d 目錄中，.profile 中的程式會自動引入(source)並執行。

## 特色

* 備有將指定目錄插入 shell 可執行檔搜尋路徑(`PATH` 環境變數）中的工具函式
* 如果指定目錄不存在或是 `PATH` 中已有相同路徑將不會添加，避免增加搜尋路徑的多餘時間

## 設定

1. 於[專案的 Releases 頁面](https://github.com/brlin-tw/dot-profile.d/releases)下載釋出包。
1. 解開釋出包。
1. 啟動一個文字終端機模擬器應用軟體。
1. 於文字終端機模擬器應用軟體中執行下列命令切換作業目錄至解開的釋出包目錄：

    ```bash
    cd /path/to/extracted/release/package/dir
    ```

1. 執行下列命令以執行產品安裝程式：

    ```bash
    ./install.sh
    ```

    您需要重新登出再登入才能讓設定生效

## 注意

.profile 為通用的 script 程式，應使用 [POSIX.1-2008 規範的 shell script 語法](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html)而非 Bash 等殼層程式的專有語法撰寫

## 授權條款

除另有註明（個別檔案的開頭 / [REUSE DEP5 文件](.reuse/dep5)）本專案的內容以[第三版的 GNU General Public License 授權條款](https://www.gnu.org/licenses/gpl-3.0.html.en)或其任意更近期版本釋出供大眾於授權範圍內自由使用。

本作品遵循 [REUSE 規範](https://reuse.software/spec/)，參閱 [REUSE - Make licensing easy for everyone 網站](https://reuse.software/)以獲取本產品授權方面的相關資訊。
