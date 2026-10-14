
#ifndef TREND_STRATEGY_MQH
#define TREND_STRATEGY_MQH

// Trend direction results
enum TrendDirection
{
   TREND_BEARISH = -1,
   TREND_NEUTRAL = 0,
   TREND_BULLISH = 1
};

// Classifies trend using two moving averages.
// This module analyses only; it does not place trades.
class CTrendStrategy
{
private:
   int fastHandle;
   int slowHandle;

public:
   CTrendStrategy()
   {
      fastHandle = INVALID_HANDLE;
      slowHandle = INVALID_HANDLE;
   }

   bool Init(string symbol,
             ENUM_TIMEFRAMES timeframe,
             int fastPeriod = 9,
             int slowPeriod = 21)
   {
      fastHandle = iMA(symbol, timeframe,
                       fastPeriod, 0,
                       MODE_EMA, PRICE_CLOSE);

      slowHandle = iMA(symbol, timeframe,
                       slowPeriod, 0,
                       MODE_EMA, PRICE_CLOSE);

      return (fastHandle != INVALID_HANDLE &&
              slowHandle != INVALID_HANDLE);
   }

   TrendDirection GetTrend()
   {
      double fast[1];
      double slow[1];

      if(CopyBuffer(fastHandle, 0, 1, 1, fast) != 1)
         return TREND_NEUTRAL;

      if(CopyBuffer(slowHandle, 0, 1, 1, slow) != 1)
         return TREND_NEUTRAL;

      if(fast[0] > slow[0])
         return TREND_BULLISH;

      if(fast[0] < slow[0])
         return TREND_BEARISH;

      return TREND_NEUTRAL;
   }

   void Release()
   {
      if(fastHandle != INVALID_HANDLE)
      {
         IndicatorRelease(fastHandle);
         fastHandle = INVALID_HANDLE;
      }

      if(slowHandle != INVALID_HANDLE)
      {
         IndicatorRelease(slowHandle);
         slowHandle = INVALID_HANDLE;
      }
   }
};

#endif
