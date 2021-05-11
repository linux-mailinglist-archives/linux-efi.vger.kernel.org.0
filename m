Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B747337AEC3
	for <lists+linux-efi@lfdr.de>; Tue, 11 May 2021 20:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhEKSxG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 May 2021 14:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhEKSwx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 May 2021 14:52:53 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F16C061761;
        Tue, 11 May 2021 11:51:45 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e14so18027070ils.12;
        Tue, 11 May 2021 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a/h54JdNC5kR17fX7/LoX7g8+9V1SkM6LPGM//jz9YE=;
        b=TyuPG2wOFQrgKxI20nIja2mzk8NJAyGwIiLGj/NpdzrU1nuGJ3oPGW2TGiZg9bh6wd
         30l/Phnddorg+Dvatg6e2gDVLUG7R3rAPN2Tgd3NmEqqFan8p6PHC/BHRVy8iRfaJKO/
         amPeFT9M8GsyJElzvFaLAn6XDBv4c2LfW0nsjuUlmr8W6BpEzw+zMNtu2oMoNGHvcG8n
         gogAnm+letvJoMK/VTjaueLYu4SHHfVbY1uWf04y/zmGK7thYghUd94dqrU5FliesezB
         8v5dWnyTDFWI0iz9wFXKfwg5Mi5uV4qoD9KMqGpRrSNSx29CnxRTbSnLd/H57hp6QPlO
         bPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a/h54JdNC5kR17fX7/LoX7g8+9V1SkM6LPGM//jz9YE=;
        b=SfWk9/dohsluSxgFdf5l+Kxz3LNJB8yVCuDYi4H2rnapxnnX4LUGCNU5UD1sOjkPr1
         YEsUPQX/CoIyL5A3T7294VMPA1VRD6z4lC6cD/94R9HJibkqoZX30radqRg2EZkl2nS7
         ms+nadk3Cg9TEN7YPweySogjxOe5B1nxfEOo/c5LxIrS08iwoys4SxbHWPpHQtCNrjxj
         XAYLG98lvCzSri7Cxvc21a67Cst3pzpV3BnOqdnwPe2LbAu9w1Vp8ZNdT/j8HXgZIQ49
         64qJ//Xsm35MhnjSSMHLPSzW6h6d6OguVETypu91Uh5Ert3LFWPTLkkXpYjWjJrcf2sj
         ZECg==
X-Gm-Message-State: AOAM5333cGgU7JUFGwU9WOc6l03JfH9ZbZe0ahd4Ie7zRX3Efu9BMBD0
        e0TLIU9pt7o+uc97R4JMlOg=
X-Google-Smtp-Source: ABdhPJzcb33bvz5DI0nPKr87rXTBl99c1OgYhzBNlqj59Pxj7WEvcQRq6DDiruZk26m5IctEX86qCA==
X-Received: by 2002:a05:6e02:1b85:: with SMTP id h5mr186059ili.303.1620759105380;
        Tue, 11 May 2021 11:51:45 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:44 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bill Wendling <morbo@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joerg Roedel <jroedel@suse.de>, Nick Terrell <terrelln@fb.com>,
        Dave Young <dyoung@redhat.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-efi@vger.kernel.org
Cc:     linux-mm@kvack.org, lkp@intel.com
Subject: [RFC PATCH v5 17/28] dyndbg: prevent build bugs via -DNO_DYNAMIC_DEBUG_TABLE
Date:   Tue, 11 May 2021 12:50:46 -0600
Message-Id: <20210511185057.3815777-18-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The next patch adds DEFINE_DYNAMIC_DEBUG_TABLE(), which broke several
subtrees, including efi, vdso, and some of arch/*/boot/compressed,
with various relocation errors, iirc.

Avoid those problems by adding a define to suppress the "transparent"
DEFINE_DYNAMIC_DEBUG_TABLE() invocation.  I found the x86 problems
myself, lkp@intel.com found arm & sparc problems, and may yet find
others.

Reported-by: <lkp@intel.com> # on [jimc:lkp-test/dyndbg-diet] recently
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 arch/arm/boot/compressed/Makefile     | 2 ++
 arch/sparc/vdso/Makefile              | 2 ++
 arch/x86/boot/compressed/Makefile     | 1 +
 arch/x86/entry/vdso/Makefile          | 3 +++
 arch/x86/purgatory/Makefile           | 1 +
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 6 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index fd94e27ba4fa..72f056a00ad4 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -82,6 +82,8 @@ compress-$(CONFIG_KERNEL_LZMA) = lzma
 compress-$(CONFIG_KERNEL_XZ)   = xzkern
 compress-$(CONFIG_KERNEL_LZ4)  = lz4
 
+KBUILD_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
+
 libfdt_objs := fdt_rw.o fdt_ro.o fdt_wip.o fdt.o
 
 ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index c5e1545bc5cf..960ed0fb6804 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -30,6 +30,8 @@ obj-y += $(vdso_img_objs)
 targets += $(vdso_img_cfiles)
 targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
 
+KBUILD_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
+
 CPPFLAGS_vdso.lds += -P -C
 
 VDSO_LDFLAGS_vdso.lds = -m elf64_sparc -soname linux-vdso.so.1 --no-undefined \
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index e0bc3988c3fa..ada4eb960d95 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -31,6 +31,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 KBUILD_CFLAGS := -m$(BITS) -O2
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
+KBUILD_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
 cflags-$(CONFIG_X86_32) := -march=i386
 cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
 KBUILD_CFLAGS += $(cflags-y)
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 05c4abc2fdfd..619878f2c427 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -29,6 +29,9 @@ vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
 vobjs32-y += vdso32/vclock_gettime.o
 vobjs-$(CONFIG_X86_SGX)	+= vsgx.o
 
+# avoid a x86_64_RELATIVE error
+KBUILD_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
+
 # files to link into kernel
 obj-y				+= vma.o extable.o
 KASAN_SANITIZE_vma.o		:= y
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 95ea17a9d20c..95ba7b18410f 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -35,6 +35,7 @@ PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
+PURGATORY_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index c23466e05e60..def8febefbd3 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -13,7 +13,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 				   -Wno-pointer-sign \
 				   $(call cc-disable-warning, address-of-packed-member) \
 				   $(call cc-disable-warning, gnu) \
-				   -fno-asynchronous-unwind-tables
+				   -fno-asynchronous-unwind-tables \
+				   -DNO_DYNAMIC_DEBUG_TABLE
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
-- 
2.31.1

