Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 617EF175447
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 08:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCBHK3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Mar 2020 02:10:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32940 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBHK3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Mar 2020 02:10:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id a25so1809195wmm.0;
        Sun, 01 Mar 2020 23:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ofOypCruFLY+RzekRLP/cwypomBwPG/ybo11TWcSycM=;
        b=TRqrUcIrKFdDwWseg6HOEW8i3BT79a7e7DdYFrNeUzl24kFv2199mEtCCzGSlc6QV/
         jGSmXDJCEPZ2Hqrg0VjF6+gDIEIzz5yVOE+kXrVnBb2rrcv6jNQvNwJAegQYvymKMHSY
         eBHnEXUJXWP5WyhfroT0cqhoJJGFZHrBmeGBiOaRsIYgy7KeId1toSnsHsABL0OgNG90
         b56553DIjKKreBuGKXB5A3HWaHxM6Ly4NoeHSUaSQ8FxN8kpxg7lv9ghFi0s08oEwCMO
         2DjdD//9aEcLaFP1Yd4+FJfl2LB9X4eYc0TqFl7qshui9VQZzaXwXlIsZxR13cqlWzR2
         OE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ofOypCruFLY+RzekRLP/cwypomBwPG/ybo11TWcSycM=;
        b=QJpK6EGV0ArHzgTDBseDUcF8y8Q5Y5BeYSvJj02rTSL/6UOMoapys9FuwnQaxZekKm
         e/FqH9kPBoC9uBM9sv11LZmkygFG01pVt6ui34Lnzp7FumsvPTQo7jOA+OI1VoAgzIVU
         Av5f8729o0C3ZjrrcoDWYRcO5ULVlMWCdz7LAMTCaESTxa+kTYdj8SOMI3V05zfTARG3
         mPcRagkjBfh3ZuAPwX+DekRiob1EUxfp550k2US9Upi3+/PWOWCQWie29g53CHFrJDpl
         PoXdAc64pxZ4A+C/MaNfVrNPbr9HTGAAn8GpZ88+NCdcEcliotMZg36UBnWT2ILTDVxv
         Aq1g==
X-Gm-Message-State: APjAAAXB4o1c2YTUEbcIL5EfdYBS0lO3L8Tm0lFM1m7nPnWBVn3yPL9I
        uxK3Q5Dty8AbgLvnTAP1Jh2CGzRw
X-Google-Smtp-Source: APXvYqyOxb8oIOp8G8Fj6ES5vYXXDyvTXtX2NK8hfoEvNobIWEkYwD3jYwB46IZmK0CfVe3bxaEAZg==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr17520202wme.125.1583133026406;
        Sun, 01 Mar 2020 23:10:26 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c2sm14239053wma.39.2020.03.01.23.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 23:10:25 -0800 (PST)
Date:   Mon, 2 Mar 2020 08:10:23 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [GIT PULL] EFI fixes
Message-ID: <20200302071023.GA7775@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


Linus,

Please pull the latest efi-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

   # HEAD: be36f9e7517e17810ec369626a128d7948942259 efi: READ_ONCE rng seed size before munmap


Three fixes to EFI mixed boot mode, mostly related to x86-64 vmap stacks 
activated years ago, bug-fixed recently for EFI, which had knock-on 
effects of various 1:1 mapping assumptions in mixed mode.

There's also a READ_ONCE() fix for reading an mmap-ed EFI firmware data 
field only once, out of caution.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (3):
      efi/x86: Align GUIDs to their size in the mixed mode runtime wrapper
      efi/x86: Remove support for EFI time and counter services in mixed mode
      efi/x86: Handle by-ref arguments covering multiple pages in mixed mode

Jason A. Donenfeld (1):
      efi: READ_ONCE rng seed size before munmap


 arch/x86/platform/efi/efi_64.c | 151 ++++++++++++++---------------------------
 drivers/firmware/efi/efi.c     |   4 +-
 2 files changed, 54 insertions(+), 101 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index fa8506e76bbe..d19a2edd63cb 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -180,7 +180,7 @@ void efi_sync_low_kernel_mappings(void)
 static inline phys_addr_t
 virt_to_phys_or_null_size(void *va, unsigned long size)
 {
-	bool bad_size;
+	phys_addr_t pa;
 
 	if (!va)
 		return 0;
@@ -188,16 +188,13 @@ virt_to_phys_or_null_size(void *va, unsigned long size)
 	if (virt_addr_valid(va))
 		return virt_to_phys(va);
 
-	/*
-	 * A fully aligned variable on the stack is guaranteed not to
-	 * cross a page bounary. Try to catch strings on the stack by
-	 * checking that 'size' is a power of two.
-	 */
-	bad_size = size > PAGE_SIZE || !is_power_of_2(size);
+	pa = slow_virt_to_phys(va);
 
-	WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
+	/* check if the object crosses a page boundary */
+	if (WARN_ON((pa ^ (pa + size - 1)) & PAGE_MASK))
+		return 0;
 
-	return slow_virt_to_phys(va);
+	return pa;
 }
 
 #define virt_to_phys_or_null(addr)				\
