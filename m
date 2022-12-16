Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F3D64EF01
	for <lists+linux-efi@lfdr.de>; Fri, 16 Dec 2022 17:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiLPQ01 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Dec 2022 11:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiLPQ0B (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Dec 2022 11:26:01 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A230E2BB33
        for <linux-efi@vger.kernel.org>; Fri, 16 Dec 2022 08:25:57 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so4490564wmb.2
        for <linux-efi@vger.kernel.org>; Fri, 16 Dec 2022 08:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ny2TExHkEZdNiam4GgngpmtWZKCcqjrEUo0Wf99rwww=;
        b=6wp5stVF9wjQFTJ01YMUJ26jEyjMMZ+/S++XQfIRFc1O1EVl2zzZnEEnO5OWQgAVF5
         MzNxy/fJb9BfqXJ2jywoEtILpRcDGr3989nW2gV9HaQobfOAZLyq573kcT8k9PbwIxlD
         rEfEkgCBf21a+MAdPaXAQ1LvnNQDg6zZ62KQq5POXUvTz+8Puz8cClo3xalXOrYbN6cr
         0lvPPE3obyuSWCBTo9fVMa8R1BoUX2yd09ZFEEM5a1ZUT+hbAJ/aCPPbGJxdIlnqjNjY
         MgB7fCZu7OmcizKUKo30l/oUeCv2w8HY1r0NEzc7JDsx969xBMdZjKH4mfvpwOAZwpuS
         3Txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ny2TExHkEZdNiam4GgngpmtWZKCcqjrEUo0Wf99rwww=;
        b=FCIjNcMx4W4MADz6keLX1Rxs+FICGxyOx68SzZErhc0G+Pg85IJNqTtYREG0vf8SXD
         cBuacDC46nbWrIXcSrjB10RX+IY4cEiqPaOr1jhAPOb4Rexb6oQzepzT/hfnhK4d617+
         GJ0tttXDVcaAKcYaAElsetEIiv7IcoOvr6sqfgUn91k6Oe3wMCaAWDZLHAlGf0ZtLPy1
         0AjrGfRstAlnkvDyDd4OXii1YprxtHgvTvQSuv9Jla/kc4JeezjXyV59KgX3BBg1r9n6
         dcHJRpQdaNjt70Oky2LwplzI/SgSgBHlcAOAfbeP6OBUxR+uSunmxWLglK3cB/0AnaMW
         tBTg==
X-Gm-Message-State: ANoB5pmx3AmE6vRYX8XTVVUNM840DJh3gIqy3wY1LAnd//TYjTEDs4oy
        mhTM8IT+tAiMg/IvdfSu1cdWzw==
X-Google-Smtp-Source: AA0mqf5dEDT69p/cpReljdA52jYU0o8ebND2v49EeVDKXljII4pdzHHN/hgOHLaRCYpaiCIh+YKVwg==
X-Received: by 2002:a05:600c:554b:b0:3d2:1761:3742 with SMTP id iz11-20020a05600c554b00b003d217613742mr20371748wmb.15.1671207955923;
        Fri, 16 Dec 2022 08:25:55 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b003b4cba4ef71sm11838404wmq.41.2022.12.16.08.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:25:55 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 4/6] riscv: Fix EFI stub usage of KASAN instrumented string functions
Date:   Fri, 16 Dec 2022 17:21:39 +0100
Message-Id: <20221216162141.1701255-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221216162141.1701255-1-alexghiti@rivosinc.com>
References: <20221216162141.1701255-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI stub must not use any KASAN instrumented code as the kernel
proper did not initialize the thread pointer and the mapping for the
KASAN shadow region.

Avoid using generic string functions by copying stub dependencies from
lib/string.c to drivers/firmware/efi/libstub/string.c as RISC-V does
not implement architecture-specific versions of those functions.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/image-vars.h        |   8 --
 drivers/firmware/efi/libstub/Makefile |   7 +-
 drivers/firmware/efi/libstub/string.c | 133 ++++++++++++++++++++++++++
 3 files changed, 137 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
