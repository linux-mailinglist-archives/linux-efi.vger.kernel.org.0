Return-Path: <linux-efi+bounces-438-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AA7842B68
	for <lists+linux-efi@lfdr.de>; Tue, 30 Jan 2024 19:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CC81C25E6C
	for <lists+linux-efi@lfdr.de>; Tue, 30 Jan 2024 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372C686AD7;
	Tue, 30 Jan 2024 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJos1uSU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3B086AD3
	for <linux-efi@vger.kernel.org>; Tue, 30 Jan 2024 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637701; cv=none; b=cjUSa12ImgidZjepbVMxIT3C/S2ydEo6VtdTYVJBO5/Mrr0Rh4rwADDL/kmrzI+YByqQqfz//R9TUJxLEeEXjcAI8Zdp23N2gcYAp83ZpRRLLFVt86va9DQ+xKx1ADYosNDmEkNSP+IdToy6Kk7kTP46mDA5yjTRUeGQ2wS/aLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637701; c=relaxed/simple;
	bh=Ja87yBDRywP0CX6OXCxIORKfnyHcITk/n7d3soQAEdQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PlAKutmHaMePwjQ9wfYdrnAqgU9iPI1VZ3KvA2s2pgG9rcUTdM+mOHjI++iXzgOqymW9+Fbfpd1UBaX2wclRgDPuXALqZ2S8eh8r1qYmjyQn66CGzyX8XqtdG27MF8zMpIPUmwBe+ONXpMZhyCIAyNupaK/lerLwYwg/55aB9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJos1uSU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf216080f5so7655359276.1
        for <linux-efi@vger.kernel.org>; Tue, 30 Jan 2024 10:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706637698; x=1707242498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pWduuWVQBghPR6SIJrFKdvonWh9z5TDyHZomCZj0848=;
        b=vJos1uSUJ4n7fY7HO5VhCWmaHgROFMqoaYHlOQ/3cgHNRLDYm5aRWe+Wnjklc2YA/6
         b/j+5U9+51mHLv2vwxQI5s+OPlqA4/E96rCOv8MB2DQwgt2LkinUma1SO+1UK1RYIm8/
         +UWp/CR8TfIRokaeYgVibikmm9VoUG82YLQbEQ8mNZkQp0C4HKDJj5Vf7xOxLOGRPqQI
         /5pzXaAMl30uwEMtRMoa+Kc4hFs+EO1nApPmoS0zytReEYmp1GGxqNIfZQRPewOLXted
         379/YICubc+grXWhBBpEtuAceUAWQLaJnWzkS4V1aHFtLojRs34A19WZY13usenzhchX
         SMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706637698; x=1707242498;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pWduuWVQBghPR6SIJrFKdvonWh9z5TDyHZomCZj0848=;
        b=UrA+r0Srw4wQhu8qAHx88lgP3Yn35ga27O0OuY09i6V6ps2REKFvl6sVauuCjc0W0M
         tAl84QFkZoiEzIbLX+Nu2t2kGuUik5962eGcWKUcPwF3kd+I+gukXEZrDEb7h842XIjE
         xVHQUA+gA7dITS2v/guJpgWp1sEIbbmT/IejALLRv7Kvpip+emUrwCHIw2892GFVUbt/
         QeBQVhFjWE0qiXtR8fNlf/ee5eYYRLbscAhcNC/ltTW5LC9rKVQaJhqvl7O8A8WNTEj1
         YXZvi/unf1BXP9LmJZBf7XrwHnWsQfdrs1irjeQCWJiN9ZjU76A48FvFPknxpl9seep/
         z1GQ==
X-Gm-Message-State: AOJu0Yw2wYroVgZmDRmIrc+lE1kmWNe3UZ20f7darAaMotHrz6cmhMBM
	AqEjzrjmG3dMkBeNkIG3ZaosJc6jgnsah5TzoZlXhYv6PKuqUuB9tYSaGBoDtvfLf4euneZ8pD9
	Cr39IQoWyuk+9oPJjo1u4Qrm5GrPJVx1LL3aKUMIDZpYDTWOKk/W2ieVgot36wVTk57BlYc+4JW
	wLsUDVNDdWZCWd0gQKmx43+kpB5w==
X-Google-Smtp-Source: AGHT+IHVZB6kbZwOEMYlK2tT43mBtUj9XSIpNQh1P3W0NVaPxSHuhGbL4V94pa8iIK4QgSN6jBLY4BI5
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:e0d:b0:dc3:721f:7a4e with SMTP id
 df13-20020a0569020e0d00b00dc3721f7a4emr2988643ybb.12.1706637698391; Tue, 30
 Jan 2024 10:01:38 -0800 (PST)
Date: Tue, 30 Jan 2024 19:01:35 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5604; i=ardb@kernel.org;
 h=from:subject; bh=gD7glzJD8v//JBqrPvDPr6NAJ6wcBKEESpbbpZq2Etg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWnZd3beRyNqzeG7L9mrlftV7vhbPr/SlWJ2zOW/Dzm+
 bPjbJpFRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiIuxojw0nFs1YM2xz2r12j
 pzXvPH+XX/F243Nnc7dN3Fq6gf3e//8MfyVrEtQW31u2Oe214kz/VQereyW/zheYpRTY0S68593 3aCYA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240130180134.239252-2-ardb+git@google.com>
