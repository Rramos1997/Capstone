#include<iostream>
#include "helper.h"
using namespace std;



int Helper::age(string name){

    int myage;
    cout<<"This is a helper file."<<endl;
    if(name == "Robert")
    myage = 25;
    else
    myage = 0;
    
    return myage;
}