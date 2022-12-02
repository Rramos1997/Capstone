%{

        
        #include<string>
        #include<iostream>
        #include<cassert>
        #include<vector>
        #include <unistd.h>
        #include<stdio.h>
        #include<sys/types.h>
        #include<sys/wait.h>

        #include<iostream>
        
        
        int yylex();
        void yyerror(const char* err);
        using std::cout;
        using std::endl;
        using std::stoi;
        using std::cerr;
        using std::string;
        std::vector<std::string> commands;
        int index = 0;
        
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
%type <union_string> file
%type <union_string> filelist
%type <union_string> filename
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
        //File rule will print the command number and the given command from the file
        file 
        { 
                //commands[] is a global variable that holds the entire BRT files worth of instructions in a vector
                pid_t child_pid;
                int child_status;
                pid_t tpid, w;
                
                for(unsigned i = 0; i<commands.size(); i++){
                        
                        child_pid = fork();
                        if(child_pid == 0){
                        
                        //std::string singleCommandLine = commands[i];
                        
                        /*

                        Parse the full command-line to pull each part out and interpret it for execvp
                        
                        The find command will search the string for a space and parse each word into a new vector for a single command line
                        */
                       std::string singleCommandLine = commands[i];
                        std::string delimiter = " ";
                        unsigned j = 0;
                        std::string wordInCommand;
                        std::vector<string> commandLine;
                        std::string comm;

                        cout<<"--------------------------------\n""Running Command "<<i+1<<":\t\t|\n"<<"--------------------------------"<<endl;

                        while ((j = singleCommandLine.find(delimiter)) && singleCommandLine.size()>0) {
                                wordInCommand = singleCommandLine.substr(0, j);
                                commandLine.push_back(wordInCommand);
                                
                                //cout<<singleCommandLine<<endl;
                                singleCommandLine.erase(0,j+delimiter.length());          
                        }
                        /*
                        Can now access each individual word in the command string line by line in a BRT file
                        */
                        comm = commandLine[0];
                                //If the command begins with "COMPILE"
                                if(comm ==  "COMPILE")
                                {       
                                        unsigned timer=0;
                                        while(timer<comm.size()){
                                                cout<<"~";
                                                //sleep(1);
                                                
                                                timer++;
                                        }
                                        cout<<endl;
                                        for(unsigned index = 0;index<commandLine.size();index++){
                                                        cout<<commandLine[index]<<" ";
                                        }
                                        cout<<endl;
                                        timer=0;
                                        
                                        const char* execChar;
                                        std::vector<char*> execCommand;
                                        /*
                                        Now check the commandLine vector for what type of compiler is being used and push it into the execvp vector
                                        */
                                        unsigned x = 0;
                                        
                                        
                                        while(x<commandLine.size()){
                                                if(commandLine[x] == "G++"){
                                                        execCommand.push_back(const_cast<char*>("g++"));
                                                        break;
                                                }
                                                if(commandLine[x] == "GCC"){
                                                        execCommand.push_back(const_cast<char*>("gcc"));
                                                        break;
                                                }
                                                x++;
                                        }
                                        //Add the filename to the execvp vector, will always be after "COMPILE"
                                        execChar = commandLine[1].c_str();
                                        execCommand.push_back(const_cast<char*>(execChar));
                                        x=2;
                                        while(x<commandLine.size()){
                                                if(commandLine[x] != "AS" && commandLine[x] != "WITH"){
                                                        execChar = commandLine[x].c_str();
                                                        execCommand.push_back(const_cast<char*>(execChar));
                                                        x++;
                                                }
                                                else
                                                        break;
                                        }
                                        /*
                                                Search the commandLine for 'AS' to see if there should be an output 
                                                file and push the output file onto the exec vector
                                        */
                                        while(x<commandLine.size()){
                                                if(commandLine[x] == "AS"){
                                                        execCommand.push_back(const_cast<char*>("-o"));
                                                        execChar = commandLine[x+1].c_str();
                                                        execCommand.push_back(const_cast<char*>(execChar));
                                                        break;
                                                }
                                                x++;
                                        }
                                        cout<<"COMMAND::";
                                        for(unsigned z = 0;z<execCommand.size();z++){
                                                cout<<execCommand[z]<<" ";
                                        }
                                        cout<<endl;
                                        while(timer<comm.size()){
                                                cout<<"~";
                                                //sleep(1);
                                                
                                                timer++;
                                        }
                                        cout<<endl;
                                        execCommand.push_back(NULL);
                                        
                                        
                                                
                                                if(execvp(execCommand[0], &execCommand[0]) != -1)
                                                        cout<<"Success."<<endl;
                                                else
                                                        cout<<"Failure.\n";
                                                abort();
                                        /*else{
                                                do {
                                                        w = waitpid(child_pid, &child_status, WUNTRACED | WCONTINUED);
                                                        if (w == -1) {
                                                                perror("waitpid");
                                                                exit(0);
                                                        }
                                                        if (WIFEXITED(child_status)) {
                                                        printf("exited, status=%d\n", WEXITSTATUS(child_status));
                                                        }
                                                }
                                                        while (!WIFEXITED(child_status) && !WIFSIGNALED(child_status));
                                                        exit(0);
           
                                                //waitpid(child_pid, &child_status, WUNTRACED | WCONTINUED );
                                                /*pid_t tpid;
                                                do {
                                                        tpid = wait(&child_status);
                                                        if(tpid != child_pid) 
                                                                //process_terminated(tpid);
                                                                //exit(0);
                                                                cout<<"In do loop"<<endl;
                                                        } 
                                                while(tpid != child_pid);

                                                return child_status;//
                                                
                                        }*/
                                        
      
                                }
                                else if(comm == "RUN"){
                                        const char* execChar;
                                        std::vector<char*> execCommand;

                                        unsigned x = 0;
                                        execChar = commandLine[1].c_str();
                                        execCommand.push_back(const_cast<char*>(execChar));
                                        while(x<commandLine.size()){
                                                if(commandLine[x] == "WITH"){
                                                        execCommand.push_back(const_cast<char*>("<"));
                                                        execChar = commandLine[x+1].c_str();
                                                        execCommand.push_back(const_cast<char*>(execChar));
                                                        break;
                                                }
                                                x++;
                                        
                                        }
                                        x = 0;
                                        while(x<commandLine.size()){
                                                if(commandLine[x]=="AS"){
                                                        execCommand.push_back(const_cast<char*>(">"));
                                                        execChar = commandLine[x+1].c_str();
                                                        execCommand.push_back(const_cast<char*>(execChar));
                                                        break;
                                                }
                                                x++;
                                        }
                                        for(unsigned z = 0;z<execCommand.size();z++){
                                                cout<<execCommand[z]<<" ";
                                        }
                                        execCommand.push_back(NULL);
                                        
                                        cout<<endl;
                                        if(execvp(execCommand[0], &execCommand[0])==0){
                                                cout<<"Unsuccessful execvp() call.\n";
                                                abort();
                                        }

                                        
                                }
                                else if(comm == "MOVE"){
                                        const char* execChar;
                                        std::vector<char*> execCommand;
                                        unsigned x = 0;
                                        execCommand.push_back(const_cast<char*>("mv"));
                                        execChar = commandLine[1].c_str();
                                        execCommand.push_back(const_cast<char*>(execChar));
                                        while(x<commandLine.size()){
                                                if(commandLine[x]=="TO"){
                                                        execChar = commandLine[x+1].c_str();
                                                        execCommand.push_back(const_cast<char*>(execChar));
                                                        break;
                                                }
                                                x++;
                                        }
                                        for(unsigned z = 0;z<execCommand.size();z++){
                                                cout<<execCommand[z]<<" ";
                                        }
                                        execCommand.push_back(NULL);
                                        cout<<endl;
                                        execvp(execCommand[0],&execCommand[0]);
                                        cout<<"Unsuccessful execvp() call.\n";
                                        abort();

                                        
                                }
                                else
                                cout<<"Unknown Command: Commands are Compile/Run/Move"<<endl;
                        }
                        else{
                        //cout<<"COMMAND #"<<i+1<<": "<<commands[i]<<endl;
                        //Waitpid here will execute commands in order
                        waitpid(child_pid, &child_status, 0);     

                        }
                        
                }
                //while(w = wait(&child_status) > 0);
                //waitpid(child_pid, &child_status, 0);
        
        } 
        ;

file:   command_list{}
        | %empty { exit(0); }
        ;

command_list: command_list command { commands.push_back(*$2); }
        | command{ commands.push_back(*$1);}
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
                        $$ = new std::string("AS "+*$2+" ");
                }
                else{
                        $$ = new std::string("AS "+*$2+" "+*$3+" "); 
                }
                delete $2;
                delete $3;
        }
        | T_AS T_EXECUTABLE phrase 
        { 
                if($3 == nullptr){       
                        $$ = new std::string("AS "+*$2+" ");
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
                        $$ = new std::string("WITH GCC ");
                }
                else{
                        $$ = new std::string("WITH GCC "+*$3+" "); 
                }
                delete $3;
        }
        | T_WITH T_GPLUSPLUS phrase 
        { 
                if($3 == nullptr){
                        $$ = new std::string("WITH G++ ");
                }
                else{
                        

                        $$ = new std::string("WITH G++ "+*$3+" "); 
                }
                delete $3;
        }
        | T_WITH T_FILENAME phrase 
        {
                if($3 == nullptr){
                        $$ = new std::string("WITH "+*$2+" ");
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
                std::string executable = "./"+*$2;
                if($3 == nullptr){
                        $$ = new std::string("RUN "+executable+" ");
                }
                else
                        $$ = new std::string("RUN "+executable+" "+*$3+" ");
                delete $2;
                delete $3;
         }
        | T_COMPILE filelist phrase 
        {
                if($3 == nullptr)
                {
                        $$ = new std::string("COMPILE "+*$2+" AS "+"a.out");
                        
                        //executable file is a.out
                }
                else
                {
                 $$ = new std::string("COMPILE "+*$2+" "+*$3+" "); 
                 //cerr << "====>"<<*$$<<"<======="<<endl;
                }
                delete $2;
                delete $3;
        }
        | T_MOVE T_FILENAME T_TO T_DESTINATION { $$ = new std::string("MOVE "+*$2+" TO "+*$4+" "); }
        | T_MOVE T_EXECUTABLE T_TO T_DESTINATION { $$ = new std::string("MOVE "+*$2+" TO "+*$4+" "); }
        | T_QUIT { exit(0); }
        ;

filelist:
        filename filelist  {
                if($2 == nullptr){
                        $$ = new std::string(*$1);
                }
                else
                        {$$ = new std::string(*$1+" "+*$2);}
        }
        | filename {$$=new std::string(*$1);}
;

filename:
        T_FILENAME{$$=$1;}
;
%%

int main(int argc, char** argv)
{
        yyparse();
}

void yyerror(const char* err){
        cerr << err << endl;     
}
