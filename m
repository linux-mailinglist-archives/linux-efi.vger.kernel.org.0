Return-Path: <linux-efi+bounces-2420-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CD29F910D
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 12:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3ACE16C1AC
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 11:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1F41C5F14;
	Fri, 20 Dec 2024 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rYENQi76"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EDD1C5CCA
	for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2024 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734693766; cv=none; b=XNBwO0+ZU9y/C2Ic1NcC9nkgGqP86eejilcfFOJ/h6G8phvzfhVS1B8T0R0+ZlZvsZSbHE3RTqvU4lfdc3XCkBVnno/fK84R0O821tVI0NVzisAC2GyZjqFlYd2+5RiSH3R0LoZzhCllQvhOqLWOm5aGzEybTe3AitXXCOAb21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734693766; c=relaxed/simple;
	bh=0KQw1DNiKBnqryYgDBurqGjOmCFqhEOFJLSA0mjA9yk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PNCXqOvaW9bpMWEM3oe3FjIKYSV9StQL9yYNIKGyQb5sEcBLQacGm0H7A6tUCMVdL63inirH2TT2iboowB15B/JQMasJcuBafWKQxSnWcmKbVKgMIeSaioH5y2vdWLSHWdcBUC7j56mzEe4ws3tniu1Hsogdo7LtQXVo5YI5ZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rYENQi76; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3860bc1d4f1so1079197f8f.2
        for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2024 03:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734693763; x=1735298563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cNSJ8HGXQNdXuP3+AktVsISDb7HTO/BmfoYSJrTO9ls=;
        b=rYENQi764ppB9qdKmb3cVHJwbk9CS5trZZssQlYrh6SIw2yp8PCImG1R+Z9a/5Xfoc
         9QivdlG4h1pIQcV3N8RyWfl74nLIF4hDXPWqrBr+ZkYZ4cMIQBNmMlDUw8TqbPM5oU7j
         gYTmk3ioxFL4HcBwGolh7i5y1e8+CiqwYFPcfPtMQPwksNvWrPWEnnqwCaeNBbfgDJto
         Rzd8A4ykPeVYwteBPAa2P17TkGha6Pbl5qD3aYN08epGQx16nlbz+LlXDM+b04S0GUut
         6St6KNq6hv+oHY/enJLEo9mgUGdKjG9x/Yx9sklm4XJrWO3oFCCbITKBmrfEhWe0zPZE
         0dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734693763; x=1735298563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNSJ8HGXQNdXuP3+AktVsISDb7HTO/BmfoYSJrTO9ls=;
        b=PnjXdN9nWgkBu6v4iZ/aUywzYVxN720mcVEmomRqYIDKranTPCcASp68x3W2cFLmX2
         JgkmBXph6NkWLm2GitxyRTcZ/3yXSXKI/3NKErFyJbWQ6L68MKFUMSAnT+g5SMmIMYlA
         yMYR9/gsyGKo3e7arpWU6bJZpWlcTSCMMwkmUg/jVTQt8W51e+BliC3iyR4svyA6y0z1
         vy/T9LEJ2TliY+ahA8CqQ9iZunuE2oF5ViqoXZB1EZxhJIp//vlCMJIrNZnJswV3rtXB
         iZdx4tZekz56wcxhU9iGI6fdVe9Wwshhl5zspBaQgJAR2sqcO478SMHmVwxn/sz6CYkU
         00sQ==
X-Gm-Message-State: AOJu0YxR8VdtGY0itIC2vtaPmPXsTKdfIlth3GvsW6pu6UF5pnfaYybt
	DcJl5LqMkKrQ9cgXfWXAE4bbzpWr6IhL09LBS+pvtgF4mRvql078ZDYlKF76WFmLQroGPmglNUA
	1iwRE0rCirGHN6M4v9jW0XPuHcDN1G4FbI/AfcJNcC+XGGyep71d7RQ5Ksq48alBIuRZlJBadrK
	6hfRAxEwN2kzS6/Jn59DY5+2vtmQ==
