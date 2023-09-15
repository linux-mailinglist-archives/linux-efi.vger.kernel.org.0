Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294F67A2477
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 19:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbjIORR2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 13:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjIORRV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 13:17:21 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E76C1
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 10:17:16 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-31f87a56b46so1528700f8f.2
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694798235; x=1695403035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkTB3o3SPk7wjY/BW3gazMut0HVQWM74hCgIhcCAFcM=;
        b=ZWXxIkRh9nRkC94H5YYVb8JyyyoyH56QsJDdB4IOp4vjiCcPJlL6vIiw8kbRaCufeN
         F+7ObMm43lNO28RDFCJR69rlLvAPLD16lZdxfO959qXRPuNqdsDF57uP8hBSRsQKUInl
         ftSFXRt6mCsSA4zgBBMNVS5hXSuikpxYhTXJUR4YqS/krlft1M0CRw5Yttb4AZMTpevM
         6V9fsVP+vi8QpMHDWchn/M9kqZIxKiby1eMYz7fxA5ogNSdmLPhODCzNlyV8zDRY4f6G
         mbq/RK/68eoZdE2+o0KciXIHSgjQMpPvlo4zcS+M47reCtcCOwEb2FjOAc2d7zkeVjai
         2lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798235; x=1695403035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkTB3o3SPk7wjY/BW3gazMut0HVQWM74hCgIhcCAFcM=;
        b=cA68ihwy5lbqi4V/qTxRLCsiT7qFze/QnnWpJF1KG8CWH9GFGPa5Ysdwc+NAlX8ICQ
         LPaLpSk8GslriSnTvvs8eM5EpmLV6l22UUbzt1azG8q7awchm631jqmL5xjadahWeCa+
         NueXGaipJGjOcy+6+j3TOOLUlmyFGRFyJ6QHHIGFkhmjIevqh2COy6jtXd+5GouDheKe
         u1MFdhZjahF9xyyVRHRh7WF0dZKDRrIeVQ/eANKN9l0/Getm1dmqk3JH9ty4qBkX1GIk
         FUtEPw6gnbNZL+UHWl2InfFvM9FhELSrACaUT0rgC7O/K9tZwuWJXbQoQxuw7i+QkNNd
         ifhQ==
X-Gm-Message-State: AOJu0YzVdbRRf80izcQTuEtrxG1M4wsy/9+Z3UMswCtmoWb59PPlOnjv
        NhobcRL2ojF6VTHACs40FNB5gh/MMeJaONyjOyTOye2ObgHz4h6XlUKW3GxztLC302cAh9pbs28
        tWEbQ1kwlsKeOLQ5Vjm0N5R2hPrDs6Ba5lyxUkMkoV/SW/ye1wZqSMq3GS9Qn
X-Google-Smtp-Source: AGHT+IFe27YEZhA0sbvSt/cpekqWltdeIKy+EnsuI1eFAF6hPycSPLLkz1Qdaat1fmsMKURuaqfdnOtx
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:1083:b0:31f:fb07:71e7 with SMTP id
 y3-20020a056000108300b0031ffb0771e7mr7394wrw.11.1694798234796; Fri, 15 Sep
 2023 10:17:14 -0700 (PDT)
Date:   Fri, 15 Sep 2023 17:16:31 +0000
In-Reply-To: <20230915171623.655440-10-ardb@google.com>
Mime-Version: 1.0
References: <20230915171623.655440-10-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2782; i=ardb@kernel.org;
 h=from:subject; bh=JN1IibTT0fAem44DQARhAKlugEKQ8yHMl5ANx7IKCog=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVlYt4UH8XjFRfNkhO9PjNPdIvT/2p0lIvL/Ib3wYqbV
 38WWe3qKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABO5/Jfhv9PJvXdPTz65ueLs
 5eernJ5+Et/NahCcGs4ecrZEetJdy72MDB8PhB2/8NEkZmmWU0kYQ2HRH7NzfYzhUy07U1qXFe1 7yw8A
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915171623.655440-17-ardb@google.com>
Subject: [PATCH v3 7/8] x86/boot: Split off PE/COFF .data section
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Describe the code and data of the decompressor binary using separate
.text and .data PE/COFF sections, so that we will be able to map them
using restricted permissions once we increase the section and file
alignment sufficiently. This avoids the need for memory mappings that
are writable and executable at the same time, which is something that
is best avoided for security reasons.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/Makefile |  2 +-
 arch/x86/boot/header.S | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index cc04917b1ac6..3cece19b7473 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -89,7 +89,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_edata\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 9e9641e220a7..a1f986105f00 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -75,9 +75,9 @@ optional_header:
 	.byte	0x02				# MajorLinkerVersion
 	.byte	0x14				# MinorLinkerVersion
 
-	.long	setup_size + ZO__end - 0x200	# SizeOfCode
+	.long	ZO__data			# SizeOfCode
 
-	.long	0				# SizeOfInitializedData
+	.long	ZO__end - ZO__data		# SizeOfInitializedData
 	.long	0				# SizeOfUninitializedData
 
 	.long	setup_size + ZO_efi_pe_entry	# AddressOfEntryPoint
@@ -178,9 +178,9 @@ section_table:
 	.byte	0
 	.byte	0
 	.byte	0
-	.long	ZO__end
+	.long	ZO__data
 	.long	setup_size
-	.long	ZO__edata			# Size of initialized data
+	.long	ZO__data			# Size of initialized data
 						# on disk
 	.long	setup_size
 	.long	0				# PointerToRelocations
@@ -191,6 +191,17 @@ section_table:
 		IMAGE_SCN_MEM_READ		| \
 		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
+	.ascii	".data\0\0\0"
+	.long	ZO__end - ZO__data		# VirtualSize
+	.long	setup_size + ZO__data		# VirtualAddress
+	.long	ZO__edata - ZO__data		# SizeOfRawData
+	.long	setup_size + ZO__data		# PointerToRawData
+
+	.long	0, 0, 0
+	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
+		IMAGE_SCN_MEM_READ		| \
+		IMAGE_SCN_MEM_WRITE		# Characteristics
+
 	.set	section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */
 
-- 
2.42.0.459.ge4e396fd5e-goog

