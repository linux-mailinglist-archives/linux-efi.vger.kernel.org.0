Return-Path: <linux-efi+bounces-5325-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CA5C282FA
	for <lists+linux-efi@lfdr.de>; Sat, 01 Nov 2025 17:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 535564E4610
	for <lists+linux-efi@lfdr.de>; Sat,  1 Nov 2025 16:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DEE258ED9;
	Sat,  1 Nov 2025 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPST1qGH"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0FF34D3A7;
	Sat,  1 Nov 2025 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014966; cv=none; b=EqyBqF0wi1vVbm2sUckW2k6zSXZ/mQseayYB6ixQoYZ+fv671HeGKbrISoi61oUVQreAGQp9S6RcyjJJ0pp2VYyAIYBJhJ0e14TuWnpnmLTdFfs2CFdby69xJE3IDCZO9p57W9W4uPO+tufiZ/PZFB6mbIBlLhlRfnpFQ9phY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014966; c=relaxed/simple;
	bh=mpbY/AMnkzNhmN4mkjkXlTWSkt2ZjxshAHZwo2hrI6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gyxMZN2Ys7ZFBiGCxCfHM8oLxFWsQOZ0YXdInwOGZbcV8GW971slY7efqDa+RBCHexSz5J4Nqb+UsNt0ve46qShBCryJuNmnTJPYu+J6TlsJxphAZrSlV8zJl6KdDD/SeF/u7Db7ezMya9ndelrrr+n/r4ef3s7QJMnL+WXRES0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPST1qGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B26C4CEF1;
	Sat,  1 Nov 2025 16:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762014965;
	bh=mpbY/AMnkzNhmN4mkjkXlTWSkt2ZjxshAHZwo2hrI6c=;
	h=From:Date:Subject:To:Cc:From;
	b=UPST1qGHgAE675YAXk4URKXgHUGpWsPdqtGU7DUmfp2PIHngmcg+b3L1CMALapD9L
	 3LKiWNHfT92b8SRq4jIO7DEACwCqQLQDdVVpD0u+Uowxm1MCM99NMteoAg9wv9EKCT
	 B4nBU/jfaUW1KM62rRdXGqrqoE/WMLwHCu4biEfeGoDqiWJsQehn2tJbn8RXhNDQrs
	 cAjDWk1eEEr2u015r27Q2xBsEUhuTHcE2lsF1xvJ0a0R45D+gmWP+U0T/edXtjEv7f
	 /CSkgOVYYa3VZSGKtxsHOevA6An6Vofsw1PR6zrnm3g54PEKj2dEP7sZXHyKl4eBdi
	 vDuVqRezhdNgg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 01 Nov 2025 12:35:47 -0400
Subject: [PATCH] kbuild: Add '-fms-extensions' to areas with dedicated
 CFLAGS
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-kbuild-ms-extensions-dedicated-cflags-v1-1-38004aba524b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOI2BmkC/x2N0QrCMAwAf2Xk2UBTJwx/RXxom3QGZ5Vmk8HYv
 6/6eHDcbWBSVQyu3QZVvmr6Lg3o1EF6hDIKKjcG7/yFyBE+46IT48tQ1lnKzzdkYU1hFsaUpzA
 auqGPxMPZ55ihtT5Vsq7/z+2+7wcnsB1WdwAAAA==
X-Change-ID: 20251101-kbuild-ms-extensions-dedicated-cflags-084b1d832fbf
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-efi@vger.kernel.org, llvm@lists.linux.dev, 
 Christian Brauner <brauner@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10437; i=nathan@kernel.org;
 h=from:subject:message-id; bh=mpbY/AMnkzNhmN4mkjkXlTWSkt2ZjxshAHZwo2hrI6c=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJlsZu8uX1HMSPkx/ce7dYfO722J5Lk+l9nuXGfXP+P5v
 9m1Ti7d1VHKwiDGxSArpshS/Vj1uKHhnLOMN05NgpnDygQyhIGLUwAmMoOF4X9meEHav5YSo7W7
 /OItre2Ofqk4zyGxexsfr6//z4zsZXsY/lkIKJTfvOWkK/4hw/R7V80h01NRJ2yu6d5ZZdjQ+zJ
 mOysA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

