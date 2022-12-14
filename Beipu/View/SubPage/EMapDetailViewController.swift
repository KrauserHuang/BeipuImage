//
//  EMapDetailViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/8/4.
//

import UIKit

class EMapDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var addrLabel: UILabel!
    
    var index = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let store = storeList[index]
        titleLabel.text = store.0
        descriptLabel.text = store.2
        addrLabel.text = store.1
    }


    let storeList:[(String,String,String)] = [("","",""),("北埔第一棧","水際村3鄰31之1號","民國九十一年，從原本的光君製茶廠，改建成現在這種客家唐式風格建築， 取名北埔第一棧，讓客家美食與茶文化更多元豐富。 北埔第一棧在吃的文化上，除酸、鹹、香一貫的客家菜特色外，也發展出令人讚嘆垂涎的料理，如金桔入菜與膨風茶入菜等， 都是極具地方特色的客家美食。 另外，特色膨風茶之產製和銷售，是近年北埔鄉對外的一項主要文化產業，亦是地方重要的經濟來源，「北埔第一棧」為北埔產茶勝地，開設膨風茶文物館，配合四周觀光茶園、果園、客家歷史古蹟、水域遊憩設施等，亦成為遊客想了解北埔鄉茶業的遊憩據點重心，更能吸引國內遊客甚至國際觀光客之注意。北埔第一棧在客家文化的傳承與發揚一直在北埔站在領先的地位，我們希望用認真傳承的心，永續經營這樣的一塊寶地。"),
                   ("福美軒飲食店","新竹縣北埔鄉北埔村南興街132號","本店開業至今已長達三十年的歷史，早期第一代是以外燴為主，現在第二代接手營業項目以辦桌、喜宴、外燴、自助餐為主，隨著時代環境的變遷，店內重新裝潢後開始經營團體訂餐(開會、聚餐).便當訂做、經濟快炒、客家小吃，可說是一家很多元化的餐廳呢! 本店位於北埔口附近的南興街上，本店面前還有一頭二十年歷史的木雕水牛在此歡迎大家光臨! 店內裝潢古色古香，每桌都鋪上油桐花的客家布，讓顧客在享用客家美食的同時別有一番感受。"),
                   ("登富茶坊客家菜","新竹縣北埔鄉北埔街34號","創立於2003年的『登富茶坊』位於新竹北埔老街上，提供擂茶套餐、精緻客家菜，餐點美味精緻，乾淨舒適的品茶空間搭配輕音樂，讓平常忙碌的客人感受輕鬆無壓力的氣氛。"),
                   ("姜太公柿餅農產商行","新竹縣北埔鄉廟前街24號","過了9月霜降後新竹吹起俗稱的「九降風」，也就是強烈的東北季風，秋天是柿餅的季節，故事就從一棵柿子樹開始。         傳承於姜家老宅的果樹  北埔的第一棵柿子樹，是當年姜家祖先飄洋過海來台灣，辛苦抵達新竹開墾時帶來的，隨著姜家人一代代生活下去，這棵樹也落地生根，種在姜家老宅「天水堂」裡，之後分枝散葉流傳在北埔各地栽種生長，也促成了北埔柿子產業蓬勃發展。  秋季時將摘下的柿青（剛成熟的柿子，味道苦澀）製作成柿餅享用。直到九二一大地震那年，災後政府為了振興產業，鼓勵地方觀光並推行「一鄉一特色」，展現地方上的農產品特色，柿餅便成了北埔的招牌之一，便成立了「姜太公柿餅農產商行」。 取名姜太公柿餅，則有「姜太公釣魚，願者上鉤」的含意，店裡大方提供顧客試吃，讓客人自行比較石柿、四周柿、筆柿、牛心柿4種柿餅口感，喜歡再買，客人往往一試成主顧。"),
                   ("北埔擂茶堂","新竹縣北埔鄉廟前街4-1號","我們店內提供現炒蔬食套餐、下午茶、擂茶DIY有空到北埔玩，記得來北埔擂茶堂走走、坐坐喔"),
                   ("山水屋民宿","新竹縣北埔鄉南坑村大南坑7-7號","山水屋簡餐咖啡民宿、為一處結合住宿、用餐的全方位的休閒空間。以歐式風格為設計主軸，搭配寬敞的綠意庭園和典雅的古堡式建築，展現歐洲鄉野的寧靜與愜意"),
                   ("清香麵店","北埔鄉 正德街9號","因為家裡有两個身心障礙的小孩   深深體會到身障家庭的辛苦付出  所以本店有提供愛心麵 給有需要的身障朋友們享用"),
                   ("北埔廟前粄條","新竹縣北埔鄉北埔街13號","1989年 原店名為”北埔粄條”由一對台鐵退休夫婦回鄉成立，是北埔地區首家以“北埔粄條”為名號的店家 現在 年輕的一代接手父母的手藝 用傳統、簡單的方式調味 用友善、熱忱的服務招待著到訪的客人"),
                   ("璞鈺擂茶","新竹縣北埔鄉廟前街8號","璞鈺將傳統擂茶摻入現代人的健康需求，開發出無糖、紅棗、漢方、綠茶、杏仁、松子、咖啡、咖啡杏仁、山葯薏仁、鹹味精力湯及養生精力湯十二種新口味夾鏈袋包裝，其中無糖口味上市後普獲好評，造福無數忌口的消費者。"),
                   ("哈客愛擂茶","新竹縣北埔鄉北埔村中豐路30號","哈客愛是位在“新竹北埔“的擂茶名店，多年來不斷地推廣客家的擂茶文化，擁有自己的工廠自產自銷，嚴選優質的天然食材製作，將傳統的擂茶創新出不同的新滋味，打造擂茶的首選品牌。"),
                   ("大豐收庭苑餐館","新竹縣北埔鄉中正路30號之1","(一)【大豐收庭苑餐館】門店位於新竹北埔老街，由鄭建卿小姐（陸籍外配，食材料理）與夫婿陳文忠先生（門店管理及帳務）共同經營，建築主體為舊教堂裝修而成（月租金3萬元），用餐空間雖沒有華麗裝潢，但環境整齊、乾淨、古樸，是個舒適用餐空間，可同時容納50人。餐館前院即為停車場，停車便利。屬客家家常料理，以剁椒魚頭及胡椒鴨為招牌菜，胡椒鴨由夫婿陳文忠先生之媽媽（北埔甘姐胡椒鴨）傳授，深受好評，已累積了不少忠實顧客。 (二)因食材新鮮，口味道地，加上停車便利，108年11月開業以來，生意興隆，但因Covid-19疫情影響，旅遊人潮驟降，導致營業額大幅滑落。隨著國內疫情趨緩及疫苗覆蓋率提升，旅遊人潮再現，大豐收庭苑餐館的營運應能回到昔日榮景。另藉由微創鳳凰第一次核撥的貸款（60萬元）幫助，汰換了部分生財器具，在停車便利及特色美食加持之下，【大豐收庭苑餐館】未來的營收及獲利可期。"),
                   ("新竹北埔林 - 客家香酥脆花生小魚乾","新竹縣北埔鄉北埔村正德街20號","我懷孕時，醫生說要多吃小魚乾補充鈣質，回娘家，父親就做了這道我最愛的客家料理。剛好北埔老街開始繁榮發展，因為懷孕辭去科學園區工作，無收入來源，父親先做5斤讓我試賣，沒想到遊客也愛上這個味道，從五斤，十斤開始賣，晃眼三個兒子相繼出生，漸漸的做到全台宅配，客人各自帶出國當伴手禮，賣到現在已有25年，父母親皆是廚師，而我這個女兒也受父母引響學會手藝，靠著信用與真材實料繼續經營"),
                   ("秀汶水","新竹縣北埔鄉北埔街22~2號(南興街102號對面)","傳統客家美食，堅持採用純米製作，真材實料，無添加防腐劑，百分百純手工，"),
                   ("茶米二十二","北埔鄉南興街67號","民國88年春.老闆受農會總幹事建議.開設第一家擂茶專賣店.將原本是居家的一道餐食.推廣出來.經過媒體的廣為報導.使擂茶成為客家族群代表性茶飲.逐漸成為北埔一遊的必by體驗遊程.也成為許多常客的日常早餐或午茶.並且是客委會許多活動中代表性的客家茶."),
                   ("泥磚屋小吃店","新竹縣北埔鄉長春街113號","一間保存完整的三合院古厝餐坊。擁有令人嘖嘖稱奇的百年歷史，質樸的屋頂、泥磚的牆壁、復古的窗櫺、木製的桌椅、一口百年古井，在在都顯示了歷史與歲月的痕跡。泥磚屋堅持用餐品質及衛生，廚房作業過程公開透明化。提供傳統道地客家美食、地瓜飯免費吃到飽、茶水服務，另附設大型停車場。"),
                   ("噹好吃鹹豬肉","新竹縣北埔鄉廟前街20-10號","位於新竹縣北埔鄉的噹好吃鹹豬肉，是北埔數一數二的鹹豬肉的專賣店，除遵照古法醃製外更研究出特調獨門的秘製醬料，將傳統的客家風味佳餚發揮到淋漓盡致。店家老闆說以前吃到別人做的鹹豬肉都覺得好鹹啊!自己在想如果鹹豬肉可以不要醃製的那麼鹹的話，那有更多的人會喜歡這道集祖先智慧及傳統美味的客家風味料理，就這樣自然而然地開始研究製作出附合現代人健康導向需求，配方中加入中藥香料的客家傳統美食料理---鹹豬肉。在噹好吃鹹豬肉的醃醬中就有一樣是來自老闆娘越南娘家自己種的胡椒，定時由越南寄過來，味道就是不一樣。而選用的都是新鮮且經合格認證的溫體豬肉，每天親自選購當天早上現宰的溫體豬肉，回來首先將豬肉清洗處理乾淨、以手工切割分片，再加上自行研究的獨門特調醬料去醃製，放入冷藏室繼續醃製一個星期使其入味後，放入烤箱烤熟，再加以真空包裝販售。"),
                   ("陳記鹹豬肉","新竹縣北埔鄉大林村6鄰11-2號","銘軒食品行本於本土、天然、創意理念經營，熱銷產品「陳記客家鹹豬肉」更是在未上市前經長期精心不斷的研發調配出客家元素不含人工味素、防腐劑、香精等安心食用的客家鹹豬肉。創始人係閩南人嫁到北埔的媳婦對此地客家美食深感著迷，且其夫家叔「陳記仙草」亦頗知名，遂思索研發「陳記客家鹹豬肉」為因應市場需求及本土客家特色故採用：真空包裝、客家創意禮盒設計，自用送禮兩相宜，受者溫馨送者大方。"),
                   ("阿麵製麵廠","新竹縣北埔鄉中豐路157號","源於一對夫妻，一份傳承一份情，延續銘豐製麵廠，將傳統的製麵技術，結合新時代對於麵食的需求，以及融合在地文化 ，多元的發展，創立了嶄新的品牌「阿麵ArtMet」。是北埔在地的製麵廠，每天有固定的專車路線送到麵店及餐廳，在新竹麵的市場佔有一席之地，但為了讓每一個家庭也能吃到【阿麵ArtMet】，研發乾麵以嶄新的風貌，從食材的挑選，到產品的呈現，都能品出滿滿的用心，給您不只是麵食，更是天然，健康，美味，和濃濃的「阿麵ArtMet」文化."),
                   ("佐京茶陶","新竹縣北埔鄉南興街63號","北埔茶農第二代彭峻暘以「佐京」為號，在老街上開了一間小茶舖，裡頭除了提供旅人品玩擂茶，更努力發揚自然農法種植的膨風茶、以及熱愛的工藝創作。十八歲那年，彭峻暘為幫母親分擔勞務，在北埔陶藝家沈東寧的工作室打工，沒想到一頭栽入陶的世界。彭峻暘沖茶手法熟練，所用杯壺器皿，皆是出自自己的雙手。從粗獷的鐵釉到清潤的青瓷，以茶事為主題的創作，從泡茶的杯壺到藏茶的大甕，意在把母親栽種的茶與親自燒製的器結合起來，從滋味到品味慢慢延伸彭式茶美學。"),
                   ("隆源餅行","新竹縣北埔鄉中正路16號","隆源餅行頂著百年老店的金字招牌，自製自銷的各式糕餅聞名全台，販售蕃薯餅、芋仔餅、擂茶餅、綠豆凸、竹塹餅、鳳梨酥、客式喜餅等各式糕餅，料多味美、口感極佳，平日常出現門庭若市的搶購人潮，假日更是出現大排長龍，等著買各式糕餅贈送親友的盛況空前，形成一特殊景緻，甚至還有一些國外的朋友不遠千里而來，只為了那令人垂涎三尺的蕃薯餅、芋仔餅，可見隆源餅行糕餅所散發的魅力驚人、不同凡響！"),
                   ("鄒記菜包","新竹縣北埔鄉中正路49號","在遠離觀光客的中正路上，鄒竣宇的「鄒記菜包」以清新姿態佇立，紅磚修葺的店頭，蒸籠冒陣陣白煙，玻璃小櫃裡陳列著當日出爐的豬籠粄，純手工捏製的漂亮外型，有著不輸西洋甜點的精緻，就算當成下午茶招待貴客，也令主人家有面子。當年輕人一窩蜂搶開咖啡館、甜點店時，鄒竣宇卻選擇賣最傳統菜包，這個決定既不創意也不時髦，他自己也坦言：「這個創業當初是沒有人看好的。他們都說菜包是老人家在賣的，年輕人賣感覺怪怪的。」鄒記菜包的店齡雖然才三年，口味卻傳承慈天宮廟前的無名老攤，而奠定口味的靈魂人物就是鄒竣宇的祖母。「我們家的菜包從一顆十元賣到現在，算下來已有將近二十年歷史了。」原本只為了分擔長輩的勞務，鄒竣宇利用假日偶爾回來幫忙擺攤，沒想到無心插柳，竟讓他漸漸對傳統手製食物產生興趣。"),
                   ("阿滿水晶餃","新竹縣北埔鄉光復街30號","阿滿姐包水晶餃的工夫是傳承自婆婆的好手藝，由於傳統的水晶餃外皮較為生硬，在經過不斷的改良修正後，終於研發出更Q彈有嚼勁的口感 。 阿滿水晶餃好吃的祕訣就在於手工製的外皮，與謹慎掌控外皮粉漿的細節比例，並搭配新鮮特選的溫體豬前腿肉內餡，簡單用心的口味迅速征服在地人的胃，成功打響口碑，阿滿姐堅持的傳統美味更成為許多饕客到北埔必吃的美食名單之一。"),
                   ("陳媽媽黃金包","新竹縣北埔鄉廟前街4-1號","北埔鄉「陳媽媽黃金包」老闆吳碧嫦傳承母親客家米食好手藝，2007年8月她嘗試將地方盛產的南瓜打成泥，與麵粉調和成包子皮，內餡有竹筍、酸菜、菜脯等口味，取名叫「黃金包」，黃澄澄的皮好看又好吃。50歲吳碧嫦是北埔客家人，在母親吳張滿妹調教下，擅於製作蘿蔔糕、年糕、粽子等客家米食，每到年節檔期，訂單接不完。去年推出「黃金包」後，也讓「陳媽媽黃金包」很快就打響名號。吳碧嫦說，北埔出產的南瓜甜度、香氣兼具，口感鬆糯，常因生產過剩，市場價格差，不少農民拿來餵豬，讓人覺得可惜，便靈機一動，把南瓜肉連同籽打成泥，再與麵粉攪和，成為色澤澄黃的包子皮，蒸熟後口感彈牙，香味四溢。黃金包以純手工製作，內餡有竹筍、酸菜、菜脯等口味，其中竹筍口味是素食的，內含素肉條，也是最暢銷的口味，不少到北埔老街的遊客都不會錯過。吳碧嫦76歲的母親吳張滿妹在店裡也幫忙做麵皮，動作俐落。"),
                   ("彭家粄糕","新竹縣北埔鄉南興街90號","「我們到現在還在磨合。」彭家粄糕第三代接班人彭家麒十年前因父親離世，不捨母親獨自經營家業，決定回家幫忙；即使偶有意見不合，母子倆仍協力撐起了營業近一甲子老店。彭家麒剛回到北埔時，主要幫忙脫水、磨米的重活，學到現在晉級為生產主力，七十歲的媽媽羅翔憶則退居協助的角色。清晨天還未亮，羅阿姨便起床將前晚做好的米食脫模、分切裝袋，一個個擺上家門前的小攤子，等著四、五點做早活的客人上門，開始一天的營業；中午後由彭家麒接手製作隔日要賣的粄糕，傍晚五點關店後也不得閒，一直忙到九點左右才休息，遇上假日或大筆訂單還得熬夜做到早上。\n和最熟悉的家人當同事可不容易，母子倆的個性和作法不同，難免有意見上的分歧，但總歸是一家人，彭家麒不把這些事放心上，這幾年兩人就這樣輪班顧店，加上彭家麒還要照顧一歲多的孩子，全家只有公休日前一晚能坐下來好好吃飯，他便邀集住外地的姊姊一起上館子，度過難得的家庭時光。"),
                   ("民歌擂茶","新竹縣北埔鄉北埔街41號","北埔的「民歌擂茶」絕對是北埔當地的人氣茶館；一走進店內，恰如其名的台灣民歌，正撩撥著四五六年級生的青春與童年記憶。在百年老宅中，一邊磨擂茶，聽懷舊民歌，點些茶食，三五好友談天說地快活又自在。愛唱歌的他，10多年前回到北埔，與朋友合夥開擂茶店，租約到期時，因緣際會租到「民歌擂茶」現址，繼續唱民歌和客人交朋友。多才多藝、愛唱歌也愛樂器的他，還會親手做二胡。而店內牆上的空間留給顧客們隨意塗鴉，其中不乏演藝圈的天王天后等名人的肯定，待下次上門時還能發現前次塗鴉的內容，增添擂茶時的樂趣；另一方面民歌擂茶不斷精益求精，接受中國生產力中心的輔導，成為優良店家。當您有機會到這裡擂茶時，推薦您還可以再來一盤炸豆皮，這是北埔在地獨一無二的傳統零食，口感相當香脆，是搭配擂茶的最佳良伴！"),
                   ("深山裡柴燒蘿蔔糕","新竹縣北埔鄉南興街100號","「深山裡」的柴燒蘿蔔糕 三代人合製，位在新竹縣峨眉鄉六寮古道最深處，花甲之年的莊煥章與妻子曾招華，加上女兒女婿和外孫，三代五人合力製作古樸蘿蔔糕，堅持用柴火蒸煮6小時，要讓古早味在大家舌尖上回味童年。 我們的蘿蔔糕是長輩以傳統的比例和方式，女兒女婿和外孫，燒木柴火蒸煮出來的，使用在來米磨成米漿（不添加在來米粉製作），再加上新鮮的白蘿蔔絲，少許鹽巴調味。香氣十足，非常Q彈，口感絕佳！ 古早農村時代，家家戶戶都會做蘿蔔糕，59歲曾招華吃過婆婆好手藝後，20年前毅然辭去工作，專心向婆婆拜師，加上每個禮拜試做調整配方比例，她笑著說：當時家裡餐桌天天都有做「失敗的蘿蔔糕」可吃。 莊家蘿蔔糕原料只有在來米漿、白蘿蔔和鹽。 曾招華說，蘿蔔好不好吃？是關鍵，原本自己栽種，但面對一籠要用掉50台斤蘿蔔，改採梨山白蘿蔔。 女兒、女婿以及16歲外孫，五人合力製作傳統「柴燒」蘿蔔糕，全家人各司其職，熱騰騰蘿蔔糕起鍋前後，莊家三代五口傳承阿婆古早味，堅持用炭火柴燒，一籠要耗時12小時才完成。全家人一起做得「很幸福」。 女兒莊千慧說，每條蘿蔔絲都要均勻沾上米漿，蒸煮6小時間柴火絕不能斷，蒸完還要放涼6～7小時，才能「送出深山」販賣。她說，家人也曾改用瓦斯，但味道就是不對，看到客人回味的表情，「堅持」傳統很「值得」。"),
                   ("北埔食堂","新竹縣北埔鄉北埔街4號","北埔食堂賣的是傳統客家菜，以蒜仁豬腳、紅槽鴨、薑絲炒大腸、爌肉竹筍最受歡迎，其中蒜仁豬腳將整隻豬蹄燙熟後，皮Q肉嫩，沾著以辣椒、蒜獨家調成醬汁入口，肉香夾帶蒜香濃腴襲人，爌肉竹筍也很好吃。"),
                   ("上品擂茶客家菜","新竹縣北埔鄉南興街89號","位於北埔南興街，是北埔擂茶的老店，店面原為巫老闆的住家，裝潢成店面後開始營業，由一開始的擂茶推廣，隨著北埔擂茶館的興起，分散了客源後，逐漸轉型結合傳統客家菜，店內隨處可見歷史痕跡，老闆還翻髒島貴第把啊公時代使用的古董級『錢櫃』搬出來當櫃檯，而有著斑駁歷史光澤的茶盤成放著擂茶，讓人彷彿回到過去。"),
                   ("榕樹下粄條","新竹縣北埔鄉城門街59號","粄條是流行於華南的客家美食，客家人將粄切成條狀加以烹煮，故稱粄條。其製作方法是將米磨成米漿，放入方形平底盤隔水蒸熟，取出放涼後切成長條狀，吃法有湯粄條、乾粄條兩種，油蔥是最重要的提香配搭，而且最好是當天做當天吃，或煮或炒，以保持有彈Ｑ的最佳口感。雖然招牌寫著50年，但這家可是從民國50年就開始，直到民國80年由第二代接手，小吃攤都是年輕面孔，現在已經傳承到第三代，一早六點開始營業到下午兩、三點就結束。"),
                   ("劉家小館","新竹縣北埔鄉南興街65號","好吃到爆表的滷味！不起眼的外觀，引人側目的是店門口擠滿滿的人潮，大約可容納的20~30人的用餐空間，不算擁擠，客家菜也是相當出名。")]
}
