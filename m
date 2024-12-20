Return-Path: <linux-efi+bounces-2419-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07D59F910C
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 12:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B62116C233
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 11:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386A71C5F00;
	Fri, 20 Dec 2024 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/2nIDpT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194EE1C4A38
	for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2024 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734693765; cv=none; b=JQRQ9bEQApGg5iXBcbhip0gvRpISj7BG67XH5yJi1lCLpAdUMMwGQ7DPPKcdPM3XrLrJH+jY5WUPXLHdcnTkBBlAoNsE7XqlVfVboF0U/9ujAHs1qc9lqu94nOD7dbDX7PIOGozgodHf6x/syL+cf0eDR7tA/3RxOsBTKakpYEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734693765; c=relaxed/simple;
	bh=yjKDfnWFkEuDhw362m3wgv7Ngw+SdWNENil+UmGcXVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s9dsm1s7ds32t1LwlBF9VANjHBBY+mhpPTu60HhCzEoE1SPFaScvVjys9F8DAQtCBHlZOCOgYjRlvCPiGLRP1JS9Xmj22W5+LHAd7wdzfSvBhZEfUIrjct2cciZKWrBfXWCpJTO/tA+M2nxJtU0vtaVm6Unw/nkWXZeuwIztbLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/2nIDpT; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4361d4e8359so15614915e9.3
        for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2024 03:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734693760; x=1735298560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6YYXdY4bN82dG0pvzgxsem1o3f0Ml+EYY91hq0XrqIE=;
        b=q/2nIDpTe6APAW4FJPuobzwo3R88HCNkllCAfxg3hSPHxf9dkbn6cMwKvmrNB9dZjI
         VbyRh9EZfT5POuxrAYKhDZNk3kKMvySeuqfovTW7euDDZqzN+1qNQIBqelbS0CTF9UAp
         H4mMmIAvu5RJYWT84bwlJ3VcGhTFffu9ue5ErHwBC19+0mc2A2zLYnHOeXswroVW9TuW
         kUVHCHtxFRJO43O63jaLekAQxwi/KKDpvvPmlXlatCl6CWxtOEz5jp92VmxrvlVlKM4/
         fZ4JK+5QHSW5pyqaQWY1fFNeJEjKrJks2OkU6lsgsZeGdYK2Y3Wd/oawBUO35m4Uk5ow
         bOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734693760; x=1735298560;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6YYXdY4bN82dG0pvzgxsem1o3f0Ml+EYY91hq0XrqIE=;
        b=eGlDwyXkseZr5FuJMeF6JK+y5RTTgArFgtrJRhtr6N0CEf3zZsreScaY1b8JCeX7ao
         OrtjD/2aHmLBCv87zClO9wSVb9D7axR9rjoAEqeJdx3X8PPCnXR3gUNOot1lqykNdLlc
         hDE+U7zGWppTUyrUk+X5MfMBxowYOhXQoYwu0Qhu+FwBmQ/h4ha6MPdOlDsSS+45ge0S
         7AXxMAJsZ8sX3EzY2Hu9GA3JImM1Qt73gHp99VFpeqJi2kEz60s0/MCt8RMuZDmcXThW
         GwBOwVuZUDgTb4m/pvUxMIY2M8XnKHQcTSBGyl6pB1h9VbweVRFpoPx4US2OGi6MX3J1
         OBIg==
X-Gm-Message-State: AOJu0Yyo3bkVYRXAk0e2EO9mUjZBqmxlqecvDJ4W6wIgtvCq2VQqGZu5
	SAMkSTH8xzp0JTbGEFYz75AbLYFcSr3g0aYfSx1ZY8aGzOoghkVtWBFZXEzFNVjjslDxrsSbNE1
	MSfjPd7ZO7c8gwTKSZkMR5P9B5qzJeoVPVbZsQ+tL3qvK+QE9kjcEIEv04bFVhtyJx30wJNkzgc
	Aj+YtjU0gg/pexhoazpYR6aTeE2A==