This is a follow up to commit c4781dc3d1cf ("Kbuild: enable
-fms-extensions") but in a separate change due to being substantially
different from the initial submission.

There are many places within the kernel that use their own CFLAGS
instead of the main KBUILD_CFLAGS, meaning code written with the main
kernel's use of '-fms-extensions' in mind that may be tangentially
included in these areas will result in "error: declaration does not
declare anything" messages from the compiler.

Add '-fms-extensions' to all these areas to ensure consistency, along
with -Wno-microsoft-anon-tag to silence clang's warning about use of the
extension that the kernel cares about using. parisc does not build with
clang so it does not need this warning flag. LoongArch does not need it
either because -W flags from KBUILD_FLAGS are pulled into cflags-vdso.

Reported-by: Christian Brauner <brauner@kernel.org>
Closes: https://lore.kernel.org/20251030-meerjungfrau-getrocknet-7b46eacc215d@brauner/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
I am taking the original '-fms-extensions' change [1] via a shared
branch in kbuild [2] so I would appreciate acks. I plan to finalize that
branch so that other maintainers can safely pull it on Thursday.

[1]: https://git.kernel.org/kbuild/c/c4781dc3d1cf0e017e1f290607ddc56cfe187afc
[2]: https://git.kernel.org/kbuild/l/kbuild-ms-extensions
---
 arch/arm64/kernel/vdso32/Makefile     | 3 ++-
 arch/loongarch/vdso/Makefile          | 2 +-
 arch/parisc/boot/compressed/Makefile  | 2 +-
 arch/powerpc/boot/Makefile            | 3 ++-
 arch/s390/Makefile                    | 3 ++-
 arch/s390/purgatory/Makefile          | 3 ++-
 arch/x86/Makefile                     | 4 +++-
 arch/x86/boot/compressed/Makefile     | 7 +++++--
 drivers/firmware/efi/libstub/Makefile | 4 ++--
 9 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index ffa3536581f6..9d0efed91414 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -63,7 +63,7 @@ VDSO_CFLAGS += -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                $(filter -Werror,$(KBUILD_CPPFLAGS)) \
                -Werror-implicit-function-declaration \
                -Wno-format-security \
-               -std=gnu11
+               -std=gnu11 -fms-extensions
 VDSO_CFLAGS  += -O2
 # Some useful compiler-dependent flags from top-level Makefile
 VDSO_CFLAGS += $(call cc32-option,-Wno-pointer-sign)
@@ -71,6 +71,7 @@ VDSO_CFLAGS += -fno-strict-overflow
 VDSO_CFLAGS += $(call cc32-option,-Werror=strict-prototypes)
 VDSO_CFLAGS += -Werror=date-time
 VDSO_CFLAGS += $(call cc32-option,-Werror=incompatible-pointer-types)
+VDSO_CFLAGS += $(if $(CONFIG_CC_IS_CLANG),-Wno-microsoft-anon-tag)
 
 # Compile as THUMB2 or ARM. Unwinding via frame-pointers in THUMB2 is
 # unreliable.
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index d8316f993482..c0cc3ca5da9f 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -19,7 +19,7 @@ ccflags-vdso := \
 cflags-vdso := $(ccflags-vdso) \
 	-isystem $(shell $(CC) -print-file-name=include) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
-	-std=gnu11 -O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
+	-std=gnu11 -fms-extensions -O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
 	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
 	$(call cc-option, -fno-asynchronous-unwind-tables) \
 	$(call cc-option, -fno-stack-protector)
diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
index 17c42d718eb3..f8481e4e9d21 100644
--- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -18,7 +18,7 @@ KBUILD_CFLAGS += -fno-PIE -mno-space-regs -mdisable-fpregs -Os
 ifndef CONFIG_64BIT
 KBUILD_CFLAGS += -mfast-indirect-calls
 endif
-KBUILD_CFLAGS += -std=gnu11
+KBUILD_CFLAGS += -std=gnu11 -fms-extensions
 
 LDFLAGS_vmlinux := -X -e startup --as-needed -T
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(addprefix $(obj)/, $(OBJECTS)) $(LIBGCC) FORCE
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index c47b78c1d3e7..f1a4761ebd44 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -70,7 +70,7 @@ BOOTCPPFLAGS	:= -nostdinc $(LINUXINCLUDE)
 BOOTCPPFLAGS	+= -isystem $(shell $(BOOTCC) -print-file-name=include)
 
 BOOTCFLAGS	:= $(BOOTTARGETFLAGS) \
-		   -std=gnu11 \
+		   -std=gnu11 -fms-extensions \
 		   -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -O2 \
 		   -msoft-float -mno-altivec -mno-vsx \
@@ -86,6 +86,7 @@ BOOTARFLAGS	:= -crD
 
 ifdef CONFIG_CC_IS_CLANG
 BOOTCFLAGS += $(CLANG_FLAGS)
+BOOTCFLAGS += -Wno-microsoft-anon-tag
 BOOTAFLAGS += $(CLANG_FLAGS)
 endif
 
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index b4769241332b..8578361133a4 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -22,7 +22,7 @@ KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
 ifndef CONFIG_AS_IS_LLVM
 KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
 endif
-KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -mpacked-stack -std=gnu11
+KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -mpacked-stack -std=gnu11 -fms-extensions
 KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
 KBUILD_CFLAGS_DECOMPRESSOR += -D__DECOMPRESSOR
 KBUILD_CFLAGS_DECOMPRESSOR += -Wno-pointer-sign
@@ -35,6 +35,7 @@ KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-membe
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_CC_NO_ARRAY_BOUNDS),-Wno-array-bounds)
+KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_CC_IS_CLANG),-Wno-microsoft-anon-tag)
 
 UTS_MACHINE	:= s390x
 STACK_SIZE	:= $(if $(CONFIG_KASAN),65536,$(if $(CONFIG_KMSAN),65536,16384))
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index bd39b36e7bd6..0c196a5b194a 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -13,7 +13,7 @@ CFLAGS_sha256.o := -D__NO_FORTIFY
 $(obj)/mem.o: $(srctree)/arch/s390/lib/mem.S FORCE
 	$(call if_changed_rule,as_o_S)
 
