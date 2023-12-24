import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

//This is a canister
actor DBank {
  // adding stable allows you to natively persist state! How awesome :D  
  stable var currentValue: Float = 300;

  stable var startTime = Time.now();

  let id = 2348923840928349;

  //Debug.print("Hello"); //Prints hello to the console.
  //Debug.print(debug_show(currentValue)); //Valid if you want to print variables etc.
  //Debug.print(currentValue); // Not valid :( debug.print can only print text.


  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdraw (amount: Float) {
    let tempValue: Float = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Withdrawing below 0");
    }
  };

  public query func checkBalance(): async Float {
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;

    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  };
}