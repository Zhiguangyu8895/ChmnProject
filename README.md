# ChmnProject
Choregrapheで開発した、Pepperくんが月次全体会議を司会するプロジェクトです。

目次
 はじめに
 　司会者プロジェクトの目的
 　司会者プロジェクトの目標
 司会者プロジェクトの使い方
 司会者プロジェクトの構造説明
 司会者プロジェクトのコード説明

＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
はじめに
ーーーーーーーーーーーーーーーーーーーーーーーー
　司会者プロジェクトの目的
  １、月次全体会議の各発言者のスピーチをつなぐ発言、２、発表時間切れの知らせ　をPepperくんに任せたい
 司会者プロジェクトの目標
 　１、全体会議の開始と終了をアナウンスする。
 　２、次に発言する方の部署と名前を発表し、次のスピーチを開始させる。
 　３、発言時間を計測し、予定の発言時間を過ぎたらアラートする。
 　４、発言終わったことを認識し、発言した方に感謝する。
 　５、すべてのスピーチが終わったら、社長に締めのスピーチをお願いする。

＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
司会者プロジェクトの使い方
ーーーーーーーーーーーーーーーーーーーーーーーー
　Choregrapheを開き、ChmnProjectを導入し、allBehaviorsのbehavior.xarから開始します。
＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
司会者プロジェクトの構造の説明
ーーーーーーーーーーーーーーーーーーーーーーーー
 allBehaviors
  すべてのBehaviorのまとめとなるBehavior
  全体会議の流れとその制御はここに詰まっています。
  ＊その下の各Behaviorは一個に一つの処理を行い、流れ（ループやその条件判断）はすべてallBehaviorsに設定する。
 　
 
 会議開始 startMeeting
  目標
   まずはRead TextのBOXでCSVファイルを読み込み、Insert DataでDataを保持
   
  　みなさま、こんばんは。これから****年*月の全体会議を始めさせていただきます。司会のシャンシャンと申します、よろしくお願いします。
  　年月はDatetime
  　一回のみ
  ・ReadCSV InsertCSVData InitPreNo
  
  
  ・Animated Say
  
  　　import time
　　　　import datetime
　　　　
　　　　class MyClass(GeneratedClass):
　　　　    def __init__(self):
　　　　        GeneratedClass.__init__(self, False)
　　　　        self.tts = ALProxy('ALAnimatedSpeech')
　　　　        self.ttsStop = ALProxy('ALAnimatedSpeech', True) #Create another proxy as wait is blocking if audioout is remote
　　　　
　　　　    def onLoad(self):
　　　　        self.bIsRunning = False
　　　　        self.ids = []
　　　　
　　　　    def onUnload(self):
　　　　        for id in self.ids:
　　　　            try:
　　　　                self.ttsStop.stop(id)
　　　　            except:
　　　　                pass
　　　　        while( self.bIsRunning ):
　　　　            time.sleep( 0.2 )
　　　　
　　　　    def onInput_onStart(self, p):
　　　　        self.bIsRunning = True
　　　　        d = datetime.datetime.today()
　　　　        y = d.year
　　　　        m = d.month
　　　　        try:
　　　　            movement = self.getParameter("Speaking movement mode")
　　　　            sentence = "\RSPD="+ str( self.getParameter("Speed (%)") ) + "\ "
　　　　            sentence += "\VCT="+ str( self.getParameter("Voice shaping (%)") ) + "\ "
　　　　            sentence += str(p)
　　　　            sentence += "みなさま、こんばんは。これより" + str(y) + "年" + str(m) + "月の全体会議を始めさせていただきます。司会のシャンシャンと申します、よろしくお願いします。"
　　　　            sentence +=  "\RST\ "
　　　　            id = self.tts.post.say(str(sentence), {"speakingMovementMode":movement})
　　　　            self.ids.append(id)
　　　　            self.tts.wait(id, 0)
　　　　        finally:
　　　　            try:
　　　　                self.ids.remove(id)
　　　　            except:
　　　　                pass
　　　　            if( self.ids == [] ):
　　　　                self.onStopped() # activate output of the box
　　　　                self.bIsRunning = False
　　　　
　　　　    def onInput_onStop(self):
　　　　        self.onUnload()
ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
 次の発言者認識 startNextSpeech
  目標
   ReadCSVData ReadPreNoの二つのALMemoryメソッドをAnimatedSayTextに入れる
  　それでは、XX部XXさん、発表お願いします。
  会議開始後一回目、最後の社長発言前まで繰り返し
ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
 発言終わり認識 thanksLastSpeech
 　目標
 　　言語認識：「ご清聴ありがとう」
 　5秒後　XXさん、発表ありがとうございました。
ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
 例外:発言時間リマインダー remindSpeechTime
 　目標
 　　次の発言者認識後X分過ぎたら＋発言終わり認識なし
 　　「時間です、ご注意いただければ幸いです。」
ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
 会議終わり endMeeting
 　目標
 　　次の発言者なし
 　「以上を持ちまして、XX年XX月の全体会議を終了させていただきます。皆様お疲れさまでした。」

  Animated Say
  import time
　　import datetime
　　
　　class MyClass(GeneratedClass):
　　    def __init__(self):
　　        GeneratedClass.__init__(self, False)
　　        self.tts = ALProxy('ALAnimatedSpeech')
　　        self.ttsStop = ALProxy('ALAnimatedSpeech', True) #Create another proxy as wait is blocking if audioout is remote
　　
　　    def onLoad(self):
　　        self.bIsRunning = False
　　        self.ids = []
　　
　　    def onUnload(self):
　　        for id in self.ids:
　　            try:
　　                self.ttsStop.stop(id)
　　            except:
　　                pass
　　        while( self.bIsRunning ):
　　            time.sleep( 0.2 )
　　
　　    def onInput_onStart(self, p):
　　        self.bIsRunning = True
　　        d = datetime.datetime.today()
　　        y = d.year
　　        m = d.month
　　        try:
　　            movement = self.getParameter("Speaking movement mode")
　　            sentence = "\RSPD="+ str( self.getParameter("Speed (%)") ) + "\ "
　　            sentence += "\VCT="+ str( self.getParameter("Voice shaping (%)") ) + "\ "
　　            sentence += str(p)
　　            sentence += "みなさま、こんばんは。これより" + str(y) + "年" + str(m) + "月の全体会議を始めさせていただきます。司会のシャンシャンと申します、よろしくお願いします。"
　　            sentence +=  "\RST\ "
　　            id = self.tts.post.say(str(sentence), {"speakingMovementMode":movement})
　　            self.ids.append(id)
　　            self.tts.wait(id, 0)
　　        finally:
　　            try:
　　                self.ids.remove(id)
　　            except:
　　                pass
　　            if( self.ids == [] ):
　　                self.onStopped() # activate output of the box
　　                self.bIsRunning = False
　　
　　    def onInput_onStop(self):
　　        self.onUnload()
 
 
 
音楽流しながら　時間です　のアラート

例外処理　頭のセンサーを使う

