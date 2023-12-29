abstract  class CounterStates{}
class CounterInitialState extends  CounterStates{ }
class CounterPlusState extends  CounterStates{ 
  final int Container;

  CounterPlusState(this.Container);
 
}
class CounterMinusState extends  CounterStates{
  final int Container;

  CounterMinusState(this.Container);
 
 }
 
