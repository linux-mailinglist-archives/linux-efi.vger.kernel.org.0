Return-Path: <linux-efi+bounces-6204-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO2rOvGnnGklJwQAu9opvQ
	(envelope-from <linux-efi+bounces-6204-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 20:18:09 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5743617C3D7
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 20:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C1A2318B841
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 19:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C570736F41A;
	Mon, 23 Feb 2026 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GN8C1JhZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCCC36EA9A;
	Mon, 23 Feb 2026 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873865; cv=none; b=gQRBjBYywt2YcSPw+C3DiO1WrzuQnuMbiTfyaVmoGNRNhMzydHdvT6LJ6USz7Ec7xBo/vFi8k3Sd4SuKi/ULmjI4Fw1eo56nMPtP5eHu4N6SwCHOSFXBzOneT2vyOUYo10iIZYkwcjE96+pE/B81BtJtS0UT1XPDqtSDDmzAZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873865; c=relaxed/simple;
	bh=JkTF5bcI/LJDdihvClbdqAW2KYqXqhfJYTnKJqYjBBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d+92+JdjMJew28qaeIOK+4KgcIwnyMYH6lH8g4wXZY8d6+h0hzwNGU/qndJ45Br3wA5Xwi3QsWwEBYoz2er/mVpuE4FjeVCe7EDH0OCDs1/OdiT5ED+nKokOiL7Mz6YTyNlK5Wa23lqm++loV7Rzy1rJ5EXQ1FdfwCB/IifwgSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GN8C1JhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B742DC116C6;
	Mon, 23 Feb 2026 19:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771873865;
	bh=JkTF5bcI/LJDdihvClbdqAW2KYqXqhfJYTnKJqYjBBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GN8C1JhZvRhhpBPCfAA96a162Ot08dT2IYkPKN6S544ZNG0yHykfVFWnC3JeUts7C
	 OOBW1bvYDFQgFVmNff8jfugMpquKLPZgcCo8UIMLh3Hw9w/f55cHJgjRT5Ew15xt2p
	 Ey6Rs1BTLVqBkq0PuTFMfq1rdUW9nTfeCblLoa7tb93nPCWIIwsP9jFfXqoMJkyJKx
	 lN1BNM0xuFGZ4sWWjhY9R1FgxDmHxcSbD/7GZSjaZugb53LR1P6RjjqTyydHuc64Di
	 oLKGybcxSvG/d9Vm7FznEoxeZN6nenq+4OYR8duG8q81LllndukFFwurhkpfYTdkLZ
	 hK7FIDMLHHP9A==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 23 Feb 2026 12:10:28 -0700
Subject: [PATCH 1/2] kbuild: Consolidate C dialect options
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-fms-anonymous-structs-v1-1-8ee406d3c36c@kernel.org>
References: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
In-Reply-To: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Kees Cook <kees@kernel.org>, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-efi@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11862; i=nathan@kernel.org;
 h=from:subject:message-id; bh=JkTF5bcI/LJDdihvClbdqAW2KYqXqhfJYTnKJqYjBBk=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJlzlllucv4qHBczxXYld7Hc+ueJCwPdrooI6CZXL+988
 ozV8PjFjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRmZcZGS6uPub1dI+a2Isa
 zcD6mtC69g7ld/8u5D66ZpZ0kunTlWWMDJuZOGy+L/xlb7869Nyya4e+hkdrie+WcGdQNJLsWGB
 7iBsA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6204-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,arm.com,kernel.org,xen0n.name,HansenPartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,gmail.com,redhat.com,alien8.de,linux.intel.com,zytor.com,linaro.org,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi,lkml];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5743617C3D7
X-Rspamd-Action: no action

