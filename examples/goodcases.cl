class Main inherits IO { 
   a : Int; 
   var: String; 
   main(): SELF_TYPE { 
 	{ 
		a <- 10; 
	 	out_string("Hello World.\n"); 
		case var of 
		b: Int => out_string("class type"); 
		c: String => out_string("another class type"); 
		esac; 
		} 
	}; 
}; 
