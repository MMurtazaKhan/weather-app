
void main(){
  perform();
}

  void task1(){
    print("Task 1 completed");
  }
  
   Future task2() async {
     Duration duration = Duration(seconds: 3);
     String result;
     await Future.delayed(duration,(){
       result = "task2";
       print("Task 2 completed");
     });
    return result;
  }
  
   void task3(String task2str){
    print("Task 3 completed with $task2str");
  }
  
  void perform() async {
    task1();
    String t = await task2();
    task3(t);
  }
  