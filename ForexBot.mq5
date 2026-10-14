
#property strict
#property version "1.00"
#property description "Multi-Strategy Forex Trading Bot"

#include <Trade/Trade.mqh>

CTrade trade;

// Safety switch: trading disabled initially
input bool AllowTrading = false;

int OnInit()
{
   trade.SetExpertMagicNumber(20261014);

   Print("ForexBot initialized.");
   Print("Automated trading enabled: ",
         AllowTrading ? "YES" : "NO");

   return INIT_SUCCEEDED;
}

void OnDeinit(const int reason)
{
   Print("ForexBot stopped. Reason: ", reason);
}

void OnTick()
{
   // Strategy modules will be added in later steps.
   // This starter version does not place orders.
}