X-Google-Smtp-Source: AGHT+IF8zUGLe6aA2WdSo/5UrRsQij4BJK0HhPCJwGp9RoMVXlZcaAC1wTrHc2l53LJ8kJfl0nK1b59/
X-Received: from wmbjj20.prod.google.com ([2002:a05:600c:6a14:b0:434:fc6f:e8c3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:598d:0:b0:385:fa3d:1988
 with SMTP id ffacd0b85a97d-38a221e2f07mr2467165f8f.8.1734693762878; Fri, 20
 Dec 2024 03:22:42 -0800 (PST)
Date: Fri, 20 Dec 2024 12:22:18 +0100
In-Reply-To: <20241220112214.2598872-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241220112214.2598872-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7976; i=ardb@kernel.org;
 h=from:subject; bh=rYysZblB1Mm5gOU2h843vOCeOHNVXYgW6tmjcsWmdn4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT01OKdZpLkvZuGDufPfx9nHCtw4YLRe0ru3vV+PWW7zh
 4tsL/I6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQ0ExgZ1mW/9uJOZp4wS+K2
 /MOjMZ8WZrzzdom/e/L5qTszXn2eP4Xhf2nXgi9Cvpc7pjXVHbqlLKl2zyx66jFRkV99wVoyBjb 7eAA=
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241220112214.2598872-12-ardb+git@google.com>
Subject: [PATCH 3/7] efi/libstub: Simplify GOP handling code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Use the LocateHandleBuffer() API and a __free() function to simplify the
logic that allocates a handle buffer to iterate over all GOP protocols
in the EFI database.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h              |  3 ++
 drivers/firmware/efi/libstub/efi-stub.c | 28 ++++------
 drivers/firmware/efi/libstub/efistub.h  |  7 +--
 drivers/firmware/efi/libstub/gop.c      | 57 +++++++-------------
 drivers/firmware/efi/libstub/x86-stub.c | 17 +-----
 5 files changed, 38 insertions(+), 74 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 521aad70e41b..f227a70ac91f 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -250,6 +250,9 @@ static inline u32 efi64_convert_status(efi_status_t status)
 #define __efi64_argmap_allocate_pool(type, size, buffer)		\
 	((type), (size), efi64_zero_upper(buffer))
 
+#define __efi64_argmap_locate_handle_buffer(type, proto, key, num, buf)	\
+	((type), (proto), (key), efi64_zero_upper(num), efi64_zero_upper(buf))
+
 #define __efi64_argmap_create_event(type, tpl, f, c, event)		\
 	((type), (tpl), (f), (c), efi64_zero_upper(event))
 
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 382b54f40603..90e06a6b1a45 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/efi.h>
+#include <linux/screen_info.h>
 #include <asm/efi.h>
 
 #include "efistub.h"
@@ -53,25 +54,16 @@ void __weak free_screen_info(struct screen_info *si)
 
 static struct screen_info *setup_graphics(void)
 {
-	efi_guid_t gop_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
-	efi_status_t status;
-	unsigned long size;
-	void **gop_handle = NULL;
-	struct screen_info *si = NULL;
+	struct screen_info *si, tmp = {};
 
-	size = 0;
-	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
-			     &gop_proto, NULL, &size, gop_handle);
-	if (status == EFI_BUFFER_TOO_SMALL) {
-		si = alloc_screen_info();
-		if (!si)
-			return NULL;
-		status = efi_setup_gop(si, &gop_proto, size);
-		if (status != EFI_SUCCESS) {
-			free_screen_info(si);
-			return NULL;
-		}
-	}
+	if (efi_setup_gop(&tmp) != EFI_SUCCESS)
+		return NULL;
+
+	si = alloc_screen_info();
+	if (!si)
+		return NULL;
+
+	*si = tmp;
 	return si;
 }
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index c321735eb237..a7c24f0a2e5e 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -314,7 +314,9 @@ union efi_boot_services {
 		void *close_protocol;
 		void *open_protocol_information;
 		void *protocols_per_handle;
-		void *locate_handle_buffer;
+		efi_status_t (__efiapi *locate_handle_buffer)(int, efi_guid_t *,
+							      void *, unsigned long *,
+							      efi_handle_t *);
 		efi_status_t (__efiapi *locate_protocol)(efi_guid_t *, void *,
 							 void **);
 		efi_status_t (__efiapi *install_multiple_protocol_interfaces)(efi_handle_t *, ...);
@@ -1083,8 +1085,7 @@ efi_status_t efi_parse_options(char const *cmdline);
 
 void efi_parse_option_graphics(char *option);
 
-efi_status_t efi_setup_gop(struct screen_info *si, efi_guid_t *proto,
-			   unsigned long size);
+efi_status_t efi_setup_gop(struct screen_info *si);
 
 efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 				  const efi_char16_t *optstr,
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 8eef63c48288..fce28488c76c 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -461,25 +461,25 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
 	}
 }
 