X-Google-Smtp-Source: AGHT+IEPtd6fv8n48QLQArvWtpQjRGaa1iszuXudfaVHD/pL8rJJFKuWgJzijdPiBSgexJW7kzhFRQ8s
X-Received: from wmqb1.prod.google.com ([2002:a05:600c:4e01:b0:434:ef30:4be3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:35d2:b0:435:d22:9c9e
 with SMTP id 5b1f17b1804b1-43668646335mr21268535e9.19.1734693760586; Fri, 20
 Dec 2024 03:22:40 -0800 (PST)
Date: Fri, 20 Dec 2024 12:22:17 +0100
In-Reply-To: <20241220112214.2598872-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241220112214.2598872-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4129; i=ardb@kernel.org;
 h=from:subject; bh=cg25M7jhCCiFzPMmRlAcGna2O6HkPSkC46Z5HoI87BA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT01OOt0W3/L5lCLSsW9HtkP5tgVXBeXtls1dU28L8/Ch
 KOnns7sKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOxmc7wP4kje8/G8++OSllx
 y7CVP53lYuxa1WiSfs1ia8X0iusHOxn+1x2a+WNqe9v3d7dt37FPn3H54PoAOd8TSwK/BB/ab+7 FzAIA
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241220112214.2598872-11-ardb+git@google.com>
Subject: [PATCH 2/7] efi/libstub: Use C99-style for loop to traverse handle buffer
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Tweak the for_each_efi_handle() macro in order to avoid the need on the
part of the caller to provide a loop counter variable.

Also move efi_get_handle_num() to the callers, so that each occurrence
can be replaced with the actual number returned by the simplified
LocateHandleBuffer API.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h  | 9 ++++-----
 drivers/firmware/efi/libstub/gop.c      | 3 +--
 drivers/firmware/efi/libstub/pci.c      | 5 ++---
 drivers/firmware/efi/libstub/x86-stub.c | 3 +--
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index d0989e072b2b..c321735eb237 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -123,11 +123,10 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 #define efi_get_handle_num(size)					\
 	((size) / (efi_is_native() ? sizeof(efi_handle_t) : sizeof(u32)))
 
-#define for_each_efi_handle(handle, array, size, i)			\
-	for (i = 0;							\
-	     i < efi_get_handle_num(size) &&				\
-		((handle = efi_get_handle_at((array), i)) || true);	\
-	     i++)
+#define for_each_efi_handle(handle, array, num)				\
+	for (int __i = 0; __i < (num) &&				\
+		((handle = efi_get_handle_at((array), __i)) || true);	\
+	     __i++)
 
 static inline
 void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index ea5da307d542..8eef63c48288 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -466,11 +466,10 @@ find_gop(efi_guid_t *proto, unsigned long size, void **handles)
 {
 	efi_graphics_output_protocol_t *first_gop;
 	efi_handle_t h;
-	int i;
 
 	first_gop = NULL;
 
-	for_each_efi_handle(h, handles, size, i) {
+	for_each_efi_handle(h, handles, efi_get_handle_num(size)) {
 		efi_status_t status;
 
 		efi_graphics_output_protocol_t *gop;
diff --git a/drivers/firmware/efi/libstub/pci.c b/drivers/firmware/efi/libstub/pci.c
index 99fb25d2bcf5..b0ba372c26c5 100644
--- a/drivers/firmware/efi/libstub/pci.c
+++ b/drivers/firmware/efi/libstub/pci.c
@@ -21,7 +21,6 @@ void efi_pci_disable_bridge_busmaster(void)
 	efi_handle_t handle;
 	efi_status_t status;
 	u16 class, command;
-	int i;
 
 	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL, &pci_proto,
 			     NULL, &pci_handle_size, NULL);
@@ -46,7 +45,7 @@ void efi_pci_disable_bridge_busmaster(void)
 		goto free_handle;
 	}
 
-	for_each_efi_handle(handle, pci_handle, pci_handle_size, i) {
+	for_each_efi_handle(handle, pci_handle, efi_get_handle_num(pci_handle_size)) {
 		efi_pci_io_protocol_t *pci;
 		unsigned long segment_nr, bus_nr, device_nr, func_nr;
 
@@ -82,7 +81,7 @@ void efi_pci_disable_bridge_busmaster(void)
 		efi_bs_call(disconnect_controller, handle, NULL, NULL);
 	}
 
-	for_each_efi_handle(handle, pci_handle, pci_handle_size, i) {
+	for_each_efi_handle(handle, pci_handle, efi_get_handle_num(pci_handle_size)) {
 		efi_pci_io_protocol_t *pci;
 
 		status = efi_bs_call(handle_protocol, handle, &pci_proto,
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 0c51d8307000..71173471faf6 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -124,7 +124,6 @@ static void setup_efi_pci(struct boot_params *params)
 	unsigned long size = 0;
 	struct setup_data *data;
 	efi_handle_t h;
-	int i;
 
 	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
 			     &pci_proto, NULL, &size, pci_handle);
@@ -150,7 +149,7 @@ static void setup_efi_pci(struct boot_params *params)
 	while (data && data->next)
 		data = (struct setup_data *)(unsigned long)data->next;
 
-	for_each_efi_handle(h, pci_handle, size, i) {
+	for_each_efi_handle(h, pci_handle, efi_get_handle_num(size)) {
 		efi_pci_io_protocol_t *pci = NULL;
 		struct pci_setup_rom *rom;
 
-- 
2.47.1.613.gc27f4b7a9f-goog


