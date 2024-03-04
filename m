Return-Path: <linux-efi+bounces-700-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB0887003D
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC2CB2366F
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7923839F;
	Mon,  4 Mar 2024 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRbUbdtL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8216A39AFC
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551240; cv=none; b=V9FfsgUlYDUl3ivpVFkEycPyX75Il6QdDwM/KmfdYZv/rJBPvx9xaUHZEN2I/aKfPOnlngWrng2WYbn1QFK1AW/a0R2zbJKdsB/i4Dr8Z73TgwsFMiO4E6yoAGA4A6/lVgh+d+JiDPTJCZ3JlGN6WhRiGlnsdsG0NlfbsnHvzM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551240; c=relaxed/simple;
	bh=XIW52LFQEZnellQCQaWMZX8BbaCwoglfBUfLmgBKEeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=je6YFVEUJkJZCW/M9aLpbiUUeStMvr15zXGVgQn/YrUuE1rzi5tM8C/g+OUBkYO7Fxl9tJMCqUlflHl8RCEg8LYbdFXxV1UsM759+tfNmr+v7JubDSUD1LoCBXt68l6UYE4zt0p4KGiMaZzRgsYxwG6vFTwNWma7mUR0gd79EUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FRbUbdtL; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-412a6bdd67fso21602795e9.3
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 03:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551237; x=1710156037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sdvrpObpXdvwnP3J/737nekXBEQoGcd4psGPSFaX07E=;
        b=FRbUbdtLcKWPUe5MFkoQomFrgooFMhF2EhVZCO7p0L7A1m/iGNvZGvvXGRClRE/dwG
         aWnOuJw5CdbIDqC8LyZM5IoJ3TwvWRv1q6uTjKASA5b5gpIyg3eNMc4h1OAHYGZiYzc6
         aFNPTzJr++1mSlkcWnwrFxByz/a+SIFuaWhlvX3uv2fR7qWiTeA9y4L0COcaS7l6F/oK
         AUEuTDIdD5m4P58M+qiGwhEjXmftMSDBEMuif1CBaLW5Rq4Gz0S1oxRNxADk20QCUu5X
         rtZ5PJhFMjhmSY6C1QAt+DkaJ9qkM0XG3hUGN6HpFfpbNN7oHg9SsWAG0FpDwLmU6jzP
         OTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551237; x=1710156037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdvrpObpXdvwnP3J/737nekXBEQoGcd4psGPSFaX07E=;
        b=Un6tXQ2ESkYAukEzggBBdsqd8HCJ/oAbFeQyFds6NHZBHpZhl6ZF61aODVhmMaiiFq
         oPCargHhhPNYN14LQoxsVTR/CMxCnCCfaHhW1xCuwooR9YyeLgnWPeTmxntGsAQvNzg+
         s9Uo0RKc68C2pW/snoGN9JNKZTS9RZwz65Bs8YHiEXKNpJGi5UASk9rZElc+S8FInpNU
         A4KOitIssyeEuDeAWAuZ+bOovQurx3sv/Ht4L815a/qVAL8TZNQeLhYorNJsUTIKzxHf
         vmyD6UD+ZU//8TdT4BJj9NLkLgbbwIGHQB/GUKh1/uaWUxtjEXl8nOCVJu8MMOO6/meE
         PhXw==
X-Gm-Message-State: AOJu0YzaGn7oJ7xY+d9eL9P8asTKbWvNTQ6KtvXL3g0mVqhw14smMZC7
	KGzAHCQo7jGJnU0ibeEE/D8TI/kxMSTzBtjag6H3W3OCUEgiz+eWk5y+PhPtaBx0ulLKhw==
