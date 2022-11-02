//File: Constant.h
#ifndef CONSTANT_H
#define CONSTANT_H
#include "Expression.h"


class Constant : public Expression {
  public:
    Constant(Gpl_type enum_name) 
      : intrinsic_type(enum_name) {}
    virtual const Constant*   evaluate() const final;
    virtual std::string as_string() const {throw intrinsic_type;}

    virtual ~Constant(){}//virtual dtor to ensure derived data is released properly, i.e., string
  private:
    std::string name;  //The actual type
};

class String_constant : public Constant {
  public:
    String_constant(const std::string& d) : Constant(STRING), data(d) {}
    virtual std::string as_string() const { return data;}
  private:
    std::string data;
};

#endif