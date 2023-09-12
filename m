Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F07279CAE2
	for <lists+linux-efi@lfdr.de>; Tue, 12 Sep 2023 11:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjILJCP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Sep 2023 05:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjILJBh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Sep 2023 05:01:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C3D10E5
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7b957fd276so4851376276.0
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509293; x=1695114093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X4mVpRsNe9aWzvwEZ2aPnnughuGbOcmpaMee8nlOmnA=;
        b=oFBUqEw2KhG5Hi4lHpFZ/tocAUyRXlpU+ej8NSKL1wvpG4wAzigL2l073XPLhtjtzP
         zJvhWfAUBOL8H4F7Qnu3CfBYmJL1/6DMg36+OZue+jGI5dJrk9LAyukQEWJHXFvUb/i9
         Urc80CVsess5G2NCm+3qB2HHo5sap17XzioRm41mVzsoJk/pN7sDJUUokf+fubiXyZGk
         i9PkIoyimm+69OjOaVVo0pL4tLGlJXoDnzJjOJ9skTM9rC1DFMjPlSh8EOlh5eYSOi4D
         +AwM257UimdqjHrYRSUTTkqMV88oCJJhm/CXFjAhIQWDExmyPv3zWtOLno286C9GylK7
         HPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509293; x=1695114093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4mVpRsNe9aWzvwEZ2aPnnughuGbOcmpaMee8nlOmnA=;
        b=jtkA/8lo9oDp6K9FAYZf6b4hcAFaqc+xaQ94kuHMi85ZveeP9PmSBUnSvsXf094SSR
         v0WEqQJ5ixzaCViyoCXLZoB3f7pIOjP17AaWnOb0fG4IMBRuSs/3jY87vLqmnMy7tHpY
         rV+HMD8CkcoSmGG2Rd0VcHDh0+o6+D/4QsPdad6tJiqa+uhIwekgEKJsY4A62kz0/+6U
         4sAtFznQ75T+poDpJAmX6b6GgJ61DJ/MSXgoukBb8FA9GlAmdzgC3qgqFFlkU+VHJ+aw
         m1MgQasJS0urhobh0M6IW6QygC6eesnPK93Yl7meeFwKLSXbZxueIFWWRip3KZBvJFHo
         8eUQ==
X-Gm-Message-State: AOJu0Yz32DawqFVaozBCfgGjqNC5pRkweCseV5KwtAxNx6gC87x8m59L
        sg/EHxgu/s8Fk7rzkueESsbmPpbeRzd3WGl4sLwHULy8338n9O1xhPoSliAxAN+lVb4SYFO+R3q
        vH/kwtWhfUavYRzl94kdr32J3NNuz1sgDAsUnywtGHWd+0bBWRHlz0fRDHaox
X-Google-Smtp-Source: AGHT+IGU1A2dC31+7FrMlSd9tXXvjyTt96UJFER92xlD1LA7ozB4sKFQYVzE4uZWk+CN1L5v9nsR4/kB
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1707:b0:d7b:9830:c172 with SMTP id
 by7-20020a056902170700b00d7b9830c172mr288048ybb.0.1694509292432; Tue, 12 Sep
 2023 02:01:32 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:00:54 +0000
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
Mime-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817; i=ardb@kernel.org;
 h=from:subject; bh=PiT71nrSXObiT6OYjT5b5wm9wzGup7NyFurX3NaL+Pk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB4/ipm95hny5ITd8V7DThWqlqs/q+1yet7j9sF7R8q
 LviVP/pjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARMR1Ghn873sQ1zP/Ew/rN
 RfHqTd+LIr2Py0Nz3nivywlVZa8Ksmf47+dzZpll4qofZxcdt5wm/FGyUpHteaL2mwNvcyZxvOR 8wQIA
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-20-ardb@google.com>
Subject: [PATCH v2 03/15] x86/efi: Drop alignment flags from PE section headers
From:   Ard Biesheuvel <ardb@google.com>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

The section header flags for alignment are documented in the PE/COFF
spec as being applicable to PE object files only, not to PE executables
such as the Linux bzImage, so let's drop them from the PE header.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b04ca8e2b213..8c8148d751c6 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -209,8 +209,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_CODE		| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		| \
-		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
+		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
 	#
 	# The EFI application loader requires a relocation section
@@ -230,8 +229,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 
 #ifdef CONFIG_EFI_MIXED
 	#
@@ -249,8 +247,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 #endif
 
 	#
@@ -271,8 +268,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_CODE		| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		| \
-		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
+		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
 	.set	section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */
-- 
2.42.0.283.g2d96d420d3-goog

