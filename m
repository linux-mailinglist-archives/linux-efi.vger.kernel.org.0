Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E0B4D7D96
	for <lists+linux-efi@lfdr.de>; Mon, 14 Mar 2022 09:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbiCNI2Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Mar 2022 04:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiCNI2P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Mar 2022 04:28:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAB61C90D
        for <linux-efi@vger.kernel.org>; Mon, 14 Mar 2022 01:27:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D69B61244
        for <linux-efi@vger.kernel.org>; Mon, 14 Mar 2022 08:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53F9C340EE;
        Mon, 14 Mar 2022 08:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647246423;
        bh=uEYMh97A01Bpv6vYFf1w8esIt7Uwp6A86+/ymKZ/QmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cFZIQ2VAIElAX2RcajF3ADu3sOABlNhYz7hm682nuUXpv0InwdA3y7ExTtkrn5aRm
         /u1+gq/3ialsb9lM03XQR43jWofOuVVdSEVlnX5JQt9eC8SIQlqDzwkv3Yr2FdOkbb
         aOFstDA5qNUIzOf5+299IAj3tSEHxw5ZwZQdsf3RzRTKpFUYqeBvytmp/1puEA/2Wm
         XVbCTMW5+/cEWbgTEJiThuIbw0J4ZIz3glL8dqS2niPkPlBqrQmMmAEq1XtAfygd/W
         H9ybQzqFKKzb5EaOYj1QmKPbzS6ooT3pEVWsd+WCdpay58O8RlM4iUjWzRTCWtzjgt
         nw923Aev7tCUw==
From:   ardb@kernel.org
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@google.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Fuad Tabba <tabba@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC PATCH v0 1/6] Implement a bare metal Rust runtime on top of QEMU's mach-virt
Date:   Mon, 14 Mar 2022 09:26:39 +0100
Message-Id: <20220314082644.3436071-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220314082644.3436071-1-ardb@kernel.org>
References: <20220314082644.3436071-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@google.com>

Implement the startup sequence to set up a runtime for Rust code, and
populate it with a logger wired to the QEMU emulated PL011 UART, and a
heap allocator.

The .text and .rodata parts are in emulated NOR flash, and the
executable pieces execute in place. The .data and .bss sections as well
as the stack are disjoint from the flash image, and reside in DRAM. The
assembler startup code sets up the stack pointer and initializes the
writable sections.

The startup code programs the MMU with a set of translation tables in
NOR flash, which describe a 2M R-X region in flash, a 2 M R-- region
covering the base of DRAM (which is where QEMU's mach-virt puts the
device tree), and 2M RW- region used for the stack, .data/.bss and the
heap.
---
 .cargo/config  |   5 +
 .gitignore     |   2 +
 Cargo.lock     |  73 ++++++++++++
 Cargo.toml     |  10 ++
 efilite.lds    |  61 ++++++++++
 src/console.rs |  57 +++++++++
 src/cstring.rs |   9 ++
 src/head.S     | 121 ++++++++++++++++++++
 src/main.rs    |  49 +++++++-
 src/ttable.S   |  37 ++++++
 10 files changed, 422 insertions(+), 2 deletions(-)

diff --git a/.cargo/config b/.cargo/config
new file mode 100644
index 000000000000..584568a162de
--- /dev/null
+++ b/.cargo/config
@@ -0,0 +1,5 @@
+[target.aarch64-unknown-linux-gnu]
+rustflags = ["-C", "relocation-model=static", "-C", "link-arg=-Wl,-Tefilite.lds,--orphan-handling=warn", "-C", "link-arg=-nostartfiles"]
+
+[build]
+target = "aarch64-unknown-linux-gnu"
diff --git a/.gitignore b/.gitignore
index ea8c4bf7f35f..c5a7561a896d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1 +1,3 @@
 /target
