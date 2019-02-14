//
//  ViewController.swift
//  TapticMusic
//
//  Created by 김준우 on 2016. 11. 18..
//  Copyright © 2016년 김준우. All rights reserved.
//
import AVFoundation
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let music = ["달고나","SAVE ME"]
    
    @IBOutlet var musicTableView: UITableView!
    
    @IBOutlet var AlbumArt : UIImageView!
    
    @IBOutlet var MusicTitle : UILabel!
    var player: AVAudioPlayer?

    
    var counterBTS = 0
    var BTS = [ 275, 279, 282, 310, 313, 317, 345, 348, 351, 353, 378, 382, 385, 413, 447, 481, 515, 687, 700, 708, 721, 737, 743, 755, 768, 777, 789, 804, 824, 828, 833, 837, 841, 846, 850, 854, 859, 863, 867, 871, 876, 880, 884, 889, 893, 897, 901, 906, 910, 914, 918, 923, 927, 931, 936, 940, 961, 974, 983, 996, 1009, 1016, 1030, 1043, 1051, 1064, 1079, 1099, 1111, 1120, 1133, 1149, 1154, 1167, 1180, 1188, 1201, 1218, 1223, 1235, 1270, 1304, 1337, 1510, 1522, 1531, 1544, 1559, 1578, 1591, 1599, 1612, 1627, 1647, 1651, 1656, 1660, 1664, 1668, 1673, 1677, 1681, 1685, 1689, 1694, 1698, 1702, 1707, 1711, 1715, 1720, 1724, 1728, 1733, 1737, 1741, 1745, 1749, 1754, 1758, 1762, 1767, 1771, 1776, 1780, 1784]
    var BTSweak = [ 147, 216, 288, 302, 335, 370, 404, 426, 460, 494, 529, 551, 554, 559, 563, 568, 572, 576, 580, 584, 589, 593, 597, 602, 606, 610, 615, 619, 621, 623, 625, 627, 630, 632, 634, 636, 638, 640, 642, 644, 646, 649, 651, 652, 654, 657, 658, 660, 661, 662, 664, 665, 667, 696, 712, 730, 747, 764, 781, 798, 970, 987, 1004, 1038, 1055, 1072, 1107, 1124, 1141, 1159, 1175, 1193, 1209, 1227, 1249, 1283, 1317, 1351, 1373, 1377, 1382, 1386, 1390, 1395, 1399, 1403, 1407, 1411, 1416, 1420, 1424, 1428, 1433, 1437, 1441, 1443, 1445, 1447, 1449, 1451, 1453, 1455, 1457, 1459, 1461, 1463, 1465, 1467, 1469, 1471, 1473, 1475, 1477, 1478, 1479, 1481, 1482, 1483, 1484, 1485, 1486, 1488, 1489, 1518, 1535, 1553, 1587, 1604, 1621]

    
    var counterDALGONA = 0
    var counterDALGONATWO = [ 94, 104, 116, 127, 139, 151, 162, 173, 185, 197, 208, 220, 232, 243, 256, 259, 264, 278, 289, 301, 313, 324, 336, 347, 359, 370, 382, 394, 405, 416, 428, 439, 445, 451, 462, 474, 486, 497, 509, 520, 532, 543, 555, 566, 578, 589, 601, 613, 624, 628, 633, 648, 659, 670, 682, 693, 705, 716, 727, 739, 750, 762, 774, 785, 797, 809, 843, 855, 866, 879, 890, 901, 912, 924, 930, 936, 947, 957, 969, 982, 994, 1005, 1016, 1109, 1122, 1127, 1131, 1141, 1154, 1201, 1212, 1224, 1236, 1246, 1258, 1270, 1282, 1293, 1305, 1316, 1328, 1340, 1351, 1363, 1385, 1397, 1409, 1420, 1432, 1444, 1455, 1467, 1478, 1490, 1501, 1513, 1524, 1535, 1546, 1593, 1605, 1616, 1628, 1639, 1651, 1662, 1674, 1686, 1697, 1709, 1720, 1731, 1743, 1755, 1759, 1763, 1778, 1789, 1800, 1812, 1823, 1835, 1847, 1858, 1869, 1881, 1893, 1905, 1916, 1928, 1939, 1951]
    
    var counterDALGONATHREE = [ 99, 110, 122, 133, 145, 157, 168, 179, 191, 203, 214, 226, 238, 249, 284, 295, 307, 319, 330, 342, 353, 365, 376, 388, 399, 411, 422, 433, 468, 480, 492, 503, 515, 526, 538, 549, 561, 572, 584, 595, 607, 619, 654, 665, 676, 687, 699, 710, 722, 733, 745, 757, 768, 779, 791, 803, 849, 860, 872, 884, 895, 906, 918, 941, 952, 963, 976, 987, 999, 1011, 1178, 1183, 1187, 1190, 1207, 1218, 1230, 1241, 1252, 1265, 1276, 1287, 1299, 1311, 1322, 1333, 1345, 1357, 1391, 1403, 1415, 1426, 1438, 1450, 1461, 1472, 1484, 1495, 1507, 1518, 1530, 1541, 1599, 1611, 1622, 1634, 1645, 1657, 1668, 1680, 1691, 1703, 1714, 1726, 1737, 1749, 1783, 1795, 1806, 1818, 1829, 1841, 1853, 1864, 1876, 1887, 1899, 1910, 1922, 1933, 1945, 1957]

    

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return music.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = musicTableView.dequeueReusableCell(withIdentifier: "MusicCell") as UITableViewCell!

        cell?.textLabel?.text = music[indexPath.row]
        
      //  cell?.backgroundColor = UIColor.gray
        
        
        return cell!
        
    }
    
    func playSound(music: String?) {
        let url = Bundle.main.url(forResource: music, withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        var cell = musicTableView.dequeueReusableCell(withIdentifier: "MusicCell") as UITableViewCell!
        
        //if cell?.isSelected == true {
        


    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var cell = musicTableView.dequeueReusableCell(withIdentifier: "MusicCell") as UITableViewCell!

        musicTableView.deselectRow(at: indexPath, animated: true)
        
        print(indexPath.row)

        if indexPath.row == 0{
            AlbumArt.image = UIImage(named: "cover53.jpg")
            print(cell?.tag)
            MusicTitle.text  = music[0]
            
            playSound(music: "1-01 달고나")
            
            var timerDALGONA = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.DALGONA), userInfo: nil, repeats: true);

            
        } else if indexPath.row == 1 {
            
            AlbumArt.image = UIImage(named: "7f0c8aadd28d54f1cbceaf9de8d06c99.jpeg")
            MusicTitle.text  = music[1]
            

            
            playSound(music: "[MP3] BTS – Save ME (Special Album)")
            
            var timerBTS = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.playTap), userInfo: nil, repeats: true);


            
        }
        
    }
    
    func playTap() {
        counterBTS += 1
        
        for time in BTS {
            
            if counterBTS == time {
                AudioServicesPlaySystemSound(1520)
            }
            
        }
        for timey in BTSweak {
            if counterBTS == timey {
                AudioServicesPlaySystemSound(1519)
            }
            
        }
        
        
        /*
         if counterBTS == 2000 {
         print(BTS)
         
         }
         
         if counterBTS == 2001 {
         print(BTSweak)
         
         }
         */
    }

    func DALGONA() {
        counterDALGONA += 1
        
        for time in counterDALGONATWO {
            
            if counterDALGONA == time {
                AudioServicesPlaySystemSound(1520)
            }
            
        }
        for timey in counterDALGONATHREE
        {
            if counterDALGONA == timey {
                AudioServicesPlaySystemSound(1519)
            }
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

