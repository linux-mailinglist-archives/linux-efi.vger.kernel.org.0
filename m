Return-Path: <linux-efi+bounces-1579-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAF295E052
	for <lists+linux-efi@lfdr.de>; Sun, 25 Aug 2024 01:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D722828A0
	for <lists+linux-efi@lfdr.de>; Sat, 24 Aug 2024 23:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A331459F9;
	Sat, 24 Aug 2024 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b="ahNNMuu3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B81448EF
	for <linux-efi@vger.kernel.org>; Sat, 24 Aug 2024 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724540843; cv=none; b=pgEHHA/1Jo1Y6bhzRly++RTmHtfkfbYqu8+XVXPluwC0qSlNUsuLhthnSF5sZqaOol/Yq1s8Z+dmExDn5J76pML7LaG4mElfvUeXTIrT4e1ZBm0zzcHbiKyO9TsMQEcyUcRSBnO1tWjnTiF6ZbKYRAydKjJQ+zXfB2+5f7NdbwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724540843; c=relaxed/simple;
	bh=U0S4KY4P4mMk6kXYBXhOMBGppwcV8ZYcGXaIpEav1FE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dn15+taxofXl32+fW0sTUf3BkkC/2kgtenNsmkr3xXj5TE9E8wV3S2E77MFAb/Qoj2cZrGJvmKZyVsigmglQtpMwEkyJvK7qqDaoBgAFjY52wGYgHHOdiltjmZbaHG6MDOLSKohXI+kLR1osDhpjbxt3JtH2MIOtXKzXP348heM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b=ahNNMuu3; arc=none smtp.client-ip=209.85.166.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: by mail-io1-f68.google.com with SMTP id ca18e2360f4ac-81f96eaa02aso185976939f.2
        for <linux-efi@vger.kernel.org>; Sat, 24 Aug 2024 16:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1724540840; x=1725145640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eplaYsiiWgCTy5PRkFB4ff2nqvq9q3OfHUIofrtUZ0k=;
        b=ahNNMuu3ulrpbVkyPWNKCl2Bk8ogfR3zSqzuxlMpajB5Xtb9UDKhaiBbWY9VhtVWyX
         VHjl3+vq/kjFVPvUtSp18vNB1H7R+eGUgSRvId+PFwgyZYU63GYLrYYfP0psPHEMWjPV
         rt4crUFF3Z6Iazfn9GKhSaX0mYqXz6FvftLolcXQjvCMVc9W58g25m8U3ByR5tv2cFih
         4WUhggnonBInufetnfhOS605gjMqlNN+lwePT8ho/Dvy5wQaUEHp/xp1B9/Wt7pd8CEs
         +yF2py+HsyoGKSNqD/MUSqxcALn4fQ8ispcza7Kj0mIzK1CGb/xyV2pqFWjK7seF8Qjb
         IWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724540840; x=1725145640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eplaYsiiWgCTy5PRkFB4ff2nqvq9q3OfHUIofrtUZ0k=;
        b=sb2nEPdviX0B4uF/9LjgvqAEaOnEnQwhyo4w60x8Pcn8fh2gDOX9x6ZoE0yRN4Zy+i
         HPc05t/EWytrn/YiIBxDq6uqG7+B3Iuv2gpmV95wq3UHgIB/jRhQKRaU+NzxQElV7RPZ
         GniQbdBlDuqW2tN2RJzIdb77NPsfOzFYo15M7E74Quoc3jwHwunLZndsWGd4mdXkqe4j
         B5rg++ss6Yf+DL+CWe4A23CT/LnBfhBnC5themehs4yU+YZi5drzHJz4pxggm5zo5UXU
         GhWGSOKcV9G7nb0l5Giw0s8rGb0/QuCPemyZjDgkGSxVI2kcJ+Dy5/17yh/uwCJcZhR8
         Q+uw==
X-Forwarded-Encrypted: i=1; AJvYcCU9mUDWJVftUk15bQWWXRokrd3rkON0NA5byxlOw0G8b2znjyy4IsbpSW9LPdHe5BOxDiuK31JK/D0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz53Oy0xk6P8Do1atlnbzgrmvEkd5i8ZcfWuf3bnage3+058V6
	VQK8DAJWga3hnk+MJVg74EN/V31Yc19dbjD7kv4H06l2F4T2beWwCa9F7P8UDQ==
X-Google-Smtp-Source: AGHT+IGMHgrjxuTK1IXh9WwnvBXGAgm3x0MPaDSYXa/O8CNdJcXDMS3NKmaFRHTenHG7ThmwiB9kVg==
X-Received: by 2002:a05:6602:6b87:b0:804:2b28:75db with SMTP id ca18e2360f4ac-82787329bbemr590220339f.10.1724540840544;
        Sat, 24 Aug 2024 16:07:20 -0700 (PDT)
