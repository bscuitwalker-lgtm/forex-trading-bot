
#ifndef SUPPORT_RESISTANCE_MQH
#define SUPPORT_RESISTANCE_MQH

class CSupportResistance
{
public:
   double GetResistance(string symbol,
                        ENUM_TIMEFRAMES timeframe,
                        int lookback = 50)
   {
      if(lookback < 2)
         return 0.0;

      double highs[];

      ArraySetAsSeries(highs, true);

      int copied = CopyHigh(
         symbol,
         timeframe,
         1,
         lookback,
         highs
      );

      if(copied != lookback)
         return 0.0;

      double highest = highs[0];

      for(int i = 1; i < copied; i++)
      {
         if(highs[i] > highest)
            highest = highs[i];
      }

      return highest;
   }

   double GetSupport(string symbol,
                     ENUM_TIMEFRAMES timeframe,
                     int lookback = 50)
   {
      if(lookback < 2)
         return 0.0;

      double lows[];

      ArraySetAsSeries(lows, true);

      int copied = CopyLow(
         symbol,
         timeframe,
         1,
         lookback,
         lows
      );

      if(copied != lookback)
         return 0.0;

      double lowest = lows[0];

      for(int i = 1; i < copied; i++)
      {
         if(lows[i] < lowest)
            lowest = lows[i];
      }

      return lowest;
   }
};

#endif
