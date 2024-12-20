Return-Path: <linux-efi+bounces-2422-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079D99F9110
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 12:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5935516C2A0
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3111C68A6;
	Fri, 20 Dec 2024 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lthm7nYl"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E981C5F2D
	for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2024 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734693770; cv=none; b=tHiQrv/zODY+JgWfVTm0898oExJo8KS3XXuJz4pQ88kqQNd5AVsjEqMUnASYFGoYoVo7shUS7cUw0yVl9OCckUuSEGAQjIzW2DmI/pMFPsQWFQ2OBG/OreqtxdI90RNuGFuNLwH/EPE53N15xehykWLIEeE/Spo5oRWmnOU99qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734693770; c=relaxed/simple;
	bh=jQFPnAR/lQIH41XKJNrgOYB+xxnzwuDMJoLacFjQ9Rg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ow02vIC2bamVpyQAR3Q+Xav/nxOgHYovr10BTYUUfzLAOYlASX8EQzljEsd6vvMBi8mSQwPxyZKjjMib5WuJ15mU/MOfv7fBorT9JGSrynmZ90bC4hI3CDj70mPPgKB/KfH1B2MqyG+P0DEBEoxy0ZKgwB9FJOVhLDSV02GGgeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lthm7nYl; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43651b1ba8aso14023185e9.1
        for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2024 03:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734693767; x=1735298567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZdfudFQMgX/SPnuBiPXL83yln9iyupuULighNWJ+Tk=;
        b=Lthm7nYlaizzC5fYhDMLy5wq/qv6kgIrADGeewIxg5NXyjM8MJM552lHyHZd4fIgzp
         xS8PDxCZ5ifQ9rN4zSduix085J1pomssYh/HcZyeXw5TOT9hQmIP/G7Ohc+B2SbDCKRM
         2+gt25aMJgIChJeJMG5PBbsz8pfMlRdtHxR1LH6ING6EzeRi7yU3LdNigQoprdGUFdP+
         bZz+q5ANdcYDsX6Q5uPtY7yTiSJzeFkQmAm+KDPUW7pLSY9O8FB1kdVxkWo0HuScgYk3
         k6/bFRLwOQ6vHOzkLZiW04I3vU0Eh5L2L08+z8uylCHPOCQZnsIu1mpl778HNHpOB4qE
         OuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734693767; x=1735298567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZdfudFQMgX/SPnuBiPXL83yln9iyupuULighNWJ+Tk=;
        b=gykesMGGsThssugoz1GjLsszflPTSITM5WCsBY74kUptffOxYsIX5OT/S72hE90pm2
         gXK8rHmxeVKQmJtZ452WUkcu9wDrU51DRWrz7aK82AftY2PXqBt1XLglKP05XaEfXE+n
         ZZ90PWaSllTMhBSNnX8gj8YjIF3SqcOMvCDtMaM60k1j2FI91DDzYcdwrZOg9HH9DVKY
         cMYqefHVqfT9tDXg/fZyZCTUFg3EGtKb4YqowsgCFQ0D4ZJ+wUs1v/24XcBlSY2R+m7N
         JSqOlMUGFZGfKg11HqMbSev2IZ5wQwhkJFeWPrE5iOQm52xsEsGc375d6wgDnWhSmjTS
         3kSg==
X-Gm-Message-State: AOJu0Yzjcw5TlSVsKC12njYYPShdrs+c2DZrZRrPO/ESJtZgHIF8xCD5
	JvqU9uYDGsGtnDpFG88ZvQWayL6PzRO0ZH3NQpH+oAJ5wS7C0z8zv9oHKZ2fUosX2jOXqEo4t3Z
	sjyhxU5GIVSInQ3nfT0OuULwcEFAmufwGAg6yf/DDtv2cAqZk5tSGs+6g7i9b8YkLaksOH6BN5D
	6PkKXRREZ+8LnmhnoLwNc7VdI6lw==
X-Google-Smtp-Source: AGHT+IHImMIL/xdHSaYtb96ILTwp8HE90q+uERYMRCTtZuhOxoziiMyV2AhqGsbIAkkH0hOTaJxgqEkG
X-Received: from wmbjn12.prod.google.com ([2002:a05:600c:6b0c:b0:435:4bd2:1dcd])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f0d:b0:432:cbe5:4f09
 with SMTP id 5b1f17b1804b1-43671247b46mr135995e9.4.1734693766818; Fri, 20 Dec
 2024 03:22:46 -0800 (PST)
Date: Fri, 20 Dec 2024 12:22:20 +0100
In-Reply-To: <20241220112214.2598872-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241220112214.2598872-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4607; i=ardb@kernel.org;
 h=from:subject; bh=/nPnk008oitHG0r/EWed5C0pBvsJuMEBmFXGRgsWLSY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT01OO+93t8LRY/mx0t1/z/ZcN/bTHdNtaiz7r95X93/f
 RT+UCLbUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbys5GRYa9ydezH/SHZuUny
 nZcesfR/jRU6fMW0btNbWR6vyXqTnRn+ypbIHJf3V7fPUO0M3b1yE9ObHS6feZfLhrM9LFjitNS XAQA=
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241220112214.2598872-14-ardb+git@google.com>
Subject: [PATCH 5/7] efi/libstub: Simplify PCI I/O handle buffer traversal
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Use LocateHandleBuffer() and a __free() cleanup helper to simplify the
PCI I/O handle buffer traversal code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/pci.c      | 33 +++++---------------
 drivers/firmware/efi/libstub/x86-stub.c | 29 ++++-------------
 2 files changed, 13 insertions(+), 49 deletions(-)