X-Google-Smtp-Source: AGHT+IHVDqgJu+Dz0YoV5UKKao4fBcAqWdDnFkLwScF8xv8zDNloyxkiGVP65TeW+d1r6fzaU41oZF0B
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1d9c:b0:412:e6d5:54dc with SMTP id
 p28-20020a05600c1d9c00b00412e6d554dcmr26224wms.3.1709551237107; Mon, 04 Mar
 2024 03:20:37 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:46 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3549; i=ardb@kernel.org;
 h=from:subject; bh=4qnuUcsZBAQzMf3naeYjQ0/7jE52Ujg7H78WoGtpBpQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpuiABgZhZ68W2LxaaL3J1YnqHLENAhXt4pe3rZP/Hc
 1cVvZ3SUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZyTpGRYZOJ/jP9ybKzlC9V
 LPnU+yT+yvmyrxsc7xxKMCv4ym+leJjhf4INw9fd29gjfUR799yfEME5f9kLNk/zRzrPk04JSPz p4AcA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-28-ardb+git@google.com>
Subject: [PATCH stable-v6.1 08/18] efi/libstub: Add limit argument to efi_random_alloc()
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit bc5ddceff4c14494d83449ad45c985e6cd353fce upstream ]

x86 will need to limit the kernel memory allocation to the lowest 512
MiB of memory, to match the behavior of the existing bare metal KASLR
physical randomization logic. So in preparation for that, add a limit
parameter to efi_random_alloc() and wire it up.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-22-ardb@kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c  |  2 +-
 drivers/firmware/efi/libstub/efistub.h     |  2 +-
 drivers/firmware/efi/libstub/randomalloc.c | 10 ++++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 40275c3131c8..16377b452119 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -181,7 +181,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		 */
 		status = efi_random_alloc(*reserve_size, min_kimg_align,
 					  reserve_addr, phys_seed,
-					  EFI_LOADER_CODE);
+					  EFI_LOADER_CODE, EFI_ALLOC_LIMIT);
 		if (status != EFI_SUCCESS)
 			efi_warn("efi_random_alloc() failed: 0x%lx\n", status);
 	} else {
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 6f5a1a16db15..8a343ea1231a 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -905,7 +905,7 @@ efi_status_t efi_get_random_bytes(unsigned long size, u8 *out);
 
 efi_status_t efi_random_alloc(unsigned long size, unsigned long align,
 			      unsigned long *addr, unsigned long random_seed,
-			      int memory_type);
+			      int memory_type, unsigned long alloc_limit);
 
 efi_status_t efi_random_get_seed(void);
 
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 1692d19ae80f..ed6f6087a9ea 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -16,7 +16,8 @@
  */
 static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
 					 unsigned long size,
-					 unsigned long align_shift)
+					 unsigned long align_shift,
+					 u64 alloc_limit)
 {
 	unsigned long align = 1UL << align_shift;
 	u64 first_slot, last_slot, region_end;
@@ -29,7 +30,7 @@ static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
 		return 0;
 
 	region_end = min(md->phys_addr + md->num_pages * EFI_PAGE_SIZE - 1,
-			 (u64)EFI_ALLOC_LIMIT);
+			 alloc_limit);
 	if (region_end < size)
 		return 0;
 
@@ -54,7 +55,8 @@ efi_status_t efi_random_alloc(unsigned long size,
 			      unsigned long align,
 			      unsigned long *addr,
 			      unsigned long random_seed,
-			      int memory_type)
+			      int memory_type,
+			      unsigned long alloc_limit)
 {
 	unsigned long total_slots = 0, target_slot;
 	unsigned long total_mirrored_slots = 0;
@@ -76,7 +78,7 @@ efi_status_t efi_random_alloc(unsigned long size,
 		efi_memory_desc_t *md = (void *)map->map + map_offset;
 		unsigned long slots;
 
-		slots = get_entry_num_slots(md, size, ilog2(align));
+		slots = get_entry_num_slots(md, size, ilog2(align), alloc_limit);
 		MD_NUM_SLOTS(md) = slots;
 		total_slots += slots;
 		if (md->attribute & EFI_MEMORY_MORE_RELIABLE)
-- 
2.44.0.278.ge034bb2e1d-goog


