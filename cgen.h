#include <assert.h>
#include <stdio.h>
#include "emit.h"
#include "cool-tree.h"
#include "symtab.h"
#include <vector> 
enum Basicness     {Basic, NotBasic};
#define TRUE 1
#define FALSE 0

class CgenClassTable;
typedef CgenClassTable *CgenClassTableP;

class CgenNode;
typedef CgenNode *CgenNodeP;


class CgenClassTable : public SymbolTable<Symbol,CgenNode> {
private:
   List<CgenNode> *nds;
   std::vector<CgenNodeP> nd_vector; 
   ostream& str;
   int stringclasstag;
   int intclasstag;
   int boolclasstag;
   int curr_class_tag;
   SymbolTable<Symbol, method_class> *method_table;  


// The following methods emit code for
// constants and global declarations.

   void code_global_data();
   void code_global_text();
   void code_bools(int);
   void code_select_gc();
   void code_constants();
//   void code_obj_init(); 
   void code_class_nametab(); 
   void code_class_objtab(); 
  // void code_dispatch_tables(); 
   void code_prototypes();  
   void code_disptab(); 
// The following creates an inheritance graph from
// a list of classes.  The graph is implemented as
// a tree of `CgenNode', and class names are placed
// in the base class symbol table.

   void install_basic_classes();
   void install_class(CgenNodeP nd);
   void install_classes(Classes cs);
   void build_inheritance_tree();
   void set_relations(CgenNodeP nd);
   void set_all_attribs(CgenNodeP nd);
   void set_meth_init(CgenNodeP nd);  
   void set_all_meth(CgenNodeP nd); 
   std::vector<CgenNodeP> get_inheritance_path(CgenNodeP nd);  
   
public:
   CgenClassTable(Classes, ostream& str);
   void code();
   CgenNodeP root();
};


class CgenNode : public class__class {
private: 
   CgenNodeP parentnd;                        // Parent of class
   List<CgenNode> *children;                  // Children of class
   Basicness basic_status;                    // `Basic' if class is basic
   int tag_val;  
   std::vector<attr_class*> attributes; 
   std::vector<method_class*> methods;                              // `NotBasic' otherwise

public:
   CgenNode(Class_ c,
            Basicness bstatus,
            CgenClassTableP class_table);

   void add_child(CgenNodeP child);
   List<CgenNode> *get_children() { return children; }
   void set_parentnd(CgenNodeP p);
   CgenNodeP get_parentnd() { return parentnd; }
   int basic() { return (basic_status == Basic); }
   int get_tag_val() {return tag_val;} 
   void set_tag_val(int tag) {tag_val = tag;} 
   std::vector<attr_class*> get_attribs() { return attributes; } 
   std::vector<method_class*> get_methods() { return methods; }
   void set_attrib(attr_class*  attrib) {attributes.push_back(attrib); } 
   void set_method(method_class*  method) {methods.push_back(method); }  

};

class BoolConst 
{
 private: 
  int val;
 public:
  BoolConst(int);
  void code_def(ostream&, int boolclasstag);
  void code_ref(ostream&) const;
};

