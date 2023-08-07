Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88E4772AAF
	for <lists+linux-efi@lfdr.de>; Mon,  7 Aug 2023 18:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjHGQ2Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Aug 2023 12:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjHGQ2E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Aug 2023 12:28:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D77F19A2;
        Mon,  7 Aug 2023 09:27:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB15B61F1C;
        Mon,  7 Aug 2023 16:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1286C433C7;
        Mon,  7 Aug 2023 16:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691425678;
        bh=wLkaloJHosR7G8O4hExvKacWkVrWZEAmjuPTLPD83HU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iLBs8tQWroYr7GPdnLfFlCIKPA9p4Gqu6G0FUTnwADdlnYLXNwEZilYHKV6/6OWTk
         StG6IBaUprPsg6dQ3dJawd42a+UWPFpiaVyBU5xLcmMPKLr+LMKWvkpkrMZBg9gle8
         AuaiVHSvswjaMTCcoWonHMNdg6NRtz1vaUrl2R+s2VZCBHAkmK4vE9NUT6z0ho/3Fq
         q/PanXxXWRkmxjfjKUEOSZ/EXcOzelotZVMhcGNiBtWpe00MBFzehjSalCeRyUYXgh
         QY6E12qO+m4oWJ+wu+0mNmfhRuYXAxLx/gvMxKc8jX2bashZjjnYTv8VcJZWTtY4Ng
         KPF3mwJVP6khw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v9 08/23] x86/decompressor: Assign paging related global variables earlier
Date:   Mon,  7 Aug 2023 18:27:05 +0200
Message-Id: <20230807162720.545787-9-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807162720.545787-1-ardb@kernel.org>
References: <20230807162720.545787-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2032; i=ardb@kernel.org; h=from:subject; bh=wLkaloJHosR7G8O4hExvKacWkVrWZEAmjuPTLPD83HU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWidEh+/WHVA8/5+ZX/sX4+btDwdioz1yXGjV3Zrx682 90d9kSso5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkAxsjw7TTs1rvLvjp3JHY e23Fo0eSLXNn2+XM8fZzbM85vf+55EtGhm1ep9l0lk3IX3JeqZ3PsjDWTlZmSWA9f7S40rnJ67f XswAA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There is no need to defer the assignment of the paging related global
variabled 'pgdir_shift' and 'ptrs_per_p4d' until after the trampoline is
cleaned up, so assign them as soon as it is clear that 5-level paging
will be enabled.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/misc.h       |  2 --
 arch/x86/boot/compressed/pgtable_64.c | 14 +++++---------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 964fe903a1cdccdc..cc70d3fb90497ed8 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -179,9 +179,7 @@ static inline int count_immovable_mem_regions(void) { return 0; }
 #endif
 
 /* ident_map_64.c */
-#ifdef CONFIG_X86_5LEVEL
 extern unsigned int __pgtable_l5_enabled, pgdir_shift, ptrs_per_p4d;
-#endif
 extern void kernel_add_identity_map(unsigned long start, unsigned long end);
 
 /* Used by PAGE_KERN* macros: */
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 2ac12ff4111bf8c0..f8092d3244c9559b 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -130,6 +130,11 @@ struct paging_config paging_prepare(void *rmode)
 			native_cpuid_eax(0) >= 7 &&
 			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
 		paging_config.l5_required = 1;
+
+		/* Initialize variables for 5-level paging */
+		__pgtable_l5_enabled = 1;
+		pgdir_shift = 48;
+		ptrs_per_p4d = 512;
 	}
 
 	paging_config.trampoline_start = find_trampoline_placement();
@@ -206,13 +211,4 @@ void cleanup_trampoline(void *pgtable)
 
 	/* Restore trampoline memory */
 	memcpy(trampoline_32bit, trampoline_save, TRAMPOLINE_32BIT_SIZE);
-
-	/* Initialize variables for 5-level paging */
-#ifdef CONFIG_X86_5LEVEL
-	if (__read_cr4() & X86_CR4_LA57) {
-		__pgtable_l5_enabled = 1;
-		pgdir_shift = 48;
-		ptrs_per_p4d = 512;
-	}
-#endif
 }
-- 
2.39.2

