Return-Path: <linux-efi+bounces-2424-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC479F9114
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 12:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB7D16C316
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 11:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143DC1C304A;
	Fri, 20 Dec 2024 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3oJQL++"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ED61CBE95
	for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2024 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734693774; cv=none; b=FnXio8vOS8f2sVg5wXKiy8TqAx7+Nfu3rP5bj486LF5ux9yV0W+1pCrzfZ5wl8shwC4o0Y7J/hOAlr/R/It87ZZOyW9zH6bLvpWjIezI8cIjwTJpTxV7KqrucJkbeZaVfXM1wEtUGq4Ye4TXZQjYbBidBsSHtDkyLvoRv43jDjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734693774; c=relaxed/simple;
	bh=16iKVImPte4Q3WShcCqcfMjR3u7rPsH1PIwZqgFwKNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ufuPJcmT6R4nCvT9DLCVAAoOd0q8DomeC6zksjdpWJmhy6EMznIGvlD+jZYlJFi9R1Htmi5agLP+bJUO0em+OQk9mO6mf+jSgdkKvbaiKt53m2+EaP7bgmMgfE0RwVqy4wK6XCWsLJcWNExyeN3mMj0FmHfu5qmzzTGLu+0VN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B3oJQL++; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4362552ce62so10217285e9.0
        for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2024 03:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734693771; x=1735298571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lHLbvVQPBhBByrX4m9XvjRmmcb5HxLT/kjwhrJBKnr8=;
        b=B3oJQL++P+8lIoOYwXm6YwtQjn22MyYyG1Ay7xeokPlH8HQi3j6zWYF5cgE6N/ObBH
         37w+wirEV/3ChyTAan8JXG9HRPZN/AqCxnXh+XrrvoC5puEZYv5JUOls3md/rQgXgDq6
         XAdb/iV2Xjv8M/NqmDtw/Ju3xge2obg2pzGOYVXlzWQtHfVsVXqCF9txWwm5aymoBH3M
         NnCApqPcHdCo1uPD90UzwzM+CdRtJ9x0kANPmJalNXkNsnYdSJLpeh5Q5mnkgzXfehvf
         WYr1OB5Xdoix3eua/PRnE/qgSP6dhvYReEYHNHMdSeQ11ZoPGXXuG3vyFoixYC8F01ND
         autg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734693771; x=1735298571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHLbvVQPBhBByrX4m9XvjRmmcb5HxLT/kjwhrJBKnr8=;
        b=bnoEd/sKI38SBd0ycAP2jskBOd7rWwYCK4+NHc3nYvEQ6tjBmFa0WEg0VLw/kUWlcC
         b2rAEMeLM5DTyjmnjCxLqTMAmPvWlZu25cWuYAqVu2bUxMWYqpO25lVir+i0TR3ccOin
         el8VZK8URXhgoPBcL8taiZcT9a347K0/IWBo/2sk6/qAoFB/606pwfT1YlhyQSLXJspV
         AyT8hJugtHcUIICSsz3frPaIIM30eHofD8IW9BuQ1At72F7jGKwjFt6n7GEsQrvaZxHn
         B+iifxfgALeicTYDL0kCSa/Zk5+aCBSw4v8LcddRjejF4q/RX5kc2xMlMM2vTHzntjbc
         Tf5g==
X-Gm-Message-State: AOJu0YxIVJlCOe2WVRPPXPZjKIAyNnX1s9zumNhIoxf8DNhFJHAC6kuF
	EdutH+tR+ft2WVVUWbhm7ZSLWt0nJbtpZqtSZSwE8fIvD9wD/V5zJw4K9YsFeipG141I9cqBnls
	nIqLxaHZgRXkDX0z6UPOa6OatimS1kbNtlzLPqMdFOCNCQ+zeM5H/uTZC2+7G/G4pciEwXmpYBp
	Zd3pl1XvnZkQGQvDGUbnR/Xl7M6Q==
