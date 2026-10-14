
#ifndef RISK_MANAGER_MQH
#define RISK_MANAGER_MQH

class CRiskManager
{
public:
   // Calculates the maximum money to risk on one trade.
   // This does not place orders.
   double CalculateRiskMoney(double equity,
                             double riskPercent)
   {
      if(equity <= 0.0)
         return 0.0;

      if(riskPercent <= 0.0 || riskPercent > 1.0)
         return 0.0;

      return equity * riskPercent / 100.0;
   }

   // Calculates position size using the estimated loss
   // for one lot at the proposed stop-loss.
   double CalculateVolume(double equity,
                          double riskPercent,
                          double lossPerLot)
   {
      if(lossPerLot <= 0.0)
         return 0.0;

      double riskMoney =
         CalculateRiskMoney(equity, riskPercent);

      if(riskMoney <= 0.0)
         return 0.0;

      return riskMoney / lossPerLot;
   }
};

#endif
