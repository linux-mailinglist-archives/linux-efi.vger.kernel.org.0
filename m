Return-Path: <linux-efi+bounces-2418-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312909F9109
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 12:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5471896B0A
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 11:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA061C4A16;
	Fri, 20 Dec 2024 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z63j0k5M"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEF01C07E4
	for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2024 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734693761; cv=none; b=ALmiLoVoKCVAN5UpHAS4p2Z/UGxgzGzghReTnhQ06zkgGKtZMYhWs0V49Ooe5toyx6ZR2l2gPZ5YVcMVrv0Zzg/TufrarRrHiiI3VDr8tSI/a3c8PuFWYmvIlvu51MkJlel1bbK4kqB6YQhxv4+iwmtc6ol1rzZ27KKYgiSIdOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734693761; c=relaxed/simple;
	bh=aIauqGBYHpW4ez5NfIDLYO5bWWI87u7AWHcSTVi1nKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OpMgjWmLTCmgay2tHj3IjhgfdEJt8VTyI63lUPgPW41lfCOuZQ0lrHU6hyCix77MtyxeiaCDAsE+Akem15bHWgdkC4wQbudFNoyr/yHV634rwdcy1TFpPmIGlD0/QmsecUBKbwpP2wGpy3921LAJ7TsE/27q1F5umccU5EPUlyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z63j0k5M; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43631d8d9c7so10200175e9.1
        for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2024 03:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734693758; x=1735298558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G4YTq/ftOlxzsFyBK5qpik8kRgidp3qaC0bsdTEKQfI=;
        b=Z63j0k5MRKPRnKB855cF0osTjU+cQLYfjz8awGx/5S8yUeOZ871wp/iQYsepTV+D7u
         FESBFzUnj3+ZiAwbppt/YW2HIUNlZRuv9SqwtDHKLI//OCYlaTgiekrH0tcKHPHc8IJK
         kncWxnhOYEXJfDiUE9P1Yn9vmieJDv5OhUs5BO1/e39zjQlKwARFbgHPYAVaJ5TFqGcs
         AlBE00gUo/8jfjQqWO4oTI5i/f7PdhE73ivAMh45jY+MCoVdcS6UVqXMEr+5b6CtjCit
         3AWQkUZqHrypqn+F9/q9HZ1DMn5df2SzZbwpkqctLOHFH02UlO8Gi6GISAegFhF7009K
         AWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734693758; x=1735298558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4YTq/ftOlxzsFyBK5qpik8kRgidp3qaC0bsdTEKQfI=;
        b=fU9CqmHP6+MgQ8A2K/lJM3sU6/w+/jf93F7Cg3i1FpTvDklE7ujtO3eeauqvXURWSE
         ce8jZe9ZqhqA/JFwik6rrrAVVrTP7/f/KTTYGGvTEXIetpBw/BuCTdech5hVXGOXMhJH
         x9hpn2D+jp3W47dFfCvO1jUJk6zKmrKlG7ZS3Jmovi1AEAZ8O5oJr8xqGps1S5BnhKPK
         Eo6QhptxlSOIb3zB0vlw2Ou3TIajBBIVFCQZ4hN5DFTfDHDufvXUP/jm11XH006LHPF2
         OFbmblQHDHMi5lN6dMFE6O9rwI4GDV1lvN1tH37ltQCvjMYTqThc2C71x5xWQbH+u8rx
         bVQQ==
X-Gm-Message-State: AOJu0Yw4FwI46iMU1qU4pL73rh6BE8hRApZQa8euUaIIwqol1ZDfn2sl
	oAMahizI2ooh2VADrnZ7oCjuhvT7B1oZkvuBQlhoyiv/25XGkTWsLNd58JvRl58bkmRJL+Gf19w
	V9qHazp6/sx8lR1rFc/dfY/eQ1ACgyek1Yyvj/Wnalm0vrWjvrnhpUK+TZ+oZLY4wpr8xAxyws2
	gXUeW2ArD9VDJsVQjaQeeo6/+R5A==
X-Google-Smtp-Source: AGHT+IEFIi4SExocJjw8kszjhCQw70qFejd1sU8fWDynz2b6RMGHYdSgLx1AafOwUuQhZpTI//tUZJaS
X-Received: from wmbjj16.prod.google.com ([2002:a05:600c:6a10:b0:434:e9fe:f913])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b8c:b0:434:ff08:202e
 with SMTP id 5b1f17b1804b1-436699ff9famr20916095e9.8.1734693758603; Fri, 20
 Dec 2024 03:22:38 -0800 (PST)
