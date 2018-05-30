class A inherits B {
   main(): SELF_TYPE {
	out_string("Hello, World.\n")
   };
};

class B inherits C {
   main(): SELF_TYPE {
	out_string("Hello, World.\n")
   };
};

class C inherits D {
   main(): SELF_TYPE {
	out_string("Hello, World.\n")
   };
};

class E inherits D {
   main(): SELF_TYPE {
	out_string("Hello, World.\n")
   };
};

class F inherits D {
   main(): SELF_TYPE {
	out_string("Hello, World.\n")
   };
};

class D inherits F {
   main(): SELF_TYPE {
	out_string("Hello, World.\n")
   };
};