+*.bin
+.*.swp
diff --git a/Cargo.lock b/Cargo.lock
new file mode 100644
index 000000000000..617acc9c6086
--- /dev/null
+++ b/Cargo.lock
@@ -0,0 +1,73 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
+
+[[package]]
+name = "cfg-if"
+version = "1.0.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+
+[[package]]
+name = "efilite"
+version = "0.1.0"
+dependencies = [
+ "linked_list_allocator",
+ "log",
+ "mmio",
+ "rlibc",
+]
+
+[[package]]
+name = "linked_list_allocator"
+version = "0.9.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "549ce1740e46b291953c4340adcd74c59bcf4308f4cac050fd33ba91b7168f4a"
+dependencies = [
+ "spinning_top",
+]
+
+[[package]]
+name = "lock_api"
+version = "0.4.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "88943dd7ef4a2e5a4bfa2753aaab3013e34ce2533d1996fb18ef591e315e2b3b"
+dependencies = [
+ "scopeguard",
+]
+
+[[package]]
+name = "log"
+version = "0.4.14"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "51b9bbe6c47d51fc3e1a9b945965946b4c44142ab8792c50835a980d362c2710"
+dependencies = [
+ "cfg-if",
+]
+
+[[package]]
+name = "mmio"
+version = "2.1.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ee857bfd0b37394f3507d78ee7bd4b712a2179a2ce50e47d36bbb481672f5408"
+
+[[package]]
+name = "rlibc"
+version = "1.0.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "fc874b127765f014d792f16763a81245ab80500e2ad921ed4ee9e82481ee08fe"
+
+[[package]]
+name = "scopeguard"
+version = "1.1.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "d29ab0c6d3fc0ee92fe66e2d99f700eab17a8d57d1c1d3b748380fb20baa78cd"
+
+[[package]]
+name = "spinning_top"
+version = "0.2.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "75adad84ee84b521fb2cca2d4fd0f1dab1d8d026bda3c5bea4ca63b5f9f9293c"
+dependencies = [
+ "lock_api",
+]
diff --git a/Cargo.toml b/Cargo.toml
index 07cf0efb7baf..9bc2b39f6e9b 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -6,3 +6,13 @@ edition = "2021"
 # See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html
 
 [dependencies]