Date: Fri, 20 Dec 2024 12:22:16 +0100
In-Reply-To: <20241220112214.2598872-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241220112214.2598872-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6232; i=ardb@kernel.org;
 h=from:subject; bh=cMbTqyf6fcVFSGOV1gvDHpolf1J3659U3OaWiXwGbLI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT01ONP46G6h5UVddxZM8VPZ1L0k90xTVue95YYxeqGtg
 c0ZdUEdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCIHxBh+s/8+VDZdZuvPlDiJ
 B13pp9/GT3l3KSzNLLA700DqcOjNUIa/oj8bC14ej7XfYPF4q1BbP0/EylObXM+Khuo4xkz8zT6 PBQA=
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241220112214.2598872-10-ardb+git@google.com>
Subject: [PATCH 1/7] x86/efistub: Drop long obsolete UGA support
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

UGA is the EFI graphical output protocol that preceded GOP, and has been
long obsolete. Drop support for it from the x86 implementation of the
EFI stub - other architectures never bothered to implement it (save for
ia64)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi.c             |  2 -
 drivers/firmware/efi/libstub/x86-stub.c | 90 --------------------
 include/linux/efi.h                     |  2 -
 3 files changed, 94 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index a7ff189421c3..41fc2254f007 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -60,7 +60,6 @@ static unsigned long efi_runtime, efi_nr_tables;
 unsigned long efi_fw_vendor, efi_config_table;
 
 static const efi_config_table_type_t arch_tables[] __initconst = {
-	{UGA_IO_PROTOCOL_GUID,		&uga_phys,		"UGA"		},
 #ifdef CONFIG_X86_UV
 	{UV_SYSTEM_TABLE_GUID,		&uv_systab_phys,	"UVsystab"	},
 #endif
@@ -72,7 +71,6 @@ static const unsigned long * const efi_tables[] = {
 	&efi.acpi20,
 	&efi.smbios,
 	&efi.smbios3,
-	&uga_phys,
 #ifdef CONFIG_X86_UV
 	&uv_systab_phys,
 #endif
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 188c8000d245..0c51d8307000 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -405,96 +405,13 @@ static void setup_quirks(struct boot_params *boot_params)
 	}
 }
 
-/*
- * See if we have Universal Graphics Adapter (UGA) protocol
- */
-static efi_status_t
-setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
-{
-	efi_status_t status;
-	u32 width, height;
-	void **uga_handle = NULL;
-	efi_uga_draw_protocol_t *uga = NULL, *first_uga;
-	efi_handle_t handle;
-	int i;
-
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
-			     (void **)&uga_handle);
-	if (status != EFI_SUCCESS)
-		return status;
-
-	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
-			     uga_proto, NULL, &size, uga_handle);
-	if (status != EFI_SUCCESS)
-		goto free_handle;
-
-	height = 0;
-	width = 0;
-
-	first_uga = NULL;
-	for_each_efi_handle(handle, uga_handle, size, i) {
-		efi_guid_t pciio_proto = EFI_PCI_IO_PROTOCOL_GUID;
-		u32 w, h, depth, refresh;
-		void *pciio;
-
-		status = efi_bs_call(handle_protocol, handle, uga_proto,
-				     (void **)&uga);
-		if (status != EFI_SUCCESS)
-			continue;
-
-		pciio = NULL;
-		efi_bs_call(handle_protocol, handle, &pciio_proto, &pciio);
-
-		status = efi_call_proto(uga, get_mode, &w, &h, &depth, &refresh);
-		if (status == EFI_SUCCESS && (!first_uga || pciio)) {
-			width = w;
-			height = h;
-
-			/*
-			 * Once we've found a UGA supporting PCIIO,
-			 * don't bother looking any further.
-			 */
-			if (pciio)
-				break;
-
-			first_uga = uga;
-		}
-	}
-
-	if (!width && !height)
-		goto free_handle;
-
-	/* EFI framebuffer */
-	si->orig_video_isVGA	= VIDEO_TYPE_EFI;
-
-	si->lfb_depth		= 32;
-	si->lfb_width		= width;
-	si->lfb_height		= height;
-
-	si->red_size		= 8;
-	si->red_pos		= 16;
-	si->green_size		= 8;
-	si->green_pos		= 8;
-	si->blue_size		= 8;
-	si->blue_pos		= 0;
-	si->rsvd_size		= 8;
-	si->rsvd_pos		= 24;
-
-free_handle:
-	efi_bs_call(free_pool, uga_handle);
-
-	return status;
-}
-
 static void setup_graphics(struct boot_params *boot_params)
 {
 	efi_guid_t graphics_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
 	struct screen_info *si;
-	efi_guid_t uga_proto = EFI_UGA_PROTOCOL_GUID;
 	efi_status_t status;
 	unsigned long size;
 	void **gop_handle = NULL;
-	void **uga_handle = NULL;
 
 	si = &boot_params->screen_info;
 	memset(si, 0, sizeof(*si));
@@ -505,13 +422,6 @@ static void setup_graphics(struct boot_params *boot_params)
 	if (status == EFI_BUFFER_TOO_SMALL)
 		status = efi_setup_gop(si, &graphics_proto, size);
 
-	if (status != EFI_SUCCESS) {
-		size = 0;
-		status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
-				     &uga_proto, NULL, &size, uga_handle);
-		if (status == EFI_BUFFER_TOO_SMALL)
-			setup_uga(si, &uga_proto, size);
-	}
 }
 
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index e5815867aba9..234200469146 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -363,7 +363,6 @@ void efi_native_runtime_setup(void);
 #define ACPI_20_TABLE_GUID			EFI_GUID(0x8868e871, 0xe4f1, 0x11d3,  0xbc, 0x22, 0x00, 0x80, 0xc7, 0x3c, 0x88, 0x81)
 #define SMBIOS_TABLE_GUID			EFI_GUID(0xeb9d2d31, 0x2d88, 0x11d3,  0x9a, 0x16, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
 #define SMBIOS3_TABLE_GUID			EFI_GUID(0xf2fd1544, 0x9794, 0x4a2c,  0x99, 0x2e, 0xe5, 0xbb, 0xcf, 0x20, 0xe3, 0x94)