diff --git a/drivers/firmware/efi/libstub/pci.c b/drivers/firmware/efi/libstub/pci.c
index b0ba372c26c5..e32d1fdb1fc7 100644
--- a/drivers/firmware/efi/libstub/pci.c
+++ b/drivers/firmware/efi/libstub/pci.c
@@ -16,36 +16,20 @@
 void efi_pci_disable_bridge_busmaster(void)
 {
 	efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
-	unsigned long pci_handle_size = 0;
-	efi_handle_t *pci_handle = NULL;
+	efi_handle_t *pci_handle __free(efi_pool) = NULL;
+	unsigned long pci_handle_num;
 	efi_handle_t handle;
 	efi_status_t status;
 	u16 class, command;
 
-	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL, &pci_proto,
-			     NULL, &pci_handle_size, NULL);
-
-	if (status != EFI_BUFFER_TOO_SMALL) {
-		if (status != EFI_SUCCESS && status != EFI_NOT_FOUND)
-			efi_err("Failed to locate PCI I/O handles'\n");
-		return;
-	}
-
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, pci_handle_size,
-			     (void **)&pci_handle);
-	if (status != EFI_SUCCESS) {
-		efi_err("Failed to allocate memory for 'pci_handle'\n");
-		return;
-	}
-
-	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL, &pci_proto,
-			     NULL, &pci_handle_size, pci_handle);
+	status = efi_bs_call(locate_handle_buffer, EFI_LOCATE_BY_PROTOCOL,
+			     &pci_proto, NULL, &pci_handle_num, pci_handle);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to locate PCI I/O handles'\n");
-		goto free_handle;
+		return;
 	}
 
-	for_each_efi_handle(handle, pci_handle, efi_get_handle_num(pci_handle_size)) {
+	for_each_efi_handle(handle, pci_handle, pci_handle_num) {
 		efi_pci_io_protocol_t *pci;
 		unsigned long segment_nr, bus_nr, device_nr, func_nr;
 
@@ -81,7 +65,7 @@ void efi_pci_disable_bridge_busmaster(void)
 		efi_bs_call(disconnect_controller, handle, NULL, NULL);
 	}
 
-	for_each_efi_handle(handle, pci_handle, efi_get_handle_num(pci_handle_size)) {
+	for_each_efi_handle(handle, pci_handle, pci_handle_num) {
 		efi_pci_io_protocol_t *pci;
 
 		status = efi_bs_call(handle_protocol, handle, &pci_proto,
@@ -107,7 +91,4 @@ void efi_pci_disable_bridge_busmaster(void)
 		if (status != EFI_SUCCESS)
 			efi_err("Failed to disable PCI busmastering\n");
 	}
-
-free_handle:
-	efi_bs_call(free_pool, pci_handle);
 }
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 53da6b5be739..4a3487e5dfc8 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -119,37 +119,23 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 static void setup_efi_pci(struct boot_params *params)
 {
 	efi_status_t status;
-	void **pci_handle = NULL;
+	efi_handle_t *pci_handle __free(efi_pool) = NULL;
 	efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
-	unsigned long size = 0;
 	struct setup_data *data;
+	unsigned long num;
 	efi_handle_t h;
 
-	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
-			     &pci_proto, NULL, &size, pci_handle);
-
-	if (status == EFI_BUFFER_TOO_SMALL) {
-		status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
-				     (void **)&pci_handle);
-
-		if (status != EFI_SUCCESS) {
-			efi_err("Failed to allocate memory for 'pci_handle'\n");
-			return;
-		}
-
-		status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
-				     &pci_proto, NULL, &size, pci_handle);
-	}
-
+	status = efi_bs_call(locate_handle_buffer, EFI_LOCATE_BY_PROTOCOL,
+			     &pci_proto, NULL, &num, pci_handle);
 	if (status != EFI_SUCCESS)
-		goto free_handle;
+		return;
 
 	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
 
 	while (data && data->next)
 		data = (struct setup_data *)(unsigned long)data->next;
 
-	for_each_efi_handle(h, pci_handle, efi_get_handle_num(size)) {
+	for_each_efi_handle(h, pci_handle, num) {
 		efi_pci_io_protocol_t *pci = NULL;
 		struct pci_setup_rom *rom;
 
@@ -169,9 +155,6 @@ static void setup_efi_pci(struct boot_params *params)
 
 		data = (struct setup_data *)rom;
 	}
-
-free_handle:
-	efi_bs_call(free_pool, pci_handle);
 }
 
 static void retrieve_apple_device_properties(struct boot_params *boot_params)
-- 
2.47.1.613.gc27f4b7a9f-goog