+rlibc = "1.0.0"
+linked_list_allocator = "0.9.1"
+log = "0.4.14"
+mmio = "2.1.0"
+
+[profile.dev]
+panic = "abort"
+
+[profile.release]
+panic = "abort"
diff --git a/efilite.lds b/efilite.lds
new file mode 100644
index 000000000000..0632cbaf8e4e
--- /dev/null
+++ b/efilite.lds
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+MEMORY
+{
+	flash	: ORIGIN = 0,          LENGTH = 2M
+	ram	: ORIGIN = 0x40000000, LENGTH = 4M
+}
+
+PROVIDE(_init_base = 0x40000000);
+PROVIDE(_init_size = 0x400000);
+
+ENTRY(__init)
+
+SECTIONS
+{
+	.text : {
+		*(.head)
+		*(.text .text*)
+		*(.rodata .rodata*)
+		*(.got .got.plt)
+	} >flash
+
+	/*
+	 * QEMU passes the DT blob by storing it at the base of DRAM
+	 * before starting the guest
+	 */
+	.dtb (NOLOAD) : {
+		_dtb = .;
+		. += 0x200000;
+	} >ram
+
+	/*
+	 * put the stack first so we will notice if we overrun and
+	 * hit the R/O mapping of the DT blob
+	 */
+	.stack (NOLOAD) : {
+		. += 0x4000;
+		_stack_end = .;
+	} >ram
+
+	.data : ALIGN(32) {
+		_data = .;
+		*(.data .data*)
+		. = ALIGN(32);
+		_edata = .;
+	} >ram AT >flash
+
+	data_lma = LOADADDR(.data);
+
+	.bss : ALIGN (32) {
+		_bss_start = .;
+		*(.bss .bss*)
+		. = ALIGN(32);
+		_bss_end = .;
+		_end = .;
+	} >ram
+
+	/DISCARD/ : {
+		*(.note*)
+	}
+}
diff --git a/src/console.rs b/src/console.rs
new file mode 100644
index 000000000000..3841c6cb2dd0
--- /dev/null
+++ b/src/console.rs
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+use core::fmt::Write;
+use log::{Level, Metadata, Record};
+use mmio::{Allow, Deny, VolBox};
+
+pub struct QemuSerialConsole {
+    base: u64,
+}
+
+struct QemuSerialConsoleWriter<'a> {
+    console: &'a QemuSerialConsole,
+}
+
+impl QemuSerialConsole {
+    fn puts(&self, s: &str) {
+        //
+        // This is technically racy, as nothing is preventing concurrent accesses to the UART if we
+        // model it this way. However, this is a debug tool only, and we never read back the
+        // register value so any races cannot have any observeable side effects to the program
+        // itself.
+        //
+        let mut out = unsafe { VolBox::<u32, Deny, Allow>::new(self.base as *mut u32) };
+
+        for b in s.as_bytes().iter() {
+            if *b == b'\n' {
+                out.write(b'\r' as u32);
+            }
+            out.write(*b as u32)
+        }
+    }
+}
+
+impl Write for QemuSerialConsoleWriter<'_> {
+    fn write_str(&mut self, s: &str) -> core::fmt::Result {
+        self.console.puts(s);
+        Ok(())
+    }
+}
+
+impl log::Log for QemuSerialConsole {
+    fn enabled(&self, metadata: &Metadata) -> bool {
+        metadata.level() <= Level::Info
+    }
+
+    fn log(&self, record: &Record) {
+        if self.enabled(record.metadata()) {
+            let mut out = QemuSerialConsoleWriter { console: &self };
+            write!(&mut out, "{} - {}", record.level(), record.args()).unwrap();
+        }
+    }
+
+    fn flush(&self) {}
+}
+
+// The primary UART of QEMU's mach-virt
+pub static OUT: QemuSerialConsole = QemuSerialConsole { base: 0x900_0000 };
diff --git a/src/cstring.rs b/src/cstring.rs
new file mode 100644
index 000000000000..b6a5c4308067
--- /dev/null
+++ b/src/cstring.rs
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+extern crate rlibc;
+use rlibc::memcmp;
+
+#[no_mangle]
+pub unsafe extern "C" fn bcmp(s1: *const u8, s2: *const u8, len: usize) -> i32 {
+    memcmp(s1, s2, len)
+}
diff --git a/src/head.S b/src/head.S
new file mode 100644
index 000000000000..b82dca4325fa
--- /dev/null
+++ b/src/head.S
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+	.macro	adr_l, reg:req, sym:req
+	adrp	\reg, \sym
+	add	\reg, \reg, :lo12:\sym
+	.endm
+
+	.macro	mov_i, reg:req, imm:req
+	movz	\reg, :abs_g2:\imm
+	movk	\reg, :abs_g1_nc:\imm
+	movk	\reg, :abs_g0_nc:\imm
+	.endm
+
+	.section ".head", "ax", %progbits
+	.globl	__init
+__init:
+	mov_i	x0, mairval
+	mov_i	x1, tcrval
+	adrp	x2, idmap
+	mov_i	x3, sctlrval
+	mov_i	x4, cpacrval
+	adr_l	x5, vector_table
+
+	msr	mair_el1, x0		// set up the 1:1 mapping
+	msr	tcr_el1, x1
+	msr	ttbr0_el1, x2
+	isb
+
+	tlbi	vmalle1			// invalidate any cached translations
+	ic	iallu			// invalidate the I-cache
+	dsb	nsh
+	isb
+
+	msr	sctlr_el1, x3		// enable MMU and caches
+	msr	cpacr_el1, x4		// enable FP/SIMD
+	msr	vbar_el1, x5		// enable exception handling
+	isb
+
+	adr_l	x0, _data		// initialize the .data section
+	adr_l	x1, _edata
+	adr_l	x2, data_lma
+0:	cmp	x0, x1
+	b.ge	1f
+	ldp	q0, q1, [x2], #32
+	stp	q0, q1, [x0], #32
+	b	0b
+
+1:	adr_l	x0, _bss_start		// wipe the .bss section
+	adr_l	x1, _bss_end
+	movi	v0.16b, #0
+2:	cmp	x0, x1
+	b.ge	3f
+	stp	q0, q0, [x0], #32
+	b	2b
+
+3:	mov	x29, xzr		// initialize the frame pointer
+	adrp	x0, _stack_end
+	mov	sp, x0
+	adrp	x0, _init_base		// initial DRAM base address
+	movz	x1, :abs_g1:_init_size	// initially mapped area
+	adr_l	x2, _end		// statically allocated by program
+	sub	x2, x2, x0
+	bl	efilite_main
+
+4:	mov_i	x0, 0x84000008		// PSCI SYSTEM OFF
+	hvc	#0
+	wfi
+	b	4b
+
+	.macro	vector_entry
+	adrp	x0, idmap
+	adrp	x1, _stack_end
+	msr	ttbr0_el1, x0		// switch back to the initial ID map
+	isb
+	mov	sp, x1			// reset the stack pointer
+	mov	x29, xzr
+	mrs	x0, esr_el1
+	mrs	x1, elr_el1
+	mrs	x2, far_el1
+	bl	handle_exception
+	.endm
+
+	.section ".text", "ax", %progbits
+	.align	11
+vector_table:
+	vector_entry
+	.org	vector_table + 0x200
+	vector_entry
+	.org	vector_table + 0x400
+	vector_entry
+	.org	vector_table + 0x600
+	vector_entry
+
+	.set	.L_MAIR_DEV_nGnRE,	0x04
+	.set	.L_MAIR_MEM_WBWA,	0xff
+	.set	mairval, .L_MAIR_DEV_nGnRE | (.L_MAIR_MEM_WBWA << 8)
+
+	.set	.L_TCR_TG0_4KB,		0x0 << 14
+	.set	.L_TCR_TG1_4KB,		0x2 << 30
+	.set	.L_TCR_IPS_64GB,	0x1 << 32
+	.set	.L_TCR_EPD1,		0x1 << 23
+	.set	.L_TCR_SH_INNER,	0x3 << 12
+	.set	.L_TCR_RGN_OWB,		0x1 << 10
+	.set	.L_TCR_RGN_IWB,		0x1 << 8
+	.set	tcrval,	.L_TCR_TG0_4KB | .L_TCR_TG1_4KB | .L_TCR_EPD1 | .L_TCR_IPS_64GB | .L_TCR_RGN_OWB
+	.set	tcrval, tcrval | .L_TCR_RGN_IWB | .L_TCR_SH_INNER | (64 - 36) // TCR_T0SZ
+
+	.set	.L_SCTLR_ELx_I,		0x1 << 12
+	.set	.L_SCTLR_ELx_SA,	0x1 << 3
+	.set	.L_SCTLR_ELx_C,		0x1 << 2
+	.set	.L_SCTLR_ELx_M,		0x1 << 0
+	.set	.L_SCTLR_EL1_SPAN,	0x1 << 23
+	.set	.L_SCTLR_EL1_WXN,	0x1 << 19
+	.set	.L_SCTLR_EL1_SED,	0x1 << 8
+	.set	.L_SCTLR_EL1_ITD,	0x1 << 7
+	.set	.L_SCTLR_EL1_RES1,	(0x1 << 11) | (0x1 << 20) | (0x1 << 22) | (0x1 << 28) | (0x1 << 29)
+	.set	sctlrval, .L_SCTLR_ELx_M | .L_SCTLR_ELx_C | .L_SCTLR_ELx_SA | .L_SCTLR_EL1_ITD | .L_SCTLR_EL1_SED
+	.set	sctlrval, sctlrval | .L_SCTLR_ELx_I | .L_SCTLR_EL1_WXN | .L_SCTLR_EL1_SPAN | .L_SCTLR_EL1_RES1
+
+	.set	.L_CPACR_EL1_FPEN,	0x3 << 20
+	.set	cpacrval, .L_CPACR_EL1_FPEN
diff --git a/src/main.rs b/src/main.rs
index e7a11a969c03..698e9c5724bf 100644
--- a/src/main.rs
+++ b/src/main.rs
@@ -1,3 +1,48 @@
-fn main() {
-    println!("Hello, world!");
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#![no_std]
+#![no_main]
+
+mod console;
+mod cstring;
+
+use core::{arch::global_asm, panic::PanicInfo};
+use linked_list_allocator::LockedHeap;
+use log::{error, info};
+
+#[global_allocator]
+pub static ALLOCATOR: LockedHeap = LockedHeap::empty();
+
+#[no_mangle]
+extern "C" fn efilite_main(base: usize, mapped: usize, used: usize) {
+    #[cfg(debug_assertions)]
+    log::set_logger(&console::OUT)
+        .map(|()| log::set_max_level(log::LevelFilter::Info))
+        .unwrap();
+
+    // Give the mapped but unused memory to the heap allocator
+    info!(
+        "Heap allocator with {} KB of memory\n",
+        (mapped - used) / 1024
+    );
+    unsafe {
+        ALLOCATOR.lock().init(base + used, mapped - used);
+    }
 }
+
+#[no_mangle]
+extern "C" fn handle_exception(esr: u64, elr: u64, far: u64) -> ! {
+    panic!(
+        "Unhandled exception: ESR = 0x{:X}, ELR = 0x{:X}, FAR = 0x{:X}.",
+        esr, elr, far
+    );
+}
+
+#[panic_handler]
+fn panic(info: &PanicInfo) -> ! {
+    error!("{}\n", info);
+    loop {}
+}
+
+global_asm!(include_str!("head.S"));
+global_asm!(include_str!("ttable.S"));
diff --git a/src/ttable.S b/src/ttable.S
new file mode 100644
index 000000000000..b6fdadb6dbdc
--- /dev/null
+++ b/src/ttable.S
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+	.set		.L_TT_TYPE_BLOCK, 0x1
+	.set		.L_TT_TYPE_TABLE, 0x3
+
+	.set		.L_TT_AF, 0x1 << 10
+	.set		.L_TT_NG, 0x3 << 11
+	.set		.L_TT_RO, 0x2 << 6
+	.set		.L_TT_XN, 0x3 << 53
+
+	.set		.L_TT_MT_DEV, 0x0 << 2			// MAIR #0
+	.set		.L_TT_MT_MEM, (0x1 << 2) | (0x3 << 8)	// MAIR #1
+
+	.set		BLOCK_XIP, .L_TT_TYPE_BLOCK | .L_TT_MT_MEM | .L_TT_AF | .L_TT_RO
+	.set		BLOCK_DEV, .L_TT_TYPE_BLOCK | .L_TT_MT_DEV | .L_TT_AF | .L_TT_XN
+	.set		BLOCK_MEM, .L_TT_TYPE_BLOCK | .L_TT_MT_MEM | .L_TT_AF | .L_TT_XN | .L_TT_NG
+
+	.section ".rodata", "a", %progbits
+	.align	12
+	/* level 2 */
+0:	.quad		BLOCK_XIP			// 2 MB of R-X flash
+	.fill		63, 8, 0x0			// 126 MB of unused flash
+	.set		idx, 64
+	.rept		448
+	.quad		BLOCK_DEV | (idx << 21)		// 896 MB of RW- device mappings
+	.set		idx, idx + 1
+	.endr
+1:	.quad		BLOCK_XIP | 0x40000000		// DT provided by VMM
+	.quad		BLOCK_MEM | 0x40200000		// 2 MB of DRAM
+	.fill		510, 8, 0x0
+
+	.globl		idmap
+idmap:
+	/* level 1 */
+	.quad		0b + .L_TT_TYPE_TABLE		// flash and device mappings
+	.quad		1b + .L_TT_TYPE_TABLE		// up to 1 GB of DRAM
+	.fill		62, 8, 0x0			// 62 GB of remaining VA space
-- 
2.30.2

