<%@ Page Language="C#"%>
//<script runat="server">
     //public double accumulatePoints() {
      
       // if (varSalaried == 1)
         //   varOvertimePay = 0;
        //else
          //  varOvertimePay = (varHoursWorked - varWorkload)*(varOvertimeRate*varRateOfPay);

       // return (varHoursWorked * varRateOfPay) + varOvertimePay;
    //}

     //public double passFailPoints() {
      
       // if (varSalaried == 1)
          //  varOvertimePay = 0;
        //else
         //   varOvertimePay = (varHoursWorked - varWorkload)*(varOvertimeRate*varRateOfPay);

       // return (varHoursWorked * varRateOfPay) + varOvertimePay;
   // }
//</script>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title></title>
</head>

<body>
    int varValue1;
    varValue1 = 0;
    string varUserInput=0;
    bool isLetter = true;
    for (int i = 0; i < Request.Form["FirstName"].Length; i++)
          if (!char.IsLetter(inputString[i]))
            isLetter = false;
            
        else
            isLetter = true;
            
     
    if (isLetter == false)
        Response.Write("Input outside of allowed range, please try again");
        else
        
        
    

   // if (varUserInput != 1 && varUserInput != 2 && varUserInput != 5){
     //   Response.Write("Input outside of allowed range, please try again");
   // }else{
     //   do
       // {
           
        //} while (varValue1 < varUserInput);
    //}

     //for (int i = 0; i < Request.Form["Surname"].Length; i++)
       //   if (!char.IsLetter(inputString[i]))
         //   isLetter = false;
            
        //else
          //  isLetter = true;
            
     
   // if (isLetter == false)
      //  Response.Write("Input outside of allowed range, please try again");
     //   else
        

    // for (int i = 0; i < Request.Form["CourseTyoe"].Length; i++)
     //     if (!char.IsLetter(inputString[i]))
      //      isLetter = false;
            
      //  else
      //      isLetter = true;
            
     
    //if (isLetter == false)
       // Response.Write("Input outside of allowed range, please try again");
       // else
        

   


    

</body>
</html>