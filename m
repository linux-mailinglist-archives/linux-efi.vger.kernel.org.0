Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5762B20E1A4
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jun 2020 23:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgF2U6H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Jun 2020 16:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgF2TNE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Jun 2020 15:13:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082C2C08EB23
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:27:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b92so7574367pjc.4
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EO3sRskvzqVrSi/8WlTJ+nKIw1S19eoepjwOuVzqC+k=;
        b=KCQ5YzkONWOo65CEsckxdgEZDidmsxzkUPEN/UJBCW/qObWNXMfEoB9r0/E7rvaRmO
         xlnRluaPTdkLMjWOJpH+yUIspSAOF0HgZkzvSgs47FWa+/kG7rzViG86wdee3s9jODiH
         uu4zTKxTboSZHSRTNaUsgRAj4+LH6Z0yJ6Lok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EO3sRskvzqVrSi/8WlTJ+nKIw1S19eoepjwOuVzqC+k=;
        b=h8VYsHSTDLNV22EekXReSUPXj/lVQyYXMY4bS+bbzAJfJyJJAWi3K57UCc/rFfXmff
         n4QhcU57kM6P/4/F57pAXsofJ+rrAE4zqCCKspmpd1+TJM7TU8omeN4ex3/9yNWhD/oP
         bUaBIlrGwKsK7/7x8nV3N3nN5D6ZfL1prOzwT+Ilcd4J1DUrMAgzCDosE+ua5qH6HphI
         63pQjMxLni054dZtmw2MPiWZwBVZD5sfmAAAbvVX6UN2CXOJqtGQswE9nfUJJX8iEv8E
         bBEznMKeFJmyiMHX8kS2N6hrLqafnH+URXwFoCeKIwoH2APXwmH6KEfyIpq4CMAN4o9p
         C2oQ==
X-Gm-Message-State: AOAM5324Ljm4GJjtdZvsF+YyzT1VfC+OGhv4SfMHc697x2+lwL5AG4Xh
        ibGg6eooqq0iRUBGXPBYcvXEpw==
X-Google-Smtp-Source: ABdhPJxsnK2AsNvKawVoNrn3+ksDPrZ4SCYduO82/RDQuADusHJqjvhs/5ikZAbuEc8CjzSaMNuCrA==
X-Received: by 2002:a17:90b:4d10:: with SMTP id mw16mr15789032pjb.143.1593412050567;
        Sun, 28 Jun 2020 23:27:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h3sm19838700pje.28.2020.06.28.23.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:27:28 -0700 (PDT)
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
Subject: [PATCH v4 17/17] x86/boot: Warn on orphan section placement
Date:   Sun, 28 Jun 2020 23:18:40 -0700
Message-Id: <20200629061840.4065483-18-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
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
 arch/x86/boot/compressed/vmlinux.lds.S | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

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
index d88612e3091f..9afb8737896f 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -75,7 +75,17 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
 
+	STABS_DEBUG
+	DWARF_DEBUG
 	ELF_DETAILS
 
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

