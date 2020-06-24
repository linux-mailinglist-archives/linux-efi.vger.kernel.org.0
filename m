Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D462069D0
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jun 2020 03:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbgFXBuI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Jun 2020 21:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388581AbgFXBtz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Jun 2020 21:49:55 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF944C061755
        for <linux-efi@vger.kernel.org>; Tue, 23 Jun 2020 18:49:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d6so378086pjs.3
        for <linux-efi@vger.kernel.org>; Tue, 23 Jun 2020 18:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYQ7/UZeNlKUAAzd40PNMMjARn27pZcaavNwLjboXuY=;
        b=SfpOc2hUEIBZELMivwVdfPJYqCy5X8PdsjkdknZE3l8iQFROsv3i6chxLhftMku9Xb
         6tsOXBb1e9JDRd5qFNA6lSfPVMaJO9wSUISKnlca3WIenGXCvUr0fPoXLMHEugtTAoOT
         NcS3jDEyvtoIgTcw9ADMPmRSLOVBJsa/GPcsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYQ7/UZeNlKUAAzd40PNMMjARn27pZcaavNwLjboXuY=;
        b=hrh80f/qXf4wdAE1QZ3yKr2ABiW0kA+YewpOMVvP6AE1jGSFvkCPL4JRVYqFv52iHa
         0kCRUdRRJqf0ZPPV/jJQvgN9/fe4i9vDr33X6iYA+I1UR9f0A5tMnxlkiUAdQV4uBKoe
         Ay1uCdkWhutHnIMn/wjOdmH2pG72jJc/nPrbIvxylYbPNSCzFcLbqYqHwW/2pQN2TMtT
         4u1FyyDPiGWRzN4siHsLwDOQz6Yuwo61d9KU1snzw6xCECW2hHNGh5JSOJ64q6N5lwX+
         RIBvArZfCFkz/W5Erbgh+88s0JCR0xw/Fj5uaxmaRiuk6EWbuo05a5Um+3hHrMklmYAV
         XdUg==
X-Gm-Message-State: AOAM532BvGYpcoiEUX/AMJqZpKMTmJuoiYlSyeKFy+Aydfpg04l9bJ/q
        bmZDXnDGBL+S05PxHg5qklLwnw==
X-Google-Smtp-Source: ABdhPJxF401TyoczuI9y6Odtjb3HBshgiTglQEqL8Iaoe+oZuP7eR1/hBT5Q+j0SgAH4D3wZeHXfhg==
X-Received: by 2002:a17:902:bd46:: with SMTP id b6mr4986763plx.287.1592963393344;
        Tue, 23 Jun 2020 18:49:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n1sm2941055pjo.47.2020.06.23.18.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 18:49:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/9] x86/boot: Warn on orphan section placement
Date:   Tue, 23 Jun 2020 18:49:36 -0700
Message-Id: <20200624014940.1204448-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624014940.1204448-1-keescook@chromium.org>
References: <20200624014940.1204448-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly named in the linker
script.

Add the common debugging sections. Discard the unused note, rel, plt,
dyn, and hash sections that are not needed in the compressed vmlinux.
Disable .eh_frame generation in the linker and enable orphan section
warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/Makefile      |  3 ++-
 arch/x86/boot/compressed/vmlinux.lds.S | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 7619742f91c9..646720a05f89 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -48,6 +48,7 @@ GCOV_PROFILE := n
 UBSAN_SANITIZE :=n
 
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
+KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
 ifeq ($(CONFIG_X86_32),y)
@@ -59,7 +60,7 @@ else
 KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
 	&& echo "-z noreloc-overflow -pie --no-dynamic-linker")
 endif
-LDFLAGS_vmlinux := -T
+LDFLAGS_vmlinux := --orphan-handling=warn -T
 
 hostprogs	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 8f1025d1f681..6fe3ecdfd685 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -75,5 +75,16 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
 
+	STABS_DEBUG
+	DWARF_DEBUG
+
 	DISCARDS
+	/DISCARD/ : {
+		*(.note.*)
+		*(.rela.*) *(.rela_*)
+		*(.rel.*) *(.rel_*)
+		*(.plt) *(.plt.*)
+		*(.dyn*)
+		*(.hash) *(.gnu.hash)
+	}
 }
-- 
2.25.1