Subject: [PATCH] x86/efistub: Avoid placing the kernel below LOAD_PHYSICAL_ADDR
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Tom Englund <tomenglund26@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The EFI stub's kernel placement logic randomizes the physical placement
of the kernel by taking all available memory into account, and picking a
region at random, based on a random seed.

When KASLR is disabled, this seed is set to 0x0, and this results in the
lowest available region of memory to be selected for loading the kernel,
even if this is below LOAD_PHYSICAL_ADDR. Some of this memory is
typically reserved for the GFP_DMA region, to accommodate masters that
can only access the first 16 MiB of system memory.

Even if such devices are rare these days, we may still end up with a
warning in the kernel log, as reported by Tom:

 swapper/0: page allocation failure: order:10, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0

Fix this by tweaking the random allocation logic to accept a low bound
on the placement, and set it to LOAD_PHYSICAL_ADDR.

Reported-by: Tom Englund <tomenglund26@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218404
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h     |  3 ++-
 drivers/firmware/efi/libstub/kaslr.c       |  2 +-
 drivers/firmware/efi/libstub/randomalloc.c | 12 +++++++-----
 drivers/firmware/efi/libstub/x86-stub.c    |  1 +
 drivers/firmware/efi/libstub/zboot.c       |  2 +-
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index a1c6ab24cd99..fc18fd649ed7 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -956,7 +956,8 @@ efi_status_t efi_get_random_bytes(unsigned long size, u8 *out);
 
 efi_status_t efi_random_alloc(unsigned long size, unsigned long align,
 			      unsigned long *addr, unsigned long random_seed,
-			      int memory_type, unsigned long alloc_limit);
+			      int memory_type, unsigned long alloc_min,
+			      unsigned long alloc_max);
 
 efi_status_t efi_random_get_seed(void);
 
diff --git a/drivers/firmware/efi/libstub/kaslr.c b/drivers/firmware/efi/libstub/kaslr.c
index 62d63f7a2645..1a9808012abd 100644
--- a/drivers/firmware/efi/libstub/kaslr.c
+++ b/drivers/firmware/efi/libstub/kaslr.c
@@ -119,7 +119,7 @@ efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
 		 */
 		status = efi_random_alloc(*reserve_size, min_kimg_align,
 					  reserve_addr, phys_seed,
-					  EFI_LOADER_CODE, EFI_ALLOC_LIMIT);
+					  EFI_LOADER_CODE, 0, EFI_ALLOC_LIMIT);
 		if (status != EFI_SUCCESS)
 			efi_warn("efi_random_alloc() failed: 0x%lx\n", status);
 	} else {
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 674a064b8f7a..4e96a855fdf4 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -17,7 +17,7 @@
 static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
 					 unsigned long size,
 					 unsigned long align_shift,
-					 u64 alloc_limit)
+					 u64 alloc_min, u64 alloc_max)
 {
 	unsigned long align = 1UL << align_shift;
 	u64 first_slot, last_slot, region_end;
@@ -30,11 +30,11 @@ static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
 		return 0;
 
 	region_end = min(md->phys_addr + md->num_pages * EFI_PAGE_SIZE - 1,
-			 alloc_limit);
+			 alloc_max);
 	if (region_end < size)
 		return 0;
 
-	first_slot = round_up(md->phys_addr, align);
+	first_slot = round_up(max(md->phys_addr, alloc_min), align);
 	last_slot = round_down(region_end - size + 1, align);
 
 	if (first_slot > last_slot)
@@ -56,7 +56,8 @@ efi_status_t efi_random_alloc(unsigned long size,
 			      unsigned long *addr,
 			      unsigned long random_seed,
 			      int memory_type,
-			      unsigned long alloc_limit)
+			      unsigned long alloc_min,
+			      unsigned long alloc_max)
 {
 	unsigned long total_slots = 0, target_slot;
 	unsigned long total_mirrored_slots = 0;
@@ -78,7 +79,8 @@ efi_status_t efi_random_alloc(unsigned long size,
 		efi_memory_desc_t *md = (void *)map->map + map_offset;
 		unsigned long slots;
 
-		slots = get_entry_num_slots(md, size, ilog2(align), alloc_limit);
+		slots = get_entry_num_slots(md, size, ilog2(align), alloc_min,
+					    alloc_max);
 		MD_NUM_SLOTS(md) = slots;
 		total_slots += slots;
 		if (md->attribute & EFI_MEMORY_MORE_RELIABLE)
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index e387f30717a7..0a49a9228b00 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -808,6 +808,7 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 
 	status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
 				  seed[0], EFI_LOADER_CODE,
+				  LOAD_PHYSICAL_ADDR,
 				  EFI_X86_KERNEL_ALLOC_LIMIT);
 	if (status != EFI_SUCCESS)
 		return status;
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index bdb17eac0cb4..1ceace956758 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -119,7 +119,7 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 		}
 
 		status = efi_random_alloc(alloc_size, min_kimg_align, &image_base,
-					  seed, EFI_LOADER_CODE, EFI_ALLOC_LIMIT);
+					  seed, EFI_LOADER_CODE, 0, EFI_ALLOC_LIMIT);
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to allocate memory\n");
 			goto free_cmdline;
-- 
2.43.0.429.g432eaa2c6b-goog