-#define UGA_IO_PROTOCOL_GUID			EFI_GUID(0x61a4d49e, 0x6f68, 0x4f1b,  0xb9, 0x22, 0xa8, 0x6e, 0xed, 0x0b, 0x07, 0xa2)
 #define EFI_GLOBAL_VARIABLE_GUID		EFI_GUID(0x8be4df61, 0x93ca, 0x11d2,  0xaa, 0x0d, 0x00, 0xe0, 0x98, 0x03, 0x2b, 0x8c)
 #define UV_SYSTEM_TABLE_GUID			EFI_GUID(0x3b13a7d4, 0x633e, 0x11dd,  0x93, 0xec, 0xda, 0x25, 0x56, 0xd8, 0x95, 0x93)
 #define LINUX_EFI_CRASH_GUID			EFI_GUID(0xcfc8fc79, 0xbe2e, 0x4ddc,  0x97, 0xf0, 0x9f, 0x98, 0xbf, 0xe2, 0x98, 0xa0)
@@ -373,7 +372,6 @@ void efi_native_runtime_setup(void);
 #define EFI_DEVICE_PATH_TO_TEXT_PROTOCOL_GUID	EFI_GUID(0x8b843e20, 0x8132, 0x4852,  0x90, 0xcc, 0x55, 0x1a, 0x4e, 0x4a, 0x7f, 0x1c)
 #define EFI_DEVICE_PATH_FROM_TEXT_PROTOCOL_GUID	EFI_GUID(0x05c99a21, 0xc70f, 0x4ad2,  0x8a, 0x5f, 0x35, 0xdf, 0x33, 0x43, 0xf5, 0x1e)
 #define EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID	EFI_GUID(0x9042a9de, 0x23dc, 0x4a38,  0x96, 0xfb, 0x7a, 0xde, 0xd0, 0x80, 0x51, 0x6a)
-#define EFI_UGA_PROTOCOL_GUID			EFI_GUID(0x982c298b, 0xf4fa, 0x41cb,  0xb8, 0x38, 0x77, 0xaa, 0x68, 0x8f, 0xb8, 0x39)
 #define EFI_PCI_IO_PROTOCOL_GUID		EFI_GUID(0x4cf5b200, 0x68b8, 0x4ca5,  0x9e, 0xec, 0xb2, 0x3e, 0x3f, 0x50, 0x02, 0x9a)
 #define EFI_FILE_INFO_ID			EFI_GUID(0x09576e92, 0x6d3f, 0x11d2,  0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
 #define EFI_SYSTEM_RESOURCE_TABLE_GUID		EFI_GUID(0xb122a263, 0x3661, 0x4f68,  0x99, 0x29, 0x78, 0xf8, 0xb0, 0xd6, 0x21, 0x80)
-- 
2.47.1.613.gc27f4b7a9f-goog


