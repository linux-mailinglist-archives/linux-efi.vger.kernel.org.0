Return-Path: <linux-efi+bounces-2423-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A5D9F9112
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 12:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B62316C27D
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 11:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484421CC177;
	Fri, 20 Dec 2024 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1f+1x0n"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573931C6F70
	for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2024 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734693772; cv=none; b=FqkL+NcnljcQcCPk/nzg7RTS9IC8ztyt4LM/9Jitxkb4RkpOsdOFf0VRCvuzWZttgIWjw5r94+3Kt9AG6ZD3TN6ccTxcMa/muO8Nndo6k8XJwhLVMVP5v2WRn9Z/KBId6Be1e0ly+5WG3tcSxAzVq0Rr1MffMl18Fvy/jMYzzlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734693772; c=relaxed/simple;
	bh=lVMPdicFtyOL832rAMJvK98velTQ2FkjUowJ3Igxmkg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t6gmCYlkORyPFEbYNwUSE2TJYFmK1yRiCMJ0K5iys7uJ1GwdRFPPzppclrKCQCBzqS3Ztr6VkaXxg8ZFy3/4hEletT6SDz4Yus7zjbea3DtoqQOjdFiRgBCUpYuQFWTCEno8eg/71zLMT/Bga+F9RKO5gFwX189vjtV3g7xc8dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c1f+1x0n; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-385d80576abso1137784f8f.3
        for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2024 03:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734693769; x=1735298569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Mq2zGEkSU736hh4kdcV8OEsSkyXvgmpNv1UZJcoKL4=;
        b=c1f+1x0nPqy8YYq12Lnf8Pl2dYs0Rrcb/uckYzeQC7Uob548SVwyQAo2FBqKN0PHQa
         SCl9rIOw7QUs49cI4B9PIxr3anZeK3Wb3pBwYBAIhtL7FvwPBoMsNK0m3p/R1HLCfbMI
         EYfe1YpvVSyrIWsGLiPZwV5geosbXMgXLs4x07Pmvr/LM/WHbXazu5Fh57ELTBKYPjdy
         I+b/Q5ujhgisn2mJAE5JjKtSQAlT1FRKHt1MRlnYpe1IvR3GbCYPeqbAuvWNVWA8msWZ
         yxUHhiNxCtrT2YcNEHmFnikzldLKw3yiA/TUwDp4AjphD+QVap5SJ5zJEJG4IreaisD9
         4MVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734693769; x=1735298569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Mq2zGEkSU736hh4kdcV8OEsSkyXvgmpNv1UZJcoKL4=;
        b=bNjOtHkRQb46cx6IE7ctUT/TjnpHo0wMMaOwSyAKn4E278Znevk8fS4lRai4deFblK
         lYhrCnifiijzwfXwdEm8IHV1F/HtvKX1/2h9H+xtAaCPU2XQ6RQSJzqLSqmNnEjMKKov
         shgyQtG5Rk9Rf8YFhWgbFacWxPXvDFzF+S701z44Un3LvUkItg0v1KkQ4qXcW3QrZpyR
         mtxhxAz0ZEVTOOwJfIgP6OhpsI8gKOtt5hUb5VHC47Xr/VNnWy2g/ibb8Zg2gq1jlzAU
         n5NY96rY7L2ISShVjV+0aMCqjcFQyeGOSAO5QdMAcRkyoKzX7a7pqxPletMWsLLamMDN
         8FBg==
X-Gm-Message-State: AOJu0Yzvsg98Fe6tDCbsIY8Ec2uhpZs8J9o+yc5Ks0yNcbRbJ9wSp9Ek
	30Ja3XQLfAmL0+K1T7PyVPGYqT3pT4pjz8MMpo1PkwH/7te+F1LZ2zDX2oVW2W+xuNOhtU2u/xB
	YwjqdzSM1wcMwK+1zSEuTd+ebU61f5PW5E1i7OszxgMNFAk8FvukpliXPX3gFY6hSnEfsJBc2XT
	MzZTUiHvfiQMQH3qTYKSNvcs6xwA==
X-Google-Smtp-Source: AGHT+IHEnq1PDrJx6ZoitqXOfRW6JfLWhdmj4+pCY+eWOZ7BG4KZEaQvyMHTmEkr7l76dh8wiKxxSpq3
X-Received: from wmbhn29.prod.google.com ([2002:a05:600c:a39d:b0:434:fe74:1bd5])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:18a9:b0:386:3835:9fff
 with SMTP id ffacd0b85a97d-38a22406d43mr2840931f8f.59.1734693768819; Fri, 20
 Dec 2024 03:22:48 -0800 (PST)
Date: Fri, 20 Dec 2024 12:22:21 +0100
In-Reply-To: <20241220112214.2598872-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241220112214.2598872-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5660; i=ardb@kernel.org;
 h=from:subject; bh=YLK9emTD2b7V0uTyYE0d8W4Cjh6Qxt9ydF/yoBPkTls=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT01uGA9p+/C/+d1M41rLlxd19jocPr/Arv0U/Fzxee3a
 JYbb1zSUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYiP4+RYcKhTeIZahGT3r+I
 zW6wdkhVfM74zO53rdXvrQ/s1+11DGX477fiu1NYxLHJp1Ke7WBcccz00szb/HunLPzXt/xmI8P JjcwA
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241220112214.2598872-15-ardb+git@google.com>
Subject: [PATCH 6/7] efi/libstub: Use cleanup helpers for freeing copies of
 the memory map
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The EFI stub may obtain the memory map from the firmware numerous times,
and this involves doing a EFI pool allocation first, which needs to be
freed after use.