Introduce CC_FLAGS_DIALECT to make it easier to update the various
places in the tree that rely on the GNU C standard and Microsoft
extensions flags atomically. All remaining uses of '-std=gnu11' and
'-fms-extensions' are in the tools directory (which has its own build
system) and other standalone Makefiles. This will allow the kernel to
use a narrower option to enable the Microsoft anonymous tagged structure
extension in a simpler manner. Place the CC_FLAGS_DIALECT block after
the configuration include (so that a future change can move the
selection of the flag to Kconfig) but before the
arch/$(SRCARCH)/Makefile include (so that CC_FLAGS_DIALECT is available
for use in those Makefiles).

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Makefile                              | 16 ++++++++++++----
 arch/arm64/kernel/vdso32/Makefile     |  3 +--
 arch/loongarch/vdso/Makefile          |  2 +-
 arch/parisc/boot/compressed/Makefile  |  2 +-
 arch/powerpc/boot/Makefile            |  3 +--
 arch/s390/Makefile                    |  3 +--
 arch/s390/purgatory/Makefile          |  3 +--
 arch/x86/Makefile                     |  6 +-----
 arch/x86/boot/compressed/Makefile     |  6 +-----
 drivers/firmware/efi/libstub/Makefile |  3 +--
 scripts/Makefile.warn                 |  5 -----
 11 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/Makefile b/Makefile
index e944c6e71e81..06ff3032a6bc 100644
--- a/Makefile
+++ b/Makefile
@@ -587,7 +587,6 @@ LINUXINCLUDE    := \
 KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
 
 KBUILD_CFLAGS :=
-KBUILD_CFLAGS += -std=gnu11
 KBUILD_CFLAGS += -fshort-wchar
 KBUILD_CFLAGS += -funsigned-char
 KBUILD_CFLAGS += -fno-common
@@ -790,6 +789,18 @@ ifdef need-config
 include $(objtree)/include/config/auto.conf
 endif
 
+CC_FLAGS_DIALECT := -std=gnu11
+# Allow including a tagged struct or union anonymously in another struct/union.
+CC_FLAGS_DIALECT += -fms-extensions
+# Clang enables warnings about GNU and Microsoft extensions by default, disable
+# them because this is expected with the above options.
+ifdef CONFIG_CC_IS_CLANG
+CC_FLAGS_DIALECT += -Wno-gnu
+CC_FLAGS_DIALECT += -Wno-microsoft-anon-tag
+endif
+export CC_FLAGS_DIALECT
+KBUILD_CFLAGS += $(CC_FLAGS_DIALECT)
+
 ifeq ($(KBUILD_EXTMOD),)
 # Objects we will link into vmlinux / subdirs we need to visit
 core-y		:=
@@ -1093,9 +1104,6 @@ NOSTDINC_FLAGS += -nostdinc
 # perform bounds checking.
 KBUILD_CFLAGS += $(call cc-option, -fstrict-flex-arrays=3)
 
-# Allow including a tagged struct or union anonymously in another struct/union.
-KBUILD_CFLAGS += -fms-extensions
-
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+= -fno-strict-overflow
 
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 9d0efed91414..bea3675fa668 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -63,7 +63,7 @@ VDSO_CFLAGS += -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                $(filter -Werror,$(KBUILD_CPPFLAGS)) \
                -Werror-implicit-function-declaration \
                -Wno-format-security \
-               -std=gnu11 -fms-extensions
+               $(CC_FLAGS_DIALECT)
 VDSO_CFLAGS  += -O2
 # Some useful compiler-dependent flags from top-level Makefile
 VDSO_CFLAGS += $(call cc32-option,-Wno-pointer-sign)
@@ -71,7 +71,6 @@ VDSO_CFLAGS += -fno-strict-overflow
 VDSO_CFLAGS += $(call cc32-option,-Werror=strict-prototypes)
 VDSO_CFLAGS += -Werror=date-time
 VDSO_CFLAGS += $(call cc32-option,-Werror=incompatible-pointer-types)
