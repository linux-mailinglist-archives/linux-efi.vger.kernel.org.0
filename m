Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8619664EF08
	for <lists+linux-efi@lfdr.de>; Fri, 16 Dec 2022 17:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiLPQ12 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Dec 2022 11:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiLPQ1B (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Dec 2022 11:27:01 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3604860358
        for <linux-efi@vger.kernel.org>; Fri, 16 Dec 2022 08:26:58 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h11so2983297wrw.13
        for <linux-efi@vger.kernel.org>; Fri, 16 Dec 2022 08:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CyWdPwmsoEln1rCKIxbXcZ7tw/K7pVLqcNgYwRXhLM=;
        b=Rvbra2pefYxN5Q59kp/VQ7E4iiWi056Ll+Lc97nNZ8xQjIW01p4/Hhmq8nyEsUCZaN
         fFEJ5yuh0sy9fep0YuWkUVmUgvhZWLsE6V/HZlrqB9miJXEuCFTFIs/2UY6MbYspUkw8
         sgtydWJi7DQ6WrAVuF3osCpkGVohxOEeO4DvlEa5KpypUXdKdcXWxti2XjDocPJq856p
         qMZjBMDvhk8b7uBHCy5IqIy3rBfQdCQG92tE+pUgOJMDn560Xj0on7/f03e3sGFwkkaP
         g88GQZxRYpt/58KFbHAgzx82CtnYDhfZQONayWapn6ilzFCEXq+aR6oxaHrFfnaE8lO7
         OAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CyWdPwmsoEln1rCKIxbXcZ7tw/K7pVLqcNgYwRXhLM=;
        b=axgtohChiUtrZl5rUcWyPmSLxndEptYGzcSd6yIcMAqvt09YFdIrgnBK1x8MJZPAnP
         1WdiZbQAVvnTs6FbCrASZMlO3DB8B/543752bsYzNtrA/iban0qN7+8vssoYs7GZLn2D
         Jb/CCnIIX1xWA9B6BS0S6HkBax88zEW0a4Ku6OdtgCPAfPK2ZDIwA6BK/Q5U8LMrmVMX
         zZ0eKtk2dEkG68ZyFCaAbJlQYrrGtqJ7Ku6/8Fi8TpDiJDRXHRcPRZVSDKNCYjFPFA0U
         apiLI1vVUCjJiUcb0XLBUhWxYtT4MfZbZg7HgUykdahZLWy3H3Mzw6vtP8r/h2wvn+t4
         klQQ==
X-Gm-Message-State: ANoB5pnA5lHXv7paS6prDcTHSYU7/WZE1z8hiVBJ4IGZ/r1K2GR7kgKM
        gm3skE021kt3e+7vC0ZYALCbPIxyU0QhT+Yi8JY=
X-Google-Smtp-Source: AA0mqf6hPxfK2i4tDJ4xpuFfTwdw7faWUPdgx5VEnXDVJO+7l98ZIdasi7aT4CKr/yV1k0PiX318Fw==
X-Received: by 2002:adf:f9c7:0:b0:242:4c28:c9a9 with SMTP id w7-20020adff9c7000000b002424c28c9a9mr19141287wrr.46.1671208016801;
        Fri, 16 Dec 2022 08:26:56 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0024245e543absm2554603wrq.88.2022.12.16.08.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:26:56 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 5/6] riscv: Fix ptdump when KASAN is enabled
Date:   Fri, 16 Dec 2022 17:21:40 +0100
Message-Id: <20221216162141.1701255-6-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221216162141.1701255-1-alexghiti@rivosinc.com>
References: <20221216162141.1701255-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The KASAN shadow region was moved next to the kernel mapping but the
ptdump code was not updated and it appears to break the dump of the kernel
page table, so fix this by moving the KASAN shadow region in ptdump.

Fixes: f7ae02333d13 ("riscv: Move KASAN mapping next to the kernel mapping")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/ptdump.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 830e7de65e3a..20a9f991a6d7 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -59,10 +59,6 @@ struct ptd_mm_info {
 };
 
 enum address_markers_idx {
-#ifdef CONFIG_KASAN
-	KASAN_SHADOW_START_NR,
-	KASAN_SHADOW_END_NR,
-#endif
 	FIXMAP_START_NR,
 	FIXMAP_END_NR,
 	PCI_IO_START_NR,
@@ -74,6 +70,10 @@ enum address_markers_idx {
 	VMALLOC_START_NR,
 	VMALLOC_END_NR,
 	PAGE_OFFSET_NR,
+#ifdef CONFIG_KASAN
+	KASAN_SHADOW_START_NR,
+	KASAN_SHADOW_END_NR,
+#endif
 #ifdef CONFIG_64BIT
 	MODULES_MAPPING_NR,
 	KERNEL_MAPPING_NR,
@@ -82,10 +82,6 @@ enum address_markers_idx {
 };
 
 static struct addr_marker address_markers[] = {
-#ifdef CONFIG_KASAN
-	{0, "Kasan shadow start"},
-	{0, "Kasan shadow end"},
-#endif
 	{0, "Fixmap start"},
 	{0, "Fixmap end"},
 	{0, "PCI I/O start"},
@@ -97,6 +93,10 @@ static struct addr_marker address_markers[] = {
 	{0, "vmalloc() area"},
 	{0, "vmalloc() end"},
 	{0, "Linear mapping"},
+#ifdef CONFIG_KASAN
+	{0, "Kasan shadow start"},
+	{0, "Kasan shadow end"},
+#endif
 #ifdef CONFIG_64BIT
 	{0, "Modules/BPF mapping"},
 	{0, "Kernel mapping"},
@@ -362,10 +362,6 @@ static int __init ptdump_init(void)
 {
 	unsigned int i, j;
 
-#ifdef CONFIG_KASAN
-	address_markers[KASAN_SHADOW_START_NR].start_address = KASAN_SHADOW_START;
-	address_markers[KASAN_SHADOW_END_NR].start_address = KASAN_SHADOW_END;
-#endif
 	address_markers[FIXMAP_START_NR].start_address = FIXADDR_START;
 	address_markers[FIXMAP_END_NR].start_address = FIXADDR_TOP;
 	address_markers[PCI_IO_START_NR].start_address = PCI_IO_START;
@@ -377,6 +373,10 @@ static int __init ptdump_init(void)
 	address_markers[VMALLOC_START_NR].start_address = VMALLOC_START;
 	address_markers[VMALLOC_END_NR].start_address = VMALLOC_END;
 	address_markers[PAGE_OFFSET_NR].start_address = PAGE_OFFSET;
+#ifdef CONFIG_KASAN
+	address_markers[KASAN_SHADOW_START_NR].start_address = KASAN_SHADOW_START;
+	address_markers[KASAN_SHADOW_END_NR].start_address = KASAN_SHADOW_END;
+#endif
 #ifdef CONFIG_64BIT
 	address_markers[MODULES_MAPPING_NR].start_address = MODULES_VADDR;
 	address_markers[KERNEL_MAPPING_NR].start_address = kernel_map.virt_addr;
-- 
2.37.2

