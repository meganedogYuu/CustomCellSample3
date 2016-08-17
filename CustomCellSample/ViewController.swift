import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /// 画像のファイル名
    let imageNames = ["cat1.jpg", "cat2.jpg", "dog1.jpg", "dog2.jpg"]
    
    /// 画像のタイトル
    let imageTitles = ["ネコ1", "ネコ2", "イヌ1", "イヌ2"]
    
    /// 画像の説明
    let imageDescriptions = [
        "ボックスから顔だけだして下を見ているオス猫",
        "寝ころびながらじゃれる猫",
        "散歩中のポメラニアン",
        "お散歩中のワンちゃん"
    ]
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    var flg = false
    
    
    var audioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /// セルの個数を指定するデリゲートメソッド（必須）
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    /// セルに値を設定するデータソースメソッド（必須）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // セルを取得
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell") as! CustomTableViewCell
        
        // セルに値を設定
        cell.setCell(imageNames[indexPath.row], titleText: imageTitles[indexPath.row], descriptionText: imageDescriptions[indexPath.row])
        
        return cell
    }
    
    /// セル内のボタンをタップされた時
    @IBAction func tapButton(sender: AnyObject) {
        
        // セルのindexPath.rowを取得
        let btn = sender as! UIButton
        let cell = btn.superview?.superview as! UITableViewCell
        let row = self.myTableView.indexPathForCell(cell)?.row
        
        // 音を鳴らすファイル名
        let fileName = "magic\(row! + 1)"
        
        print(fileName)
        
        // サウンドデータの読み込み
        let soundPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("magic", ofType: "mp3")!)
        
        // サウンドデータの読み込み（mp3のファイルを追加してこちらの71行目ではなくこちらをお使い下さい）
        //let soundPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileName, ofType: "mp3")!)
        
        
        // AudioPlayerのインスタンスを生成
        audioPlayer = try! AVAudioPlayer(contentsOfURL: soundPath)
        
        
        
        if flg {
            // 音源を再生
            audioPlayer.play()
        }else {
            audioPlayer.stop()
        }
        
        flg = !flg
    }
}

