#ChmnProject  
Choregrapheで開発した、Pepper（名前：シャンシャン）が月次全体会議を司会するプロジェクトです。  
  
目次  
はじめに  
司会者プロジェクトの目的  
司会者プロジェクトの目標  
司会者プロジェクトの使い方  
司会者プロジェクトの構造説明  
Behaviorまとめ  
全体会議の流れの説明  
各Behaviorの詳細説明  
カスタムしたコードの説明  
  
＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝  
はじめに  
****  
司会者プロジェクトの目的  
１、月次全体会議の各発言者のスピーチをつなぐ発言、２、発表時間切れの知らせをシャンシャンに任せたい  
司会者プロジェクトの目標  
１、全体会議の開始と終了をアナウンスする。  
２、次に発言する方の部署と名前を発表し、次のスピーチを開始させる。  
３、発言時間を計測し、予定の発言時間を過ぎたらアラートする。  
４、発言終わったことを認識し、発言した方に感謝する。  
５、すべてのスピーチが終わったら、社長に締めのスピーチをお願いする。  
  
＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝  
司会者プロジェクトの使い方  
****  
Choregrapheを開き、ChmnProjectを導入する  
*LICENSE、README.md、agenda.csv、speechEndTest.txtは導入しなくてもいいです  
allBehaviorsのbehavior.xarから開始します。  
＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝  
司会者プロジェクトの構造の説明  
****  
Behaviorまとめ  
０、allBehaviors：すべてのBehaviorのまとめとなるBehavior  
１、startmeeting：シャンシャンが全体会議の開始をアナウンスする。  
２、loadAgenda：アジェンダを読み込む。  
３、startNextSpeech：次の発言者の部署と名前を認識し、アナウンスする。  
４、checkSpeechTimeout：次のスピーチの所要時間を読み込み、時間になったらタイムオーバーのアナウンスする。  
５、checkSpeechEnd：発言者をセンサーで認識し、発言終わりを監視する。  
６、thanksLastSpeech：発言終わったら、感謝の言葉を流れる。  
７、nextPresidentSpeech：すべての発言者が発表し終わったら、次は社長に締めのスピーチをお願いする。  
８、endMeeting：閉会のアナウンスする。  
****  
全体会議の流れ説明  
０、allBehaviors>１、startMeeting>２、loadAgenda>３、startNextSpeech>  
４、checkSpeechTimeout&５、checkSpeechEnd>  
５、checkSpeechEndで発言終わりを監視できたら、checkSpeechTimeout停止＋６、thanksLastSpeech>  
ifNextPresenterOrPresidentで次に発言者はまだいるかどうかを判断し、いるなら２、loadAgndaに戻りループする>  
次に発言者がいない場合７、nextPresidentSpeech>５、checkSpeechEnd>８、endMeeting  
****  
各Behaviorの詳細説明  
０、allBehaviors  
すべてのBehaviorのまとめとなるBehavior。  
全体会議の流れとその制御はここに詰まっています。  
.その下の各Behaviorは一個に一つの処理を行い、流れ（ループやその条件判断）はすべてallBehaviorsに設定する。*  
  
1.startmeeting  
シャンシャンが全体会議の開始をアナウンスする。  
同時に発言者番号PreNoを1に初期化する。  
  
2.loadAgenda  
アジェンダを読み込む。  
読み込んだデータをCSVDataに格納する。  
  
3.startNextSpeech  
次の発言者の部署と名前を認識し、アナウンスする。  
PreNoとCSVDataを読み込み、現在の発言者の部署と名前をアナウンスする。  
  
4.checkSpeechTimeout  
次のスピーチの所要時間を読み込み、時間になったらタイムオーバーのアナウンスする。  
PreNoとCSVDataを読み込み、現在の発言者の発言時間を認識する。  
その時間になるまでWait、時間になったらアナウンスする。  
.時間になる前にcheckSpeechEndが発生したら中止される。  
  
5.checkSpeechEnd  
発言終わりを監視する。  
発言終わったらcheckSpeechTimeoutを中止する。  
  
6.thanksLastSpeech  
感謝の言葉を流れる。  
  
7.nextPresidentSpeech  
次は社長に締めのスピーチをお願いする。  
  
8.endMeeting：閉会のアナウンスする。  
****  
カスタムしたコードの説明  
本プロジェクトではメモリの中のCSVDataから必要なデータを抽出するため、  
Pythonでコードを書けるAnimatedSayTextボックスを多用しています。  
またifNextPresenterOrPresidentの判断でも発言者が最後まで達したかどうかを判断するため  
コードを書いています。  
  
まずReadTextボックスを追加し、Pathをテキストファイルの絶対パスを入れます。  
（<https://github.com/yacchin1205/pepper-web-boxes/tree/master/web-boxes/IO/>）  
そしてInsertDataボックスでメモリにデータを書き込みます。  
あとは各AnimatedSayTextなどでメモリからデータを取り出して操作します。  
  
データ取り出しコードの共通する部分は、  
各ボックスの「defonLoad(self):」に「self.memory=ALProxy("ALMemory")」追加  
「defonUnload(self):」に「self.memory=None」を追加します。これでメモリの読み込むができるようになります。  
そして「defonInput_onStart(self,p):」で「csvData=self.memory.getData("CSVData")」  
のようにメモリからデータを取り出せます。  
  
eg.startNextSpeechのstartNextSpeechボックス  
    csvData=self.memory.getData("CSVData")でCSVDataを取得し、  
    currentPreNo=self.memory.getData("PreNo")で現在発言者の番号を取得し  
    CSVDataに対して文字列処理を行います。  
    forlineincsvData.splitlines():#行ごとに処理する  
    forwordinline.split(',')[0]:#「,」を区切り文字とする場合の配列の一番目の文字列、番号に当たる  
    ifword==str(currentPreNo):#現在発言者の番号と一致する場合  
    department=line.split(',')[1]#二番目の文字列、部署  
    presenter=line.split(',')[2]#三番目の文字列、名前  
    break  
  
他にも似たように、先にメモリからデータを取り出して、もろもろ操作を行います。  
  
**注意：ReadTextで文字コードをutf8と設定する場合、操作対象となるテキストファイルは「BOMなしのUTF-8」に設定してください。**  
  
  
TODO：  
音楽流しながら時間ですのアラート  
  
例外処理頭のセンサーを使う  
  
