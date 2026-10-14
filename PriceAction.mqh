
#ifndef PRICE_ACTION_MQH
#define PRICE_ACTION_MQH

enum CandleSignal
{
   CANDLE_BEARISH = -1,
   CANDLE_NEUTRAL = 0,
   CANDLE_BULLISH = 1
};

class CPriceAction
{
public:
   CandleSignal GetEngulfingSignal(
      string symbol,
      ENUM_TIMEFRAMES timeframe)
   {
      // Candle 1 is the last completed candle.
      // Candle 2 is the completed candle before it.
      double open1  = iOpen(symbol, timeframe, 1);
      double close1 = iClose(symbol, timeframe, 1);
      double open2  = iOpen(symbol, timeframe, 2);
      double close2 = iClose(symbol, timeframe, 2);

      if(open1 <= 0.0 || close1 <= 0.0 ||
         open2 <= 0.0 || close2 <= 0.0)
      {
         return CANDLE_NEUTRAL;
      }

      // Bullish engulfing: bearish candle followed
      // by a bullish candle whose body engulfs it.
      if(close2 < open2 &&
         close1 > open1 &&
         open1 <= close2 &&
         close1 >= open2)
      {
         return CANDLE_BULLISH;
      }

      // Bearish engulfing: bullish candle followed
      // by a bearish candle whose body engulfs it.
      if(close2 > open2 &&
         close1 < open1 &&
         open1 >= close2 &&
         close1 <= open2)
      {
         return CANDLE_BEARISH;
      }

      return CANDLE_NEUTRAL;
   }
};

#endif
