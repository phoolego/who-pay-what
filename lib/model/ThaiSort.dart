import 'dart:math';

class ThaiSort{
  static compareTo(String a,String b){
    int size = max(a.length, b.length);
    int aShift = 0;
    int bShift = 0;
    for(int i=0 ; i<size ; i++){
      if(i>=a.length){
        return -1;
      }if(i>b.length){
        return 1;
      }if(a.codeUnitAt(i)==b.codeUnitAt(i)){
        continue;
      }if((a.codeUnitAt(i)>=3585 && a.codeUnitAt(i)<=3630) && (b.codeUnitAt(i)>=3648 && b.codeUnitAt(i)<=3652) && i+1<b.length){
        if(a.substring(i,i+1).compareTo(b.substring(i+1,i+2))<0){
          return -1;
        }else if(a.substring(i,i+1).compareTo(b.substring(i+1,i+2))>0){
          return 1;
        }
      }if((b.codeUnitAt(i)>=3585 && b.codeUnitAt(i)<=3630) && (a.codeUnitAt(i)>=3648 && a.codeUnitAt(i)<=3652) && i+1<a.length){
        if(b.substring(i,i+1).compareTo(a.substring(i+1,i+2))<0){
          return 1;
        }else if(b.substring(i,i+1).compareTo(a.substring(i+1,i+2))>0){
          return -1;
        }
      }if(a.codeUnitAt(i)<b.codeUnitAt(i)){
        return -1;
      }else if(a.codeUnitAt(i)>b.codeUnitAt(i)){
        return 1;
      }
    }
    return 0;
  }
}