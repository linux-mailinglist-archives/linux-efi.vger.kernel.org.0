Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466E8234E12
	for <lists+linux-efi@lfdr.de>; Sat,  1 Aug 2020 01:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgGaXJK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 Jul 2020 19:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgGaXIs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 Jul 2020 19:08:48 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4725C0617A3
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:08:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j20so15179211pfe.5
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8vhxEY/3GLUdito3wLDKhA5WtBC+SXdkXa/hytPCigE=;
        b=erx5/JpqhPcqTt2NRt7KYL2WjFYzLuGG8P3y0Er3rEKdM9crkTPu/ZeFlU0GCIVOMc
         DiuJnOx0TWdOG3xCGBDcbldLx8jiF9vR+PM5/8GcMbuuzJl25XeRIG6137MXRlGMlfwL
         YRvGL0llW8thsScXCRcN7FWXAu5q57sDHshm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8vhxEY/3GLUdito3wLDKhA5WtBC+SXdkXa/hytPCigE=;
        b=G4fIETAhfSnk/Apnt1jHNpbzqXXLHSnZNMI8LsAfhqkYBdpxcUG3/YfvSeVHXRoCVp
         0LGybbcWSpbECYO+a08euT3JRwnV+Y88IAlrBBlJSfs4VqIbdnCgRfMd9iUz+eenYDNW
         Z6NcHmEKLG3Xh/EpNf6VBxabyLaeTUGIFYdhxP7+slD39b9EjRl4hbCZUD53xdbuGmv4
         nBsZNnTStLjBe2X6WLjR0aPFRDuwleYtWgzsdYInb7sEE1m8YEuMyAqkz3gHU8j0tpQY
         q2NjLgVwoYyaIaYpF5jxq4aOT/8/cApP+zWL+O4qeqx2Myywd9cQ2y5rqjVUISYXUt49
         TVYA==
X-Gm-Message-State: AOAM530L1bhk/BjpDBEa0eUq22xB5dMbEl/utFDh8RoWoapj5Yz9ASmS
        IPhTTqI4ulf6aryj9PqZgpEzYw==
X-Google-Smtp-Source: ABdhPJyLpLDveshlbN8sTzxQNU2pIN2ioMmjwXEATDhMsYZvm7qIKteqmlw+pfo4TpnxoNFX69boWQ==
X-Received: by 2002:a65:6644:: with SMTP id z4mr5848694pgv.391.1596236928153;
        Fri, 31 Jul 2020 16:08:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k21sm8098390pgl.0.2020.07.31.16.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:08:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 33/36] x86/boot/compressed: Remove, discard, or assert for unwanted sections
Date:   Fri, 31 Jul 2020 16:08:17 -0700
Message-Id: <20200731230820.1742553-34-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for warning on orphan sections, stop the linker from
generating the .eh_frame* sections, discard unwanted non-zero-sized
generated sections, and enforce other expected-to-be-zero-sized sections
(since discarding them might hide problems with them suddenly gaining
unexpected entries).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/Makefile      |  1 +
 arch/x86/boot/compressed/vmlinux.lds.S | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 96d53e300ab6..43b49e1f5b6d 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -49,6 +49,7 @@ GCOV_PROFILE := n
 UBSAN_SANITIZE :=n
 
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
+KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
 LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker)
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 42dea70a5091..1fb9809a9e61 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -83,6 +83,11 @@ SECTIONS
 	ELF_DETAILS
 
 	DISCARDS
+	/DISCARD/ : {
+		*(.dynamic) *(.dynsym) *(.dynstr) *(.dynbss)
+		*(.hash) *(.gnu.hash)
+		*(.note.*)
+	}
 
 	/*
 	 * Sections that should stay zero sized, which is safer to
@@ -93,13 +98,18 @@ SECTIONS
 	}
 	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
 
+	.plt (NOLOAD) : {
+		*(.plt) *(.plt.*)
+	}
+	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
+
 	/* ld.lld does not like .rel* sections being made "NOLOAD". */
 	.rel.dyn : {
-		*(.rel.*)
+		*(.rel.*) *(.rel_*)
 	}
 	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
 	.rela.dyn : {
-		*(.rela.*)
+		*(.rela.*) *(.rela_*)
 	}
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
-- 
2.25.1

