# ChmnProject
a Choregraphe project for Pepper to chair a meeting

目次
 司会者プロジェクト
 　共通に必要な設定ファイル
  会議開始
  次の発言者認識
  発言終わり認識
   例外:発言時間リマインダー
  会議終わり
 退勤打刻リマインダー

＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
司会者プロジェクト
ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
　共通に必要な情報
  CSVファイルから、部署、名前を読み込み Read Text BOX
  フォーマットは、番号、部署、名前
  今何番に行ったの情報も保持すべき
ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
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

