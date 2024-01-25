Return-Path: <linux-efi+bounces-430-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF2683C3DF
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jan 2024 14:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7ED1C20D27
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jan 2024 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55A755C12;
	Thu, 25 Jan 2024 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHSTMXCb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAED4F5EF
	for <linux-efi@vger.kernel.org>; Thu, 25 Jan 2024 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190074; cv=none; b=jwcbb9Z6P9ylcQ1lUghMFP/B59kKIBhfbDNPwDUqjC+gDY1zH6zSlHMPZhxtPWANpUiyRDyPJj0GboOMvfp9qyr1CS5GRIDcPbHFtyFYCausen9SF8Md6i1BwVHsfe4IjtGtyPfwubQ4A62fjeNV6WhKCJFl4OGpEX4qDrK0/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190074; c=relaxed/simple;
	bh=o0BxVvTQS5MSXqBmv/bmD6LFgFxW5egcf2/t3GpmLGU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CRA6X3dSekT2hd4Uv2R7VC8ltOmEJrzqPW/tikt7nbKn8LoS7w6QVZz2AWF3Rmmj6s8Qll4VMY/a6tgmnhBXWtLjD7f0lZuJuRKuaxmqRhi05ht50V8J3tqY0PByWnITJCCkNvimOXbZZfDIUL802M+eiSw6MOhiK57YAUDkY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHSTMXCb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc223d528cfso10393807276.0
        for <linux-efi@vger.kernel.org>; Thu, 25 Jan 2024 05:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706190072; x=1706794872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9nt7EMjgJbD8vwTEa+79r1xNr8G1pxLgvPvAbin5kyE=;
        b=tHSTMXCbh6spMJH8FRsAh+zkwE6T20za4RMPy4k4l24DONM3upTrjip/zlkKYMlg8N
         1uH+8+uDboECsm2bzLGjpd8kOJSJ0/EFqwCSx1j5uRAAYUeGJZJiqP8e/dyhBTkcdfDg
         PGIlDdwR9cm1F4AhIFqc1PK0L6njAoOLXSJ1HThPrRAytZgFSGbtte21JtKGUWVXl63X
         5PCeoorZY0WHi+js/ZCzhit2b8rrmC5B09k9lOpkesSfB99oxsgM8x44FgZXgcrHaft9
         dkW2ajxfZGnWtB0VNBuQCXJSnRqq9knu0hqSBmcHPqkm5/Fxk5w8wlkc8nrwLfCWdTBz
         rMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706190072; x=1706794872;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9nt7EMjgJbD8vwTEa+79r1xNr8G1pxLgvPvAbin5kyE=;
        b=XfY4UU5BQGIJuQeTs8BNq7taVReEDB5hudPoSnH9nUewjVaiSn7QkcwjeuX7D08g66
         FxgsZoUizqJIYMgDWsFQZ+qF30bq/mqRw0IW5twDvsIdLr5gDWuhpvWvoLerNhxvi6Rx
         gLPvn4tTc5aWAN6riXXKVJENWyB3raSphNfAGuW6NsaCbj2VeNoucZ769H2DiZKqo+9K
         DWf9gHGfroz9c+zn0Ln9YAo/yKHfjelhFmhQc9E6sH96Hr/emiQYgMc7oy+oPdRagicQ
         cNSNbbbYxXUof83vIq1D74kLbrBwQOCSmqmIjR4eJsrjANz088KW9d56PKc7dKQgvN2A
         aI1w==
X-Gm-Message-State: AOJu0Yx1RS0RRoSw5cIavksLWLeFInRITsM733eXKkgaukv55ywfsRsP
	W7JSJ1BZdQskkbNvCZ6vdnhs8INC2dheg5vO95LcoQ7Dv4vwl7etLcHrzwx7h32V2B/XboRVt6n
	C1C5H3CZUK3kClabCgYuzpo+w+rvmJCW7EtHrKCrYN5KlhD8vnUf/e8oJulY88z9NA+ks316N59
	Doc+zYJrFnU7+545Dd5Rf4iw0V1g==
