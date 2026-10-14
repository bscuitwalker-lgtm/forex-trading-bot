
#ifndef MOMENTUM_STRATEGY_MQH
#define MOMENTUM_STRATEGY_MQH

enum MomentumDirection
{
   MOMENTUM_BEARISH = -1,
   MOMENTUM_NEUTRAL = 0,
   MOMENTUM_BULLISH = 1
};

class CMomentumStrategy
{
private:
   int macdHandle;

public:
   CMomentumStrategy()
   {
      macdHandle = INVALID_HANDLE;
   }

   bool Init(string symbol,
             ENUM_TIMEFRAMES timeframe,
             int fast = 12,
             int slow = 26,
             int signal = 9)
   {
      macdHandle = iMACD(
         symbol,
         timeframe,
         fast,
         slow,
         signal,
         PRICE_CLOSE
      );

      return macdHandle != INVALID_HANDLE;
   }

   MomentumDirection GetMomentum()
   {
      double mainLine[1];
      double signalLine[1];

      // Read the last completed candle.
      if(CopyBuffer(macdHandle, 0, 1, 1, mainLine) != 1)
         return MOMENTUM_NEUTRAL;

      if(CopyBuffer(macdHandle, 1, 1, 1, signalLine) != 1)
         return MOMENTUM_NEUTRAL;

      if(mainLine[0] > signalLine[0])
         return MOMENTUM_BULLISH;

      if(mainLine[0] < signalLine[0])
         return MOMENTUM_BEARISH;

      return MOMENTUM_NEUTRAL;
   }

   void Release()
   {
      if(macdHandle != INVALID_HANDLE)
      {
         IndicatorRelease(macdHandle);
         macdHandle = INVALID_HANDLE;
      }
   }
};

#endif
