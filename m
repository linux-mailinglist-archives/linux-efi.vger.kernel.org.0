Return-Path: <linux-efi+bounces-706-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84D2870046
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D754283755
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B563638FBC;
	Mon,  4 Mar 2024 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJbn31KO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194F738DF7
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551253; cv=none; b=LchorshjEbFUeXEe46z8ffPg2brTLPWHWzCO+898yeLQTvQSw8aj1KF40UbudGqXTSNQkeKsPYQFt7PPEWd6Z7JvOqYWbqBmHuaPwdMBvhBi23w7NHIBgiLUVJTaRNo2yKuApoPwmxH24gfkNCT4CRbxGs5UtYJjUUgD96ywWm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551253; c=relaxed/simple;
	bh=8OWldvukvmZpWOq8P7oUlDuHoHdvrpus0wKOSakpwtQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oG4TPv+XKlzZJDLneZ+aQFw2Sc7a/S+adQum+8xY1W1bIjo0Drv/rZ38vQptfNK94s6ggWTgJf7rmRO3Dy0w9RlPo3+59mF8onVSIrtGnCrHNTnXLaNusiszNhSXGFdbBTFhRVfgFBDUTYAmKvvaKGAm0YRZtfPVHZCou7e4i/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UJbn31KO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607c9677a91so71433037b3.2
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 03:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551251; x=1710156051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2VMwItLsTNQ1/Piu0UnveJwXB3eNhUp/z91rraupBN4=;
        b=UJbn31KOEoUVHy0AhWG5Hm9OCtYVdab2wgC+mCSe8njAZEse3l8YyY8shThU8RIksi
         X1GymZEoJ5t44oUqrs1TH/1ErZgB6RfMCM0SV7yTk1hvgS2TtniFHNwPSBW2aQfkXeVt
         oPDo2ITIB06QYU6uGR6+MhmBQw/QuEQv4xfzDwlenYze0oXR/iuSIPJ9vOE48oV78Pvm
         VLDoq8ywIyMUkM8WboZbLuDis2Bld4/W41a9QfXj/w5/YAXzIPYj+v1OuBpnxdctTwLD
         b/OdI1dZ/Os0NZCsF3jsqMMWopXaZZEU0tlEdR8M7NpgeNI/X/WPuGgUaC3vwxA9J6rO
         Gvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551251; x=1710156051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2VMwItLsTNQ1/Piu0UnveJwXB3eNhUp/z91rraupBN4=;
        b=XlVCCZynd0z/vF7s+jpKPSaKO0eoN/GX0g74girIRbp4KAhUK6uU2qKB01X0EyS5b0
         l9DlDIsyNkMfd74X9PnWmW/449kaMb0hu7rfcJVbNIt9qlSjJpRbSmgN6JzSFmeEJO/n
         YV1iOG9OR+gWn78msfoRaKzfMh+DQLC3JwW0+DEq6t653MSjGL7VavE2TEzrqdrRCmlm
         O6QQ0dfxxPjPCQ7YePKvtqnilrynRRQGTz4KLpv4oQjpH3wY9JE/7BMCrpYh/fTfGsJR
         jYTDlQP6sNiwf3PbiusLGWwakr/nkTUztUwVXaWQmwnWRXkukULoOhjI3lfQONBuiGWu
         Te4g==
X-Gm-Message-State: AOJu0YzfTHBukO5k48uj00UYPqXqIQ5FP34IJWnLgf9/weh5r332A/VL
	o0djscTPKTBRJxBmO55GPT4AiW6ldN1HvRwAZinqUP7kUytLuVpnCXnW/pxbPt9e3/fUJQ==
X-Google-Smtp-Source: AGHT+IHSHHdFcPDmBUGEGULbdTc1D0bjggDzywnPnpvbnxWw1FbeUWwEctW4kLK3Ceug3jmNDavXCmwo
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:fcd:b0:609:33af:cca8 with SMTP id
 dg13-20020a05690c0fcd00b0060933afcca8mr2555248ywb.2.1709551251233; Mon, 04
 Mar 2024 03:20:51 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:52 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3359; i=ardb@kernel.org;
 h=from:subject; bh=P8OiDo3hIcD2caoAHpBhOy8GahGPOEMqbPhF5JV0ZE4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpusiHU7apaVlW7nrDOJPjpd0SBUkttUUbFlZuWNvm7
 Njc8ulyRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIrSzDP43+ZreO8DOGfzm6
 prb2JZgaSCttqZ//+FiP3EGze6Jcsxl+sycvDf+Z9NOc+9KNg4wVYYf3+c+Y1x6/3+lS87JqoWc XGAE=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-34-ardb+git@google.com>
Subject: [PATCH stable-v6.1 14/18] efi/x86: Avoid physical KASLR on older Dell systems
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 50d7cdf7a9b1ab6f4f74a69c84e974d5dc0c1bf1 upstream ]

River reports boot hangs with v6.6 and v6.7, and the bisect points to
commit

  a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")

which moves the memory allocation and kernel decompression from the
legacy decompressor (which executes *after* ExitBootServices()) to the
EFI stub, using boot services for allocating the memory. The memory
allocation succeeds but the subsequent call to decompress_kernel() never
returns, resulting in a failed boot and a hanging system.

As it turns out, this issue only occurs when physical address
randomization (KASLR) is enabled, and given that this is a feature we
can live without (virtual KASLR is much more important), let's disable
the physical part of KASLR when booting on AMI UEFI firmware claiming to
implement revision v2.0 of the specification (which was released in
2006), as this is the version these systems advertise.

Fixes: a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218173
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 31 +++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 61017921f9ca..47ebc85c0d22 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -273,17 +273,20 @@ void efi_adjust_memory_range_protection(unsigned long start,
 	}
 }
 
+static efi_char16_t *efistub_fw_vendor(void)
+{
+	unsigned long vendor = efi_table_attr(efi_system_table, fw_vendor);
+
+	return (efi_char16_t *)vendor;
+}
+
 static const efi_char16_t apple[] = L"Apple";
 
 static void setup_quirks(struct boot_params *boot_params)
 {
-	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
-		efi_table_attr(efi_system_table, fw_vendor);
-
-	if (!memcmp(fw_vendor, apple, sizeof(apple))) {
-		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
-			retrieve_apple_device_properties(boot_params);
-	}
+	if (IS_ENABLED(CONFIG_APPLE_PROPERTIES) &&
+	    !memcmp(efistub_fw_vendor(), apple, sizeof(apple)))
+		retrieve_apple_device_properties(boot_params);
 }
 
 /*
@@ -759,11 +762,25 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && !efi_nokaslr) {
 		u64 range = KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR - kernel_total_size;
+		static const efi_char16_t ami[] = L"American Megatrends";
 
 		efi_get_seed(seed, sizeof(seed));
 
 		virt_addr += (range * seed[1]) >> 32;
 		virt_addr &= ~(CONFIG_PHYSICAL_ALIGN - 1);
+
+		/*
+		 * Older Dell systems with AMI UEFI firmware v2.0 may hang
+		 * while decompressing the kernel if physical address
+		 * randomization is enabled.
+		 *
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=218173
+		 */
+		if (efi_system_table->hdr.revision <= EFI_2_00_SYSTEM_TABLE_REVISION &&
+		    !memcmp(efistub_fw_vendor(), ami, sizeof(ami))) {
+			efi_debug("AMI firmware v2.0 or older detected - disabling physical KASLR\n");
+			seed[0] = 0;
+		}
 	}
 
 	status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
-- 
2.44.0.278.ge034bb2e1d-goog


