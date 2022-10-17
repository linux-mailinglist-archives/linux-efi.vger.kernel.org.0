Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181ED601496
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiJQRSG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiJQRSF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:18:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B5671BD7
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:18:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C530AB819CD
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FA6C43142;
        Mon, 17 Oct 2022 17:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027081;
        bh=88uds8AVevybA4x35BWLgccQpx2Fnz1PGgvpZZiKAYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BfrgBTVJyIPDzeCUkhjzPYi0+YE3fnvnjris7VL1w3AiZmkj0HsDwzESwT/BzRFl7
         x3izGe7/CWoCj7AVuqVmN/dSrwkxrLf1G51bB/svPaXd/UMrLKgrnH8XIceo8TaoMT
         wDmmK9mtRL7iaE3dY/WUrtJ/MBQgPG6TX1LILatOuhGdallmbW/RORuxEZPOP2cXIb
         AitCFtayf3S5LfMxuDeAlhXJgqfpr7vsJ1f73YyIEiD5ES8CPzlUUXn52W5pSWOPGX
         Hh/gd7XGI77sWhT6l4hx59ME7740UDkuUjnftqbWTWizmrOdd09TbYFRUjC6X5wvWo
         DImjfZVhiMjEQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 13/21] efi: libstub: Provide local implementations of strrchr() and memchr()
Date:   Mon, 17 Oct 2022 19:16:52 +0200
Message-Id: <20221017171700.3736890-14-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4057; i=ardb@kernel.org; h=from:subject; bh=88uds8AVevybA4x35BWLgccQpx2Fnz1PGgvpZZiKAYc=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY3+WnUbqw1M/lfyr7ejE4TwsltMoY0MWX1BHwtp 77E9IC6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02N/gAKCRDDTyI5ktmPJDBxC/ 9txBSoe4aiGJUt7eAlJEwR1wS0OY1uSpP77Dj4oBq735VFpj3huZIYZUd6qtV1QO03HdXw1Fr2afAx xdTbOYw4E2rDztCc+hsDOmRc1ZDDiulCNpJk+fHLHMUM2RjxnhU4InSgmw8ZbYai5RcIYCcnthXmZc 9dhSexFP4isfTuAvlh3NZLs2nHi3THS2kEXfG+0UF77p+VHpiAQSy2JoIDV+oruhrwTf8CLjW7zCdA zx+2bfIQ6MGfKw+FBhcDfyj7AovywefYPB/57Z+9iMRyia5FJT7Isr7zyo7NISu8b9h6URULQX+Y0F EYfO6Ol2reacskeho2/ekKYb2gL5vXNQY7OpjEcVWqJ03fmvRGXEneoYgGpChr/IhV2bvrLxZyzMGo Xv4pWfpoDIU4kFr3+RHC5QQnuFMxgQ3n40oboOQZECJEl/aFdQ+WlnXibBokmM05eNTYXHz8ndFYy5 ZywtfgalmUutB5EQreXGL38QkjqmCqB258+WX9aOhNkZQ=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Clone the implementations of strrchr() and memchr() in lib/string.c so
we can use them in the standalone zboot decompressor app. These routines
are used by the FDT handling code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/image-vars.h        |  3 -
 arch/riscv/kernel/image-vars.h        |  2 -
 drivers/firmware/efi/libstub/Makefile |  2 +
 drivers/firmware/efi/libstub/string.c | 62 ++++++++++++++++++++
 4 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index ace584e0b065..f31130ba0233 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -21,9 +21,6 @@ PROVIDE(__efistub_primary_entry_offset	= primary_entry - _text);
  * linked at. The routines below are all implemented in assembler in a
  * position independent manner
  */
-PROVIDE(__efistub_memchr		= __pi_memchr);
-PROVIDE(__efistub_strcmp		= __pi_strcmp);
-PROVIDE(__efistub_strrchr		= __pi_strrchr);
 PROVIDE(__efistub_dcache_clean_poc	= __pi_dcache_clean_poc);
 
 PROVIDE(__efistub__text			= _text);
diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
index 4913abd6dd10..7e2962ef73f9 100644
--- a/arch/riscv/kernel/image-vars.h
+++ b/arch/riscv/kernel/image-vars.h
@@ -23,9 +23,7 @@
  * linked at. The routines below are all implemented in assembler in a
  * position independent manner
  */
-__efistub_memchr		= memchr;
 __efistub_strcmp		= strcmp;
-__efistub_strrchr		= strrchr;
 
 __efistub__start		= _start;
 __efistub__start_kernel		= _start_kernel;
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 53304e9c6778..6824ee5a4ae6 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -21,6 +21,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 cflags-$(CONFIG_ARM64)		:= -fpie $(DISABLE_STACKLEAK_PLUGIN) \
 				   $(call cc-option,-mbranch-protection=none)
 cflags-$(CONFIG_ARM)		:= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
+				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
+				   -DEFI_HAVE_STRCMP \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
 cflags-$(CONFIG_RISCV)		:= -fpic
diff --git a/drivers/firmware/efi/libstub/string.c b/drivers/firmware/efi/libstub/string.c
index 5a1519d435bf..168fe8e79abc 100644
--- a/drivers/firmware/efi/libstub/string.c
+++ b/drivers/firmware/efi/libstub/string.c
@@ -64,6 +64,28 @@ char *strstr(const char *s1, const char *s2)
 	return NULL;
 }
 
+#ifndef EFI_HAVE_STRCMP
+/**
+ * strcmp - Compare two strings
+ * @cs: One string
+ * @ct: Another string
+ */
+int strcmp(const char *cs, const char *ct)
+{
+	unsigned char c1, c2;
+
+	while (1) {
+		c1 = *cs++;
+		c2 = *ct++;
+		if (c1 != c2)
+			return c1 < c2 ? -1 : 1;
+		if (!c1)
+			break;
+	}
+	return 0;
+}
+#endif
+
 /**
  * strncmp - Compare two length-limited strings
  * @cs: One string
@@ -140,3 +162,43 @@ long simple_strtol(const char *cp, char **endp, unsigned int base)
 
 	return simple_strtoull(cp, endp, base);
 }
+
+#ifdef CONFIG_EFI_PARAMS_FROM_FDT
+#ifndef EFI_HAVE_STRRCHR
+/**
+ * strrchr - Find the last occurrence of a character in a string
+ * @s: The string to be searched
+ * @c: The character to search for
+ */
+char *strrchr(const char *s, int c)
+{
+	const char *last = NULL;
+	do {
+		if (*s == (char)c)
+			last = s;
+	} while (*s++);
+	return (char *)last;
+}
+#endif
+#ifndef EFI_HAVE_MEMCHR
+/**
+ * memchr - Find a character in an area of memory.
+ * @s: The memory area
+ * @c: The byte to search for
+ * @n: The size of the area.
+ *
+ * returns the address of the first occurrence of @c, or %NULL
+ * if @c is not found
+ */
+void *memchr(const void *s, int c, size_t n)
+{
+	const unsigned char *p = s;
+	while (n-- != 0) {
+		if ((unsigned char)c == *p++) {
+			return (void *)(p - 1);
+		}
+	}
+	return NULL;
+}
+#endif
+#endif
-- 
2.35.1

