#ifndef RSI_FILTER_MQH
#define RSI_FILTER_MQH

class CRSIFilter
{
private:
   int rsiHandle;

public:
   CRSIFilter()
   {
      rsiHandle = INVALID_HANDLE;
   }

   bool Init(string symbol,
             ENUM_TIMEFRAMES timeframe,
             int period = 14)
   {
      if(rsiHandle != INVALID_HANDLE)
         IndicatorRelease(rsiHandle);

      rsiHandle = iRSI(
         symbol,
         timeframe,
         period,
         PRICE_CLOSE
      );

      return (rsiHandle != INVALID_HANDLE);
   }

   double GetRSI()
   {
      if(rsiHandle == INVALID_HANDLE)
         return -1.0;

      double values[1];

      // Read the last completed candle.
      if(CopyBuffer(
         rsiHandle, 0, 1, 1, values
      ) != 1)
      {
         return -1.0;
      }

      return values[0];
   }

   bool IsRSIValid()
   {
      double value = GetRSI();

      return (value >= 0.0 && value <= 100.0);
   }

   void Release()
   {
      if(rsiHandle != INVALID_HANDLE)
      {
         IndicatorRelease(rsiHandle);
         rsiHandle = INVALID_HANDLE;
      }
   }
};

#endif
