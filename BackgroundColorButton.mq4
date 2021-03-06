//+------------------------------------------------------------------+
//|                                        BackgroundColorButton.mq4 |
//|                                                             Enzo |
//|                                https://github.com/lorenzosaldana |
//+------------------------------------------------------------------+
#property copyright "Enzo"
#property version   "1.00"
#property strict
#property indicator_chart_window

extern bool value_to_toggle = false; // The Value to Toggle

// unique identifier that we can access from multiple places throughout the code
string sButtonName = "toggle_button";
string sButtonName2 = "toggle_button2";
int offsize1 = 50;
int offsize2 = 40;
int fontsize = 28;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping

   // force the button to be drawn when the indicator is first placed on the chart
   Toggle();
//---
   return(INIT_SUCCEEDED);
  }
  
// this is not added automatically so you'll need to add it yourself
void OnDeinit(const int reason){
   // clean up our button when the indicator is removed from the chart
   ObjectDelete(sButtonName);
   ObjectDelete(sButtonName2);
   // clean off commment too
   Comment("");
}
  
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   // if the sparam passed to the function is the unique id of the button then toggle it
   if(sparam==sButtonName) Toggle();
  }
//+------------------------------------------------------------------+

void Toggle()
{
// function to handle toggle
   color cColor  = clrAqua;
   string Button1 = "ON";
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrBlack);
   offsize1 = 50;
   offsize2 = 40;
   fontsize = 20;
   // use a string type if you need text on your button
   
   if(value_to_toggle == true)
   {
      cColor = clrRed;
      ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrWhite);
      Button1 = "Off";
      offsize1 = 50;
      offsize2 = 40;
      fontsize = 20;
   }
   
   CreateButton(sButtonName,cColor,FW_REGULAR,Button1);
   value_to_toggle = !value_to_toggle;
   
       
}

void CreateButton(string sName, color cColor, string sFont = "Wingdings", string sText = ""){
// create a button on the chart

// many of these settings are hard coded below but you can easily have them as paramaters and pass them to the function
// just like I've done already with the color, font and text

   if(ObjectFind(sName)< 0){
      ObjectCreate(0,sName,OBJ_BUTTON,0,0,0);
   }
   
   // these could be external valiables to allow the user to create the button wherever they wanted
   ObjectSetInteger(0,sName,OBJPROP_XDISTANCE,0);
   ObjectSetInteger(0,sName,OBJPROP_YDISTANCE,75);
   ObjectSetInteger(0,sName,OBJPROP_XSIZE,offsize1);
   ObjectSetInteger(0,sName,OBJPROP_YSIZE,offsize2);
   ObjectSetInteger(0,sName,OBJPROP_CORNER,CORNER_LEFT_UPPER);
   
   ObjectSetString(0,sName,OBJPROP_TEXT,sText);
   ObjectSetInteger(0,sName,OBJPROP_COLOR, cColor);
   // I'm setting the background and border to the same as the chart background
   // as I'm just using a wingding arrow
   long result;

   ChartGetInteger(0,CHART_COLOR_BACKGROUND,0,result);

   color cBack = (color) result;

   ObjectSetInteger(0,sName,OBJPROP_BGCOLOR, clrDimGray);

   ObjectSetInteger(0,sName,OBJPROP_BORDER_COLOR,clrBlue);
   // make sure our object shows up in the 'Objects List'
   ObjectSetInteger(0,sName,OBJPROP_HIDDEN, false);
   // commmented out some settings as they are not used
   // I would have normally deleted them but left them for completeness
   //ObjectSetInteger(0,sName,OBJPROP_BORDER_TYPE,BORDER_FLAT);
   //ObjectSetInteger(0,sName,OBJPROP_STATE,false);
   ObjectSetString(0,sName,OBJPROP_FONT,sFont);
   ObjectSetInteger(0,sName,OBJPROP_FONTSIZE,fontsize);
   
}
