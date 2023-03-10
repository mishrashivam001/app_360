import 'user_register_model.dart';

class LoginResponse {
  bool? success;
  LoginData? data;
  String? error;
  LoginResponse({this.success, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (error != null) {
      data['error'] = error;
    }
    return data;
  }
}

class LoginData {
  int? userID;
  String? email;
  String? firstName;
  String? lastName;
  String? country;
  int? funnelID;
  String? language;
  String? customSource;
  int? rating;
  int? points;
  double? totalBalance;
  double? totalProfit;
  List<Brands>? brands;
  String? token;
  String? refreshToken;
  String? redirectTo;

  LoginData(
      {this.userID,
      this.email,
      this.firstName,
      this.lastName,
      this.country,
      this.funnelID,
      this.language,
      this.customSource,
      this.rating,
      this.points,
      this.totalBalance,
      this.totalProfit,
      this.brands,
      this.token,
      this.refreshToken,
      this.redirectTo});

  LoginData.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    email = json['Email'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    country = json['Country'];
    funnelID = json['FunnelID'];
    language = json['Language'];
    customSource = json['CustomSource'];
    rating = json['Rating'];
    points = json['Points'];
    totalBalance = json['TotalBalance'];
    totalProfit = json['TotalProfit'];
    if (json['Brands'] != null) {
      brands = <Brands>[];
      json['Brands'].forEach((v) {
        brands!.add(Brands.fromJson(v));
      });
    }
    token = json['token'];
    refreshToken = json['refreshToken'];
    redirectTo = json['RedirectTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserID'] = userID;
    data['Email'] = email;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['Country'] = country;
    data['FunnelID'] = funnelID;
    data['Language'] = language;
    data['CustomSource'] = customSource;
    data['Rating'] = rating;
    data['Points'] = points;
    data['TotalBalance'] = totalBalance;
    data['TotalProfit'] = totalProfit;
    if (brands != null) {
      data['Brands'] = brands!.map((v) => v.toJson()).toList();
    }
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    data['RedirectTo'] = redirectTo;
    return data;
  }
}

// class Brands {
//   int? brandID;
//   int? accountID;
//   int? userGroupID;
//   String? loginID;
//   String? userName;
//   String? password;
//   String? brandName;
//   String? description;
//   String? brandImageURL;
//   String? brandURL;
//   String? brandAutoLogin;
//   String? autoLoginToWithdraw;
//   int? minDeposit;
//   double? minBetAmount;
//   double? stars;
//   String? tradeType;
//   String? tradeAPIType;
//   bool? isTraderoom;
//   bool? enableBotActivity;
//   int? totalTrades;
//   int? winningTrades;
//   double? profit;
//   int? openTrades;
//   double? openVolume;
//   double? initialBalance;
//   double? actualBalance;
//   double? bonusBalance;
//   int? betAmount;
//   int? minPayout;
//   int? maxConcurrentTrades;
//   int? maxStopLoss;
//   int? maxTakeProfit;
//   bool? invertSignal;
//   dynamic channelStrength;
//   int? tradeFromHour;
//   int? tradeToHour;
//   int? maxTradesPerDay;
//   int? tradeStopLoss;
//   int? tradeTakeProfit;
//   dynamic channelRangeID;
//   List<ChannelDefinitions>? channelDefinitions;
//   bool? isInvertSignalEnabled;
//   bool? isAutoTradeEnabled;
//   bool? isAutoTrade;
//   bool? isFunded;
//   TradeLimits? tradeLimits;
//   List<Assets>? assets;
//   int? packageStep;
//   int? depositQty;
//   dynamic mt4Account;
//   String? logo;
//   String? uRL;

//   Brands(
//       {this.brandID,
//       this.accountID,
//       this.userGroupID,
//       this.loginID,
//       this.userName,
//       this.password,
//       this.brandName,
//       this.description,
//       this.brandImageURL,
//       this.brandURL,
//       this.brandAutoLogin,
//       this.autoLoginToWithdraw,
//       this.minDeposit,
//       this.minBetAmount,
//       this.stars,
//       this.tradeType,
//       this.tradeAPIType,
//       this.isTraderoom,
//       this.enableBotActivity,
//       this.totalTrades,
//       this.winningTrades,
//       this.profit,
//       this.openTrades,
//       this.openVolume,
//       this.initialBalance,
//       this.actualBalance,
//       this.bonusBalance,
//       this.betAmount,
//       this.minPayout,
//       this.maxConcurrentTrades,
//       this.maxStopLoss,
//       this.maxTakeProfit,
//       this.invertSignal,
//       this.channelStrength,
//       this.tradeFromHour,
//       this.tradeToHour,
//       this.maxTradesPerDay,
//       this.tradeStopLoss,
//       this.tradeTakeProfit,
//       this.channelRangeID,
//       this.channelDefinitions,
//       this.isInvertSignalEnabled,
//       this.isAutoTradeEnabled,
//       this.isAutoTrade,
//       this.isFunded,
//       this.tradeLimits,
//       this.assets,
//       this.packageStep,
//       this.depositQty,
//       this.mt4Account,
//       this.logo,
//       this.uRL});

//   Brands.fromJson(Map<String, dynamic> json) {
//     brandID = json['BrandID'];
//     accountID = json['AccountID'];
//     userGroupID = json['UserGroupID'];
//     loginID = json['LoginID'];
//     userName = json['UserName'];
//     password = json['Password'];
//     brandName = json['BrandName'];
//     description = json['Description'];
//     brandImageURL = json['BrandImageURL'];
//     brandURL = json['BrandURL'];
//     brandAutoLogin = json['BrandAutoLogin'];
//     autoLoginToWithdraw = json['AutoLoginToWithdraw'];
//     minDeposit = json['MinDeposit'];
//     minBetAmount = json['MinBetAmount'];
//     stars = json['Stars'];
//     tradeType = json['TradeType'];
//     tradeAPIType = json['TradeAPIType'];
//     isTraderoom = json['IsTraderoom'];
//     enableBotActivity = json['EnableBotActivity'];
//     totalTrades = json['TotalTrades'];
//     winningTrades = json['WinningTrades'];
//     profit = json['Profit'];
//     openTrades = json['OpenTrades'];
//     openVolume = json['OpenVolume'];
//     initialBalance = json['initialBalance'];
//     actualBalance = json['actualBalance'];
//     bonusBalance = json['bonusBalance'];
//     betAmount = json['BetAmount'];
//     minPayout = json['MinPayout'];
//     maxConcurrentTrades = json['MaxConcurrentTrades'];
//     maxStopLoss = json['MaxStopLoss'];
//     maxTakeProfit = json['MaxTakeProfit'];
//     invertSignal = json['InvertSignal'];
//     channelStrength = json['channelStrength'];
//     tradeFromHour = json['TradeFromHour'];
//     tradeToHour = json['TradeToHour'];
//     maxTradesPerDay = json['MaxTradesPerDay'];
//     tradeStopLoss = json['TradeStopLoss'];
//     tradeTakeProfit = json['TradeTakeProfit'];
//     channelRangeID = json['ChannelRangeID'];
//     if (json['ChannelDefinitions'] != null) {
//       channelDefinitions = <ChannelDefinitions>[];
//       json['ChannelDefinitions'].forEach((v) {
//         channelDefinitions!.add(ChannelDefinitions.fromJson(v));
//       });
//     }
//     isInvertSignalEnabled = json['IsInvertSignalEnabled'];
//     isAutoTradeEnabled = json['IsAutoTradeEnabled'];
//     isAutoTrade = json['IsAutoTrade'];
//     isFunded = json['IsFunded'];
//     tradeLimits = json['TradeLimits'] != null
//         ? TradeLimits.fromJson(json['TradeLimits'])
//         : null;
//     if (json['Assets'] != null) {
//       assets = <Assets>[];
//       json['Assets'].forEach((v) {
//         assets!.add(Assets.fromJson(v));
//       });
//     }
//     packageStep = json['PackageStep'];
//     depositQty = json['DepositQty'];
//     mt4Account = json['mt4Account'];
//     logo = json['Logo'];
//     uRL = json['URL'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['BrandID'] = brandID;
//     data['AccountID'] = accountID;
//     data['UserGroupID'] = userGroupID;
//     data['LoginID'] = loginID;
//     data['UserName'] = userName;
//     data['Password'] = password;
//     data['BrandName'] = brandName;
//     data['Description'] = description;
//     data['BrandImageURL'] = brandImageURL;
//     data['BrandURL'] = brandURL;
//     data['BrandAutoLogin'] = brandAutoLogin;
//     data['AutoLoginToWithdraw'] = autoLoginToWithdraw;
//     data['MinDeposit'] = minDeposit;
//     data['MinBetAmount'] = minBetAmount;
//     data['Stars'] = stars;
//     data['TradeType'] = tradeType;
//     data['TradeAPIType'] = tradeAPIType;
//     data['IsTraderoom'] = isTraderoom;
//     data['EnableBotActivity'] = enableBotActivity;
//     data['TotalTrades'] = totalTrades;
//     data['WinningTrades'] = winningTrades;
//     data['Profit'] = profit;
//     data['OpenTrades'] = openTrades;
//     data['OpenVolume'] = openVolume;
//     data['initialBalance'] = initialBalance;
//     data['actualBalance'] = actualBalance;
//     data['bonusBalance'] = bonusBalance;
//     data['BetAmount'] = betAmount;
//     data['MinPayout'] = minPayout;
//     data['MaxConcurrentTrades'] = maxConcurrentTrades;
//     data['MaxStopLoss'] = maxStopLoss;
//     data['MaxTakeProfit'] = maxTakeProfit;
//     data['InvertSignal'] = invertSignal;
//     data['channelStrength'] = channelStrength;
//     data['TradeFromHour'] = tradeFromHour;
//     data['TradeToHour'] = tradeToHour;
//     data['MaxTradesPerDay'] = maxTradesPerDay;
//     data['TradeStopLoss'] = tradeStopLoss;
//     data['TradeTakeProfit'] = tradeTakeProfit;
//     data['ChannelRangeID'] = channelRangeID;
//     if (channelDefinitions != null) {
//       data['ChannelDefinitions'] =
//           channelDefinitions!.map((v) => v.toJson()).toList();
//     }
//     data['IsInvertSignalEnabled'] = isInvertSignalEnabled;
//     data['IsAutoTradeEnabled'] = isAutoTradeEnabled;
//     data['IsAutoTrade'] = isAutoTrade;
//     data['IsFunded'] = isFunded;
//     if (tradeLimits != null) {
//       data['TradeLimits'] = tradeLimits!.toJson();
//     }
//     if (assets != null) {
//       data['Assets'] = assets!.map((v) => v.toJson()).toList();
//     }
//     data['PackageStep'] = packageStep;
//     data['DepositQty'] = depositQty;
//     data['mt4Account'] = mt4Account;
//     data['Logo'] = logo;
//     data['URL'] = uRL;
//     return data;
//   }
// }

// class ChannelDefinitions {
//   int? iD;
//   String? channelsRange;

//   ChannelDefinitions({this.iD, this.channelsRange});

//   ChannelDefinitions.fromJson(Map<String, dynamic> json) {
//     iD = json['ID'];
//     channelsRange = json['ChannelsRange'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['ID'] = iD;
//     data['ChannelsRange'] = channelsRange;
//     return data;
//   }
// }

// class TradeLimits {
//   List<int>? takeProfit;
//   List<int>? stopLoss;

//   TradeLimits({this.takeProfit, this.stopLoss});

//   TradeLimits.fromJson(Map<String, dynamic> json) {
//     takeProfit = json['TakeProfit'].cast<int>();
//     stopLoss = json['StopLoss'].cast<int>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['TakeProfit'] = takeProfit;
//     data['StopLoss'] = stopLoss;
//     return data;
//   }
// }

// class Assets {
//   String? name;
//   String? label;
//   bool? enabled;

//   Assets({this.name, this.label, this.enabled});

//   Assets.fromJson(Map<String, dynamic> json) {
//     name = json['Name'];
//     label = json['Label'];
//     enabled = json['Enabled'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['Name'] = name;
//     data['Label'] = label;
//     data['Enabled'] = enabled;
//     return data;
//   }
// }
