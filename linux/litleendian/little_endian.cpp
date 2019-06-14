
#include <fstream.h>
#include <iostream.h>

int main() {
   ofstream fout;

   cout << "Creating a file and saving data\n.";
   fout.open("file.dat");

   if(fout.fail()) {
      cout << "The file  couldn't be opened.\n";
      exit(1); 
   }

   
   int var = 65536;
   fout.write( reinterpret_cast< const char *>( &var), sizeof(var));
   var = 65535;
   fout.write( reinterpret_cast< const char *>( &var), sizeof(var));
   var = 70; 
   fout.write( reinterpret_cast< const char *>( &var), sizeof(var));
   fout.close();
   return 0;
}


