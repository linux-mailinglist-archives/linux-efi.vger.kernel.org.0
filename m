Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9515C6341A7
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbiKVQiY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiKVQiX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:38:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBEF1F629;
        Tue, 22 Nov 2022 08:38:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 387B21F86B;
        Tue, 22 Nov 2022 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669135100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ijZzk37OXai+jGE+66RqH2CbOPjTrghJ/VVtjn87O6o=;
        b=XioRDaqYtGYbNEWh/ik6eRxv0gzn3AnafIr6/RKaxSGQxsRaIU+yR3G+bTNKuRfJDUQV1t
        DiF0dXt5wE1/eK/HbLWuXYWHcWAofp3zL+V77IALMa2StJ3omO/efbwi1tbBIFoeB5FU0u
        /YzzK5LAVtXuZtCjvg04QfQ6xewmQhk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D190E13AA1;
        Tue, 22 Nov 2022 16:38:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lpDPMfv6fGMXPgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 22 Nov 2022 16:38:19 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [PATCH v2 1/3] x86/realmode: test real_mode_header outside of real_mode_size_needed()
Date:   Tue, 22 Nov 2022 17:38:08 +0100
Message-Id: <20221122163810.29752-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221122163810.29752-1-jgross@suse.com>
References: <20221122163810.29752-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move the test for the realmode trampoline memory having been allocated
already to the callers of real_mode_size_needed(). This allows to use
that function in setup_real_mode() and set_real_mode_permissions(),
too.

While at it change the size calculation to use PAGE_ALIGN() instead of
open coding it.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/realmode.h | 5 +----
 arch/x86/platform/efi/quirks.c  | 3 ++-
 arch/x86/realmode/init.c        | 6 +++---
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index fd6f6e5b755a..1eb3d4232e81 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -78,10 +78,7 @@ extern unsigned char secondary_startup_64_no_verify[];
 
 static inline size_t real_mode_size_needed(void)
 {
-	if (real_mode_header)
-		return 0;	/* already allocated. */
-
-	return ALIGN(real_mode_blob_end - real_mode_blob, PAGE_SIZE);
+	return PAGE_ALIGN(real_mode_blob_end - real_mode_blob);
 }
 
 static inline void set_real_mode_mem(phys_addr_t mem)
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index b0b848d6933a..7c18ca720eee 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -445,7 +445,8 @@ void __init efi_free_boot_services(void)
 		 * panicking early.)
 		 */
 		rm_size = real_mode_size_needed();
-		if (rm_size && (start + rm_size) < (1<<20) && size >= rm_size) {
+		if (!real_mode_header && rm_size &&
+		    (start + rm_size) < (1<<20) && size >= rm_size) {
 			set_real_mode_mem(start);
 			start += rm_size;
 			size -= rm_size;
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 41d7669a97ad..37a3658efaa0 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -48,7 +48,7 @@ void __init reserve_real_mode(void)
 	phys_addr_t mem;
 	size_t size = real_mode_size_needed();
 
-	if (!size)
+	if (real_mode_header || !size)
 		return;
 
 	WARN_ON(slab_is_available());
@@ -94,7 +94,7 @@ static void __init setup_real_mode(void)
 	unsigned char *base;
 	unsigned long phys_base;
 	struct trampoline_header *trampoline_header;
-	size_t size = PAGE_ALIGN(real_mode_blob_end - real_mode_blob);
+	size_t size = real_mode_size_needed();
 #ifdef CONFIG_X86_64
 	u64 *trampoline_pgd;
 	u64 efer;
@@ -182,7 +182,7 @@ static void __init setup_real_mode(void)
 static void __init set_real_mode_permissions(void)
 {
 	unsigned char *base = (unsigned char *) real_mode_header;
-	size_t size = PAGE_ALIGN(real_mode_blob_end - real_mode_blob);
+	size_t size = real_mode_size_needed();
 
 	size_t ro_size =
 		PAGE_ALIGN(real_mode_header->ro_end) -
-- 
2.35.3

