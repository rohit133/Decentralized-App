import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Time "mo:base/Time";
import Int "mo:base/Int";
import Text "mo:base/Text";
import Float "mo:base/Float";

actor DBank{
  // Initial Value
  stable var currentValue : Float = 300; 
  // currentValue :=300;
  Debug.print(debug_show(currentValue));

  // Initial Time 
  stable var startTime = Time.now();
  // startTime := Time.now()
  Debug.print(debug_show(startTime));

  public func topUp(amount: Float){
    currentValue +=amount; 
    Debug.print(debug_show(currentValue));
  };
  

  public func withdraw(amount : Float){
    let tempValue : Float = currentValue - amount;
    if(tempValue >= 0){
      currentValue -=amount;
      Debug.print(debug_show(currentValue));
    } 
    else {
      Debug.print("Amount provided is greater than current Balance ");
    }
  };

  public query func checkBalance() : async Float {
    return currentValue;
  };

  public func compound(){
    let currentTime = Time.now();
    let timeElapsedNs = currentTime - startTime;
    let timeElapsedS = timeElapsedNs / 1000000000;
    currentValue :=  currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;

  };

}