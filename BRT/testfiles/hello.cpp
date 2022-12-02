#include<iostream>
#include<string>
#include "helper.h"

using namespace std;
Helper h;

int main(){
  string name = "Robert";
  int Myage;
  cout<<"Hello World!"<<endl;
  Myage = h.age(name);
  cout<<"My age is "<<Myage<<endl;
  return 0;
}
