%{

        
        #include<string>
        #include<iostream>
        #include<cassert>
        #include<vector>
        
        int yylex();
        void yyerror(const char* err);
        using std::cout;
        using std::endl;
        using std::stoi;
        using std::cerr;
        std::vector<std::string> commands;
        
%}

%union {
        std::string* union_string;
        
};

%token <union_string> T_FILENAME "filename"
%token <union_string> T_EXECUTABLE "executable"
%token <union_string> T_DESTINATION "destination"
%token T_GPLUSPLUS "g++"
%token T_GMINMIN "gcc"
%token T_COMPILE        "compile"
%token T_WITH   "with"
%token T_AS     "as"
%token T_RUN    "run"
%token T_MOVE   "move"
%token T_TO     "to"
%token T_QUIT "quit"
%token T_AND

%type <union_string> command
%type <union_string> phrase
/*%token T_ERROR


%token <union_string> T_COMPILER       "compiler"
%token <union_string> T_STRING_CONSTANT "string constant" 
%token T_OUTPUT
 */


%%

// -- BACKUP THAT WILL WORK WITH PRINTING OUT THE COMMANDS -- 
/*
T_COMPILE T_FILENAME T_AS T_EXECUTABLE T_WITH T_COMPILER {cout<<"COMPILE "<<*$2<<" AS "<<*$4<<" WITH "<<*$6<<endl; }
        | T_COMPILE T_FILENAME T_AS T_EXECUTABLE {cout<<"COMPILE "<<*$2<<" AS "<<*$4<<endl; }
        | T_COMPILE T_FILENAME { cout<<"COMPILE "<<*$2<<endl; }
        | T_FILENAME {cout<<"Error~ "<<*$1<<": Usage is <command> <filename>"<<endl;}
        
        ;
        
*/

start_symbol : 
        file 
        { 
                for(unsigned i = 0; i<commands.size(); i++){
                        cout<<commands[i]<<endl;
                }

        
        } /*{ cout<<$1<<endl; }*/
        ;

file:   command { 
        
        commands.push_back(*$1);
        /*cout<<*$1<<endl;*/
        }
        | %empty
        ;

//And action to combine commands together
//EX: compile hello.cpp as hello AND move ./hello to ..
/*and:
        command and command {}
        | phrase and command {}
        ;*/
//Secondary phrases that can be used with the action commands, can have an empty field for if you compile without an executable assigned or run an executable with or without directed input
phrase:
        T_AS T_FILENAME phrase 
        {
                if($3 == nullptr){
                        $$ = new std::string("AS "+*$2+" "+"\n");
                }
                else{
                        $$ = new std::string("AS "+*$2+" "+*$3+"\n"); 
                }
                delete $2;
                delete $3;
        }
        | T_AS T_EXECUTABLE phrase 
        { 
                if($3 == nullptr){       
                        $$ = new std::string("AS "+*$2+"\n");
                }
                else{
                        $$ = new std::string("AS "+*$2+" "+*$3+" "); 
                }
                delete $2;
                delete $3; 
        }
        | T_WITH T_GMINMIN phrase 
        { 
                if($3 == nullptr){
                        $$ = new std::string("WITH GCC");
                }
                else{
                        $$ = new std::string("WITH GCC "+*$3+" "); 
                }
                delete $3;
        }
        | T_WITH T_GPLUSPLUS phrase 
        { 
                if($3 == nullptr){
                        $$ = new std::string("WITH G++");
                }
                else{
                        

                        $$ = new std::string("WITH G++ "+*$3+" "); 
                }
                delete $3;
        }
        | T_WITH T_FILENAME phrase 
        {
                if($3 == nullptr){
                        $$ = new std::string("WITH "+*$2);
                }
                else{
                        $$ = new std::string("WITH "+*$2+" "+*$3+" "); 
                }
                delete $2;
                delete $3;
        }     
        | %empty { $$ = nullptr; }
        ;   
        //| command { $$ = $1; }
        

//The commands I want my language to run (COMPILE, RUN, MOVE)
command: 
         T_RUN T_EXECUTABLE phrase
         {
                if($3 == nullptr){
                        $$ = new std::string("RUN "+*$2+" ");
                }
                else
                        $$ = new std::string("RUN "+*$2+" "+*$3+"\n");
                delete $2;
                delete $3;
         }
        | T_MOVE T_FILENAME T_TO T_DESTINATION { cout<<"MOVE "<<*$2<<" TO "<<*$4; }
        | T_COMPILE T_FILENAME phrase 
        {
                if($3 == nullptr)
                {
                        //executable file is a.out
                }
                else
                {
                 $$ = new std::string("COMPILE "+*$2+" "+*$3+"\n"); 
                 //cerr << "====>"<<*$$<<"<======="<<endl;
                }
                delete $2;
                delete $3;
        }
        | T_QUIT { exit(0); }
        ;


/*cout<<"COMPILE "<<*$2<<" ";*/
/*compiler: T_GPLUSPLUS {}
        | T_GMINMIN {}
        ;

//Filename variable, either a '.' file or an executable
file_name: T_FILENAME { cout<<*$1<<endl; }
        | T_EXECUTABLE {}
        ;
*/

%%

int main(int argc, char** argv)
{
        yyparse();
}

void yyerror(const char* err){
        cerr << err << endl;     
}
