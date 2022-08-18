class Slac
    #Somethig like a crowbar
    def title
        puts
        puts
        puts "              *********************************"
        puts "              *                               *"
        puts "              *  バールのようなもの　by Ruby  *"
        puts "              *                               *"
        puts "              *********************************"
        puts
        puts
        puts "      1986年のPCゲーム「シルフィード」のミニゲーム"
        puts
        puts "       『ザカリテの逆襲』をアレンジした物のアレンジです"
        puts
        puts "      ※元ネタはネットで探してください"
        puts
        puts
        puts "  遊び方"
        puts
        puts "     『バールだ！』と言ったタイミングでEnterを押してください"
        puts
        puts
        puts "                  ゆっくり：1  オニ：9"
        puts
        puts "                  \e[31m数字を入力してenter\e[0m"
        #外部ファイルから読み込む形にすべきかも。処理速度と相談
    end

    def opening
        title
        n = gets.to_i
        puts

        #例外の排除（文字列など）
        if n != 1 && n != 9
            puts "数字を入れてやりなおし！"
            exit
        end
        #速度調整
        n == 1 ? @s = 0.2 : @s = 0.08
        
        #この辺にカウントダウンを入れたい
    end

    def body        
        #処理時間判定のための起点
        s_time = Time.now.to_f

        t1 = Thread.new do
            print "ワレハ　ガーライルグンノ　ショウグン　"
            sleep(1)
            rand(Time.now.sec + 1).times do
                #元ネタはこの処理に音声が入る。Win32 APIで ドレミは出来そう
                print "バッ"
                sleep(@s)
            end
            puts " \e[31mバールダ .\e[0m"
            #メイン処理の経過時間測定用
            @result = Time.now.to_f  
        end
       
        t2 = Thread.new do
            if gets
                #enter入力時の時間測定用
                @inter = Time.now.to_f
                Thread.kill(t1)
            end
        end
        
        t1.join
        t2.join

        begin
            #ここは@spanにしないように考え直したい
            @span = (@result - @inter)
        rescue Exception => e
            #@resultがnilの場合、「バールダ .」が表示される前に処理が止まると、
            puts 
            print "ヒキョウモノメ  (YOU_LOSE)"
            exit
        end
    end

    def judge
        if @span < -0.35
            #マジックナンバーです、難易度の調整。改善の余地あり、-0.3なら激ムズ
            #人間の反射速度は鍛えても0.1が限界とのこと。
            puts 
            print "シコンデヤル  (YOU_LOSE)"
	    puts 
        else
            puts 
            print "グヌゥ…  (YOU_WIN)" #GNUとかけて。元ネタは「タスカッタ」
        end
    end
end

#メイン
    game = Slac.new

	game.opening

	game.body
 
	game.judge