-static efi_graphics_output_protocol_t *
-find_gop(efi_guid_t *proto, unsigned long size, void **handles)
+static efi_graphics_output_protocol_t *find_gop(unsigned long num,
+						const efi_handle_t handles[])
 {
 	efi_graphics_output_protocol_t *first_gop;
 	efi_handle_t h;
 
 	first_gop = NULL;
 
-	for_each_efi_handle(h, handles, efi_get_handle_num(size)) {
+	for_each_efi_handle(h, handles, num) {
 		efi_status_t status;
 
 		efi_graphics_output_protocol_t *gop;
 		efi_graphics_output_protocol_mode_t *mode;
 		efi_graphics_output_mode_info_t *info;
-
-		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
 		void *dummy = NULL;
 
-		status = efi_bs_call(handle_protocol, h, proto, (void **)&gop);
+		status = efi_bs_call(handle_protocol, h,
+				     &EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID,
+				     (void **)&gop);
 		if (status != EFI_SUCCESS)
 			continue;
 
@@ -499,7 +499,8 @@ find_gop(efi_guid_t *proto, unsigned long size, void **handles)
 		 * Once we've found a GOP supporting ConOut,
 		 * don't bother looking any further.
 		 */
-		status = efi_bs_call(handle_protocol, h, &conout_proto, &dummy);
+		status = efi_bs_call(handle_protocol, h,
+				     &EFI_CONSOLE_OUT_DEVICE_GUID, &dummy);
 		if (status == EFI_SUCCESS)
 			return gop;
 
@@ -510,16 +511,22 @@ find_gop(efi_guid_t *proto, unsigned long size, void **handles)
 	return first_gop;
 }
 
-static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
-			      unsigned long size, void **handles)
+efi_status_t efi_setup_gop(struct screen_info *si)
 {
-	efi_graphics_output_protocol_t *gop;
+	efi_handle_t *handles __free(efi_pool) = NULL;
 	efi_graphics_output_protocol_mode_t *mode;
 	efi_graphics_output_mode_info_t *info;
+	efi_graphics_output_protocol_t *gop;
+	efi_status_t status;
+	unsigned long num;
 
-	gop = find_gop(proto, size, handles);
+	status = efi_bs_call(locate_handle_buffer, EFI_LOCATE_BY_PROTOCOL,
+			      &EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID, NULL, &num,
+			      (void **)&handles);
+	if (status != EFI_SUCCESS)
+		return status;
 
-	/* Did we find any GOPs? */
+	gop = find_gop(num, handles);
 	if (!gop)
 		return EFI_NOT_FOUND;
 
@@ -551,29 +558,3 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 
 	return EFI_SUCCESS;
 }
-
-/*
- * See if we have Graphics Output Protocol
- */
-efi_status_t efi_setup_gop(struct screen_info *si, efi_guid_t *proto,
-			   unsigned long size)
-{
-	efi_status_t status;
-	void **gop_handle = NULL;
-
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
-			     (void **)&gop_handle);
-	if (status != EFI_SUCCESS)
-		return status;
-
-	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL, proto, NULL,
-			     &size, gop_handle);
-	if (status != EFI_SUCCESS)
-		goto free_handle;
-
-	status = setup_gop(si, proto, size, gop_handle);
-
-free_handle:
-	efi_bs_call(free_pool, gop_handle);
-	return status;
-}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 71173471faf6..53da6b5be739 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -406,24 +406,11 @@ static void setup_quirks(struct boot_params *boot_params)
 
 static void setup_graphics(struct boot_params *boot_params)
 {
-	efi_guid_t graphics_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
-	struct screen_info *si;
-	efi_status_t status;
-	unsigned long size;
-	void **gop_handle = NULL;
-
-	si = &boot_params->screen_info;
-	memset(si, 0, sizeof(*si));
-
-	size = 0;
-	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
-			     &graphics_proto, NULL, &size, gop_handle);
-	if (status == EFI_BUFFER_TOO_SMALL)
-		status = efi_setup_gop(si, &graphics_proto, size);
+	struct screen_info *si = memset(&boot_params->screen_info, 0, sizeof(*si));
 
+	efi_setup_gop(si);
 }
 
-
 static void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
 {
 	efi_bs_call(exit, handle, status, 0, NULL);
-- 
2.47.1.613.gc27f4b7a9f-goog


