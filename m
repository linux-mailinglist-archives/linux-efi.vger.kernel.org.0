Return-Path: <linux-efi+bounces-3826-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1868CAD1386
	for <lists+linux-efi@lfdr.de>; Sun,  8 Jun 2025 19:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968DE168A46
	for <lists+linux-efi@lfdr.de>; Sun,  8 Jun 2025 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4371C18FDA5;
	Sun,  8 Jun 2025 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZvNgGfF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539991547D2;
	Sun,  8 Jun 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749402804; cv=none; b=uDloQ5iHUvbHkseBduuAjdTenO1WOErod1BS/13O/CE3tGx3vSlleVvfUO8ekMW50TE4WsYWcuVkyigvmWF7QS38EJ5u3EdakoyBthI3iFmsaozR8a7Vkm0sfUVfab0EgYixx6KUdJfbpudaABrpEi/tGep7dIgB/wQex6r5q3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749402804; c=relaxed/simple;
	bh=m+EoCFMxjYw9Ar69UF6bMBSGvTD8Er/Yt1M9FwegE6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Awr9sB/C1C+DR6+ZiHesf7mkF9cXF8D9cTkpxY2heJTohLKAEZNWeTl5qTY55kM6IhFcNAEsUC3MCr9SZaOgJzfT+eLYsnOpVudtakW6aB1nggckT1MgZL1iPlwywNtEcHPWSR65PDePB1JxnEqINdwzFygcjGwlGHkD/wQ/RKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZvNgGfF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ade33027bcfso226706066b.1;
        Sun, 08 Jun 2025 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749402800; x=1750007600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QjbfX1fbIV8T50DrEqaU+DfCTlIuWvkjOJ7fSp2QxDo=;
        b=dZvNgGfFhnijCgVyIBRm2Ei8bf4LqszDd+LKalv8fHbiLzzobkhPYblGzWoplwNxDb
         ZGZ0UjmlE4TNRGVpVbTXYWiCwQyepUZfGxzgRY6SQlwiQ+ppk9Km2ACslkMrn9Ayvq75
         YdqiyjAWz316YoBoSERbEjD4txFj5GtxwJn0xg3RziF6eoQdtLL/hpTp37Tk/yEkUia8
         jtU7xKOfwyajgtcJDyZozcK6nMBLIx6cNBo2+DIJjCq0KnO9SD07Sug23cNOHuOTYe5W
         NF0O9YC0kbSx4hyL6MFDaVsOPn3tHPfUwMI4L5DFHP2uGqGX+KF4mJoOp1B1xOSPVobl
         RQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749402800; x=1750007600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjbfX1fbIV8T50DrEqaU+DfCTlIuWvkjOJ7fSp2QxDo=;
        b=fq+JmKfyK7vtinB5Y3KhpTfQ4LPwNRnH8m61m2Pl/pONHrXVsaCERJHEbY3bpw3uYQ
         wRWKy7GNLWlDSCtXKU7CEdcamYR574579kUqoHhNKB8xcJnbsf8PGuf7btFLv9xaeVOS
         lfB41FefOodiKzdA2mtvzI6I3EOTRdc7KBXz4apaymQoHYEg8fvmR1ib1o453NwWFQ7A
         /gINqc7ME3aiI1Nb0vxyKQLHQEqpyukFQ2Rf1sfgjf3JNMjmdp8DplSHqD62w1ehqmjA
         D1cf8mySnKMz83mVrPXNqtiy2x34oD9Z9dpoxraiDLLRlNfphLpELZNY0Ds2K7cl13ra
         muKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwxpeWMFqYmwO0N/t9guy0eJURaxANitbyYVxpK5uYwf1PE3Tor1gVeHCA+m0RB2n2jlktOaixOHs=@vger.kernel.org, AJvYcCVKAUFZ1ffybeo6MHoEleE15i2tOxg+m+vz1q4HZeZoZNuEp510vEtn8EiOKNc4qKBUv7qycIz4BKc3/s3s@vger.kernel.org
X-Gm-Message-State: AOJu0YykFLcaLBtslJx4Au/PC53/NRzN3zmXh0EJITBllB6vfWUM8R5L
	es/lEVxvZ7flS/xwSVHUQGoSjaNvu+p3bPnvf3hHUGHyAlc+2vvlXgeB
X-Gm-Gg: ASbGncuQ0K+cmpnTy19qlMBRQJbBlq7isrS9hAtDufbOtqTgSkBZwNmQt0NSWQZ1ovY
	s2Qkc/6UBYBiTF8Z5EwT58IAf4tmdcVpRi0UDrvjVu8Jy0+HSG8xrBA3BSiNdy58nylLg8K2eBd
	xhEJsx0clR2tc/RV5WWlS/JS6w70/iqswHwPOnLdc9K9zKpqHy7NEiynE2eP6IWoiVYq4F3FDr7
	iPswT9rbKW5M4YNG6Tsf/KXRFvHB0kRvUBB0NUyb8+HgVF6L8hGQpCIA/UlgLbUmQxWEKBpArnI
	SpLXep1GWj5nhN+pB2UxhYld9Uz3baZQH6BqS0G0XCCnz+rT2ILV9+CTeDq0b8w1+g==
X-Google-Smtp-Source: AGHT+IG3xR5v5kUXLn4fsu7ZdkOmphG+QVMf1ufEPwxLiBQ+KtVduIT43cDZ0VN7vD0Z3Uv0KQaNqg==
X-Received: by 2002:a17:906:4fca:b0:ad8:9a3b:b274 with SMTP id a640c23a62f3a-ade1aaff72bmr983386466b.52.1749402799299;
        Sun, 08 Jun 2025 10:13:19 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc76feesm433253566b.147.2025.06.08.10.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 10:13:19 -0700 (PDT)
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
	Khalid Ali <khaliidcaliy@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] x86/efi: error handling on efi memory map
Date: Sun,  8 Jun 2025 17:11:25 +0000
Message-ID: <20250608171220.4528-1-khaliidcaliy@gmail.com>
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
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/x86/include/asm/efi.h     |  4 ++--
 arch/x86/platform/efi/efi.c    | 10 ++++++----
 arch/x86/platform/efi/efi_32.c |  9 ++++++---
 arch/x86/platform/efi/efi_64.c | 34 ++++++++++++++++++++++------------
 4 files changed, 36 insertions(+), 21 deletions(-)

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
index b2cc7b4552a1..ed827dacd493 100644
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
@@ -84,7 +87,7 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	return 0;
 }
 
-void __init efi_map_region_fixed(efi_memory_desc_t *md) {}
+int __init efi_map_region_fixed(efi_memory_desc_t *md) {}
 void __init parse_efi_setup(u64 phys_addr, u32 data_len) {}
 
 efi_status_t efi_call_svam(efi_runtime_services_t * const *,
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


