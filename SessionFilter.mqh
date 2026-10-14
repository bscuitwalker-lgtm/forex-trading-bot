#ifndef SESSION_FILTER_MQH
#define SESSION_FILTER_MQH

class CSessionFilter
{
public:
   // Uses broker server time.
   // Configure the permitted hours from 0 to 23.
   bool IsSessionAllowed(int startHour,
                         int endHour)
   {
      if(startHour < 0 || startHour > 23 ||
         endHour < 0 || endHour > 23)
      {
         return false;
      }

      MqlDateTime currentTime;

      if(!TimeToStruct(TimeCurrent(), currentTime))
         return false;

      int hour = currentTime.hour;

      // Equal hours means the filter is disabled.
      if(startHour == endHour)
         return true;

      // Normal session, e.g. 8 to 17.
      if(startHour < endHour)
      {
         return (hour >= startHour &&
                 hour < endHour);
      }

      // Overnight session, e.g. 22 to 6.
      return (hour >= startHour ||
              hour < endHour);
   }
};

#endif
