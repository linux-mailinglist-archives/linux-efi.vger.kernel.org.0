Return-Path: <linux-efi+bounces-432-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB7983DB1F
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jan 2024 14:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60BC287CA0
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jan 2024 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AF71B599;
	Fri, 26 Jan 2024 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xW10/i+R"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEC81AACB
	for <linux-efi@vger.kernel.org>; Fri, 26 Jan 2024 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706276645; cv=none; b=dE8fK16KYJ6YKYDs9RHdSIfBHY5QpQriF//0I7H8BbU04YktqCAvOKO+oQf+PyeGULu9wOr81VqZLd/UjtrlmEPgh1cR7/aXpmP1XzOfbWHdF111U9+KZDuyg24ogEL2TK7p1c3WR/3u7cp0we7Xfr20/HAIGEU9etjsDkm5ZLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706276645; c=relaxed/simple;
	bh=KDGHlF9BjXdSB0sZEccUbLYZAH/18txpi/bnbz/Z/vA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lj+Z8USdxqi00FF/s6Yd/d0nMaqn/jCTIFvj6PL/moKPJxf8BWSK+evbJH+6XdGLaeYPUmvevSj4tWCSxaK4/5R4xiHdbFvgsEGazP1Tw+uwI0Z7KsN6jZ8JoL5L2+mm8QJVI00e10tg9+eHfrjf4COz5ErpZvHhbJlGCcoeVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xW10/i+R; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6477d2cbcso373145276.3
        for <linux-efi@vger.kernel.org>; Fri, 26 Jan 2024 05:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706276642; x=1706881442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TnNIHpV3zteiVajtwnpfhHYHgjNd8+MoEisix2YWyS8=;
        b=xW10/i+R8iNdC1IM2O659rHzYJt6rwPfot31CRfzvuoU/AeiHX8/xjfb1T3LtaAJv8
         QRTTG6tH6y+VbP85dkX20WWjtj7ZI+SMfGgvo7dGFESQyXHkwP+/O5Wxjc6pbjceBl2u
         zpnFyHmtNZqWgPCPNPcfd6GBXihwLsFnF0wLMWrqbH6CZueFc9g1tnwV1hRjTuKnTWki
         t6EO9C0XK50h99XaxB0LJY95DXdKDIFYx6ZaaRfN2u75Z6VuWJh1mC8VrlUezIAav+wr
         aBhRfQL5b4qrXX2GELOUXO+/tj5hOieSabtAj+DTJQibldktuBtXex5mJYNuQEM2YACH
         idww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706276642; x=1706881442;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TnNIHpV3zteiVajtwnpfhHYHgjNd8+MoEisix2YWyS8=;
        b=Iyk8Wnm1ODZu/PWh9u4/9KbtH690RxEU0BgStX/6HR+GMmLCR6TTV3Dgk8mq5nQ9Oz
         EBeCZnb6Jx2LsA8sDI4y3g6+5W3iDJNGQsKrBkOFpyMJ1Ln0IUKnlUr0c01z1o9HvXaj
         /SjxiYdTiWLODAwTFvffKWunV/WxdZJuepgwvB6VoXUTZ5SBjBe66DNLLJNhk6tIQsHm
         UHdd9zcDMjazMgxOID9uj++/iAHoxNCvuRsoI4PN6wn24WaAiyDI2fYys3tPVlLpNjeV
         JYBUwzFHZCHx9bp64y3kiHScwQgE90rTPPA+IX1lNJ0MO2nPwSaMnIQu9M6WVHA3Gjob
         0QWg==
X-Gm-Message-State: AOJu0YxTA+Jb7zOYsoLA2k1k9E/OMSelIsYUytG7jfs/10PVRJuf9c7j
	H56MIbGrdSC4bpJ0avk4NOQc3rTT0slXw9lIK4WSSnHfHKyPwpACThCRs7aq9QH7+4uwH7zAfns
	/cFEaJmL5HMmwjKoZLLyaJsYanIiDwV0tvvaGCh0pBvv/i9V/hluw3QDyg+ur3nrXSGQjlJfaDe
	I1vNyDecZszx8lYf4cMZeRPmZQTw==
X-Google-Smtp-Source: AGHT+IERGzGpTqbu2AclGclMAWfXANfdP3LoVV7qJ2T1tzODZT7Ntk8EvJppyz9qss3JaGO4eYka9TRI
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1b8b:b0:dc2:2847:b34a with SMTP id
 ei11-20020a0569021b8b00b00dc22847b34amr112080ybb.9.1706276641623; Fri, 26 Jan
 2024 05:44:01 -0800 (PST)
