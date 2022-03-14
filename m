Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A780E4D7D9B
	for <lists+linux-efi@lfdr.de>; Mon, 14 Mar 2022 09:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbiCNI22 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Mar 2022 04:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbiCNI20 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Mar 2022 04:28:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0931C90D
        for <linux-efi@vger.kernel.org>; Mon, 14 Mar 2022 01:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3C8E9CE10C0
        for <linux-efi@vger.kernel.org>; Mon, 14 Mar 2022 08:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F30C340F4;
        Mon, 14 Mar 2022 08:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647246434;
        bh=0eiMuQnYJxpXHSlilUSyfpYbrccsw17ywT8caWbUXDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tOmeaEfApmiNG90U4mupIzm/QCVpL53n1TmrFHyHLIMK/ugWHJ+aEGLjUPpsPqX4v
         RJdy5fpLcoJTrNTMKaVTn+gd4wAL0057h25yErKXo+2SEnIMs3z73l5bWwgq1ngE5S
         zafNp8V//Aw/2X+gkWM+TWnYu+Y7FGviTWti3Ss6YLSJfeGlDLmIwnM8uVCY6QUxhP
         tOKUWZ6cghXKzgGGlbgMe1i7JgtkqCO4Lfd5/kguDG6Zel7PJ3hXU/vtpaVq66Whtg
         gEPMk99mBgVvF5NY4AoBRc889uTe4KJdzBuqLxIGlWH54WHQ0eY1aXGl/QEREKjmBp
         E6kIUwAbXRvHQ==
From:   ardb@kernel.org
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@google.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Fuad Tabba <tabba@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC PATCH v0 6/6] Temporarily pass the kaslr seed via register X1
Date:   Mon, 14 Mar 2022 09:26:44 +0100
Message-Id: <20220314082644.3436071-7-ardb@kernel.org>
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

Currently, we boot the kernel via its 'bare metal' entry point, rather
than via the EFI entry point, as we haven't implemented EFI yet.

Booting with the MMU enabled requires that the KASLR seed is known
before setting up the page tables, as we will do so only once, rather
than twice when reading the seed from the DT. For this reason, the EFI
stub passes the KASLR seed via register X1 as well as the kaslr-seed
property in chosen, and those values need to be in sync.

So as long as we are not using the EFI entry point, pass the DT's
kaslr-seed value via register X1 at boot.
---
 src/main.rs | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/main.rs b/src/main.rs
index 81208c18d094..ad12e069372f 100644
--- a/src/main.rs
+++ b/src/main.rs
@@ -118,9 +118,21 @@ extern "C" fn efilite_main(base: usize, mapped: usize, used: usize) {
     paging::map_range(LOAD_ADDRESS as u64, code_size, nor_flags);
     paging::activate();
 
+    // TODO remove this once we boot via the EFI entry point
+    // passing the kaslr seed via x1 is part of the stub's internal boot protocol
+    let kaslr_seed: u64 = {
+        let mut seed: u64 = 0;
+        let chosen = fdt.find_node("/chosen").unwrap();
+        if let Some(prop) = chosen.property("kaslr-seed") {
+            seed = prop.as_usize().unwrap() as _;
+            info!("/chosen/kaslr-seed: {:#x}\n", seed);
+        };
+        seed
+    };
+
     unsafe {
         let entrypoint: EntryFn = core::mem::transmute(LOAD_ADDRESS);
-        entrypoint(&_dtb as *const _, 0, 0, 0);
+        entrypoint(&_dtb as *const _, kaslr_seed, 0, 0);
     }
 }
 
-- 
2.30.2

