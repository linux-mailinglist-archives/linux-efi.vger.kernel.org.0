Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1B74D7D9A
	for <lists+linux-efi@lfdr.de>; Mon, 14 Mar 2022 09:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbiCNI2X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Mar 2022 04:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbiCNI2W (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Mar 2022 04:28:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BFE1CFDF
        for <linux-efi@vger.kernel.org>; Mon, 14 Mar 2022 01:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10A6861244
        for <linux-efi@vger.kernel.org>; Mon, 14 Mar 2022 08:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64B8C340E9;
        Mon, 14 Mar 2022 08:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647246432;
        bh=06tI/T1GvhECF+IatJT8s2EXaWx5xagNfQnNrKsZMMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELoP4rvEy7ZpK5RCFCWN1lim32r836rjlT8rAYg4g9TJH3n0m1EMjGwglMKTf/F0G
         aeiYg5AG3NDaL3A7Cq5aOL35wwRe3wOW1SOt+sd39dJZlzaGW1bQKqjUm27aBV6ZFW
         SVG0S0V54AaP/kOmJqYMT2zlqZZYzQiXrbr0nddd5exHerKfjvn29LshIqohEfJBDf
         JzR5A2fInJFBVDfuJuVfFLvZ1+bi1esL0OxEAAOTEP+t5zxN3UmLlw7o2wliW37pG0
         1OjM92y9IurC19jGDE24PFcNGcAhdnTq9D/B+cnzQZnKcrgEOyh3YFWdVMV1xCQzC4
         uR0qO1gzDAaxQ==
From:   ardb@kernel.org
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@google.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Fuad Tabba <tabba@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC PATCH v0 5/6] Remap code section of loaded kernel and boot it
Date:   Mon, 14 Mar 2022 09:26:43 +0100
Message-Id: <20220314082644.3436071-6-ardb@kernel.org>
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

Implement the bare minimum needed to discover the size of the
text/rodata region of the loaded image, and use it to remap this region
read-only so that we can execute it while WXN protections are enabled.

Then, boot the loaded image by jumping to the start of it.
---
 src/cmo.rs    | 37 ++++++++++++++++++++
 src/main.rs   | 22 ++++++++++++
 src/pecoff.rs | 23 ++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/src/cmo.rs b/src/cmo.rs
new file mode 100644
index 000000000000..49456222c705
--- /dev/null
+++ b/src/cmo.rs
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+use core::arch::asm;
+
+const CTR_IDC: u64 = 1 << 28;
+
+const CTR_DMINLINE_SHIFT: u64 = 16;
+const CTR_DMINLINE_MASK: u64 = 0xf;
+
+pub fn dcache_clean_to_pou(base: *const u8, size: isize) {
+    let ctr = unsafe {
+        let mut l: u64;
+        asm!("mrs {reg}, ctr_el0", // CTR: cache type register
+            reg = out(reg) l,
+            options(pure, nomem, nostack, preserves_flags),
+        );
+        l
+    };
+
+    // Perform the clean only if needed for coherency with the I side
+    if (ctr & CTR_IDC) == 0 {
+        let line_shift = 2 + ((ctr >> CTR_DMINLINE_SHIFT) & CTR_DMINLINE_MASK);
+        let line_size: isize = 1 << line_shift;
+        let num_lines = (size + line_size - 1) >> line_shift;
+        let mut offset: isize = 0;
+
+        for _ in 1..=num_lines {
+            unsafe {
+                asm!("dc cvau, {reg}",
+                    reg = in(reg) base.offset(offset),
+                    options(nomem, nostack, preserves_flags),
+                );
+            }
+            offset += line_size;
+        }
+    }
+}
diff --git a/src/main.rs b/src/main.rs
index 048d1b4842cb..81208c18d094 100644
--- a/src/main.rs
+++ b/src/main.rs
@@ -6,11 +6,13 @@
 #![allow(incomplete_features)]
 #![feature(specialization)]
 
+mod cmo;
 mod console;
 mod cstring;
 mod fwcfg;
 mod pagealloc;
 mod paging;
+mod pecoff;
 
 use core::{arch::global_asm, panic::PanicInfo};
 use linked_list_allocator::LockedHeap;
@@ -29,6 +31,8 @@ extern "C" {
     static _dtb_end: u8;
 }
 
+type EntryFn = unsafe extern "C" fn(*const u8, u64, u64, u64) -> !;
+
 const LOAD_ADDRESS: *mut u8 = 0x43210000 as _;
 
 #[no_mangle]
@@ -97,9 +101,27 @@ extern "C" fn efilite_main(base: usize, mapped: usize, used: usize) {
         .load_kernel_image(LOAD_ADDRESS)
         .expect("Failed to load kernel image");
 
+    let pe_image = pecoff::Parser::from_ptr(LOAD_ADDRESS);
+
+    // Clean the code region of the loaded image to the PoU so we
+    // can safely fetch instructions from it once the PXN/UXN
+    // attributes are cleared
+    let code_size = pe_image.get_code_size();
+    cmo::dcache_clean_to_pou(LOAD_ADDRESS, code_size as isize);
+
     // Switch back to the initial ID map so we can remap
     // the loaded kernel image with different permissions
     paging::deactivate();
+
+    // Remap the text/rodata part of the image read-only so we will
+    // be able to execute it with WXN protections enabled
+    paging::map_range(LOAD_ADDRESS as u64, code_size, nor_flags);
+    paging::activate();
+
+    unsafe {
+        let entrypoint: EntryFn = core::mem::transmute(LOAD_ADDRESS);
+        entrypoint(&_dtb as *const _, 0, 0, 0);
+    }
 }
 
 #[no_mangle]
diff --git a/src/pecoff.rs b/src/pecoff.rs
new file mode 100644
index 000000000000..b9b82fc5cc53
--- /dev/null
+++ b/src/pecoff.rs
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+pub struct Parser {
+    base_of_code: u64,
+    size_of_code: u64,
+}
+
+impl Parser {
+    pub fn from_ptr(ptr: *const u8) -> Parser {
+        // TODO check magic number, arch, etc
+        // TODO deal with variable PE header offset
+        let pehdr_offset = 64;
+
+        Parser {
+            base_of_code: unsafe { *(ptr.offset(pehdr_offset + 28) as *const u32) } as u64,
+            size_of_code: unsafe { *(ptr.offset(pehdr_offset + 44) as *const u32) } as u64,
+        }
+    }
+
+    pub fn get_code_size(&self) -> u64 {
+        return self.base_of_code + self.size_of_code;
+    }
+}
-- 
2.30.2