X-Google-Smtp-Source: AGHT+IFfpcbxYvQshEs3e4Dk4tdzJxIzJwuNEo5SczSb3OkxWUkg2WxGa3gNNsxnoBpvBrIqnw0afadc
X-Received: from wmox17.prod.google.com ([2002:a05:600c:1791:b0:436:164a:763e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a0a:b0:434:f0df:9f6
 with SMTP id 5b1f17b1804b1-4366854737fmr22340085e9.3.1734693770825; Fri, 20
 Dec 2024 03:22:50 -0800 (PST)
Date: Fri, 20 Dec 2024 12:22:22 +0100
In-Reply-To: <20241220112214.2598872-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241220112214.2598872-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5256; i=ardb@kernel.org;
 h=from:subject; bh=duZrOElq0qpO0f9uxS54lPTgiTD/koygRLoGgpOpZdc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT01uLDWStpYa5qlDMtEp/ZIhlWGookL9kYISh69GqrcL
 92aubWjlIVBjINBVkyRRWD233c7T0+UqnWeJQszh5UJZAgDF6cATIQjkeF/Ro1n+43ZphkPVx0q
 m7zuYnXKS3PP1J2KE3+cvFy8JO0iB8N/l3W2Sj3f4472Tczw28Fxf3/NbNk3zgoiFcq3+y7d1ut nBwA=
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241220112214.2598872-16-ardb+git@google.com>
Subject: [PATCH 7/7] efi/libstub: Use __free() helper for pool deallocations
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Annotate some local buffer allocations as __free(efi_pool) and simplify
the associated error handling accordingly. This removes a couple of
gotos and simplifies the code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c |  9 ++++-----
 drivers/firmware/efi/libstub/efi-stub.c        | 21 ++++++++++----------
 drivers/firmware/efi/libstub/x86-stub.c        | 16 ++++++---------
 3 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index c0c81ca4237e..fd6dc790c5a8 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -47,9 +47,10 @@ bool __pure __efi_soft_reserve_enabled(void)
  */
 efi_status_t efi_parse_options(char const *cmdline)
 {
-	size_t len;
+	char *buf __free(efi_pool) = NULL;
 	efi_status_t status;
-	char *str, *buf;
+	size_t len;
+	char *str;
 
 	if (!cmdline)
 		return EFI_SUCCESS;
@@ -102,7 +103,6 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_parse_option_graphics(val + strlen("efifb:"));
 		}
 	}
-	efi_bs_call(free_pool, buf);
 	return EFI_SUCCESS;
 }
 
@@ -250,7 +250,7 @@ static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
 						  u64, const union efistub_event *);
 		struct { u32 hash_log_extend_event; } mixed_mode;
 	} method;
-	struct efistub_measured_event *evt;
+	struct efistub_measured_event *evt __free(efi_pool) = NULL;
 	int size = struct_size(evt, tagged_event.tagged_event_data,
 			       events[event].event_data_len);
 	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
@@ -312,7 +312,6 @@ static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
 
 	status = efi_fn_call(&method, hash_log_extend_event, protocol, 0,
 			     load_addr, load_size, &evt->event_data);
-	efi_bs_call(free_pool, evt);
 
 	if (status == EFI_SUCCESS)
 		return EFI_SUCCESS;
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 90e06a6b1a45..874f63b4a383 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -104,8 +104,8 @@ static u32 get_supported_rt_services(void)
 
 efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 {
+	char *cmdline __free(efi_pool) = NULL;
 	efi_status_t status;
-	char *cmdline;
 
 	/*
 	 * Get the command line from EFI, using the LOADED_IMAGE
@@ -120,25 +120,24 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 
 	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
 		status = efi_parse_options(cmdline);
-		if (status != EFI_SUCCESS)
-			goto fail_free_cmdline;
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to parse EFI load options\n");
+			return status;
+		}
 	}
 
 	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
 	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
 	    cmdline[0] == 0) {
 		status = efi_parse_options(CONFIG_CMDLINE);
-		if (status != EFI_SUCCESS)
-			goto fail_free_cmdline;
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to parse built-in command line\n");
+			return status;
+		}
 	}
 
-	*cmdline_ptr = cmdline;
+	*cmdline_ptr = no_free_ptr(cmdline);
 	return EFI_SUCCESS;
-
-fail_free_cmdline:
-	efi_err("Failed to parse options\n");
-	efi_bs_call(free_pool, cmdline);
-	return status;
 }
 
 efi_status_t efi_stub_common(efi_handle_t handle,
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 4dfd25e6ac71..6fa1d4f62e81 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -42,7 +42,7 @@ union sev_memory_acceptance_protocol {
 static efi_status_t
 preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 {
-	struct pci_setup_rom *rom = NULL;
+	struct pci_setup_rom *rom __free(efi_pool) = NULL;
 	efi_status_t status;
 	unsigned long size;
 	uint64_t romsize;
@@ -75,14 +75,13 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	rom->data.len	= size - sizeof(struct setup_data);
 	rom->data.next	= 0;
 	rom->pcilen	= romsize;
-	*__rom = rom;
 
 	status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
 				PCI_VENDOR_ID, 1, &rom->vendor);
 
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to read rom->vendor\n");
-		goto free_struct;
+		return status;
 	}
 
 	status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
@@ -90,21 +89,18 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to read rom->devid\n");
-		goto free_struct;
+		return status;
 	}
 
 	status = efi_call_proto(pci, get_location, &rom->segment, &rom->bus,
 				&rom->device, &rom->function);
 
 	if (status != EFI_SUCCESS)
-		goto free_struct;
+		return status;
 
 	memcpy(rom->romdata, romimage, romsize);
-	return status;
-
-free_struct:
-	efi_bs_call(free_pool, rom);
-	return status;
+	*__rom = no_free_ptr(rom);
+	return EFI_SUCCESS;
 }
 
 /*
-- 
2.47.1.613.gc27f4b7a9f-goog


