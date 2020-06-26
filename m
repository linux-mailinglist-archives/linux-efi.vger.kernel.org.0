Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D083C20B8E5
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 21:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgFZTAO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Jun 2020 15:00:14 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:61998 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgFZTAN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Jun 2020 15:00:13 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 05QIxVdb016565;
        Sat, 27 Jun 2020 03:59:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 05QIxVdb016565
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593197972;
        bh=YLQjhUwHPBRq2DAWtdSXfOATkkHnCY2Fw5j0ijLSoIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bVJmDujf2uItKo8FtGdsHXdwjcQnUdsZRwRzIlCwrlVDzmnreh3gR4a9taowo6F7k
         RmbKZe2Uv0iDcAMcz1PVjTPCxyuM1MMu/2t8eUnN29uFyNidHmKC4K1O1Kwnh0upoa
         YUVX+n67XGo6lkL3BxM3XGRAOBSpVpiHe5gUbmV7nJObPdbPmXJHkTEqd4J4xEc5oW
         3+caTkAbJsKMk8Sb0OLLWKSiIzWvUrFE4SYsBShs2WvlDmTVFINPLCtvINrCftD067
         kGI4TNi3RoD3W9mSRplKS0uQSOHyXf9rWXpEqcqy/FTgAMKlAL2o7eLn4wfeqXvpPV
         YJLVXu3/zL4Eg==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com, x86@kernel.org,
        linux-efi@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] kbuild: remove cc-option test of -ffreestanding
Date:   Sat, 27 Jun 2020 03:59:13 +0900
Message-Id: <20200626185913.92890-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626185913.92890-1-masahiroy@kernel.org>
References: <20200626185913.92890-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Some Makefiles already pass -ffreestanding unconditionally.
For example, arch/arm64/lib/Makefile, arch/x86/purgatory/Makefile.
No problem report so far about hard-coding this option. So, we can
assume all supported compilers know -ffreestanding.

I confirmed GCC 4.8 and Clang manuals document this option.

Get rid of cc-option from -ffreestanding.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/s390/Makefile                    | 2 +-
 arch/x86/Makefile                     | 2 +-
 arch/x86/boot/compressed/Makefile     | 2 +-
 drivers/firmware/efi/libstub/Makefile | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 8dfa2cf1f05c..ba94b03c8b2f 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -27,7 +27,7 @@ KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2
 KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
-KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-option,-ffreestanding)
+KBUILD_CFLAGS_DECOMPRESSOR += -ffreestanding
 KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 89c3cdfba753..edc68538a04e 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -36,7 +36,7 @@ REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse
 
-REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -ffreestanding)
+REALMODE_CFLAGS += -ffreestanding
 REALMODE_CFLAGS += -fno-stack-protector
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -Wno-address-of-packed-member)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align4))
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index c88a31569a5e..b7beabecef8a 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -35,7 +35,7 @@ cflags-$(CONFIG_X86_32) := -march=i386
 cflags-$(CONFIG_X86_64) := -mcmodel=small
 KBUILD_CFLAGS += $(cflags-y)
 KBUILD_CFLAGS += -mno-mmx -mno-sse
-KBUILD_CFLAGS += $(call cc-option,-ffreestanding)
+KBUILD_CFLAGS += -ffreestanding
 KBUILD_CFLAGS += -fno-stack-protector
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index f8418763cd79..296b18fbd7a2 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -28,7 +28,7 @@ cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
 KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
 				   -include $(srctree)/drivers/firmware/efi/libstub/hidden.h \
 				   -D__NO_FORTIFY \
-				   $(call cc-option,-ffreestanding) \
+				   -ffreestanding \
 				   -fno-stack-protector \
 				   $(call cc-option,-fno-addrsig) \
 				   -D__DISABLE_EXPORTS
-- 
2.25.1

