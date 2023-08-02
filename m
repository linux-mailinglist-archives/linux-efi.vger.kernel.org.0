Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471E276D2D6
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 17:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjHBPuJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 11:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbjHBPtr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 11:49:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C4A2115;
        Wed,  2 Aug 2023 08:49:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB5E561A22;
        Wed,  2 Aug 2023 15:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3565DC433CA;
        Wed,  2 Aug 2023 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690991367;
        bh=wLkaloJHosR7G8O4hExvKacWkVrWZEAmjuPTLPD83HU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z0jbRDxOadnHFmUlfOB+RPWvI0hs1uNcNcfp1ibBm8GunBz62YVbcJnOxKIjBWBhV
         g2mFqj2qoy4+7H9HXZ2SishX+VdRgSLDouR4C1Mcu823yAO+v4iYAaQO/P+zU5s2HE
         +CHi48+wwja0V7UKXCgSoMA8GD3h6Jbkj/fCJTnYO6PEiybmPREaBDWoVZBZoks+9z
         2XIK3HraGn9QoP08ezXrovI3oeRjYMBfBkXiJ0m6TW507DcyJkyWTuLCl2poYjm7YF
         A6oSZjq/hmIn1QLB2fhWK/JJb2ekEl6UWCTvHk5K8t6Ftss8/rzvxXZU6za75ePWjX
         6FhsxNb1LDYbg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v8 08/23] x86/decompressor: Assign paging related global variables earlier
Date:   Wed,  2 Aug 2023 17:48:16 +0200
Message-Id: <20230802154831.2147855-9-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802154831.2147855-1-ardb@kernel.org>
References: <20230802154831.2147855-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2032; i=ardb@kernel.org; h=from:subject; bh=wLkaloJHosR7G8O4hExvKacWkVrWZEAmjuPTLPD83HU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVU1e78+sOqB57z8yv/Y/183KDh7VRmrkuMG7uyXz14t 7s77IlYRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIvhWMDJ1Z6r+qdslerPrr 93nD2wQ3jdpAj4O38uXWzzUqPsj9+R0jwzopDUP23kqVHIHDZ+7MMlwh9TqswOH6ceEPTm7G3Tw vGQA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

