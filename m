Return-Path: <linux-efi+bounces-3824-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5699AD11A8
	for <lists+linux-efi@lfdr.de>; Sun,  8 Jun 2025 11:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7573AB7BB
	for <lists+linux-efi@lfdr.de>; Sun,  8 Jun 2025 09:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67FA1F4727;
	Sun,  8 Jun 2025 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqekV+4T"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B011F37D3;
	Sun,  8 Jun 2025 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749373563; cv=none; b=B8Tx45d5TiYXXyrxnQsGGlm8B/wNBbvA9X7PKB105niVb5HvMhdkKWBQvQB539bmFKnuQD362FPzYw5gAhOIJOU557SuCjjvpJxGd95QHeHVTHhk9nxsduQAIioayf1cux3s12TkQDbgirw2k0GTBE3XKi+mD64YT4sIHLdxlQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749373563; c=relaxed/simple;
	bh=tcMBRg7oCjJM3aBNpfa4NJDlrrMeVJInimamhc0PQjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YcEAwJya/faIcqI7NGOuLhV7UdK2W0E50QDdhfVKgkwZiieyChi4d97dvHXgbiOO9WWMn21nt45KwelpAMJHKooa9mWeIhd7m4WlG+S0SeFiQ91Yh74oY6gJrpoRitsahLSydFg9nuW1sGzEUgowibtu9Xxvbfw1viXKYoG1wkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqekV+4T; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so29948115e9.3;
        Sun, 08 Jun 2025 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749373560; x=1749978360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V8zG1PbHmuLFJOMJTmtn9Ynye1/oiJIIxmzHDeu+J4o=;
        b=JqekV+4TbEyOS33jdpmOKv+mLpD20dtnUlPKXxYRL15Jxkaen+46hK0VL9kyjpQXZc
         ukxwnnO+ecJOxowhdNJIc3dKBrkmhBoABkSJe1/1fbcNPttbw2NlVUwCGB0/j8+h9vC9
         k8yIaF0jkvtHex+ey7EgAFJ4aWkp5IPcWUCeeShMDRs0cm0Gl27Qof3B6EQIdPmVmk5s
         HEW5DqGx5pLhXPgNarqXr5ZSh+t2UGgmUhHdXGbbMlnqaT0l1F56o9yrr+wTC2s8+qz8
         fGCUzV0hcPrCXRanPhopPCwL76wVNqADnVx02KhnbTvYyURpe9G2tcx6l37zfYn+Kv/A
         +xXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749373560; x=1749978360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8zG1PbHmuLFJOMJTmtn9Ynye1/oiJIIxmzHDeu+J4o=;
        b=vWLw5vTqCXl+ePaF8F/nQs5KgLgAubgQDH/N0cDqRa+H0saOTjEm+chmNRVadB5Vm7
         zOXBbqtczRYq2OR2MQ5kbhO2XjI9gdjT6nuRvBtEFhVBmqUcc5YXSKXGigIX9RoxtFfV
         B1QINfq/tmrkWW36n/D68vAMErf/hG8abiaGWwChlk2T5FqQG+SJsTVP51ht973BOJ82
         9REBGJ5t9xw/G6KNYfLcRc+YEwOVkdmxWvs2m0m+jbLigchSUGrfmCDR+rdUxPblG2ba
         l8iWPfP8HlVURuQYoFaFL5jfNTmoZ59pjiJsEHihztObmPGms+WWL7uwvdiLr9HoHoJw
         cK3g==
X-Forwarded-Encrypted: i=1; AJvYcCVrpNG191zsKdadSFpzzg9YepbsbV6jM3tuy7/DRrHGkpavN+AkgHdYZ4w2yN0iug9s8rAZv+hE2kE=@vger.kernel.org, AJvYcCXMssJBeSJIiE6R3KKA7LaJ2vtmWjWVAWHz/uwnph7+KlBLEo924Zwz4tee7k0/YkgxllALXRGO2i2Cit5J@vger.kernel.org
X-Gm-Message-State: AOJu0YyIOnHtZAnFnPQdKmPCda3hku4MdrvIUwV8LYCMbHe3HdsC7xlS
	BwTuWfuQNQrhY8+w3paK65Qhc5QEBWuGqbgM20Cume2WOQPWLx7Y93ox
