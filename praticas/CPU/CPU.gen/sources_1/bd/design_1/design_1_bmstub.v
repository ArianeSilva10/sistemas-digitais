// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------

`timescale 1 ps / 1 ps

(* BLOCK_STUB = "true" *)
module design_1 (
  clk_0,
  rst_0
);

  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK" *)
  (* X_INTERFACE_MODE = "slave CLK.CLK_0" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_0, INSERT_VIP 0" *)
  input clk_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RST_0 RST" *)
  (* X_INTERFACE_MODE = "slave RST.RST_0" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RST_0, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
  input rst_0;

  // stub module has no contents

endmodule
