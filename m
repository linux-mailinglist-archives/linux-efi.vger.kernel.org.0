Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AC2234E6C
	for <lists+linux-efi@lfdr.de>; Sat,  1 Aug 2020 01:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgGaXS1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 Jul 2020 19:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgGaXST (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 Jul 2020 19:18:19 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B987DC06174A
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:18:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh1so5009571plb.12
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ASfOQ/kuJ12Krf5ZSehq5O7QSVOARTcDMayUR4wNtMg=;
        b=CBwwwhReWppNNFxkvHvxRIhoW1Pgu8rHz+Qem7CAjWQdaO5/GhluYGmbCsExNeTCUF
         GWVGhVmhGtziej1K0jwGNK4TJgftLk6BkDTi/Z0ZxQWg/3ennjOq71gQNscUJvF+p4mD
         yI8Dj9rogIG8+VxEZn7maN5u3Fg4sY5VJnsxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ASfOQ/kuJ12Krf5ZSehq5O7QSVOARTcDMayUR4wNtMg=;
        b=pXj5WI/XgDHpUNwfkL137elHw2ItDUjsHR+luV92iGb+Ew7JwDx2RVHOtGa2IV4U5I
         IH9rRWU1kvlMmQzMlF+3hPJjTQE4nl9/TG+pDHPMVDIdk9dRsNgvH/hrJ2ckEgwWPOL/
         S8q0oYl0vSw7aCiM0jNYsy/u3MXMG5sOZX+O+V6IHy3Yr48X+6WBQ91aDgMz4BQLnI/R
         zLZrbmXsabJMqMwheI3XpOoSQ/viBUQJt7/o0+4L+YTUz3Lybx9ekGZOVHYo1kx1UgsQ
         y6qZ9OoK3DdiYT2gZ498BsJ9Ei6CytxGFe0aA84zpzKg9viyvWpdWBTZ48b1ZN1OKG81
         Vz4Q==
X-Gm-Message-State: AOAM531UGr4kQZ6GBU8PfaxqKC2RSsqlu4MXQC+y8vKWkP0RtMz/GPG5
        qzaYdjADifyGoWO7Kjua8y5HGQ==
X-Google-Smtp-Source: ABdhPJznKgXN1lBTUHP4lNeyH9aApE9G8kuG5iWIGXTxrA6qwoEEfymIgb4tSDTdVf2K5qllv9bpTQ==
X-Received: by 2002:a17:90b:196:: with SMTP id t22mr6432467pjs.13.1596237497321;
        Fri, 31 Jul 2020 16:18:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l16sm10621043pff.167.2020.07.31.16.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:18:14 -0700 (PDT)
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
Subject: [PATCH v5 26/36] arm/boot: Handle all sections explicitly
Date:   Fri, 31 Jul 2020 16:08:10 -0700
Message-Id: <20200731230820.1742553-27-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for warning on orphan sections, use common macros for
debug sections, discards, and text stubs. Add discards for unwanted .note,
and .rel sections.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/boot/compressed/vmlinux.lds.S | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index 09ac33f52814..b914be3a207b 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -2,6 +2,7 @@
 /*
  *  Copyright (C) 2000 Russell King
  */
+#include <asm/vmlinux.lds.h>
 
 #ifdef CONFIG_CPU_ENDIAN_BE8
 #define ZIMAGE_MAGIC(x) ( (((x) >> 24) & 0x000000ff) | \
@@ -17,8 +18,11 @@ ENTRY(_start)
 SECTIONS
 {
   /DISCARD/ : {
+    COMMON_DISCARDS
     *(.ARM.exidx*)
     *(.ARM.extab*)
+    *(.note.*)
+    *(.rel.*)
     /*
      * Discard any r/w data - this produces a link error if we have any,
      * which is required for PIC decompression.  Local data generates
@@ -36,9 +40,7 @@ SECTIONS
     *(.start)
     *(.text)
     *(.text.*)
-    *(.gnu.warning)
-    *(.glue_7t)
-    *(.glue_7)
+    ARM_STUBS_TEXT
   }
   .table : ALIGN(4) {
     _table_start = .;
@@ -128,12 +130,10 @@ SECTIONS
   PROVIDE(__pecoff_data_size = ALIGN(512) - ADDR(.data));
   PROVIDE(__pecoff_end = ALIGN(512));
 
-  .stab 0		: { *(.stab) }
-  .stabstr 0		: { *(.stabstr) }
-  .stab.excl 0		: { *(.stab.excl) }
-  .stab.exclstr 0	: { *(.stab.exclstr) }
-  .stab.index 0		: { *(.stab.index) }
-  .stab.indexstr 0	: { *(.stab.indexstr) }
-  .comment 0		: { *(.comment) }
+  STABS_DEBUG
+  DWARF_DEBUG
+  ARM_DETAILS
+
+  ARM_ASSERTS
 }
 ASSERT(_edata_real == _edata, "error: zImage file size is incorrect");
-- 
2.25.1