X-Gm-Gg: ASbGncskC9v5qvnwPVIlwc9WsgaswvHD1tT9Lnci29qCPZJRtqchjijgGBS1rpEZaE1
	/jBuHCnlqE1lEX/HapZ9Ip3cjLfOfQnjYiBCblNo324RR5+EQhb7g0GRSPX4kb/rSaNBY13TaDt
	elAB3YTVtteKhKl+143s9UC0CkrRglY2BPhsNj2MDnadstcNJDVEwcVSbegE4p3OvdxIBm9flNG
	+Xz+I/GEitl2d7ymf54i0f+ryobMUGcGLzzXmr3XYI2znWIyVGUllLlKAtjK7j4X63sDzSAgk4/
	1uBLx83qBpX7xsHWRPcFr8Puj9Gr4yicgcfYi/Gqj104b/ZH8PJ44Z+NdEXP6BCGCIs9WYJ0jtm
	/2g==
X-Google-Smtp-Source: AGHT+IF4O6kYg/XR3Kv3d786/5hTXBm0imOZokDheIdLXFKsrSG7u1VGf0WOnURx0EImBH2Wm4evgA==
X-Received: by 2002:a05:600c:3849:b0:442:e147:bea7 with SMTP id 5b1f17b1804b1-452013fb12bmr90374155e9.29.1749373559615;
        Sun, 08 Jun 2025 02:05:59 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45309106019sm25815745e9.6.2025.06.08.02.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 02:05:59 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: ardb@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: hpa@zytor.com,
	x86@kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khalid Ali <khaliidcaliy@gmail.com>
Subject: [PATCH] x86/efi: error handling on efi memory map
Date: Sun,  8 Jun 2025 08:59:28 +0000
Message-ID: <20250608090356.1115-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khalid Ali <khaliidcaliy@gmail.com>

Memory mapping could fail and we need account it and handle it
gracefully or at least do some actions about it.

Currently this patch from the surface look incomplete, and the reason for
that is i didn't know what to do with mapping failures, and how to react
with.

The point is this patch addresses it assuming the worse case scenario all
or some mappings failed. Also i found FIXME that is
saying missing error handling and i think this is the best way we can
fix it. The functions i modified there prototype are important however there usage propably was
once or twice so they have low risk.

Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>
---
 arch/x86/include/asm/efi.h     |  4 ++--
 arch/x86/platform/efi/efi.c    | 10 ++++++----
 arch/x86/platform/efi/efi_32.c |  7 +++++--
 arch/x86/platform/efi/efi_64.c | 34 ++++++++++++++++++++++------------
 4 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index f227a70ac91f..bc73c07e5d7c 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -127,8 +127,8 @@ extern bool efi_disable_ibt_for_runtime;
 
 extern int __init efi_memblock_x86_reserve_range(void);
 extern void __init efi_print_memmap(void);
-extern void __init efi_map_region(efi_memory_desc_t *md);
-extern void __init efi_map_region_fixed(efi_memory_desc_t *md);
+extern int __init efi_map_region(efi_memory_desc_t *md);
+extern int __init efi_map_region_fixed(efi_memory_desc_t *md);
 extern void efi_sync_low_kernel_mappings(void);
 extern int __init efi_alloc_page_tables(void);
 extern int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 463b784499a8..0a614039e4bb 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -690,7 +690,8 @@ static void * __init efi_map_regions(int *count, int *pg_shift)
 		if (!should_map_region(md))
 			continue;
 
