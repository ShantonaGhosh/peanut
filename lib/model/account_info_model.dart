// To parse this JSON data, do
//
//     final accountInfoModel = accountInfoModelFromJson(jsonString);

import 'dart:convert';

AccountInfoModel accountInfoModelFromJson(String str) => AccountInfoModel.fromJson(json.decode(str));

String accountInfoModelToJson(AccountInfoModel data) => json.encode(data.toJson());

class AccountInfoModel {
    String address;
    double balance;
    String city;
    String country;
    int currency;
    int currentTradesCount;
    double currentTradesVolume;
    double equity;
    double freeMargin;
    bool isAnyOpenTrades;
    bool isSwapFree;
    int leverage;
    String name;
    String phone;
    int totalTradesCount;
    double totalTradesVolume;
    int type;
    int verificationLevel;
    String zipCode;

    AccountInfoModel({
        required this.address,
        required this.balance,
        required this.city,
        required this.country,
        required this.currency,
        required this.currentTradesCount,
        required this.currentTradesVolume,
        required this.equity,
        required this.freeMargin,
        required this.isAnyOpenTrades,
        required this.isSwapFree,
        required this.leverage,
        required this.name,
        required this.phone,
        required this.totalTradesCount,
        required this.totalTradesVolume,
        required this.type,
        required this.verificationLevel,
        required this.zipCode,
    });

    factory AccountInfoModel.fromJson(Map<String, dynamic> json) => AccountInfoModel(
        address: json["address"],
        balance: json["balance"]?.toDouble(),
        city: json["city"],
        country: json["country"],
        currency: json["currency"],
        currentTradesCount: json["currentTradesCount"],
        currentTradesVolume: json["currentTradesVolume"]?.toDouble(),
        equity: json["equity"]?.toDouble(),
        freeMargin: json["freeMargin"]?.toDouble(),
        isAnyOpenTrades: json["isAnyOpenTrades"],
        isSwapFree: json["isSwapFree"],
        leverage: json["leverage"],
        name: json["name"],
        phone: json["phone"],
        totalTradesCount: json["totalTradesCount"],
        totalTradesVolume: json["totalTradesVolume"]?.toDouble(),
        type: json["type"],
        verificationLevel: json["verificationLevel"],
        zipCode: json["zipCode"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "balance": balance,
        "city": city,
        "country": country,
        "currency": currency,
        "currentTradesCount": currentTradesCount,
        "currentTradesVolume": currentTradesVolume,
        "equity": equity,
        "freeMargin": freeMargin,
        "isAnyOpenTrades": isAnyOpenTrades,
        "isSwapFree": isSwapFree,
        "leverage": leverage,
        "name": name,
        "phone": phone,
        "totalTradesCount": totalTradesCount,
        "totalTradesVolume": totalTradesVolume,
        "type": type,
        "verificationLevel": verificationLevel,
        "zipCode": zipCode,
    };
}
