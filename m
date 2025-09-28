Return-Path: <linux-efi+bounces-4949-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 298AFBA6C20
	for <lists+linux-efi@lfdr.de>; Sun, 28 Sep 2025 10:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99249189B195
	for <lists+linux-efi@lfdr.de>; Sun, 28 Sep 2025 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293102BEC5E;
	Sun, 28 Sep 2025 08:55:23 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B7B2BEC34;
	Sun, 28 Sep 2025 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759049723; cv=none; b=J9sJWB72D9Oy+zThN1h9ERMDJnF8WjFdlm7HQLpTj5jPMaf721iRiq4WHrmwq40aU2pShKqtk07dJEtpcvSO2NZmRGki6htzBdJ7A6wC3ye64599d3TlUQRXhQ1ZnNijoPbn/M2yPP2/gbfoC7pXk3Cjf3G+ibLGnLBd3mg7f9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759049723; c=relaxed/simple;
	bh=nADEC65nloTImBWgECRcANU51eI+plXlTbKKhYpcFYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EhyPX5WJ/Y1a/UjIQHAy0M4j/zfauNaxCG/QeNy1zol2SmQKAwchdUeS7Ybe0PGBuJB+uV/CXEWs6erEgZkxnQncSeK/cAcDBg3mlF5FPbK3/t7povRUpAzcsHo/npGcUrkDNiL319i9HNcQwV8GzqS1MPPIEfotWpj2GHvE5og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx37_199hoCMwPAA--.31679S3;
	Sun, 28 Sep 2025 16:55:17 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxpeTw99hoCnK5AA--.60733S2;
	Sun, 28 Sep 2025 16:55:12 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Ard Biesheuvel <ardb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] efistub: Only link libstub to final vmlinux
Date: Sun, 28 Sep 2025 16:55:06 +0800
Message-ID: <20250928085506.4471-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpeTw99hoCnK5AA--.60733S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF4rCF15tF13uFykWry5Jrc_yoWrCFykpa
	nakr4qvrWkWrWvq3s7G3yUWw15KFn8trZIqFyDCFZ0yr4UZwn29rZxJrZrAFZ8Xr1DAFWS
	qr1xKFyakF1DA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUc9a9UUUUU

When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
the following objtool warning on LoongArch:

  vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
  falls through to next function __efistub_exit_boot_func()

This is because efi_boot_kernel() doesn't end with a return instruction
or an unconditional jump, then objtool has determined that the function
can fall through into the next function.

At the beginning, try to do something to make efi_boot_kernel() ends with
an unconditional jump instruction, but this modification seems not proper.

Since the efistub functions are useless for stack unwinder, they can be
ignored by objtool. After many discussions, no need to link libstub to
the vmlinux.o, only link libstub to the final vmlinux.

Do the similar things for arm64 and riscv, otherwise there may be objtool
warnings when arm64 and riscv support objtool, this is to make consistent
with the archs that use libstub.

Link: https://lore.kernel.org/lkml/pq4h7jgndnt6p45lj4kgubxjd5gidfetugcuf5rcxzxxanzetd@6rrlpjnjsmuy/
Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 Makefile                | 1 +
 arch/arm64/Makefile     | 5 ++++-
 arch/loongarch/Makefile | 5 ++++-
 arch/riscv/Makefile     | 5 ++++-
 scripts/link-vmlinux.sh | 5 ++---
 5 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 10355ecf32cb..8ba2e28ef3d1 100644
--- a/Makefile
+++ b/Makefile
@@ -1201,6 +1201,7 @@ KBUILD_VMLINUX_OBJS := built-in.a $(patsubst %/, %/lib.a, $(filter %/, $(libs-y)
 KBUILD_VMLINUX_LIBS := $(filter-out %/, $(libs-y))
 
 export KBUILD_VMLINUX_LIBS
+export KBUILD_VMLINUX_LIBS_PRELINK
 export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
 
 ifdef CONFIG_TRIM_UNUSED_KSYMS
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 73a10f65ce8b..038f37ef2143 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -156,7 +156,10 @@ KBUILD_CPPFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
 KBUILD_AFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
 
 libs-y		:= arch/arm64/lib/ $(libs-y)
-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+
+ifdef CONFIG_EFI_STUB
+KBUILD_VMLINUX_LIBS_PRELINK += $(objtree)/drivers/firmware/efi/libstub/lib.a
+endif
 
 # Default target when executing plain make
 boot		:= arch/arm64/boot
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index ae419e32f22e..4eb904c20718 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -169,7 +169,10 @@ CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x c /dev
 endif
 
 libs-y += arch/loongarch/lib/
-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+
+ifdef CONFIG_EFI_STUB
+KBUILD_VMLINUX_LIBS_PRELINK += $(objtree)/drivers/firmware/efi/libstub/lib.a
+endif
 
 drivers-y		+= arch/loongarch/crypto/
 
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index df57654a615e..cfd82b2c1bbf 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -173,7 +173,10 @@ boot-image-$(CONFIG_XIP_KERNEL)		:= xipImage
 KBUILD_IMAGE				:= $(boot)/$(boot-image-y)
 
 libs-y += arch/riscv/lib/
-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+
+ifdef CONFIG_EFI_STUB
+KBUILD_VMLINUX_LIBS_PRELINK += $(objtree)/drivers/firmware/efi/libstub/lib.a
+endif
 
 ifeq ($(KBUILD_EXTMOD),)
 ifeq ($(CONFIG_MMU),y)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 51367c2bfc21..b3cbff31d8a9 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -61,12 +61,11 @@ vmlinux_link()
 	shift
 
 	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
-		# Use vmlinux.o instead of performing the slow LTO link again.
 		objs=vmlinux.o
-		libs=
+		libs="${KBUILD_VMLINUX_LIBS_PRELINK}"
 	else
 		objs=vmlinux.a
-		libs="${KBUILD_VMLINUX_LIBS}"
+		libs="${KBUILD_VMLINUX_LIBS} ${KBUILD_VMLINUX_LIBS_PRELINK}"
 	fi
 
 	if is_enabled CONFIG_GENERIC_BUILTIN_DTB; then
-- 
2.42.0


