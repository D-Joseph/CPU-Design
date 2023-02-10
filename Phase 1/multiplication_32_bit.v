module multiplication_32_bit (
  input signed [31:0] a, b,
  output signed [63:0] product,

);

reg [31:0] A, Q;
reg [5:0] counter;

always @ (multiplicand or multiplier) begin
    A = multiplicand;
    Q = multiplier;
    counter = 6'd32;
    product = 64'b0;
end

always @ (counter) begin
    case (Q[1:0])
      2'b00 : begin
        A = {A[30:0], A[31]};
        Q = {Q[30:1], Q[31]};
      end 
      2'b01 : begin
        product = product + A;
        A = {A[30:0], A[31]};
        Q = {Q[30:1], Q[31]};
      end
      2'b10 : begin
        product = product - A;
        A = {A[30:0], A[31]};
        Q = {Q[30:1], Q[31]};
      end
      2'b11 : begin
        A = {A[30:1], A[31]};
        Q = {Q[30:0], Q[31]};
      end   
    endcase
   counter = counter - 1;
end
  
endmodule