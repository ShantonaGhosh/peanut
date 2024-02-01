// To parse this JSON data, do
//
//     final tradeListModel = tradeListModelFromJson(jsonString);

import 'dart:convert';

List<TradeListModel> tradeListModelFromJson(String str) => List<TradeListModel>.from(json.decode(str).map((x) => TradeListModel.fromJson(x)));

String tradeListModelToJson(List<TradeListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TradeListModel {
    double currentPrice;
    dynamic comment;
    int digits;
    int login;
    double openPrice;
    DateTime openTime;
    double profit;
    double sl;
    double swaps;
    String symbol;
    double tp;
    int ticket;
    int type;
    double volume;

    TradeListModel({
        required this.currentPrice,
        required this.comment,
        required this.digits,
        required this.login,
        required this.openPrice,
        required this.openTime,
        required this.profit,
        required this.sl,
        required this.swaps,
        required this.symbol,
        required this.tp,
        required this.ticket,
        required this.type,
        required this.volume,
    });

    factory TradeListModel.fromJson(Map<String, dynamic> json) => TradeListModel(
        currentPrice: json["currentPrice"]?.toDouble(),
        comment: json["comment"],
        digits: json["digits"],
        login: json["login"],
        openPrice: json["openPrice"]?.toDouble(),
        openTime: DateTime.parse(json["openTime"]),
        profit: json["profit"]?.toDouble(),
        sl: json["sl"]?.toDouble(),
        swaps: json["swaps"]?.toDouble(),
        symbol: json["symbol"],
        tp: json["tp"],
        ticket: json["ticket"],
        type: json["type"],
        volume: json["volume"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "currentPrice": currentPrice,
        "comment": comment,
        "digits": digits,
        "login": login,
        "openPrice": openPrice,
        "openTime": openTime.toIso8601String(),
        "profit": profit,
        "sl": sl,
        "swaps": swaps,
        "symbol": symbol,
        "tp": tp,
        "ticket": ticket,
        "type": type,
        "volume": volume,
    };
}