Date: Fri, 26 Jan 2024 14:43:57 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3994; i=ardb@kernel.org;
 h=from:subject; bh=Y96q7GKu/v3rW4tp8R6Ype9eFtC7E1BdN0T+JMK5c7U=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXXzdlkFbZdC84PBk76qTp1s1RZ47k9ntG9x16PzV/Pn6
 9jbeal1lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIkYzWBkeCSSqddXHfhh+tYd
 EzXCLlg/97j4ydN7o5fOWQXzNc9NbRn+51VfjNM3LJb5oyvLvOK/hOypdosj5ZdMX0xt8cqrilj HDQA=
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240126134356.2859488-2-ardb+git@google.com>
Subject: [PATCH] x86/efistub: Give up if memory attribute protocol returns an error
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: pjones@redhat.com, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The recently introduced EFI memory attributes protocol should be used
if it exists to ensure that the memory allocation created for the kernel
permits execution. This is needed for compatibility with tightened
requirements related Windows logo certification for x86 PCs.

Currently, we simply strip the execute protect (XP) attribute from the
entire range, but this might be rejected under some firmware security
policies, and so in a subsequent patch, this will be changed to only
strip XP from the executable region that runs early, and make it
read-only (RO) as well.

In order to catch any issues early, ensure that the memory attribute
protocol works as intended, and give up if it produces spurious errors.

Note that the DXE services based fallback was always based on best
effort, so don't propagate any errors returned by that API.

Fixes: a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 24 ++++++++++++--------
 drivers/firmware/efi/libstub/x86-stub.h |  4 ++--
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 0d510c9a06a4..cb0be88c8131 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -223,8 +223,8 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	}
 }
 
-void efi_adjust_memory_range_protection(unsigned long start,
-					unsigned long size)
+efi_status_t efi_adjust_memory_range_protection(unsigned long start,
+						unsigned long size)
 {
 	efi_status_t status;
 	efi_gcd_memory_space_desc_t desc;
@@ -236,13 +236,17 @@ void efi_adjust_memory_range_protection(unsigned long start,
 	rounded_end = roundup(start + size, EFI_PAGE_SIZE);
 
 	if (memattr != NULL) {
-		efi_call_proto(memattr, clear_memory_attributes, rounded_start,
-			       rounded_end - rounded_start, EFI_MEMORY_XP);
-		return;
+		status = efi_call_proto(memattr, clear_memory_attributes,
+					rounded_start,
+					rounded_end - rounded_start,
+					EFI_MEMORY_XP);
+		if (status != EFI_SUCCESS)
+			efi_warn("Failed to clear EFI_MEMORY_XP attribute\n");
+		return status;
 	}
 
 	if (efi_dxe_table == NULL)
-		return;
+		return EFI_SUCCESS;
 
 	/*
 	 * Don't modify memory region attributes, they are
@@ -255,7 +259,7 @@ void efi_adjust_memory_range_protection(unsigned long start,
 		status = efi_dxe_call(get_memory_space_descriptor, start, &desc);
 
 		if (status != EFI_SUCCESS)
-			return;
+			break;
 
 		next = desc.base_address + desc.length;
 
@@ -280,8 +284,10 @@ void efi_adjust_memory_range_protection(unsigned long start,
 				 unprotect_start,
 				 unprotect_start + unprotect_size,
 				 status);
+			break;
 		}
 	}
+	return EFI_SUCCESS;
 }
 
 static void setup_unaccepted_memory(void)
@@ -805,9 +811,7 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 
 	*kernel_entry = addr + entry;
 
-	efi_adjust_memory_range_protection(addr, kernel_total_size);
-
-	return EFI_SUCCESS;
+	return efi_adjust_memory_range_protection(addr, kernel_total_size);
 }
 
 static void __noreturn enter_kernel(unsigned long kernel_addr,
diff --git a/drivers/firmware/efi/libstub/x86-stub.h b/drivers/firmware/efi/libstub/x86-stub.h
index 37c5a36b9d8c..1c20e99a6494 100644
--- a/drivers/firmware/efi/libstub/x86-stub.h
+++ b/drivers/firmware/efi/libstub/x86-stub.h
@@ -5,8 +5,8 @@
 extern void trampoline_32bit_src(void *, bool);
 extern const u16 trampoline_ljmp_imm_offset;
 
-void efi_adjust_memory_range_protection(unsigned long start,
-					unsigned long size);
+efi_status_t efi_adjust_memory_range_protection(unsigned long start,
+						unsigned long size);
 
 #ifdef CONFIG_X86_64
 efi_status_t efi_setup_5level_paging(void);
-- 
2.43.0.429.g432eaa2c6b-goog


