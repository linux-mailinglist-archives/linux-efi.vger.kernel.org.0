Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CF24D7D97
	for <lists+linux-efi@lfdr.de>; Mon, 14 Mar 2022 09:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiCNI2R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Mar 2022 04:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237028AbiCNI2P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Mar 2022 04:28:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72421CB0B
        for <linux-efi@vger.kernel.org>; Mon, 14 Mar 2022 01:27:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F6DC6125C
        for <linux-efi@vger.kernel.org>; Mon, 14 Mar 2022 08:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4005C340F6;
        Mon, 14 Mar 2022 08:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647246425;
        bh=vzSBjJ1sxDwQUc1X0CmXZXicnEitrFeXZRaxKaqJLb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hOmF36EguKA2IrnDnWkzFjcwzCUk5QZ6sGQF3A6qqs4LegPuTtWerBg3orBrpoQPk
         vJoxzdM/RZB6DRTJxyiBqvgI2A2JU7Irawf4F8sc1zuZeuVHNGj8Ms0bBksPsc0N1L
         WbCi1DiynEFA8DQXQcbhHwtEWWZVt1VkdeUy9NzDoC1in5gBTHOl0aEua5Viq7adEW
         J1Oxk9GC1h6mqj18JEbxV5W8fy6CQSoumoH7TcJXqsPnhFAG92X1NWyeYGLLHYPmvJ
         qYlrnKz0fB1LMtdykJ/Dr9CX1NX4hIEuKf80Q/+DXJ9/ROaYgKOayQSwWTh7wFidlw
         UrYbJkrMj1JFQ==
From:   ardb@kernel.org
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@google.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Fuad Tabba <tabba@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC PATCH v0 2/6] Add DTB processing
Date:   Mon, 14 Mar 2022 09:26:40 +0100
Message-Id: <20220314082644.3436071-3-ardb@kernel.org>
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

Add handling of the QEMU provided DTB, which we will need to consult to
find the DRAM layout and the fwcfg device. Initially, just dump the
/chosen/bootargs only, if one is provided.
---
 Cargo.lock  |  7 +++++++
 Cargo.toml  |  1 +
 src/main.rs | 10 ++++++++++
 3 files changed, 18 insertions(+)

diff --git a/Cargo.lock b/Cargo.lock
index 617acc9c6086..2750d4a3937c 100644
--- a/Cargo.lock
+++ b/Cargo.lock
@@ -12,12 +12,19 @@ checksum = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
 name = "efilite"
 version = "0.1.0"
 dependencies = [
+ "fdt",
  "linked_list_allocator",
  "log",
  "mmio",
  "rlibc",
 ]
 
+[[package]]
+name = "fdt"
+version = "0.1.3"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "b643857cf70949306b81d7e92cb9d47add673868edac9863c4a49c42feaf3f1e"
+
 [[package]]
 name = "linked_list_allocator"
 version = "0.9.1"
diff --git a/Cargo.toml b/Cargo.toml
index 9bc2b39f6e9b..b073376d9e16 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -10,6 +10,7 @@ rlibc = "1.0.0"
 linked_list_allocator = "0.9.1"
 log = "0.4.14"
 mmio = "2.1.0"
+fdt = "0.1.3"
 
 [profile.dev]
 panic = "abort"
diff --git a/src/main.rs b/src/main.rs
index 698e9c5724bf..6d880732b469 100644
--- a/src/main.rs
+++ b/src/main.rs
@@ -13,6 +13,10 @@ use log::{error, info};
 #[global_allocator]
 pub static ALLOCATOR: LockedHeap = LockedHeap::empty();
 
+extern "C" {
+    static _dtb: u8;
+}
+
 #[no_mangle]
 extern "C" fn efilite_main(base: usize, mapped: usize, used: usize) {
     #[cfg(debug_assertions)]
@@ -28,6 +32,12 @@ extern "C" fn efilite_main(base: usize, mapped: usize, used: usize) {
     unsafe {
         ALLOCATOR.lock().init(base + used, mapped - used);
     }
+
+    let fdt = unsafe { fdt::Fdt::from_ptr(&_dtb).expect("Failed to parse device tree") };
+
+    fdt.chosen()
+        .bootargs()
+        .map(|args| info!("/chosen/bootargs: {:?}\n", args));
 }
 
 #[no_mangle]
-- 
2.30.2

