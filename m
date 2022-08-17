Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22620596D45
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 13:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbiHQLEI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 07:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239138AbiHQLED (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 07:04:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E4352DD7
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 04:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 446A8B81CD3
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 11:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49170C433B5;
        Wed, 17 Aug 2022 11:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660734238;
        bh=3PrJjnOGtOD0UKlkOGdoGZPYOPQoP/mzktlyZiou0eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cFSEPM9iCVJs2nZ05M/iZHgZR3Mwkt6rtFtFMpXry1jnFEli+Yc3h/uhd4YhbJG67
         vc9nOx4IUAfndzWet4MLG6V5VCcGI5itwmHMt/bTByxNAwTfFjQlyiU0KqnhQ9nmq2
         KMGt6+b8a/T0U5HO+NlHalhNFZrwh1OY1pIsa/X6q6uUYxC/jR/WtxmN5zfkXaEMaT
         8KhMXasuGCFfbH2nZxQH/php3izftAW8tHmC06NgUcQmI5g8cITuVhxE+fMy+lCgOq
         cH4XhGpdw4zfWKm+DMweCSBcWs+5vTYcqT00rL+BO8UBZ9M7aTJgVcGsQRPhS76Vhf
         PVV5HnVbgRfng==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 1/6] efi/libstub: use EFI provided memcpy/memset routines
Date:   Wed, 17 Aug 2022 13:03:40 +0200
Message-Id: <20220817110345.1771267-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220817110345.1771267-1-ardb@kernel.org>
References: <20220817110345.1771267-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5962; i=ardb@kernel.org; h=from:subject; bh=3PrJjnOGtOD0UKlkOGdoGZPYOPQoP/mzktlyZiou0eg=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi/MsEVN9/aOFe4exvn4xjsTaddu1D5BPP/D+AXZzo JgLh5A2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvzLBAAKCRDDTyI5ktmPJMHcC/ 486HzEeFpQ9oSYux6evpO4iM7RTPjdp/8SPrXU9uDcRFWjdav9zAOrrQhHwNwVV2w+FWSKxZIQl/0f Pw8nDxhXfkph8FniAqPJufMRwPgLT//mBOUtSau14B1YAdig1zfr/wCkX/cFEuioMKpYMSF1OoFMFg y1MkNz7kkT2kzUvObcvgH2fMU7q/jj/NFmMgx72MAh58ufGHL9RMOBKKXpA3Zqge/wMeke9Jx03fSX 9TQRc7GOyCW94Sr8/KvPcQlEbX7a/Sf3VG3jamHrfVIOecMkOEpY01Lu3y0Qs6oMmE4D1z6Hm+1kWX o+KyTPOsbxZ91WDxYkglRqy0pxTsiwY9bBWrAvZ/g3dBH8UIGglEAR7p5xpm6VTBpXgi3qbOrGPZGU QWNPAwERVQKCQAO39zJZyjOMHshzzpiUwh5ef1v1A6vYZbDxfXpDI+I4tHMJWhEvB7pPZIBOhfhxIf dgeuN2gKDMC6b7fp5rUSuCpDdvojiCj9LALGW6/pq9Oyw=
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

The stub is used in different execution environments, but on arm64 and
RISC-V, we still use the core kernel's implementation of memcpy and
memset, as they are just a branch instruction away, and can generally be
reused even from code such as the EFI stub that runs in a completely
different address space.

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
 arch/riscv/kernel/image-vars.h            |  9 ------
 drivers/firmware/efi/libstub/Makefile     |  3 +-
 drivers/firmware/efi/libstub/efistub.h    |  4 +--
 drivers/firmware/efi/libstub/intrinsics.c | 30 ++++++++++++++++++++
 5 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 3285b9847871..6e94c728295b 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -23,9 +23,6 @@ PROVIDE(__efistub_primary_entry		= primary_entry);
  */
 PROVIDE(__efistub_memcmp		= __pi_memcmp);
 PROVIDE(__efistub_memchr		= __pi_memchr);
-PROVIDE(__efistub_memcpy		= __pi_memcpy);
-PROVIDE(__efistub_memmove		= __pi_memmove);
-PROVIDE(__efistub_memset		= __pi_memset);
 PROVIDE(__efistub_strlen		= __pi_strlen);
 PROVIDE(__efistub_strnlen		= __pi_strnlen);
 PROVIDE(__efistub_strcmp		= __pi_strcmp);
@@ -38,16 +35,6 @@ PROVIDE(__efistub__edata		= _edata);
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
index d0537573501e..d7303c94b4a7 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -55,7 +55,8 @@ KCOV_INSTRUMENT			:= n
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
-				   alignedmem.o relocate.o vsprintf.o
+				   alignedmem.o relocate.o vsprintf.o \
+				   intrinsics.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index ab9e990447d3..a3377f0b1251 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -280,8 +280,8 @@ union efi_boot_services {
 		void *install_multiple_protocol_interfaces;
 		void *uninstall_multiple_protocol_interfaces;
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