X-Google-Smtp-Source: AGHT+IHzrMZjMq0XHzS8MBmbI1YkfR+iJ25keEBmxETcruvvMBPlErbF96qKDvra50YV4KMUNiAGGxP2
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:108d:b0:dc2:65db:1d5e with SMTP id
 v13-20020a056902108d00b00dc265db1d5emr495734ybu.13.1706190072161; Thu, 25 Jan
 2024 05:41:12 -0800 (PST)
Date: Thu, 25 Jan 2024 14:40:59 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3459; i=ardb@kernel.org;
 h=from:subject; bh=Y0sUbFiOgoOcsmNvXTMynncOEh1ZqMy2nPZhSQVJ/ck=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXVTyuuTVYWiJgXqvK+jDn2IvM3w+7D0Iua0C20797nbv
 HWaw3eno5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkQSEjw/+GW2sNb3lYTH29
 Ts1MVM57ltWuFJWYNzqrtDZ7vPu75Ssjw+wo5tlLXh2SF//Yv+io99oI6UMrUsQTTRRydh54aP9 BkAcA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125134058.2076660-2-ardb+git@google.com>
Subject: [PATCH] x86/efi: Remap kernel code read-only before dropping NX attribute
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: pjones@redhat.com, jan.setjeeilers@oracle.com, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Currently, the EFI stub strips the NX restriction from the entire loaded
kernel. It would be better to only apply this change to the part of the
kernel that will actually execute from the firmware's 1:1 mapping of
memory, and make this region read-only first, rather than relying on
memory with RWX mappings before calling ExitBootServices().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
Note that this patch relies on some non-trivial rework of the early 1:1
init code, which was necessary for unrelated reasons.

https://lkml.kernel.org/r/20240125112818.2016733-19-ardb%2Bgit%40google.com

 arch/x86/boot/compressed/Makefile       | 2 +-
 arch/x86/boot/compressed/misc.c         | 1 +
 arch/x86/include/asm/boot.h             | 1 +
 drivers/firmware/efi/libstub/x86-stub.c | 4 +++-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index bccee07eae60..75c0b0be9685 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -84,7 +84,7 @@ LDFLAGS_vmlinux += -T
 hostprogs	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
-sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABbCDGRSTtVW] \(_text\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
+sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABbCDGRrSTtVW] \(_text\|__end_rodata_aligned\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
 
 quiet_cmd_voffset = VOFFSET $@
       cmd_voffset = $(NM) $< | sed -n $(sed-voffset) > $@
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b99e08e6815b..71c8415ee62e 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -330,6 +330,7 @@ static size_t parse_elf(void *output)
 	return ehdr.e_entry - LOAD_PHYSICAL_ADDR;
 }
 
+const unsigned long kernel_ro_size = VO___end_rodata_aligned - VO__text;
 const unsigned long kernel_total_size = VO__end - VO__text;
 
 static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index a38cc0afc90a..852adf628067 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -81,6 +81,7 @@
 
 #ifndef __ASSEMBLY__
 extern unsigned int output_len;
+extern const unsigned long kernel_ro_size;
 extern const unsigned long kernel_total_size;
 
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 0d510c9a06a4..cd05081301c7 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -236,6 +236,8 @@ void efi_adjust_memory_range_protection(unsigned long start,
 	rounded_end = roundup(start + size, EFI_PAGE_SIZE);
 
 	if (memattr != NULL) {
+		efi_call_proto(memattr, set_memory_attributes, rounded_start,
+			       rounded_end - rounded_start, EFI_MEMORY_RO);
 		efi_call_proto(memattr, clear_memory_attributes, rounded_start,
 			       rounded_end - rounded_start, EFI_MEMORY_XP);
 		return;
@@ -805,7 +807,7 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 
 	*kernel_entry = addr + entry;
 
-	efi_adjust_memory_range_protection(addr, kernel_total_size);
+	efi_adjust_memory_range_protection(addr, kernel_ro_size);
 
 	return EFI_SUCCESS;
 }
-- 
2.43.0.429.g432eaa2c6b-goog


