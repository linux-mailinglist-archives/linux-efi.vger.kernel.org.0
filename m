Return-Path: <linux-efi+bounces-707-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B87870049
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2290D1C2301A
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB6839843;
	Mon,  4 Mar 2024 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZUEJh9y+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117838FA9
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551256; cv=none; b=C1s5p+z4xOlqp4A1gn71MFv5QKZSi8ht/YtcIVSqrOpHMOPaKHAaGiKr/yEmEPgs6b+PPwBY3BKS8TSZ047lk26bE581YtVBe1MSGGVe6Jqoyvbku5wsuylzr9ET4LvHjwCqYtE3vbejuvHolFjY6Yb23ueHaTBj757oBSOKCbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551256; c=relaxed/simple;
	bh=Per68CQai+Xxn0L865kRZlAQEqWfbghnDKgpM0J0Z2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YyAvphBreSayuISY9C5SiJ6ECU3+h2F3RIi+9umMtgiknfbiVDC0N6QvJAYvlMuU1VN1h2/pXVsvMjT7XnYXqygEVwuXkb2rtR0Z+rcOBkSbpfcDDQd3b+jFpXROZFoNKyHmauwndZCS69GMPkvB1bSaJ7rW35oWxkKWemd1ZBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZUEJh9y+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40e4478a3afso21818285e9.1
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 03:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551253; x=1710156053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NeNAFg50HmtrCQt/PisL3d49xdgdApCb/sQmOQhS1s=;
        b=ZUEJh9y+qnMbH/U8+YTJKWqGKsEKSSVgGuGvAeeNV5oBDZ/eMOH+rrjr/CPvHaCA0U
         J55D2SZok8Th+3zoEMmRfh3VVwC/cWxZefOwNvv1KDe9kduzDKAH3eICanSnaXhF2Wnl
         r1o1RUj5hTvBEOs9mcRVLq2i3pU76RjAmTtiapqNOcdr7TNdLGvmgR/IeD08L1ctehck
         RBdBmjP6ruUYKn3XZOyPra2bL8CyUSewH0s/brDT3W5ySL3+AEAn8c2PfeT5aZ4P4Ppp
         ToRnckKlywXq5xBYa5Art+vMgr8jYtfibFogJSbMErNxf8df9QUsbE2Uuu1OFzeexLs/
         yeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551253; x=1710156053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NeNAFg50HmtrCQt/PisL3d49xdgdApCb/sQmOQhS1s=;
        b=i00Dz0nD3FO3o1wQise77W0xylCBAZ7ntWyiyYLjb0BO1SLAI+kv2ZYanKMmDOl/Yc
         8O51DQfE8r+1dIA1Em+WYlgyi6V8xpmhXe/ZCC36etYY6tpre0NEenM94ICidmDEJVme
         cXuk4uihUU4qXJZhHbiVsDCysMcAY5Bvx2pQfyXFi71uJ8bfDtBTIvp8MKUdtlWLGgzJ
         fupWQzCuQXMOafctK1/AynMtB7RCobjuE/4hCOBr7wZKm9BV0SQ6s77qcfyBZuGYkxlK
         eWPY0VB8FldrUd0mCS0k8s7EgWIOw5EX4ey6pr7El+70ouiV+ioii+sdDVKu5Kt9Au5T
         aqhg==
X-Gm-Message-State: AOJu0Yz7yN1Qa9Zoxfut8Zj5is79NnGMFCrc3SJNVHXEm9nSk9STIQMe
	A7kNCeospqQ6TjUv6TBT0PccjirpES35UbEtqK/jj0H/q9TKMKc7km7z/WoyufLnyjcb3Q==
X-Google-Smtp-Source: AGHT+IFiguM/J3Dv2lwiXmuUxrqk1kYqDcOjIMNw43F31n5XIgbHco39X/WSrt7KJo4tK4C8oVpyvk/0
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:35c4:b0:412:913:54c7 with SMTP id
 r4-20020a05600c35c400b00412091354c7mr137456wmq.4.1709551253445; Mon, 04 Mar
 2024 03:20:53 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:53 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5123; i=ardb@kernel.org;
 h=from:subject; bh=mxcQdW9uBvIFkQoofAnf0NS1G1nd57HK1gT1qIwIw8E=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpuqg9cdWfWk9eOb+RY9+VsgxGp+Y/TCdv3PtopOMo7
 sXrJbCqo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExkoyHDP4Mze9lWuuw6WFd4
 c+aLnV33A+1z1Qwvs+as87q6kteS/zbDf0fxQh/b2G+Waxovigs9WO2Qbdvr0OHBanutvdnyy72 DbAA=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-35-ardb+git@google.com>
Subject: [PATCH stable-v6.1 15/18] x86/efistub: Avoid placing the kernel below LOAD_PHYSICAL_ADDR
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Tom Englund <tomenglund26@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 2f77465b05b1270c832b5e2ee27037672ad2a10a upstream ]

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

Fixes: a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
Reported-by: Tom Englund <tomenglund26@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218404
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c  |  2 +-
 drivers/firmware/efi/libstub/efistub.h     |  3 ++-
 drivers/firmware/efi/libstub/randomalloc.c | 12 +++++++-----
 drivers/firmware/efi/libstub/x86-stub.c    |  1 +
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 16377b452119..16f15e36f9a7 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -181,7 +181,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		 */
 		status = efi_random_alloc(*reserve_size, min_kimg_align,
 					  reserve_addr, phys_seed,
-					  EFI_LOADER_CODE, EFI_ALLOC_LIMIT);
+					  EFI_LOADER_CODE, 0, EFI_ALLOC_LIMIT);
 		if (status != EFI_SUCCESS)
 			efi_warn("efi_random_alloc() failed: 0x%lx\n", status);
 	} else {
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 4b4055877f3d..6741f3d900c5 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -906,7 +906,8 @@ efi_status_t efi_get_random_bytes(unsigned long size, u8 *out);
 
 efi_status_t efi_random_alloc(unsigned long size, unsigned long align,
 			      unsigned long *addr, unsigned long random_seed,
-			      int memory_type, unsigned long alloc_limit);
+			      int memory_type, unsigned long alloc_min,
+			      unsigned long alloc_max);
 
 efi_status_t efi_random_get_seed(void);
 
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index ed6f6087a9ea..7ba05719a53b 100644
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
index 47ebc85c0d22..c1dcc86fcc3d 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -785,6 +785,7 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 
 	status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
 				  seed[0], EFI_LOADER_CODE,
+				  LOAD_PHYSICAL_ADDR,
 				  EFI_X86_KERNEL_ALLOC_LIMIT);
 	if (status != EFI_SUCCESS)
 		return status;
-- 
2.44.0.278.ge034bb2e1d-goog