Received: from shizuku.. (mobile-130-126-255-62.near.illinois.edu. [130.126.255.62])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f85671sm1563938173.80.2024.08.24.16.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 16:07:20 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	x86@kernel.org
Cc: wentaoz5@illinois.edu,
	marinov@illinois.edu,
	tyxu@illinois.edu,
	jinghao7@illinois.edu,
	tingxur@illinois.edu,
	steven.h.vanderleest@boeing.com,
	chuck.wolber@boeing.com,
	matthew.l.weber3@boeing.com,
	Matt.Kelly2@boeing.com,
	andrew.j.oppelt@boeing.com,
	samuel.sarkisian@boeing.com,
	morbo@google.com,
	samitolvanen@google.com,
	masahiroy@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	ardb@kernel.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	arnd@arndb.de,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	oberpar@linux.ibm.com,
	akpm@linux-foundation.org,
	paulmck@kernel.org,
	bhelgaas@google.com,
	kees@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	kent.overstreet@linux.dev,
	nathan@kernel.org,
	hpa@zytor.com,
	mathieu.desnoyers@efficios.com,
	ndesaulniers@google.com,
	justinstitt@google.com,
	maskray@google.com,
	dvyukov@google.com
Subject: [RFC PATCH 2/3] kbuild, llvm-cov: disable instrumentation in odd or sensitive code
Date: Sat, 24 Aug 2024 18:06:40 -0500
Message-Id: <20240824230641.385839-3-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824230641.385839-1-wentaoz5@illinois.edu>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable instrumentation in the same areas that were disabled for
kernel/gcov/

Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
Signed-off-by: Chuck Wolber <chuck.wolber@boeing.com>
---
 arch/x86/boot/Makefile                | 1 +
 arch/x86/boot/compressed/Makefile     | 1 +
 arch/x86/entry/vdso/Makefile          | 1 +
 arch/x86/platform/efi/Makefile        | 1 +
 arch/x86/purgatory/Makefile           | 1 +
 arch/x86/realmode/rm/Makefile         | 1 +
 arch/x86/um/vdso/Makefile             | 1 +
 drivers/firmware/efi/libstub/Makefile | 2 ++
 kernel/trace/Makefile                 | 1 +
 scripts/Makefile.modfinal             | 1 +
 10 files changed, 11 insertions(+)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 9cc0ff6e9067..2cc2c55af305 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -57,6 +57,7 @@ KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
+LLVM_COV_PROFILE := n
 
 $(obj)/bzImage: asflags-y  := $(SVGA_MODE)
 
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f2051644de94..86c79c36db2e 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -43,6 +43,7 @@ KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 # Disable relocation relaxation in case the link is not PIE.
 KBUILD_CFLAGS += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
 KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
+LLVM_COV_PROFILE := n
 
 # sev.c indirectly includes inat-table.h which is generated during
 # compilation and stored in $(objtree). Add the directory to the includes so
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index c9216ac4fb1e..d9587b3b6bf2 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -156,6 +156,7 @@ quiet_cmd_vdso = VDSO    $@
 
 VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 \
 	$(call ld-option, --eh-frame-hdr) -Bsymbolic -z noexecstack
+LLVM_COV_PROFILE := n
 
 quiet_cmd_vdso_and_check = VDSO    $@
       cmd_vdso_and_check = $(cmd_vdso); $(cmd_vdso_check)
diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefile
index 500cab4a7f7c..a07852e8f3ae 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 KASAN_SANITIZE := n
 GCOV_PROFILE := n
+LLVM_COV_PROFILE := n
 
 obj-$(CONFIG_EFI) 		+= memmap.o quirks.o efi.o efi_$(BITS).o \
 				   efi_stub_$(BITS).o
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index ebdfd7b84feb..b4e619114898 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -28,6 +28,7 @@ PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
 LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
 LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
 targets += purgatory.ro purgatory.chk
+LLVM_COV_PROFILE := n
 
 # These are adjustments to the compiler flags used for objects that
 # make up the standalone purgatory.ro
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index a0fb39abc5c8..d36338bfa2ce 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -67,3 +67,4 @@ KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
 		   -I$(srctree)/arch/x86/boot
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
+LLVM_COV_PROFILE := n
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 6a77ea6434ff..3ea2f5d123fe 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -60,3 +60,4 @@ quiet_cmd_vdso = VDSO    $@
 		 sh $(src)/checkundef.sh '$(NM)' '$@'
 
 VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv -z noexecstack
+LLVM_COV_PROFILE := n
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index ed4e8ddbe76a..b8224ff291d9 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -62,6 +62,8 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 # `-fdata-sections` flag from KBUILD_CFLAGS_KERNEL
 KBUILD_CFLAGS_KERNEL := $(filter-out -fdata-sections, $(KBUILD_CFLAGS_KERNEL))
 
+LLVM_COV_PROFILE := n
+
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 057cd975d014..0293acc50afa 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -30,6 +30,7 @@ endif
 ifdef CONFIG_GCOV_PROFILE_FTRACE
 GCOV_PROFILE := y
 endif
+LLVM_COV_PROFILE := n
 
 # Functions in this file could be invoked from early interrupt
 # code and produce random code coverage.
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 1fa98b5e952b..4fc791fff26c 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -22,6 +22,7 @@ __modfinal: $(modules:%.o=%.ko)
 modname = $(notdir $(@:.mod.o=))
 part-of-module = y
 GCOV_PROFILE := n
+LLVM_COV_PROFILE := n
 KCSAN_SANITIZE := n
 
 quiet_cmd_cc_o_c = CC [M]  $@
-- 
2.45.2