-KBUILD_CFLAGS := -std=gnu11 -fno-strict-aliasing -Wall -Wstrict-prototypes
+KBUILD_CFLAGS := -std=gnu11 -fms-extensions -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -Os -m64 -msoft-float -fno-common
@@ -21,6 +21,7 @@ KBUILD_CFLAGS += -fno-stack-protector
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 KBUILD_CFLAGS += $(CLANG_FLAGS)
+KBUILD_CFLAGS += $(if $(CONFIG_CC_IS_CLANG),-Wno-microsoft-anon-tag)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
 KBUILD_AFLAGS += -D__DISABLE_EXPORTS
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 4db7e4bf69f5..e20e25b8b16c 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -48,7 +48,8 @@ endif
 
 # How to compile the 16-bit code.  Note we always compile for -march=i386;
 # that way we can complain to the user if the CPU is insufficient.
-REALMODE_CFLAGS	:= -std=gnu11 -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
+REALMODE_CFLAGS	:= -std=gnu11 -fms-extensions -m16 -g -Os \
+		   -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)
@@ -60,6 +61,7 @@ REALMODE_CFLAGS += $(cc_stack_align4)
 REALMODE_CFLAGS += $(CLANG_FLAGS)
 ifdef CONFIG_CC_IS_CLANG
 REALMODE_CFLAGS += -Wno-gnu
+REALMODE_CFLAGS += -Wno-microsoft-anon-tag
 endif
 export REALMODE_CFLAGS
 
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 74657589264d..68f9d7a1683b 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -25,7 +25,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 # avoid errors with '-march=i386', and future flags may depend on the target to
 # be valid.
 KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
-KBUILD_CFLAGS += -std=gnu11
+KBUILD_CFLAGS += -std=gnu11 -fms-extensions
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
 KBUILD_CFLAGS += -Wundef
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
@@ -36,7 +36,10 @@ KBUILD_CFLAGS += -mno-mmx -mno-sse
 KBUILD_CFLAGS += -ffreestanding -fshort-wchar
 KBUILD_CFLAGS += -fno-stack-protector
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
-KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
+ifdef CONFIG_CC_IS_CLANG
+KBUILD_CFLAGS += -Wno-gnu
+KBUILD_CFLAGS += -Wno-microsoft-anon-tag
+endif
 KBUILD_CFLAGS += -Wno-pointer-sign
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS += -D__DISABLE_EXPORTS
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 94b05e4451dd..7d15a85d579f 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -11,12 +11,12 @@ cflags-y			:= $(KBUILD_CFLAGS)
 
 cflags-$(CONFIG_X86_32)		:= -march=i386
 cflags-$(CONFIG_X86_64)		:= -mcmodel=small
-cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -std=gnu11 \
+cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -std=gnu11 -fms-extensions \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
 				   -mno-mmx -mno-sse -fshort-wchar \
 				   -Wno-pointer-sign \
 				   $(call cc-disable-warning, address-of-packed-member) \
-				   $(call cc-disable-warning, gnu) \
+				   $(if $(CONFIG_CC_IS_CLANG),-Wno-gnu -Wno-microsoft-anon-tag) \
 				   -fno-asynchronous-unwind-tables \
 				   $(CLANG_FLAGS)
 

---
base-commit: c4781dc3d1cf0e017e1f290607ddc56cfe187afc
change-id: 20251101-kbuild-ms-extensions-dedicated-cflags-084b1d832fbf

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