-VDSO_CFLAGS += $(if $(CONFIG_CC_IS_CLANG),-Wno-microsoft-anon-tag)
 
 # Compile as THUMB2 or ARM. Unwinding via frame-pointers in THUMB2 is
 # unreliable.
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index 520f1513f07d..904ef4a0d826 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -24,7 +24,7 @@ endif
 cflags-vdso := $(ccflags-vdso) \
 	-isystem $(shell $(CC) -print-file-name=include) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
-	-std=gnu11 -fms-extensions -O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
+	$(CC_FLAGS_DIALECT) -O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
 	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
 	$(call cc-option, -fno-asynchronous-unwind-tables) \
 	$(call cc-option, -fno-stack-protector)
diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
index f8481e4e9d21..14eefb5ed5d1 100644
--- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -18,7 +18,7 @@ KBUILD_CFLAGS += -fno-PIE -mno-space-regs -mdisable-fpregs -Os
 ifndef CONFIG_64BIT
 KBUILD_CFLAGS += -mfast-indirect-calls
 endif
-KBUILD_CFLAGS += -std=gnu11 -fms-extensions
+KBUILD_CFLAGS += $(CC_FLAGS_DIALECT)
 
 LDFLAGS_vmlinux := -X -e startup --as-needed -T
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(addprefix $(obj)/, $(OBJECTS)) $(LIBGCC) FORCE
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index f1a4761ebd44..7ee0fa2d3371 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -70,7 +70,7 @@ BOOTCPPFLAGS	:= -nostdinc $(LINUXINCLUDE)
 BOOTCPPFLAGS	+= -isystem $(shell $(BOOTCC) -print-file-name=include)
 
 BOOTCFLAGS	:= $(BOOTTARGETFLAGS) \
-		   -std=gnu11 -fms-extensions \
+		   $(CC_FLAGS_DIALECT) \
 		   -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -O2 \
 		   -msoft-float -mno-altivec -mno-vsx \
@@ -86,7 +86,6 @@ BOOTARFLAGS	:= -crD
 
 ifdef CONFIG_CC_IS_CLANG
 BOOTCFLAGS += $(CLANG_FLAGS)
-BOOTCFLAGS += -Wno-microsoft-anon-tag
 BOOTAFLAGS += $(CLANG_FLAGS)
 endif
 
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index d78ad6885ca2..c8d16aca1cdc 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -22,7 +22,7 @@ KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
 ifndef CONFIG_AS_IS_LLVM
 KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
 endif
-KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -mpacked-stack -std=gnu11 -fms-extensions
+KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -mpacked-stack $(CC_FLAGS_DIALECT)
 KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
 KBUILD_CFLAGS_DECOMPRESSOR += -D__DECOMPRESSOR
 KBUILD_CFLAGS_DECOMPRESSOR += -Wno-pointer-sign
@@ -35,7 +35,6 @@ KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-membe
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_CC_NO_ARRAY_BOUNDS),-Wno-array-bounds)
-KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_CC_IS_CLANG),-Wno-microsoft-anon-tag)
 
 UTS_MACHINE	:= s390x
 STACK_SIZE	:= $(if $(CONFIG_KASAN),65536,$(if $(CONFIG_KMSAN),65536,16384))
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 61d240a37633..95a8ac45b67e 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -13,7 +13,7 @@ CFLAGS_sha256.o := -D__NO_FORTIFY
 $(obj)/mem.o: $(srctree)/arch/s390/lib/mem.S FORCE
 	$(call if_changed_rule,as_o_S)
 
