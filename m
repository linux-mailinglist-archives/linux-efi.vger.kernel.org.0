Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ECA4D7D99
	for <lists+linux-efi@lfdr.de>; Mon, 14 Mar 2022 09:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbiCNI2X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Mar 2022 04:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237028AbiCNI2W (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Mar 2022 04:28:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2AE1C90D
        for <linux-efi@vger.kernel.org>; Mon, 14 Mar 2022 01:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CF84B80B01
        for <linux-efi@vger.kernel.org>; Mon, 14 Mar 2022 08:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88578C340F6;
        Mon, 14 Mar 2022 08:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647246430;
        bh=z/YGAz9LQB8pb8wT8N++FTB8PEZI7HV+rq1+GaYfjpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNzdZjkDs+iRFcUzGzvBd/xrLOEyuqcphlEFIf8vsyckpcgWaxbEkgxDOX83ST/vc
         ruvWX7GX9uiAOxi1xKAGgVC3y2L8Tg66VAVURVUSUiTa8b8Sws/JWwXNUH0Ngbz4YC
         HQ8R9NJgt1QSzaJvKI2czyaZucn57gboovH03Zah9JrAWj03I9UgpCxJuSJstUvPA1
         Gi+rBJ3B7r/q9f9qPBEvSIDKAk5uQAJ8Kv+B6gcqaL6lwrkxM/Tk1950prPMvaLELF
         3LDOymK8RirWsaKmd0Tn+3Z3EuZxeVbaXGbZGTUmmontSOS656NqbHciWybR1bYOEl
         CqWvaLBWjyO8g==
From:   ardb@kernel.org
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@google.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Fuad Tabba <tabba@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC PATCH v0 4/6] Discover QEMU fwcfg device and use it to load the kernel
Date:   Mon, 14 Mar 2022 09:26:42 +0100
Message-Id: <20220314082644.3436071-5-ardb@kernel.org>
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

QEMU exposes a paravirtualized interface to load various items exposed
by the host into the guest. Implement a minimal driver for it, and use
it to load the kernel image into DRAM.
---
 src/fwcfg.rs | 85 ++++++++++++++++++++
 src/main.rs  | 18 +++++
 2 files changed, 103 insertions(+)

diff --git a/src/fwcfg.rs b/src/fwcfg.rs
new file mode 100644
index 000000000000..57f405df174b
--- /dev/null
+++ b/src/fwcfg.rs
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+use mmio::{Allow, Deny, VolBox};
+
+pub struct FwCfg {
+    // read-only data register
+    data: VolBox<u64, Allow, Deny>,
+
+    // write-only selector register
+    selector: VolBox<u16, Deny, Allow>,
+
+    // write-only DMA register
+    dmacontrol: VolBox<u64, Deny, Allow>,
+}
+
+const CFG_KERNEL_SIZE: u16 = 0x08;
+const CFG_KERNEL_DATA: u16 = 0x11;
+
+const CFG_DMACTL_DONE: u32 = 0;
+const CFG_DMACTL_ERROR: u32 = 1;
+const CFG_DMACTL_READ: u32 = 2;
+
+#[repr(C)]
+struct DmaTransfer {
+    control: u32,
+    length: u32,
+    address: u64,
+}
+
+impl FwCfg {
+    pub fn from_fdt_node(node: fdt::node::FdtNode) -> Option<FwCfg> {
+        if let Some(mut iter) = node.reg() {
+            iter.next().map(|reg| {
+                let addr = reg.starting_address;
+                unsafe {
+                    FwCfg {
+                        data: VolBox::<u64, Allow, Deny>::new(addr as *mut u64),
+                        selector: VolBox::<u16, Deny, Allow>::new(addr.offset(8) as *mut u16),
+                        dmacontrol: VolBox::<u64, Deny, Allow>::new(addr.offset(16) as *mut u64),
+                    }
+                }
+            })
+        } else {
+            None
+        }
+    }
+
+    unsafe fn dma_transfer(
+        &mut self,
+        load_address: *mut u8,
+        size: usize,
+        config_item: u16,
+    ) -> Result<(), &str> {
+        let xfer = DmaTransfer {
+            control: u32::to_be(CFG_DMACTL_READ),
+            length: u32::to_be(size as u32),
+            address: u64::to_be(load_address as u64),
+        };
+        self.selector.write(u16::to_be(config_item));
+        self.dmacontrol.write(u64::to_be(&xfer as *const _ as u64));
+
+        let control = VolBox::<u32, Allow, Deny>::new(&xfer.control as *const _ as *mut u32);
+        loop {
+            match control.read() {
+                CFG_DMACTL_DONE => return Ok(()),
+                CFG_DMACTL_ERROR => return Err("fwcfg DMA error"),
+                _ => (), // keep polling
+            }
+        }
+    }
+
+    pub fn get_kernel_size(&mut self) -> usize {
+        self.selector.write(u16::to_be(CFG_KERNEL_SIZE));
+        self.data.read() as usize
+    }
+
+    pub fn load_kernel_image(&mut self, load_address: *mut u8) -> Result<(), &str> {
+        let size = self.get_kernel_size();
+        if size > 0 {
+            unsafe { self.dma_transfer(load_address, size, CFG_KERNEL_DATA) }
+        } else {
+            Err("No kernel image provided by fwcfg")
+        }
+    }
+}
diff --git a/src/main.rs b/src/main.rs
index af58ccc0318d..048d1b4842cb 100644
--- a/src/main.rs
+++ b/src/main.rs
@@ -8,6 +8,7 @@
 
 mod console;
 mod cstring;
+mod fwcfg;
 mod pagealloc;
 mod paging;
 
@@ -28,6 +29,8 @@ extern "C" {
     static _dtb_end: u8;
 }
 
+const LOAD_ADDRESS: *mut u8 = 0x43210000 as _;
+
 #[no_mangle]
 extern "C" fn efilite_main(base: usize, mapped: usize, used: usize) {
     #[cfg(debug_assertions)]
@@ -79,6 +82,21 @@ extern "C" fn efilite_main(base: usize, mapped: usize, used: usize) {
     // Switch to the new ID map so we can use all of DRAM
     paging::activate();
 
+    let compat = ["qemu,fw-cfg-mmio"];
+    let fwcfg_node = fdt
+        .find_compatible(&compat)
+        .expect("QEMU fwcfg node not found");
+
+    info!("QEMU fwcfg node found: {}\n", fwcfg_node.name);
+
+    let mut fwcfg = fwcfg::FwCfg::from_fdt_node(fwcfg_node).expect("Failed to open fwcfg device");
+
+    // TODO allocate fwcfg.get_kernel_size() bytes here instead of using a fixed address
+
+    fwcfg
+        .load_kernel_image(LOAD_ADDRESS)
+        .expect("Failed to load kernel image");
+
     // Switch back to the initial ID map so we can remap
     // the loaded kernel image with different permissions
     paging::deactivate();
-- 
2.30.2

