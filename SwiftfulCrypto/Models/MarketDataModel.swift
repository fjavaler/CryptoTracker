//
//  MarketDataModel.swift
//  SwiftfulCrypto
//
//  Created by Frederick Javalera on 6/12/21.
//

import Foundation

//JSON data:
/*
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 7887,
     "upcoming_icos": 0,
     "ongoing_icos": 50,
     "ended_icos": 3375,
     "markets": 622,
     "total_market_cap": {
       "btc": 44035853.57490479,
       "eth": 657870692.2196349,
       "ltc": 9753717218.56748,
       "bch": 2712952184.113949,
       "bnb": 4564222926.990855,
       "eos": 325746437087.1406,
       "xrp": 1879540511134.9727,
       "xlm": 4868297495369.058,
       "link": 72434730120.99391,
       "dot": 75568217201.63351,
       "yfi": 43101775.94850337,
       "usd": 1560345648289.8396,
       "aed": 5731305600733.401,
       "ars": 148439651041141.62,
       "aud": 2024323788882.7107,
       "bdt": 132434155898504.84,
       "bhd": 588111438642.5728,
       "bmd": 1560345648289.8396,
       "brl": 7983190198962.727,
       "cad": 1896740566604.6438,
       "chf": 1401656935513.116,
       "clp": 1126570405332952,
       "cny": 9984183699712.191,
       "czk": 32720370227355.527,
       "dkk": 9583151462916.99,
       "eur": 1288588048455.4375,
       "gbp": 1106040090370.7166,
       "hkd": 12110295076615.436,
       "huf": 448657886845141.7,
       "idr": 22194356501274664,
       "ils": 5076428532146.149,
       "inr": 114266920446431.75,
       "jpy": 171139512456834.12,
       "krw": 1742203933598021.2,
       "kwd": 469085151899.7256,
       "lkr": 309202982228030.5,
       "mmk": 2570448254717025.5,
       "mxn": 31006876653686.04,
       "myr": 6409899923174.648,
       "ngn": 642862407095413.8,
       "nok": 13009537877181.346,
       "nzd": 2189213315265.7432,
       "php": 74553315075288.38,
       "pkr": 243257886568386.1,
       "pln": 5800818999364.714,
       "rub": 112265309048805.45,
       "sar": 5851862586557.243,
       "sek": 12993271273797.934,
       "sgd": 2068537743172.6555,
       "thb": 48484952682933.29,
       "try": 13086306883077.219,
       "twd": 43152919249103.8,
       "uah": 42196494461564.984,
       "vef": 156237409763.26157,
       "vnd": 35786527443527450,
       "zar": 21423545751019.49,
       "xdr": 1082389931379.585,
       "xag": 55879301201.4902,
       "xau": 831352161.4088277,
       "bits": 44035853574904.79,
       "sats": 4403585357490479
     },
     "total_volume": {
       "btc": 3092330.537294436,
       "eth": 46197665.44734689,
       "ltc": 684935459.5978438,
       "bch": 190511690.0001714,
       "bnb": 320513508.66051036,
       "eos": 22874897908.041824,
       "xrp": 131987007104.97661,
       "xlm": 341866542542.5741,
       "link": 5086585355.563073,
       "dot": 5306628275.162603,
       "yfi": 3026736.7873422215,
       "usd": 109572180512.71956,
       "aed": 402469576241.2696,
       "ars": 10423880283802.23,
       "aud": 142154125821.2596,
       "bdt": 9299926110644.127,
       "bhd": 41298960129.22971,
       "bmd": 109572180512.71956,
       "brl": 560603708868.506,
       "cad": 133194846909.4566,
       "chf": 98428580182.39557,
       "clp": 79111173827877.6,
       "cny": 701119511446.7383,
       "czk": 2297723146742.7036,
       "dkk": 672957817472.2623,
       "eur": 90488541693.7216,
       "gbp": 77669473151.17778,
       "hkd": 850421468891.5641,
       "huf": 31506110854176.23,
       "idr": 1558554695612921.8,
       "ils": 356482132080.08075,
       "inr": 8024168008871.366,
       "jpy": 12017933060108.598,
       "krw": 122342818151477.08,
       "kwd": 32940575055.358322,
       "lkr": 21713166580042.035,
       "mmk": 180504634004107.2,
       "mxn": 2177396456712.6606,
       "myr": 450122517546.251,
       "ngn": 45143738371240.44,
       "nok": 913569012242.849,
       "nzd": 153733165996.94153,
       "php": 5235358784897.7295,
       "pkr": 17082302941932.984,
       "pln": 407351016883.11127,
       "rub": 7883608815709.645,
       "sar": 410935451624.22546,
       "sek": 912426722261.0046,
       "sgd": 145258963128.2683,
       "thb": 3404759703946.185,
       "try": 918959963524.0757,
       "twd": 3030328224259.7715,
       "uah": 2963165189209.2354,
       "vef": 10971462434.738604,
       "vnd": 2513037960059221,
       "zar": 1504426038439.639,
       "xdr": 76008687611.14632,
       "xag": 3924013172.904992,
       "xau": 58380057.77717705,
       "bits": 3092330537294.4355,
       "sats": 309233053729443.56
     },
     "market_cap_percentage": {
       "btc": 42.54151037696967,
       "eth": 17.67349180626313,
       "usdt": 4.0104767478688474,
       "bnb": 3.385761331484726,
       "ada": 3.0014476757701885,
       "doge": 2.5963540903659226,
       "xrp": 2.4574935708118972,
       "usdc": 1.510547100310248,
       "dot": 1.3303693798144025,
       "uni": 0.7108119284509731
     },
     "market_cap_change_percentage_24h_usd": 0.8849511547374446,
     "updated_at": 1623554438
   }
 }
 */
struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
  
  enum CodingKeys: String, CodingKey {
    case totalMarketCap = "total_market_cap"
    case totalVolume = "total_volume"
    case marketCapPercentage = "market_cap_percentage"
    case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
  }
  
  var marketCap: String {
    if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
      return "$" + item.value.formattedWithAbbreviations()
    }
    
    return ""
  }
  
  var volume: String {
    if let item = totalVolume.first(where: { $0.key == "usd" }) {
      return "\(item.value.formattedWithAbbreviations())"
    }
    
    return ""
  }
  
  var btcDominance: String {
    if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
      return item.value.asPercentageString()
    }
    
    return ""
  }
}
