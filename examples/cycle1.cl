class A inherits B {
   main(): SELF_TYPE {
	out_string("Hello, World.\n")
   };
};

class B inherits A {
   main(): SELF_TYPE {
	out_string("Hello, World.\n")
   };
};
