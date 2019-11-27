// Assembler for RNBIP 2

#include <iostream>
#include <unordered_map>
#include <string>
#include <fstream>
#include <sstream>
#include <vector>
#include <bitset>

// write END to end the program

using namespace std;

class assembler
{
private: 
unordered_map <string ,string> m1;

public: 
void init_assemble();
void parser(string s1, ofstream & outfile1);
void assemble();
assembler();
};

assembler::assembler()
{
 // code for assemble 
 init_assemble();
}

void assembler::init_assemble()
{

//code for init

m1.insert(make_pair("NOP","00000000"));
m1.insert(make_pair("CLR","00000001"));
m1.insert(make_pair("CLC","00000010"));
m1.insert(make_pair("JUD","00000011"));
m1.insert(make_pair("JUA","00000100"));
m1.insert(make_pair("CUD","00000101"));
m1.insert(make_pair("CUA","00000110"));
m1.insert(make_pair("RTU","00000111"));
//m1.insert(make_pair("JCD","00000000"));
/*
m1.insert(make_pair("ADD","00000101"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));
m1.insert(make_pair("CLC","00000001"));

*/
}

void assembler::parser(string s1 , ofstream & os)
{
    if (s1 == "END") exit(0);
   //if
   //cout<<s1<<endl;
   vector <string> array;
   stringstream ss(s1);
   string temp;
   while (ss >> temp)
    array.push_back(temp);
   string ans ;
   if (array.size() == 2)
   {
       bitset<8> b(stoi(array[1]));
       if (m1.find(array[0])!=m1.end())
       ans = m1[array[0]] + b.to_string();
       else ans = "0000000000000000";
   }
   else 
   {
      if (m1.find(array[0])!=m1.end())
      ans = m1[array[0]] + "00000000";
      else ans = "0000000000000000";
   }
   os << ans <<endl;
}

void assembler::assemble()
{
 std::ifstream  fin;
 std::ofstream  outfile;
 string line;
 fin.open("input.txt");
 outfile.open("instruct.txt");

 while(fin)
 {
    getline(fin, line);
    parser(line,outfile);
 }
 outfile.close();
 fin.close();
}

int main ()
{
    ofstream ofs;
    ofs.open("instruct.txt", ofstream::out | ofstream::trunc);
    ofs.close();

    assembler * a1 = new assembler();
    a1->assemble();
    free(a1);
    return 0;
}
