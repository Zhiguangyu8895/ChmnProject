みんなが修正

# ChmnProject  
Choregrapheで開発した、Pepperくんが月次全体会議を司会するプロジェクトです。  
  
## 目次  
### はじめに  
司会者プロジェクトの目的  
司会者プロジェクトの目標  
### 司会者プロジェクトの現状  
使い方  
Behavior一覧  
各Behaviorの詳細  
カスタムしたコード  
### 残課題  
  
****  
## はじめに  
  
### 司会者プロジェクトの目的  
1.月次全体会議の各発言者のスピーチをつなぐように発言してもらいたい。  
2.発表時間切れの知らせをシャンシャンに任せたい。  
### 司会者プロジェクトの目標  
1.全体会議の開始と終了をアナウンスする。  
2.アジェンダに応じて、次に発言する方の部署と名前を発表し、次のスピーチを開始させる。  
3.発言時間を計測し、予定の発言時間を過ぎたらアラートする。  
4.発言終わったことを認識し、発言した方に感謝する。  
  
****  
## 司会者プロジェクトの現状  
  
### 使い方  
1.Choregrapheを開き、ChmnProjectを導入する。  
..LICENSE、README.md、agenda.csv、parts.csv、sectionEndTest.txtはプロジェクトに導入しなくてもいい。  
..プロジェクトの「プロパティ」で、プロジェクトの言語設定を正しくする（バーチャルロボットでは英語、実機では日本語など）  
2.ファイル内容を編集、確認する。  
..agenda.csv には発言者番号、所属部署、発言者、制限時間を登録する。  
..parts.csv　には発言者番号（どの発言者から次のパートに入るかを認識するため）、パート名を登録する。  
..sectionEnd.txtの内容は「N」。  
3.allBehaviorsのinitVariablesのpath for filesを修正 
..Pepper実機で実行するときは、Choregrapheの「接続」＞「アドバンスト」＞「ファイルの転送」でCSVファイルをPepperに転送する。  
..そのままでは「/home/nao/」の配下になる。SSH接続して「/home/nao/」で確認できる。  
4.allBehaviorsのbehavior.xarを実行する。  
5.各発言者がスピーチを終わるなどで、次の部分を進んでもいい時、sectionEnd.txtの内容を「Y」に書き換える（内容がYのtxtファイルをアップロードする）。  
  
### Behavior一覧  
1.allBehaviors:すべてのBehaviorのまとめとなるBehavior、ここで会議の流れを組む。  
2.checkSectionEnd:現在のパートの終わりを監視する。  
..センサーによる監視の実装はまだ終わってないので、当面はsectionEndTestの内容を監視。  
3.checkSpeechTimeout:スピーチがタイムオーバーの時アナウンスする。  
4.endMeeting:閉会のアナウンスする。  
5.endPrePart:前のパートの終了する。  
6.loadAgenda:アジェンダ（agenda.csv）を読み込んでメモリに書き込む。  
7.loadParts:パート名とその始めの発言者番号（parts.csv）を読み込んでメモリに書き込む。  
8.randomNextFrase:次につなぐフレーズ（それでは、次にはなど）をランダムでしゃべる。  
9.restTime:音楽を流しながら休憩時間開始。  
10.startmeeting:全体会議の開始をアナウンスする。  
11.startNextPart:次のパートを開始する。  
12.startNextSpeech:次の発言者の部署と名前をアナウンスする。  
13.thanksPreSpeech:先の発言者に感謝の言葉を流れる。  
  
### 各Behaviorの詳細説明  
1.allBehaviors  
..すべてのBehaviorのまとめとなるBehavior。  
..全体会議の流れとその制御はここに詰まっています。  
..その下の各Behaviorは一個に一つの処理を行い、流れ（ループやその条件判断）はすべてallBehaviorsに設定する。  
..Behavior以外には分岐判断のifボックスやメモリに保存されているグローバル変数を変更するInsertDataボックスを置いてある。  
　　
2.checkSectionEnd  
..次に進んでいいかどうかを判断する。  
..2019.2.10　センサーなどによる判断アルゴリズムは未実装のため、現在ではsectionEndTest.txtの内容による判断している。  
  
3.checkSpeechTimeout  
..スピーチの時間になったらタイムオーバーのアナウンスする。  
..PreNoとagendaDataを読み込み、現在の発言者の発言時間を読み込む。  
..その時間になるまでWait、時間になったらアナウンスする。  
..時間になる前にcheckSectionEndが発生したら中止される。  
  
4.endMeeting  
..閉会のアナウンスする。  
  
5.endPrePart  
..前のパートを閉める。
  
6.loadAgenda  
..アジェンダを読み込む。  
..読み込んだデータをagendaDataに格納する。  
  
7.loadParts  
..パート情報を読み込む。  
..読み込んだデータをPartsDataに格納する。  
  
8.randomNextFrase  
..ランダムに次をつなぐ言葉を言う。
  
9.restTime  
..休憩時間に入り、音楽を流す。  
  
10.startMeeting  
..会議始まりのアナウンス。  
  
11.startNextPart  
..次のパートを開始する。  
  
12.startNextSpeech  
..次の発言者の部署と名前をアナウンスする。  
  
13.thanksPreSpeech  
..感謝の言葉を流れる。  
  
### カスタムしたコードの説明  
本プロジェクトではメモリの中のagendaDataから必要なデータを抽出するため、  
Pythonでコードを書けるAnimatedSayTextボックスを多用しています。  
またifLastPresenterの判断でも発言者が最後まで達したかどうかを判断するため  
コードを書いています。  
  
まずReadTextボックスを追加し、Pathにテキストファイルの絶対パスを入れます。  
（<https://github.com/yacchin1205/pepper-web-boxes/tree/master/web-boxes/IO/>）  
そしてInsertDataボックスでメモリにデータを書き込みます。  
あとは各AnimatedSayTextなどでメモリからデータを取り出して操作します。  
  
データ取り出しコードの共通する部分は、  
各ボックスの「def onLoad(self):」に「self.memory=ALProxy("ALMemory")」追加  
「def onUnload(self):」に「self.memory=None」を追加します。これでメモリの読み込むができるようになります。  
そして「def onInput_onStart(self,p):」で「agendaData=self.memory.getData("agendaData")」  
のようにメモリからデータを取り出せます。  
  
eg.startNextSpeechのstartNextSpeechボックス  
```python
agendaData=self.memory.getData("agendaData") #agendaDataを取得する
currentPreNo=self.memory.getData("PreNo") #現在発言者の番号を取得する
for line in agendaData.splitlines(): #行ごとに処理する
	word = line.split(',')[0] #「,」を区切り文字とする場合の配列の一番目の文字列、番号に当たる
	if word==str(currentPreNo): #現在発言者の番号と一致する場合
		department=line.split(',')[1]#二番目の文字列、部署
		presenter=line.split(',')[2]#三番目の文字列、名前
		break
```
  
他にも似たように、先にメモリからデータを取り出して、もろもろ操作を行います。  
  
**注意:ReadTextで文字コードをutf8と設定する場合、操作対象となるテキストファイルは「BOMなしのUTF-8」に設定してください。**  
  
  

Tips:
  バーチャルロボットではプロジェクトの言語がEnglish、実機ではJapanese

TODO:  

例外処理頭のセンサーを使う  
  