-		efi_map_region(md);
+		if (efi_map_region(md))
+			return NULL;
 
 		if (left < desc_size) {
 			new_memmap = realloc_pages(new_memmap, *pg_shift);
@@ -736,9 +737,10 @@ static void __init kexec_enter_virtual_mode(void)
 	* Map efi regions which were passed via setup_data. The virt_addr is a
 	* fixed addr which was used in first kernel of a kexec boot.
 	*/
-	for_each_efi_memory_desc(md)
-		efi_map_region_fixed(md); /* FIXME: add error handling */
-
+	for_each_efi_memory_desc(md) {
+		if (efi_map_region_fixed(md))
+			return;
+	}
 	/*
 	 * Unregister the early EFI memmap from efi_init() and install
 	 * the new EFI memory map.
diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index b2cc7b4552a1..5ca63a72b1f1 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -33,7 +33,7 @@
 #include <asm/tlbflush.h>
 #include <asm/efi.h>
 
-void __init efi_map_region(efi_memory_desc_t *md)
+int __init efi_map_region(efi_memory_desc_t *md)
 {
 	u64 start_pfn, end_pfn, end;
 	unsigned long size;
@@ -54,8 +54,11 @@ void __init efi_map_region(efi_memory_desc_t *md)
 	}
 
 	md->virt_addr = (unsigned long)va;
-	if (!va)
+	if (!va) {
 		pr_err("ioremap of 0x%llX failed!\n", md->phys_addr);
+		return -EINVAL;
+	}
+	return 0;
 }
 
 /*
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index e7e8f77f77f8..b75a9557685c 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -268,12 +268,12 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	return 0;
 }
 
-static void __init __map_region(efi_memory_desc_t *md, u64 va)
+static int __init __map_region(efi_memory_desc_t *md, u64 va)
 {
 	unsigned long flags = _PAGE_RW;
 	unsigned long pfn;
 	pgd_t *pgd = efi_mm.pgd;
-
+	int retval;
 	/*
 	 * EFI_RUNTIME_SERVICES_CODE regions typically cover PE/COFF
 	 * executable images in memory that consist of both R-X and
@@ -298,22 +298,25 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
 		flags |= _PAGE_ENC;
 
 	pfn = md->phys_addr >> PAGE_SHIFT;
-	if (kernel_map_pages_in_pgd(pgd, pfn, va, md->num_pages, flags))
+	retval = kernel_map_pages_in_pgd(pgd, pfn, va, md->num_pages, flags);	
+	if (retval)
 		pr_warn("Error mapping PA 0x%llx -> VA 0x%llx!\n",
 			   md->phys_addr, va);
+	return retval;
 }
 
-void __init efi_map_region(efi_memory_desc_t *md)
+int __init efi_map_region(efi_memory_desc_t *md)
 {
 	unsigned long size = md->num_pages << PAGE_SHIFT;
 	u64 pa = md->phys_addr;
+	int retval = 0;
 
 	/*
 	 * Make sure the 1:1 mappings are present as a catch-all for b0rked
 	 * firmware which doesn't update all internal pointers after switching
 	 * to virtual mode and would otherwise crap on us.
 	 */
-	__map_region(md, md->phys_addr);
+	retval = __map_region(md, md->phys_addr);
 
 	/*
 	 * Enforce the 1:1 mapping as the default virtual address when
@@ -322,7 +325,7 @@ void __init efi_map_region(efi_memory_desc_t *md)
 	 */
 	if (efi_is_mixed()) {
 		md->virt_addr = md->phys_addr;
-		return;
+		return retval;
 	}
 
 	efi_va -= size;
@@ -343,12 +346,13 @@ void __init efi_map_region(efi_memory_desc_t *md)
 
 	if (efi_va < EFI_VA_END) {
 		pr_warn(FW_WARN "VA address range overflow!\n");
-		return;
+		return retval;
 	}
 
 	/* Do the VA map */
-	__map_region(md, efi_va);
+	retval = __map_region(md, efi_va);
 	md->virt_addr = efi_va;
+	return retval;
 }
 
 /*
@@ -356,10 +360,16 @@ void __init efi_map_region(efi_memory_desc_t *md)
  * md->virt_addr is the original virtual address which had been mapped in kexec
  * 1st kernel.
  */
-void __init efi_map_region_fixed(efi_memory_desc_t *md)
-{
-	__map_region(md, md->phys_addr);
-	__map_region(md, md->virt_addr);
+int __init efi_map_region_fixed(efi_memory_desc_t *md)
+{
+	int retval;
+	retval = __map_region(md, md->phys_addr);
+	if (retval)
+		return retval;
+	retval = __map_region(md, md->virt_addr);
+	if (retval)
+		return retval;
+	return 0;
 }
 
 void __init parse_efi_setup(u64 phys_addr, u32 data_len)
-- 
2.49.0


