Return-Path: <linux-efi+bounces-703-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3AC87003F
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0121F281ECA
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435D43984F;
	Mon,  4 Mar 2024 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3eYZKraX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C10937157
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551247; cv=none; b=n6yjE2HFh43LsjYhLI1TG9xuJigHE05Fsqwbd6QpZ29A9TWViOwgrazsVOODyWtu0QyTbS7uWHZjnnxlPLRKpelhln4YDR7jYyRXAWXdFMOVhSHRGaIMW1REkla82AZKTfpsGEWRvsPN144x1unOgWLU0iDgjrbxWI/JAa931Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551247; c=relaxed/simple;
	bh=2YRqf7C7z8liqqmWEbngC2mjZ4UbBAhViA0W1TkZKn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r80nOgF6J76mq6ZkFYZxgDYHd43s6yDX0M08u1+K8lXk2ni5J/7m8U6Q7xwW56UvU5t27DkHUnDB0wa92DRMRsE7E0pigecVjBI8bklBQd4MCCCec1m25DleuO0XybUqlZMZAoecbZF3UKPbVRIuKqlE7rBScRnWTwMspp9dRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3eYZKraX; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-412c9e3c9b9so13390455e9.0
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 03:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551244; x=1710156044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h+mDWGDNfb7c6RNZ5sMw7NZUyybd0XgmzdynTa9PTho=;
        b=3eYZKraXR1YpJWh7gc0FDbaZ30mk5a5qwdcl4YiwRpmaxld5dYsiwprgM/YEJkiTv8
         1W264Uf1julcWeU7S3bh9Pm3hhjMH0roBqBlC1K41ddATO8sgOIH1UzmsfMa24HvEpjB
         Ig0K86GXr+j24Br+npuPVATrqlWcK5mC4SVhXngASpspthgBjKeCS+HY4uFnoGl1Wx99
         dS6+nvPfi9q/dab/wmldO1pJJTfBSOgAiSVnYnN8+vhUUk1cUbuu25c2Dea37FFIkd+E
         OoN3CW0WIvauc1rEcdHvjpo19XuUc5RJ1ff0i1hqdj0+eJQXNCvE5Z0Z4+4gA2tGBVuS
         UX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551244; x=1710156044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+mDWGDNfb7c6RNZ5sMw7NZUyybd0XgmzdynTa9PTho=;
        b=cg+y5MY6MBSDRsoaPDbjcncR/dpxN+QvLtZleho7vGsMELE6inVQoNtaIwCIQ6yhV2
         1nT5FuodE1aHJJJqD0Pm+aVzu4hAQaRmgj00n3FXFMv1E3Lkj1zkw5Z212ywOcXcFr3V
         D+4Ya25eadSiF7uGHwjR1CG96vF4YOgeE7AbXVNXiZzElwYed41FMCSZgVY7BeqAAJ4y
         f//sZiAfFL6yuybb77o/ipawBoxXrO3zPJbZ/pmPO2g7dbPMzlBCCKlcRxczeTPr7z6U
         Rj/KMWEboDj6lHImjOZBy3ahQP5IvkFJczVg97jAveRwpWY6qOY1fFnSdGC3F5QxBp7Q
         Bbng==
X-Gm-Message-State: AOJu0Yy8INFREhSrgTkwiB0o+Q3oxA3/VpwYGIe3+uyLj2USTwxHaX/P
	OcnmWZd0to5Ph3ddthHEuYjVUXmVkGEZ6zAmKO/KuGDSYz4/UtngYeO6mB7XHPBUT86qFQ==
X-Google-Smtp-Source: AGHT+IFHvnkqE+udJAl+Z7DWwseV2RuAWWKME5rPAqMPXaoEvR5I7YVSSsS2AsF67NWjx1vt5sGImlUK
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:21d1:b0:412:e55e:290a with SMTP id
 x17-20020a05600c21d100b00412e55e290amr42899wmj.1.1709551244062; Mon, 04 Mar
 2024 03:20:44 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:49 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3560; i=ardb@kernel.org;
 h=from:subject; bh=l1viORQ4TuoNJ3blqVcyO9JUifcv9cebCbX/oNGqapc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpulDP/zcts/iidfm3B97Z8/2Q5vz2c99WSlsvtgoWi
 5f5souvo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwkZyHD/yoPzSsB2/4fUDJt
 Ppk/Yc+TqLNbJux4FP32wYvJ1ep3v4QyMny63q+54EpQe+mOfyx+crEm2z29S3qehVXOvVyzXT7 1Gz8A
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-31-ardb+git@google.com>
Subject: [PATCH stable-v6.1 11/18] x86/efistub: Prefer EFI memory attributes
 protocol over DXE services
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 11078876b7a6a1b7226344fecab968945c806832 upstream ]

Currently, the EFI stub relies on DXE services in some cases to clear
non-execute restrictions from page allocations that need to be
executable. This is dodgy, because DXE services are not specified by
UEFI but by PI, and they are not intended for consumption by OS loaders.
However, no alternative existed at the time.

Now, there is a new UEFI protocol that should be used instead, so if it
exists, prefer it over the DXE services calls.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-18-ardb@kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 29 ++++++++++++++------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index adaddd38d97d..01af018b9315 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -26,6 +26,7 @@ const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
 u32 image_offset __section(".data");
 static efi_loaded_image_t *image = NULL;
+static efi_memory_attribute_protocol_t *memattr;
 
 static efi_status_t
 preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
@@ -222,12 +223,18 @@ void efi_adjust_memory_range_protection(unsigned long start,
 	unsigned long rounded_start, rounded_end;
 	unsigned long unprotect_start, unprotect_size;
 
-	if (efi_dxe_table == NULL)
-		return;
-
 	rounded_start = rounddown(start, EFI_PAGE_SIZE);
 	rounded_end = roundup(start + size, EFI_PAGE_SIZE);
 
+	if (memattr != NULL) {
+		efi_call_proto(memattr, clear_memory_attributes, rounded_start,
+			       rounded_end - rounded_start, EFI_MEMORY_XP);
+		return;
+	}
+
+	if (efi_dxe_table == NULL)
+		return;
+
 	/*
 	 * Don't modify memory region attributes, they are
 	 * already suitable, to lower the possibility to
@@ -758,6 +765,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 			       efi_system_table_t *sys_table_arg,
 			       struct boot_params *boot_params)
 {
+	efi_guid_t guid = EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID;
 	unsigned long bzimage_addr = (unsigned long)startup_32;
 	unsigned long buffer_start, buffer_end;
 	struct setup_header *hdr = &boot_params->hdr;
@@ -769,13 +777,18 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		efi_exit(handle, EFI_INVALID_PARAMETER);
 
-	efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
-	if (efi_dxe_table &&
-	    efi_dxe_table->hdr.signature != EFI_DXE_SERVICES_TABLE_SIGNATURE) {
-		efi_warn("Ignoring DXE services table: invalid signature\n");
-		efi_dxe_table = NULL;
+	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {
+		efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
+		if (efi_dxe_table &&
+		    efi_dxe_table->hdr.signature != EFI_DXE_SERVICES_TABLE_SIGNATURE) {
+			efi_warn("Ignoring DXE services table: invalid signature\n");
+			efi_dxe_table = NULL;
+		}
 	}
 
+	/* grab the memory attributes protocol if it exists */
+	efi_bs_call(locate_protocol, &guid, NULL, (void **)&memattr);
+
 	status = efi_setup_5level_paging();
 	if (status != EFI_SUCCESS) {
 		efi_err("efi_setup_5level_paging() failed!\n");
-- 
2.44.0.278.ge034bb2e1d-goog