Streamline this using a cleanup helper, which makes the code easier to
follow.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/kaslr.c       |  4 +---
 drivers/firmware/efi/libstub/mem.c         | 20 ++++++++------------
 drivers/firmware/efi/libstub/randomalloc.c |  4 +---
 drivers/firmware/efi/libstub/relocate.c    | 10 ++++------
 drivers/firmware/efi/libstub/x86-stub.c    | 11 ++++++-----
 5 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/firmware/efi/libstub/kaslr.c b/drivers/firmware/efi/libstub/kaslr.c
index 6318c40bda38..4bc963e999eb 100644
--- a/drivers/firmware/efi/libstub/kaslr.c
+++ b/drivers/firmware/efi/libstub/kaslr.c
@@ -57,7 +57,7 @@ u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle)
  */
 static bool check_image_region(u64 base, u64 size)
 {
-	struct efi_boot_memmap *map;
+	struct efi_boot_memmap *map __free(efi_pool) = NULL;
 	efi_status_t status;
 	bool ret = false;
 	int map_offset;
@@ -80,8 +80,6 @@ static bool check_image_region(u64 base, u64 size)
 		}
 	}
 
-	efi_bs_call(free_pool, map);
-
 	return ret;
 }
 
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 4f1fa302234d..9c82259eea81 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -20,10 +20,10 @@
 efi_status_t efi_get_memory_map(struct efi_boot_memmap **map,
 				bool install_cfg_tbl)
 {
+	struct efi_boot_memmap tmp, *m __free(efi_pool) = NULL;
 	int memtype = install_cfg_tbl ? EFI_ACPI_RECLAIM_MEMORY
 				      : EFI_LOADER_DATA;
 	efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;
-	struct efi_boot_memmap *m, tmp;
 	efi_status_t status;
 	unsigned long size;
 
@@ -48,24 +48,20 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap **map,
 		 */
 		status = efi_bs_call(install_configuration_table, &tbl_guid, m);
 		if (status != EFI_SUCCESS)
-			goto free_map;
+			return status;
 	}
 
 	m->buff_size = m->map_size = size;
 	status = efi_bs_call(get_memory_map, &m->map_size, m->map, &m->map_key,
 			     &m->desc_size, &m->desc_ver);
-	if (status != EFI_SUCCESS)
-		goto uninstall_table;
+	if (status != EFI_SUCCESS) {
+		if (install_cfg_tbl)
+			efi_bs_call(install_configuration_table, &tbl_guid, NULL);
+		return status;
+	}
 
-	*map = m;
+	*map = no_free_ptr(m);
 	return EFI_SUCCESS;
-
-uninstall_table:
-	if (install_cfg_tbl)
-		efi_bs_call(install_configuration_table, &tbl_guid, NULL);
-free_map:
-	efi_bs_call(free_pool, m);
-	return status;
 }
 
 /**
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index c41e7b2091cd..e5872e38d9a4 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -59,9 +59,9 @@ efi_status_t efi_random_alloc(unsigned long size,
 			      unsigned long alloc_min,
 			      unsigned long alloc_max)
 {
+	struct efi_boot_memmap *map __free(efi_pool) = NULL;
 	unsigned long total_slots = 0, target_slot;
 	unsigned long total_mirrored_slots = 0;
-	struct efi_boot_memmap *map;
 	efi_status_t status;
 	int map_offset;
 
@@ -130,7 +130,5 @@ efi_status_t efi_random_alloc(unsigned long size,
 		break;
 	}
 
-	efi_bs_call(free_pool, map);
-
 	return status;
 }
diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
index d694bcfa1074..99b45d1cd624 100644
--- a/drivers/firmware/efi/libstub/relocate.c
+++ b/drivers/firmware/efi/libstub/relocate.c
@@ -23,14 +23,14 @@
 efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 				 unsigned long *addr, unsigned long min)
 {
-	struct efi_boot_memmap *map;
+	struct efi_boot_memmap *map __free(efi_pool) = NULL;
 	efi_status_t status;
 	unsigned long nr_pages;
 	int i;
 
 	status = efi_get_memory_map(&map, false);
 	if (status != EFI_SUCCESS)
-		goto fail;
+		return status;
 
 	/*
 	 * Enforce minimum alignment that EFI or Linux requires when
@@ -79,11 +79,9 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 	}
 
 	if (i == map->map_size / map->desc_size)
-		status = EFI_NOT_FOUND;
+		return EFI_NOT_FOUND;
 
-	efi_bs_call(free_pool, map);
-fail:
-	return status;
+	return EFI_SUCCESS;
 }
 
 /**
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 4a3487e5dfc8..4dfd25e6ac71 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -616,7 +616,7 @@ static efi_status_t allocate_e820(struct boot_params *params,
 				  struct setup_data **e820ext,
 				  u32 *e820ext_size)
 {
-	struct efi_boot_memmap *map;
+	struct efi_boot_memmap *map __free(efi_pool) = NULL;
 	efi_status_t status;
 	__u32 nr_desc;
 
@@ -630,13 +630,14 @@ static efi_status_t allocate_e820(struct boot_params *params,
 				 EFI_MMAP_NR_SLACK_SLOTS;
 
 		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
+		if (status != EFI_SUCCESS)
+			return status;
 	}
 
-	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) && status == EFI_SUCCESS)
-		status = allocate_unaccepted_bitmap(nr_desc, map);
+	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
+		return allocate_unaccepted_bitmap(nr_desc, map);
 
-	efi_bs_call(free_pool, map);
-	return status;
+	return EFI_SUCCESS;
 }
 
 struct exit_boot_struct {
-- 
2.47.1.613.gc27f4b7a9f-goog


