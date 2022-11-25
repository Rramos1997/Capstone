#include <iostream>
#include <string>

using namespace std;

int main(){
  string hello = "hello";
  string world = "world";
  string name = "";
  int age = 25;
  cout<<hello<<" "<<world<<endl<<"I am "<<age<<" years old."<<endl;
  cout<<"What's your name?"<<endl;
  cin>>name;
  cout<<endl<<name<<endl;
  return 0;
}