@@ -568,85 +565,25 @@ efi_thunk_set_virtual_address_map(unsigned long memory_map_size,
 
 static efi_status_t efi_thunk_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 {
-	efi_status_t status;
-	u32 phys_tm, phys_tc;
-	unsigned long flags;
-
-	spin_lock(&rtc_lock);
-	spin_lock_irqsave(&efi_runtime_lock, flags);
-
-	phys_tm = virt_to_phys_or_null(tm);
-	phys_tc = virt_to_phys_or_null(tc);
-
-	status = efi_thunk(get_time, phys_tm, phys_tc);
-
-	spin_unlock_irqrestore(&efi_runtime_lock, flags);
-	spin_unlock(&rtc_lock);
-
-	return status;
+	return EFI_UNSUPPORTED;
 }
 
 static efi_status_t efi_thunk_set_time(efi_time_t *tm)
 {
-	efi_status_t status;
-	u32 phys_tm;
-	unsigned long flags;
-
-	spin_lock(&rtc_lock);
-	spin_lock_irqsave(&efi_runtime_lock, flags);
-
-	phys_tm = virt_to_phys_or_null(tm);
-
-	status = efi_thunk(set_time, phys_tm);
-
-	spin_unlock_irqrestore(&efi_runtime_lock, flags);
-	spin_unlock(&rtc_lock);
-
-	return status;
+	return EFI_UNSUPPORTED;
 }
 
 static efi_status_t
 efi_thunk_get_wakeup_time(efi_bool_t *enabled, efi_bool_t *pending,
 			  efi_time_t *tm)
 {
-	efi_status_t status;
-	u32 phys_enabled, phys_pending, phys_tm;
-	unsigned long flags;
-
-	spin_lock(&rtc_lock);
-	spin_lock_irqsave(&efi_runtime_lock, flags);
-
-	phys_enabled = virt_to_phys_or_null(enabled);
-	phys_pending = virt_to_phys_or_null(pending);
-	phys_tm = virt_to_phys_or_null(tm);
-
-	status = efi_thunk(get_wakeup_time, phys_enabled,
-			     phys_pending, phys_tm);
-
-	spin_unlock_irqrestore(&efi_runtime_lock, flags);
-	spin_unlock(&rtc_lock);
-
-	return status;
+	return EFI_UNSUPPORTED;
 }
 
 static efi_status_t
 efi_thunk_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
 {
-	efi_status_t status;
-	u32 phys_tm;
-	unsigned long flags;
-
-	spin_lock(&rtc_lock);
-	spin_lock_irqsave(&efi_runtime_lock, flags);
-
-	phys_tm = virt_to_phys_or_null(tm);
-
-	status = efi_thunk(set_wakeup_time, enabled, phys_tm);
-
-	spin_unlock_irqrestore(&efi_runtime_lock, flags);
-	spin_unlock(&rtc_lock);
-
-	return status;
+	return EFI_UNSUPPORTED;
 }
 
 static unsigned long efi_name_size(efi_char16_t *name)
@@ -658,6 +595,8 @@ static efi_status_t
 efi_thunk_get_variable(efi_char16_t *name, efi_guid_t *vendor,
 		       u32 *attr, unsigned long *data_size, void *data)
 {
+	u8 buf[24] __aligned(8);
+	efi_guid_t *vnd = PTR_ALIGN((efi_guid_t *)buf, sizeof(*vnd));
 	efi_status_t status;
 	u32 phys_name, phys_vendor, phys_attr;
 	u32 phys_data_size, phys_data;
@@ -665,14 +604,19 @@ efi_thunk_get_variable(efi_char16_t *name, efi_guid_t *vendor,
 
 	spin_lock_irqsave(&efi_runtime_lock, flags);
 
+	*vnd = *vendor;
+
 	phys_data_size = virt_to_phys_or_null(data_size);
-	phys_vendor = virt_to_phys_or_null(vendor);
+	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_name = virt_to_phys_or_null_size(name, efi_name_size(name));
 	phys_attr = virt_to_phys_or_null(attr);
 	phys_data = virt_to_phys_or_null_size(data, *data_size);
 
-	status = efi_thunk(get_variable, phys_name, phys_vendor,
-			   phys_attr, phys_data_size, phys_data);
+	if (!phys_name || (data && !phys_data))
+		status = EFI_INVALID_PARAMETER;
+	else
+		status = efi_thunk(get_variable, phys_name, phys_vendor,
+				   phys_attr, phys_data_size, phys_data);
 
 	spin_unlock_irqrestore(&efi_runtime_lock, flags);
 
@@ -683,19 +627,25 @@ static efi_status_t
 efi_thunk_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 		       u32 attr, unsigned long data_size, void *data)
 {
+	u8 buf[24] __aligned(8);
+	efi_guid_t *vnd = PTR_ALIGN((efi_guid_t *)buf, sizeof(*vnd));
 	u32 phys_name, phys_vendor, phys_data;
 	efi_status_t status;
 	unsigned long flags;
 
 	spin_lock_irqsave(&efi_runtime_lock, flags);
 
+	*vnd = *vendor;
+
 	phys_name = virt_to_phys_or_null_size(name, efi_name_size(name));
-	phys_vendor = virt_to_phys_or_null(vendor);
+	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_data = virt_to_phys_or_null_size(data, data_size);
 
-	/* If data_size is > sizeof(u32) we've got problems */
-	status = efi_thunk(set_variable, phys_name, phys_vendor,
-			   attr, data_size, phys_data);
+	if (!phys_name || !phys_data)
+		status = EFI_INVALID_PARAMETER;
+	else
+		status = efi_thunk(set_variable, phys_name, phys_vendor,
+				   attr, data_size, phys_data);
 
 	spin_unlock_irqrestore(&efi_runtime_lock, flags);
 
@@ -707,6 +657,8 @@ efi_thunk_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
 				   u32 attr, unsigned long data_size,
 				   void *data)
 {
+	u8 buf[24] __aligned(8);
+	efi_guid_t *vnd = PTR_ALIGN((efi_guid_t *)buf, sizeof(*vnd));
 	u32 phys_name, phys_vendor, phys_data;
 	efi_status_t status;
 	unsigned long flags;
@@ -714,13 +666,17 @@ efi_thunk_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
 	if (!spin_trylock_irqsave(&efi_runtime_lock, flags))
 		return EFI_NOT_READY;
 
+	*vnd = *vendor;
+
 	phys_name = virt_to_phys_or_null_size(name, efi_name_size(name));
-	phys_vendor = virt_to_phys_or_null(vendor);
+	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_data = virt_to_phys_or_null_size(data, data_size);
 
-	/* If data_size is > sizeof(u32) we've got problems */
-	status = efi_thunk(set_variable, phys_name, phys_vendor,
-			   attr, data_size, phys_data);
+	if (!phys_name || !phys_data)
+		status = EFI_INVALID_PARAMETER;
+	else
+		status = efi_thunk(set_variable, phys_name, phys_vendor,
+				   attr, data_size, phys_data);
 
 	spin_unlock_irqrestore(&efi_runtime_lock, flags);
 
@@ -732,39 +688,36 @@ efi_thunk_get_next_variable(unsigned long *name_size,
 			    efi_char16_t *name,
 			    efi_guid_t *vendor)
 {
+	u8 buf[24] __aligned(8);
+	efi_guid_t *vnd = PTR_ALIGN((efi_guid_t *)buf, sizeof(*vnd));
 	efi_status_t status;
 	u32 phys_name_size, phys_name, phys_vendor;
 	unsigned long flags;
 
 	spin_lock_irqsave(&efi_runtime_lock, flags);
 
+	*vnd = *vendor;
+
 	phys_name_size = virt_to_phys_or_null(name_size);
-	phys_vendor = virt_to_phys_or_null(vendor);
+	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_name = virt_to_phys_or_null_size(name, *name_size);
 
-	status = efi_thunk(get_next_variable, phys_name_size,
-			   phys_name, phys_vendor);
+	if (!phys_name)
+		status = EFI_INVALID_PARAMETER;
+	else
+		status = efi_thunk(get_next_variable, phys_name_size,
+				   phys_name, phys_vendor);
 
 	spin_unlock_irqrestore(&efi_runtime_lock, flags);
 
+	*vendor = *vnd;
 	return status;
 }
 
 static efi_status_t
 efi_thunk_get_next_high_mono_count(u32 *count)
 {
-	efi_status_t status;
-	u32 phys_count;
-	unsigned long flags;
-
-	spin_lock_irqsave(&efi_runtime_lock, flags);
-
-	phys_count = virt_to_phys_or_null(count);
-	status = efi_thunk(get_next_high_mono_count, phys_count);
-
-	spin_unlock_irqrestore(&efi_runtime_lock, flags);
-
-	return status;
+	return EFI_UNSUPPORTED;
 }
 
 static void
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 621220ab3d0e..21ea99f65113 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -552,7 +552,7 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 
 		seed = early_memremap(efi.rng_seed, sizeof(*seed));
 		if (seed != NULL) {
-			size = seed->size;
+			size = READ_ONCE(seed->size);
 			early_memunmap(seed, sizeof(*seed));
 		} else {
 			pr_err("Could not map UEFI random seed!\n");
@@ -562,7 +562,7 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 					      sizeof(*seed) + size);
 			if (seed != NULL) {
 				pr_notice("seeding entropy pool\n");
-				add_bootloader_randomness(seed->bits, seed->size);
+				add_bootloader_randomness(seed->bits, size);
 				early_memunmap(seed, sizeof(*seed) + size);
 			} else {
 				pr_err("Could not map UEFI random seed!\n");
