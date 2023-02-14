module multiplication_32_bit (
  input wire [31:0] a,
  input wire [31:0] b,
  output wire [63:0] result
);

  wire [31:0] p;
  wire [31:0] q;
  wire [31:0] n;
  wire [31:0] sum;

  reg[30:0] p_next;
  reg [30:0] q_next;

  wire [63:0] result_temp;
  wire [31:0] result_temp_low;
  wire [31:0] result_temp_high;

  assign p = a << 1;
  assign q = {b[31], b[30:0]};
  assign n = ~b + 1;
  assign sum = q + n;

  always @ (p or sum) begin
    if (p[0] == 1'b0) begin
      p_next = {p[30:0], 1'b0};
    end else if (p[0] == 1'b1 && sum[0] == 1'b0) begin
      p_next = {sum[30:0], 1'b0};
    end else begin
      p_next = {sum[30:0], 1'b1};
    end
  end

  always @ (p_next or q) begin
    if (p_next[0] == 1'b0) begin
      q_next = q >> 1;
    end else if (p_next[0] == 1'b1 && q[0] == 1'b0) begin
      q_next = (q + n) >> 1;
    end else begin
      q_next = (q + p) >> 1;
    end
  end

  assign result_temp = {p_next, q_next};
  assign result_temp_low = result_temp[31:0];
  assign result_temp_high = result_temp[63:32];
  assign result = {result_temp_high, result_temp_low};

endmodule