-KBUILD_CFLAGS := -std=gnu11 -fms-extensions -fno-strict-aliasing -Wall -Wstrict-prototypes
+KBUILD_CFLAGS := $(CC_FLAGS_DIALECT) -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -Os -m64 -msoft-float -fno-common
@@ -21,7 +21,6 @@ KBUILD_CFLAGS += -fno-stack-protector
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 KBUILD_CFLAGS += $(CLANG_FLAGS)
-KBUILD_CFLAGS += $(if $(CONFIG_CC_IS_CLANG),-Wno-microsoft-anon-tag)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 KBUILD_CFLAGS += $(call cc-option, -Wno-default-const-init-unsafe)
 KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5f881460a8b5..46fec0b08487 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -48,7 +48,7 @@ endif
 
 # How to compile the 16-bit code.  Note we always compile for -march=i386;
 # that way we can complain to the user if the CPU is insufficient.
-REALMODE_CFLAGS	:= -std=gnu11 -fms-extensions -m16 -g -Os \
+REALMODE_CFLAGS	:= $(CC_FLAGS_DIALECT) -m16 -g -Os \
 		   -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
@@ -59,10 +59,6 @@ REALMODE_CFLAGS += -fno-stack-protector
 REALMODE_CFLAGS += -Wno-address-of-packed-member
 REALMODE_CFLAGS += $(cc_stack_align4)
 REALMODE_CFLAGS += $(CLANG_FLAGS)
-ifdef CONFIG_CC_IS_CLANG
-REALMODE_CFLAGS += -Wno-gnu
-REALMODE_CFLAGS += -Wno-microsoft-anon-tag
-endif
 export REALMODE_CFLAGS
 
 # BITS is used as extension for files which are available in a 32 bit
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 68f9d7a1683b..8924196927bf 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -25,7 +25,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 # avoid errors with '-march=i386', and future flags may depend on the target to
 # be valid.
 KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
-KBUILD_CFLAGS += -std=gnu11 -fms-extensions
+KBUILD_CFLAGS += $(CC_FLAGS_DIALECT)
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
 KBUILD_CFLAGS += -Wundef
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
@@ -36,10 +36,6 @@ KBUILD_CFLAGS += -mno-mmx -mno-sse
 KBUILD_CFLAGS += -ffreestanding -fshort-wchar
 KBUILD_CFLAGS += -fno-stack-protector
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
-ifdef CONFIG_CC_IS_CLANG
-KBUILD_CFLAGS += -Wno-gnu
-KBUILD_CFLAGS += -Wno-microsoft-anon-tag
-endif
 KBUILD_CFLAGS += -Wno-pointer-sign
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS += -D__DISABLE_EXPORTS
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index e386ffd009b7..fbb8d4e33256 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -11,12 +11,11 @@ cflags-y			:= $(KBUILD_CFLAGS)
 
 cflags-$(CONFIG_X86_32)		:= -march=i386
 cflags-$(CONFIG_X86_64)		:= -mcmodel=small
-cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -std=gnu11 -fms-extensions \
+cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ $(CC_FLAGS_DIALECT) \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
 				   -mno-mmx -mno-sse -fshort-wchar \
 				   -Wno-pointer-sign \
 				   $(call cc-disable-warning, address-of-packed-member) \
-				   $(if $(CONFIG_CC_IS_CLANG),-Wno-gnu -Wno-microsoft-anon-tag) \
 				   -fno-asynchronous-unwind-tables \
 				   $(CLANG_FLAGS)
 
diff --git a/scripts/Makefile.warn b/scripts/Makefile.warn
index 5567da6c7dfe..e77ca875aea4 100644
--- a/scripts/Makefile.warn
+++ b/scripts/Makefile.warn
@@ -28,11 +28,6 @@ endif
 KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
 
 ifdef CONFIG_CC_IS_CLANG
-# The kernel builds with '-std=gnu11' and '-fms-extensions' so use of GNU and
-# Microsoft extensions is acceptable.
-KBUILD_CFLAGS += -Wno-gnu
-KBUILD_CFLAGS += -Wno-microsoft-anon-tag
-
 # Clang checks for overflow/truncation with '%p', while GCC does not:
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=111219
 KBUILD_CFLAGS += $(call cc-option, -Wno-format-overflow-non-kprintf)

-- 
2.53.0


