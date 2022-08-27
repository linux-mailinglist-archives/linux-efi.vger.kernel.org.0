Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677E55A3608
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 10:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiH0Ij1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 04:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiH0IjX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 04:39:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D80DBFC6B
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 01:39:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DEAAB822E5
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEFDC433B5;
        Sat, 27 Aug 2022 08:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661589559;
        bh=c82V61iIcOxdbLmW3edxD5a0MH1rbeC8C+w6vuiZUxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tyq9XW7k+MkqwYFN7gesGE/gH9rrQ0KjdYjZLPsQbsgEV3SdW1eItoQ3pE9/Kyho0
         fjcARVUSSM24rpDYB3ZHDP3HqTdXMXnj3lOWqxf3svrA2/9rizfWW3vcxmF/J9nuQM
         CiWFvzfH9Qxjg2eZj4sdiBlOyGubPLrNz3BkPCkz6JZK71myTQ9XZSaufoOvAhNAkZ
         hTJ+ATZTYlToluIZlAifOG6jMQ8cu5apQQacp4W8HrMzswgM7OGStc2C78A1wGVAdN
         aLJOtT+VmcpUllsnmdQ2eYi17KrYFZ5IS8EFG0aFDGLPGyjckMyH+YpSIuGh9sGV9E
         S8YSPJNeIsJmg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 3/9] efi/libstub: use EFI provided memcpy/memset routines
Date:   Sat, 27 Aug 2022 10:38:44 +0200
Message-Id: <20220827083850.2702465-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827083850.2702465-1-ardb@kernel.org>
References: <20220827083850.2702465-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6505; i=ardb@kernel.org; h=from:subject; bh=c82V61iIcOxdbLmW3edxD5a0MH1rbeC8C+w6vuiZUxg=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCdgPKf8vyKTN1fNb4hsOVagIZLJhDFXDLAOZVzAi Fc6ipFSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwnYDwAKCRDDTyI5ktmPJIkqDA C38EsHGxIcOKzSyMJypImt+olxyvd8XcGDoL2Dkd7iSfmr1m72q6yvsM5o60WTbeyqXdJOVgWTWum5 4qHzmftU2rQZG9YjUkiJW7i2KKWKaj3O0zIpNjFZggk7WwRe0DII8LjFROf4u4IYna04rp0ADFQW8+ O8ohNbGMblq5n7HpI0CG5HGHRuaAy1KtmgvbRht9XJAHBYYBe2Qz0gQNu0ECYtuv7v76i3UyQhEEas GmBaSATGuJfTJQmOvcTTjl30H6DDvah9RKVDVK0ePFhMG32ULQLnMVLp48XDKK/OyYe1w2FbiEOzk0 V+0U0roQDdNGiErFiJ/ETFGRnS363cyKI/LZzTnJm8CkUjEKN6KTEoa6+emsYuw+4OnpOODQ8q7dO/ dWqKtiHzY8XKvBnj8VGWsUhM9NFV1/jpx52Um51xutvQlogzJAUtHzRhGftGQs0tCM1EwvdmeEU7cg iHLxRktNTi8pgtlhKhlJ7rQ2GttSHoP43eB4KAlOMqwWs=
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

The stub is used in different execution environments, but on arm64,
RISC-V and LoongArch, we still use the core kernel's implementation of
memcpy and memset, as they are just a branch instruction away, and can
generally be reused even from code such as the EFI stub that runs in a
completely different address space.

KAsan complicates this slightly, resulting in the need for some hacks to
expose the uninstrumented, __ prefixed versions as the normal ones, as
the latter are instrumented to include the KAsan checks, which only work
in the core kernel.

Unfortunately, #define'ing memcpy to __memcpy when building C code does
not guarantee that no explicit memcpy() calls will be emitted. And with
the upcoming zboot support, which consists of a separate binary which
therefore needs its own implementation of memcpy/memset anyway, it's
better to provide one explicitly instead of linking to the existing one.

Given that EFI exposes implementations of memmove() and memset() via the
boot services table, let's wire those up in the appropriate way, and
drop the references to the core kernel ones.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/image-vars.h            | 13 ---------
 arch/loongarch/kernel/image-vars.h        |  3 --
 arch/riscv/kernel/image-vars.h            |  9 ------
 drivers/firmware/efi/libstub/Makefile     |  2 +-
 drivers/firmware/efi/libstub/efistub.h    |  4 +--
 drivers/firmware/efi/libstub/intrinsics.c | 30 ++++++++++++++++++++
 6 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index afa69e04e75e..11643f4d864d 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -24,9 +24,6 @@ PROVIDE(__efistub_primary_entry_offset	= primary_entry - _text);
  */
 PROVIDE(__efistub_memcmp		= __pi_memcmp);
 PROVIDE(__efistub_memchr		= __pi_memchr);