index d6e5f739905e..15616155008c 100644
--- a/arch/riscv/kernel/image-vars.h
+++ b/arch/riscv/kernel/image-vars.h
@@ -23,14 +23,6 @@
  * linked at. The routines below are all implemented in assembler in a
  * position independent manner
  */
-__efistub_memcmp		= memcmp;
-__efistub_memchr		= memchr;
-__efistub_strlen		= strlen;
-__efistub_strnlen		= strnlen;
-__efistub_strcmp		= strcmp;
-__efistub_strncmp		= strncmp;
-__efistub_strrchr		= strrchr;
-
 __efistub__start		= _start;
 __efistub__start_kernel		= _start_kernel;
 __efistub__end			= _end;
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index b1601aad7e1a..031d2268bab5 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -130,9 +130,10 @@ STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
 # also means that we need to be extra careful to make sure that the stub does
 # not rely on any absolute symbol references, considering that the virtual
 # kernel mapping that the linker uses is not active yet when the stub is
-# executing. So build all C dependencies of the EFI stub into libstub, and do
-# a verification pass to see if any absolute relocations exist in any of the
-# object files.
+# executing. In addition, we need to make sure that the stub does not use KASAN
+# instrumented code like the generic string functions. So build all C
+# dependencies of the EFI stub into libstub, and do a verification pass to see
+# if any absolute relocations exist in any of the object files.
 #
 STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
diff --git a/drivers/firmware/efi/libstub/string.c b/drivers/firmware/efi/libstub/string.c
index 5d13e43869ee..5154ae6e7f10 100644
--- a/drivers/firmware/efi/libstub/string.c
+++ b/drivers/firmware/efi/libstub/string.c
@@ -113,3 +113,136 @@ long simple_strtol(const char *cp, char **endp, unsigned int base)
 
 	return simple_strtoull(cp, endp, base);
 }
+
+#ifndef __HAVE_ARCH_STRLEN
+/**
+ * strlen - Find the length of a string
+ * @s: The string to be sized
+ */
+size_t strlen(const char *s)
+{
+	const char *sc;
+
+	for (sc = s; *sc != '\0'; ++sc)
+		/* nothing */;
+	return sc - s;
+}
+EXPORT_SYMBOL(strlen);
+#endif
+
+#ifndef __HAVE_ARCH_STRNLEN
+/**
+ * strnlen - Find the length of a length-limited string
+ * @s: The string to be sized
+ * @count: The maximum number of bytes to search
+ */
+size_t strnlen(const char *s, size_t count)
+{
+	const char *sc;
+
+	for (sc = s; count-- && *sc != '\0'; ++sc)
+		/* nothing */;
+	return sc - s;
+}
+EXPORT_SYMBOL(strnlen);
+#endif
+
+#ifndef __HAVE_ARCH_STRCMP
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
+EXPORT_SYMBOL(strcmp);
+#endif
+
+#ifndef __HAVE_ARCH_STRRCHR
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
+EXPORT_SYMBOL(strrchr);
+#endif
+
+#ifndef __HAVE_ARCH_MEMCMP
+/**
+ * memcmp - Compare two areas of memory
+ * @cs: One area of memory
+ * @ct: Another area of memory
+ * @count: The size of the area.
+ */
+#undef memcmp
+__visible int memcmp(const void *cs, const void *ct, size_t count)
+{
+	const unsigned char *su1, *su2;
+	int res = 0;
+
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	if (count >= sizeof(unsigned long)) {
+		const unsigned long *u1 = cs;
+		const unsigned long *u2 = ct;
+		do {
+			if (get_unaligned(u1) != get_unaligned(u2))
+				break;
+			u1++;
+			u2++;
+			count -= sizeof(unsigned long);
+		} while (count >= sizeof(unsigned long));
+		cs = u1;
+		ct = u2;
+	}
+#endif
+	for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
+		if ((res = *su1 - *su2) != 0)
+			break;
+	return res;
+}
+EXPORT_SYMBOL(memcmp);
+#endif
+
+#ifndef __HAVE_ARCH_MEMCHR
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
+EXPORT_SYMBOL(memchr);
+#endif
-- 
2.37.2

