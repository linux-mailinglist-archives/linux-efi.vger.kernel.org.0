Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB57A2471
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 19:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbjIORRZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 13:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbjIORRH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 13:17:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85F210C7
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 10:17:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c081a44afso15785617b3.3
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 10:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694798221; x=1695403021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E9eWcbH+X5RovGSPuQxChs9MvgHe0ps0mCUAD008mTw=;
        b=jZ59k5ObgUE3icbBZTibDglcJRPdQqetZ2FVnYzAfnuMtjxN3kEFGWDIJKI5QKaHGG
         hRmCuZZhTd6xD10Go/M39Gzf8G0ggNwrBwYveZ+RMidVx0naY9s02Kxj5QeC7EW1acu+
         BlJzQEfJ4WvriJ2/DnFfEKd3z2AR8QFD3Gx7b7zts62lmnmrB9HfHINv/s57/J+mdFvd
         hZ2zLhNbhDfTXIXdMay+FHyIdOq0xdQ90B9z/5xpzkuBIMzZBtzX6mDhi89WaSBNYqlg
         xMuix+SAyEt0UD1/C/us1zWe2zoeIWw3Kt/5msiV7GL2wHFWo5mFvnieV1aO+IcW1gm9
         miJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798221; x=1695403021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9eWcbH+X5RovGSPuQxChs9MvgHe0ps0mCUAD008mTw=;
        b=bbOMsvrE/3Yg7cKAMIDpX1waBkU3TTLvkDPFCIGpMZ7wfUnIWMnT1DZW71TA3M3V9B
         lEpV/ljNBMXofyv0PYyk0duk2GJuP6X8GXJGhxgJaSUq7o4mDZ25YU8N9FVC8B8ojw5r
         0kylOL1iVuzcmwNJ8+S2R+ReqHYbhH8+QCOUrYPjHmo17f/RokXdbCXxDEYFolfswWiX
         86ZycAc+a6hIN1rzA/LEYQMc5ZG4Pg6//nvh4NBOWIDxVRllSbNd1egfg4UfNndTCItX
         Q+eHLMKRVgj+SQisG0rldd+SKamSd+5wPsgIYRyx0jNinIdhc7sTEUfJODi8bRdnyWcG
         7MMA==
X-Gm-Message-State: AOJu0YyjobHmfgSJjEveA18GL63mVS/F9IUfB3gfisvR1sUFGKP3APrl
        q//lgyTipnXguttSNA9VeAPwIFhPAczWuXcwwzj01L/O6s7/mhWiugwZC64+ALUjlDNRQbbde2a
        0axBPDmuKzhU8lx8RjxIshuhO14jEhTTQOUv5LjJsK6mC6yoBPlUe6OWWVwX7
X-Google-Smtp-Source: AGHT+IFtQXI11txgKs/647s9qdsCl7yLhMru8nI1binF3h1LHoJBEeCf/lDSyWZL5m4sNqFHFYeFg4jr
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:ad4b:0:b0:d7e:b82a:ef68 with SMTP id
 l11-20020a25ad4b000000b00d7eb82aef68mr47501ybe.3.1694798220818; Fri, 15 Sep
 2023 10:17:00 -0700 (PDT)
Date:   Fri, 15 Sep 2023 17:16:26 +0000
In-Reply-To: <20230915171623.655440-10-ardb@google.com>
Mime-Version: 1.0
References: <20230915171623.655440-10-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3304; i=ardb@kernel.org;
 h=from:subject; bh=OUd8E2aciVCnJVkSx3yx1dxd9pxNed9z5i4jS/GHCYk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVlYhaTwk2vRL0Z514lbzwsMa1y/Z9da0OK1umvYV5g3
 q2e17auo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExE6xojwzS5awVtJ1R2lvzk
 7P6bH2N5Tr3NccqNz/kPX2Y9TLwpK8nI8Kx0Zb5A+k1pLRv+D7euxd/8ljdhetPnlBy/7OXiFx4 6swAA
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915171623.655440-12-ardb@google.com>
Subject: [PATCH v3 2/8] x86/boot: Set EFI handover offset directly in header asm
From:   Ard Biesheuvel <ardb@google.com>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

The offsets of the EFI handover entrypoints are available to the
assembler when constructing the header, so there is no need to set them
from the build tool afterwards.

This change has no impact on the resulting bzImage binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 18 ++++++++++++++-
 arch/x86/boot/tools/build.c | 24 --------------------
 2 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 5575d0f06bab..72744ba440f6 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -524,8 +524,24 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 # define INIT_SIZE VO_INIT_SIZE
 #endif
 
+	.macro		__handover_offset
+#ifndef CONFIG_EFI_HANDOVER_PROTOCOL
+	.long		0
+#elif !defined(CONFIG_X86_64)
+	.long		ZO_efi32_stub_entry
+#else
+	/* Yes, this is really how we defined it :( */
+	.long		ZO_efi64_stub_entry - 0x200
+#ifdef CONFIG_EFI_MIXED
+	.if		ZO_efi32_stub_entry != ZO_efi64_stub_entry - 0x200
+	.error		"32-bit and 64-bit EFI entry points do not match"
+	.endif
+#endif
+#endif
+	.endm
+
 init_size:		.long INIT_SIZE		# kernel initialization size
-handover_offset:	.long 0			# Filled in by build.c
+handover_offset:	__handover_offset
 kernel_info_offset:	.long ZO_kernel_info
 
 # End of setup header #####################################################
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 14ef13fe7ab0..069497543164 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -55,8 +55,6 @@ u8 buf[SETUP_SECT_MAX*512];
 #define PECOFF_COMPAT_RESERVE 0x0
 #endif
 
-static unsigned long efi32_stub_entry;
-static unsigned long efi64_stub_entry;
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
 static unsigned long _end;
@@ -265,31 +263,12 @@ static void efi_stub_defaults(void)
 #endif
 }
 
-static void efi_stub_entry_update(void)
-{
-	unsigned long addr = efi32_stub_entry;
-
-#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
-#ifdef CONFIG_X86_64
-	/* Yes, this is really how we defined it :( */
-	addr = efi64_stub_entry - 0x200;
-#endif
-
-#ifdef CONFIG_EFI_MIXED
-	if (efi32_stub_entry != addr)
-		die("32-bit and 64-bit EFI entry points do not match\n");
-#endif
-#endif
-	put_unaligned_le32(addr, &buf[0x264]);
-}
-
 #else
 
 static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
 static inline void update_pecoff_text(unsigned int text_start,
 				      unsigned int file_sz) {}
 static inline void efi_stub_defaults(void) {}
-static inline void efi_stub_entry_update(void) {}
 
 static inline int reserve_pecoff_reloc_section(int c)
 {
@@ -332,8 +311,6 @@ static void parse_zoffset(char *fname)
 	p = (char *)buf;
 
 	while (p && *p) {
-		PARSE_ZOFS(p, efi32_stub_entry);
-		PARSE_ZOFS(p, efi64_stub_entry);
 		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, _end);
@@ -416,7 +393,6 @@ int main(int argc, char ** argv)
 
 	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
 
-	efi_stub_entry_update();
 
 	crc = partial_crc32(buf, i, crc);
 	if (fwrite(buf, 1, i, dest) != i)
-- 
2.42.0.459.ge4e396fd5e-goog

