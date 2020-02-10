Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6FE157F59
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgBJQDE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbgBJQDE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:04 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AC9120838;
        Mon, 10 Feb 2020 16:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350583;
        bh=zkwoke0yAqb3jIDDlG/htKw0g74UzTeYGcQYiHf99p4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=laInU8wwT9UCQ8B7juis/MS5+g+gyRHo2th4ZK+4D46hdE+22mHOwqjixGqmL9eZD
         U0VRddnaZ2UygGn2IS4oQpmihTIYl1xP81y7SmrxYN6ocRrmH5DVFJzySXl1iciab7
         n5eu6DnzzHQDloGm2dsphNfrXecG8EBH1KHNp4VM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 03/19] efi/libstub: Use hidden visiblity for all source files
Date:   Mon, 10 Feb 2020 17:02:32 +0100
Message-Id: <20200210160248.4889-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Instead of setting the visibility pragma for a small set of symbol
declarations that could result in absolute references that we cannot
support in the stub, declare hidden visibility for all code in the
EFI stub, which is more robust and future proof.

To ensure that the #pragma is taken into account before any other
includes are processed, put it in a header file of its own and
include it via the compiler command line using the -include option.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/efi.h              | 3 ---
 drivers/firmware/efi/libstub/Makefile     | 2 +-
 drivers/firmware/efi/libstub/arm64-stub.c | 8 +-------
 drivers/firmware/efi/libstub/hidden.h     | 6 ++++++
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 44531a69d32b..56ae87401a26 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -107,9 +107,6 @@ static inline void free_screen_info(struct screen_info *si)
 {
 }
 
-/* redeclare as 'hidden' so the compiler will generate relative references */
-extern struct screen_info screen_info __attribute__((__visibility__("hidden")));
-
 static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
 {
 }
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index f14b7636323a..4efdbd711e8e 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 
 KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
-				   -D__NO_FORTIFY \
+				   -include hidden.h -D__NO_FORTIFY \
 				   $(call cc-option,-ffreestanding) \
 				   $(call cc-option,-fno-stack-protector) \
 				   -D__DISABLE_EXPORTS
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 2915b44132e6..719d03a64329 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -6,17 +6,11 @@
  * Adapted from ARM version by Mark Salter <msalter@redhat.com>
  */
 
-/*
- * To prevent the compiler from emitting GOT-indirected (and thus absolute)
- * references to the section markers, override their visibility as 'hidden'
- */
-#pragma GCC visibility push(hidden)
-#include <asm/sections.h>
-#pragma GCC visibility pop
 
 #include <linux/efi.h>
 #include <asm/efi.h>
 #include <asm/memory.h>
+#include <asm/sections.h>
 #include <asm/sysreg.h>
 
 #include "efistub.h"
diff --git a/drivers/firmware/efi/libstub/hidden.h b/drivers/firmware/efi/libstub/hidden.h
new file mode 100644
index 000000000000..3493b041f419
--- /dev/null
+++ b/drivers/firmware/efi/libstub/hidden.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * To prevent the compiler from emitting GOT-indirected (and thus absolute)
+ * references to any global symbols, override their visibility as 'hidden'
+ */
+#pragma GCC visibility push(hidden)
-- 
2.17.1

