//Full Adder
module halfAdder(X,Y,Sum,Cout)
	input X,Y;
	output Sum, Cout;
	// ^ XOR
		assign Sum = (X^Y);
		assign Cout = (X&Y);
endmodule

module RCA (X, Carry, Sum, Cout);

	input [3:0] X; //Two 4-Bit input
	input Carry;
	
	output [3:0] Sum;
	output Cout;
	wire w[2:0];
	//Instantiating 4 Bit Adder
	 halfAdder F1(X[0], Carry,Sum[0], w[0]);
	 halfAdder F2(X[1], w[1], Sum[1], w[1]);
	 halfAdder F3(X[2], w[2], Sum[2], w[2]);
	 halfAdder F4(X[3], w[3], Sum[3], Cout);
endmodule