-PROVIDE(__efistub_memcpy		= __pi_memcpy);
-PROVIDE(__efistub_memmove		= __pi_memmove);
-PROVIDE(__efistub_memset		= __pi_memset);
 PROVIDE(__efistub_strlen		= __pi_strlen);
 PROVIDE(__efistub_strnlen		= __pi_strnlen);
 PROVIDE(__efistub_strcmp		= __pi_strcmp);
@@ -40,16 +37,6 @@ PROVIDE(__efistub__edata		= _edata);
 PROVIDE(__efistub_screen_info		= screen_info);
 PROVIDE(__efistub__ctype		= _ctype);
 
-/*
- * The __ prefixed memcpy/memset/memmove symbols are provided by KASAN, which
- * instruments the conventional ones. Therefore, any references from the EFI
- * stub or other position independent, low level C code should be redirected to
- * the non-instrumented versions as well.
- */
-PROVIDE(__efistub___memcpy		= __pi_memcpy);
-PROVIDE(__efistub___memmove		= __pi_memmove);
-PROVIDE(__efistub___memset		= __pi_memset);
-
 PROVIDE(__pi___memcpy			= __pi_memcpy);
 PROVIDE(__pi___memmove			= __pi_memmove);
 PROVIDE(__pi___memset			= __pi_memset);
diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel/image-vars.h
index c901ebb903f2..88f5d81702df 100644
--- a/arch/loongarch/kernel/image-vars.h
+++ b/arch/loongarch/kernel/image-vars.h
@@ -9,9 +9,6 @@
 
 __efistub_memcmp		= memcmp;
 __efistub_memchr		= memchr;
-__efistub_memcpy		= memcpy;
-__efistub_memmove		= memmove;
-__efistub_memset		= memset;
 __efistub_strcat		= strcat;
 __efistub_strcmp		= strcmp;
 __efistub_strlen		= strlen;
diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
index 71a76a623257..d6e5f739905e 100644
--- a/arch/riscv/kernel/image-vars.h
+++ b/arch/riscv/kernel/image-vars.h
@@ -25,21 +25,12 @@
  */
 __efistub_memcmp		= memcmp;
 __efistub_memchr		= memchr;
-__efistub_memcpy		= memcpy;
-__efistub_memmove		= memmove;
-__efistub_memset		= memset;
 __efistub_strlen		= strlen;
 __efistub_strnlen		= strnlen;
 __efistub_strcmp		= strcmp;
 __efistub_strncmp		= strncmp;
 __efistub_strrchr		= strrchr;
 
-#ifdef CONFIG_KASAN
-__efistub___memcpy		= memcpy;
-__efistub___memmove		= memmove;
-__efistub___memset		= memset;
-#endif
-
 __efistub__start		= _start;
 __efistub__start_kernel		= _start_kernel;
 __efistub__end			= _end;
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 68c181dcb8cf..498ea6f7a92a 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -65,7 +65,7 @@ efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
 $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o fdt.o string.o \
+lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o fdt.o string.o intrinsics.o \
 				   $(patsubst %.c,lib-%.o,$(efi-deps-y))
 
 lib-y				+= $(ARCH)-stub.o
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index c7efc404e663..54f37e886be7 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -301,8 +301,8 @@ union efi_boot_services {
 		efi_status_t (__efiapi *install_multiple_protocol_interfaces)(efi_handle_t *, ...);
 		efi_status_t (__efiapi *uninstall_multiple_protocol_interfaces)(efi_handle_t, ...);
 		void *calculate_crc32;
-		void *copy_mem;
-		void *set_mem;
+		void (__efiapi *copy_mem)(void *, const void *, unsigned long);
+		void (__efiapi *set_mem)(void *, unsigned long, unsigned char);
 		void *create_event_ex;
 	};
 	struct {
diff --git a/drivers/firmware/efi/libstub/intrinsics.c b/drivers/firmware/efi/libstub/intrinsics.c
new file mode 100644
index 000000000000..a04ab39292b6
--- /dev/null
+++ b/drivers/firmware/efi/libstub/intrinsics.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+#include <asm/string.h>
+
+#include "efistub.h"
+
+#ifdef CONFIG_KASAN
+#undef memcpy
+#undef memmove
+#undef memset
+void *__memcpy(void *__dest, const void *__src, size_t __n) __alias(memcpy);
+void *__memmove(void *__dest, const void *__src, size_t count) __alias(memmove);
+void *__memset(void *s, int c, size_t count) __alias(memset);
+#endif
+
+void *memcpy(void *dst, const void *src, size_t len)
+{
+	efi_bs_call(copy_mem, dst, src, len);
+	return dst;
+}
+
+extern void *memmove(void *dst, const void *src, size_t len) __alias(memcpy);
+
+void *memset(void *dst, int c, size_t len)
+{
+	efi_bs_call(set_mem, dst, len, c & U8_MAX);
+	return dst;
+}
-- 
2.35.1

