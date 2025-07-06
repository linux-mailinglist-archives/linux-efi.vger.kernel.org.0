Return-Path: <linux-efi+bounces-4137-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A793AFA441
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 12:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB593B9B69
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 10:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBC619ABC2;
	Sun,  6 Jul 2025 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kA7fW8uZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3E92E36EF;
	Sun,  6 Jul 2025 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751796172; cv=none; b=oP5Q64RpSEXoFZV6Gord8AHAHRh/13oIoY52PAa2rf0/V/7wIhd/ZZd06gPJ7e/Tssc18jVFW68wX0bFtYhqSZiPfobrUgRDZrWHKCrMbN9+NZuPezdz/whPU/qkD8uCzE+Qvx3LyXFlVAVjsDsrshdKMOEVVtXccA+/3IboABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751796172; c=relaxed/simple;
	bh=jxmCS+4FrIHekoqmBASHBs38Fb+lwrYLRZy5w9rNduk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqXEO1aXLnfCC6zn6r2quke6e+65lv7DlWooAuqsE79SbkvhvgQanWmrOj6wZqF2T4GjgPe+n0SqelAQ6PeUNwhoagoxHuI4/1MgzsT4vK5JuPpjL0eL4Wk8jTic7LGR1hOfzfUpBED2YedZB3wzLqDrG6ZPsOR3cyMuuA84n6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kA7fW8uZ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so3040864a12.2;
        Sun, 06 Jul 2025 03:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751796168; x=1752400968; darn=vger.kernel.org;
        h=content-transfer-encoding:reference:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PNcWWt0/wmFdTHt0R4q28XFCfyYaQTMM9C3UysIYQmk=;
        b=kA7fW8uZ1KrWYZt5d4pZ697X3RTqbd+ZeaqFxy4/7riY3mFbIUo/g2sktLzzDSI/8s
         HL7o58jDzrf6QwNYhXsT8JK+gc8k/Zq3SRDEgWuEq4PN7E+Rs+Fd/f9JRtwenfmzdpOP
         xb3b8nM6FRiQe7JBEpxIKx1WDh1mgjAQ/qaJhZUzLux7mDPvKLK9tzBNHx+5qd9zvonx
         jxOrRZybCphmlyQZiBWL0My/ZIv9IybetWUJnNm8Hf/W58ew+XOhn6zhUNwOW30t1/6b
         CrOKKJ/Aleap2Pq/JUIzqR5JmI8vO7hmlUkU4RsXjCHmiYr8anhnEczs0/+Q/O2SWwS/
         CTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751796168; x=1752400968;
        h=content-transfer-encoding:reference:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNcWWt0/wmFdTHt0R4q28XFCfyYaQTMM9C3UysIYQmk=;
        b=nSdQl6kko+r9fQx+EmpoKILgcbxvMieKmecGc6iOTBdqhKbOdBSiMYhbXdaGRe9ifa
         VLqkppzxASVOB77LRaklypL1EZGbgSYRmG0eywekxzCMgM2uw0uyBMc04n6+cXJku6gp
         8I3sep9nEvhiG/tGvAwzPhLgMGiqWU9h6FYhRR4gaTc0qciGDfgfVnbdAagB6e2ZZUxH
         YqR3QmwoGfKCLujie8mOJIb8639NS+vT2ryYOrs/9aKsNvCoQpYDD3+Xds2gSS2KOOY/
         Z7uXYa0p1BHDUDgLAWcKUEp6G5KB52lPK83iRDwsWEyiCh20NVO86AHbLnu56CLtFJZH
         Eomg==
X-Forwarded-Encrypted: i=1; AJvYcCUK+D9OHUA7FAeLAE+NEvlDk7W29Bu36ljA7SrPShHzHgO0RFVLOEDMiKZtW1RQ2S648dOUr3thrmxb/je+@vger.kernel.org, AJvYcCV/Z0batsKxO+/UVHcGGCoV5Jg8JwA61codxA0rwUqOjqo3mmY7qyqMBbTmSUmQY5aUCdeECr72zgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Lf6WM6fB/b7DhOQ0nE+UdImkfduU9osoZ5HIIYPyMJ/DG4Vr
	2p8e2tKirH9Z79qHgrHFub+RMVmH0A8/owDttsQehhq13hLgIfDs2JIV
X-Gm-Gg: ASbGncvRfLu7OqUQQknaKJPJKwIYLvY4kDg4vgrL7cmOBdJU+XHR8u5QBGjrhPTX4oA
	PFpfZP35I3CXhvKxDXpmjn1bwEpjySmy24/Y3XLueAFsI6BhCvtO2nyPactM3x8gwu+b2pVhAde
	RGWN3DuqCj6pa/5LOw9kFi8og8RUMLW37eepIea7aKMIXsMkPNhntOu8Xa3YDAjycbrHALPrCCp
	v/LgR/ik07GA44+gF6KfO2QsappO5GC1yrZVB6rTjRGxHI8Kw1osqSGPU3x352FKAqHk8//n1S7
	wRXKyDOusG0h4m6R8HfhOrYzf6t8K/hpHOajq2x2Gljy4m1e8M+QNEaqw1z4sbsbHdlcrXH9wLP
	UnQ==
X-Google-Smtp-Source: AGHT+IE4s171/KjxqB8iYnlhBf7VCGXc4LuTnGH5I/jpwjV6AilXsb+dkrPi/ioa9DqGWZ5fewdQ5A==
X-Received: by 2002:a17:907:e92:b0:ad8:85df:865b with SMTP id a640c23a62f3a-ae41088d46dmr441615666b.33.1751796167876;
        Sun, 06 Jul 2025 03:02:47 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b0335fsm481655666b.129.2025.07.06.03.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 03:02:47 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: ardb@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: gargaditya08@live.com,
	jonathan@marek.ca,
	kees@kernel.org,
	linux-efi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	lukas@wunner.de,
	linux-kernel@vger.kernel.org,
	Khalid Ali <khaliidcaliy@gmail.com>
Subject: [PATCH v2 2/2] efi/libstub: Print uefi status code on error messages
Date: Sun,  6 Jul 2025 10:01:29 +0000
Message-ID: <20250706100147.1447-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250706095705.1386-1-khaliidcaliy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reference: <20250706095705.1386-1-khaliidcaliy@gmail.com>
Content-Transfer-Encoding: 8bit

From: Khalid Ali <khaliidcaliy@gmail.com>

Print the UEFI status code in error messages, particularly when 
handling return values from functions that return EFI_STATUS.

This saves time, specially for debugging. It makes easy to find
status code easily.

Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>
---

Some source files related to other architectures i changed it also. I
didn't able to compile, because i don't have access to those architectures.
So, i am relying test robots and reviewers for source files related to
non-x86 architectures.  

 drivers/firmware/efi/libstub/arm32-stub.c     |  6 ++--
 drivers/firmware/efi/libstub/efi-stub-entry.c |  4 +--
 drivers/firmware/efi/libstub/efi-stub.c       | 10 +++---
 drivers/firmware/efi/libstub/file.c           | 14 ++++----
 drivers/firmware/efi/libstub/loongarch.c      |  2 +-
 drivers/firmware/efi/libstub/pci.c            |  4 +--
 drivers/firmware/efi/libstub/random.c         |  2 +-
 drivers/firmware/efi/libstub/riscv-stub.c     |  2 +-
 drivers/firmware/efi/libstub/tpm.c            |  2 +-
 drivers/firmware/efi/libstub/x86-stub.c       | 32 +++++++++----------
 drivers/firmware/efi/libstub/zboot.c          |  4 +--
 11 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index 1073dd947516..583be54b6b1f 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -36,7 +36,7 @@ efi_status_t check_platform_features(void)
 			     sizeof(*efi_entry_state),
 			     (void **)&efi_entry_state);
 	if (status != EFI_SUCCESS) {
-		efi_err("allocate_pool() failed\n");
+		efi_err("allocate_pool() failed: 0x%lx\n", status);
 		return status;
 	}
 
@@ -46,7 +46,7 @@ efi_status_t check_platform_features(void)
 	status = efi_bs_call(install_configuration_table, &cpu_state_guid,
 			     efi_entry_state);
 	if (status != EFI_SUCCESS) {
-		efi_err("install_configuration_table() failed\n");
+		efi_err("install_configuration_table() failed: 0x%lx\n", status);
 		goto free_state;
 	}
 
@@ -96,7 +96,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	 */
 	status = efi_low_alloc_above(alloc_size, EFI_PAGE_SIZE, &alloc_base, 0x0);
 	if (status != EFI_SUCCESS) {
-		efi_err("Unable to allocate memory for uncompressed kernel.\n");
+		efi_err("Unable to allocate memory for uncompressed kernel: 0x%lx\n", status);
 		return status;
 	}
 
diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
index a6c049835190..bc98fdd5f11f 100644
--- a/drivers/firmware/efi/libstub/efi-stub-entry.c
+++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
@@ -54,7 +54,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	status = efi_bs_call(handle_protocol, handle, &loaded_image_proto,
 			     (void *)&image);
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to get loaded image protocol\n");
+		efi_err("Failed to get loaded image protocol: 0x%lx\n", status);
 		return status;
 	}
 
@@ -69,7 +69,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 				     &reserve_size,
 				     image, handle);
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to relocate kernel\n");
+		efi_err("Failed to relocate kernel: 0x%lx\n", status);
 		return status;
 	}
 
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 874f63b4a383..689a41c9ab0e 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -76,7 +76,7 @@ static void install_memreserve_table(void)
 	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(*rsv),
 			     (void **)&rsv);
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to allocate memreserve entry!\n");
+		efi_err("Failed to allocate memreserve entry: 0x%lx\n", status);
 		return;
 	}
 
@@ -87,7 +87,7 @@ static void install_memreserve_table(void)
 	status = efi_bs_call(install_configuration_table,
 			     &memreserve_table_guid, rsv);
 	if (status != EFI_SUCCESS)
-		efi_err("Failed to install memreserve config table!\n");
+		efi_err("Failed to install memreserve config table: 0x%lx\n", status);
 }
 
 static u32 get_supported_rt_services(void)
@@ -114,14 +114,14 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 	 */
 	cmdline = efi_convert_cmdline(image);
 	if (!cmdline) {
-		efi_err("getting command line via LOADED_IMAGE_PROTOCOL\n");
+		efi_err("getting command line via LOADED_IMAGE_PROTOCOL: 0x%lx\n", status);
 		return EFI_OUT_OF_RESOURCES;
 	}
 
 	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
 		status = efi_parse_options(cmdline);
 		if (status != EFI_SUCCESS) {
-			efi_err("Failed to parse EFI load options\n");
+			efi_err("Failed to parse EFI load options: 0x%lx\n", status);
 			return status;
 		}
 	}
@@ -131,7 +131,7 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 	    cmdline[0] == 0) {
 		status = efi_parse_options(CONFIG_CMDLINE);
 		if (status != EFI_SUCCESS) {
-			efi_err("Failed to parse built-in command line\n");
+			efi_err("Failed to parse built-in command line: 0x%lx\n", status);
 			return status;
 		}
 	}
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index bd626d55dcbc..428ad4aeeb2e 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -54,14 +54,14 @@ static efi_status_t efi_open_file(efi_file_protocol_t *volume,
 	status = efi_call_proto(volume, open, &fh, fi->filename,
 				EFI_FILE_MODE_READ, 0);
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to open file: %ls\n", fi->filename);
+		efi_err("Failed to open file: %ls (0x%lx)\n", fi->filename, status);
 		return status;
 	}
 
 	info_sz = sizeof(struct finfo);
 	status = efi_call_proto(fh, get_info, &info_guid, &info_sz, fi);
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to get file info\n");
+		efi_err("Failed to get file info: 0x%lx\n", status);
 		efi_call_proto(fh, close);
 		return status;
 	}
@@ -81,13 +81,13 @@ static efi_status_t efi_open_volume(efi_loaded_image_t *image,
 	status = efi_bs_call(handle_protocol, efi_table_attr(image, device_handle),
 			     &fs_proto, (void **)&io);
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to handle fs_proto\n");
+		efi_err("Failed to handle fs_prot: 0x%lx\n", status);
 		return status;
 	}
 
 	status = efi_call_proto(io, open_volume, fh);
 	if (status != EFI_SUCCESS)
-		efi_err("Failed to open volume\n");
+		efi_err("Failed to open volume: 0x%lx\n", status);
 
 	return status;
 }
@@ -170,7 +170,7 @@ static efi_status_t efi_open_device_path(efi_file_protocol_t **volume,
 
 	status = efi_call_proto(io, open_volume, volume);
 	if (status != EFI_SUCCESS)
-		efi_err("Failed to open volume\n");
+		efi_err("Failed to open volume: 0x%lx\n", status);
 
 	return status;
 }
@@ -275,7 +275,7 @@ do_builtin:	cmdline	    = builtin_cmdline;
 							    &alloc_addr,
 							    hard_limit);
 			if (status != EFI_SUCCESS) {
-				efi_err("Failed to allocate memory for files\n");
+				efi_err("Failed to allocate memory for files: 0x%lx\n", status);
 				goto err_close_file;
 			}
 
@@ -299,7 +299,7 @@ do_builtin:	cmdline	    = builtin_cmdline;
 
 			status = efi_call_proto(file, read, &chunksize, addr);
 			if (status != EFI_SUCCESS) {
-				efi_err("Failed to read file\n");
+				efi_err("Failed to read file: 0x%lx\n", status);
 				goto err_close_file;
 			}
 			addr += chunksize;
diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
index 3782d0a187d1..53b297a6613e 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -55,7 +55,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
 
 	status = efi_alloc_virtmap(&priv.runtime_map, &desc_size, &desc_ver);
 	if (status != EFI_SUCCESS) {
-		efi_err("Unable to retrieve UEFI memory map.\n");
+		efi_err("Unable to retrieve UEFI memory map: 0x%lx\n", status);
 		return status;
 	}
 
diff --git a/drivers/firmware/efi/libstub/pci.c b/drivers/firmware/efi/libstub/pci.c
index 1dccf77958d3..8cfffe1942ab 100644
--- a/drivers/firmware/efi/libstub/pci.c
+++ b/drivers/firmware/efi/libstub/pci.c
@@ -25,7 +25,7 @@ void efi_pci_disable_bridge_busmaster(void)
 	status = efi_bs_call(locate_handle_buffer, EFI_LOCATE_BY_PROTOCOL,
 			     &pci_proto, NULL, &pci_handle_num, &pci_handle);
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to locate PCI I/O handles\n");
+		efi_err("Failed to locate PCI I/O handles: 0x%lx\n", status);
 		return;
 	}
 
@@ -89,6 +89,6 @@ void efi_pci_disable_bridge_busmaster(void)
 		status = efi_call_proto(pci, pci.write, EfiPciIoWidthUint16,
 					PCI_COMMAND, 1, &command);
 		if (status != EFI_SUCCESS)
-			efi_err("Failed to disable PCI busmastering\n");
+			efi_err("Failed to disable PCI busmastering: 0x%lx\n", status);
 	}
 }
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index 7109b8a2dcba..b9849997bb28 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -106,7 +106,7 @@ efi_status_t efi_random_get_seed(void)
 			     struct_size(seed, bits, seed_size),
 			     (void **)&seed);
 	if (status != EFI_SUCCESS) {
-		efi_warn("Failed to allocate memory for RNG seed.\n");
+		efi_warn("Failed to allocate memory for RNG seed: 0x%lx\n", status);
 		goto err_warn;
 	}
 
diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
index e7d9204baee3..7859c950ca51 100644
--- a/drivers/firmware/efi/libstub/riscv-stub.c
+++ b/drivers/firmware/efi/libstub/riscv-stub.c
@@ -45,7 +45,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 					   kernel_size, kernel_codesize, kernel_memsize,
 					   efi_kaslr_get_phys_seed(image_handle));
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to relocate kernel\n");
+		efi_err("Failed to relocate kernel: 0x%lx\n", status);
 		*image_size = 0;
 	}
 
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index a5c6c4f163fc..ea7ab420c9cf 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -100,7 +100,7 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
 			     sizeof(*log_tbl) + log_size, (void **)&log_tbl);
 
 	if (status != EFI_SUCCESS) {
-		efi_err("Unable to allocate memory for event log\n");
+		efi_err("Unable to allocate memory for event log: 0x%lx\n", status);
 		return;
 	}
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 13d8eba06e4b..aae3b7456759 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -65,7 +65,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
 			     (void **)&rom);
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to allocate memory for 'rom'\n");
+		efi_err("Failed to allocate memory for 'rom' 0x%lx\n", status);
 		return status;
 	}
 
@@ -80,7 +80,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 				PCI_VENDOR_ID, 1, &rom->vendor);
 
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to read rom->vendor\n");
+		efi_err("Failed to read rom->vendor: 0x%lx\n", status);
 		return status;
 	}
 
@@ -88,7 +88,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 				PCI_DEVICE_ID, 1, &rom->devid);
 
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to read rom->devid\n");
+		efi_err("Failed to read rom->devid: 0x%lx\n", status);
 		return status;
 	}
 
@@ -179,7 +179,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 				     size + sizeof(struct setup_data),
 				     (void **)&new);
 		if (status != EFI_SUCCESS) {
-			efi_err("Failed to allocate memory for 'properties'\n");
+			efi_err("Failed to allocate memory for 'properties': 0x%lx\n", status);
 			return;
 		}
 
@@ -254,14 +254,14 @@ static void apple_set_os(void)
 	if (set_os->version >= 2) {
 		status = set_os->set_os_vendor("Apple Inc.");
 		if (status != EFI_SUCCESS)
-			efi_err("Failed to set OS vendor via apple_set_os\n");
+			efi_err("Failed to set OS vendor via apple_set_os: 0x%lx\n", status);
 	}
 
 	if (set_os->version > 0) {
 		/* The version being set doesn't seem to matter */
 		status = set_os->set_os_version("Mac OS X 10.9");
 		if (status != EFI_SUCCESS)
-			efi_err("Failed to set OS version via apple_set_os\n");
+			efi_err("Failed to set OS version via apple_set_os: 0x%lx\n", status);
 	}
 }
 
@@ -283,7 +283,7 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 					rounded_end - rounded_start,
 					EFI_MEMORY_RO);
 		if (status != EFI_SUCCESS) {
-			efi_warn("Failed to set EFI_MEMORY_RO attribute\n");
+			efi_warn("Failed to set EFI_MEMORY_RO attribute: 0x%lx\n", status);
 			return status;
 		}
 
@@ -292,7 +292,7 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 					rounded_end - rounded_start,
 					EFI_MEMORY_XP);
 		if (status != EFI_SUCCESS)
-			efi_warn("Failed to clear EFI_MEMORY_XP attribute\n");
+			efi_warn("Failed to clear EFI_MEMORY_XP attribute: 0x%lx\n", status);
 		return status;
 	}
 
@@ -361,7 +361,7 @@ static void setup_unaccepted_memory(void)
 
 	status = efi_call_proto(proto, allow_unaccepted_memory);
 	if (status != EFI_SUCCESS)
-		efi_err("Memory acceptance protocol failed\n");
+		efi_err("Memory acceptance protocol failed: 0x%lx\n", status);
 }
 
 static efi_char16_t *efistub_fw_vendor(void)
@@ -414,7 +414,7 @@ static efi_status_t efi_allocate_bootparams(efi_handle_t handle,
 
 	status = efi_bs_call(handle_protocol, handle, &proto, (void **)&image);
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to get handle for LOADED_IMAGE_PROTOCOL\n");
+		efi_err("Failed to get handle for LOADED_IMAGE_PROTOCOL: 0x%lx\n", status);
 		return status;
 	}
 
@@ -846,14 +846,14 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	status = efi_setup_5level_paging();
 	if (status != EFI_SUCCESS) {
-		efi_err("efi_setup_5level_paging() failed!\n");
+		efi_err("efi_setup_5level_paging() failed: 0x%lx\n", status);
 		goto fail;
 	}
 
 #ifdef CONFIG_CMDLINE_BOOL
 	status = parse_options(CONFIG_CMDLINE);
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to parse options\n");
+		efi_err("Failed to parse options: 0x%lx\n", status);
 		goto fail;
 	}
 #endif
@@ -862,7 +862,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 					       ((u64)boot_params->ext_cmd_line_ptr << 32));
 		status = parse_options((char *)cmdline_paddr);
 		if (status != EFI_SUCCESS) {
-			efi_err("Failed to parse options\n");
+			efi_err("Failed to parse options: 0x%lx\n", status);
 			goto fail;
 		}
 	}
@@ -872,7 +872,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	status = efi_decompress_kernel(&kernel_entry, boot_params);
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to decompress kernel\n");
+		efi_err("Failed to decompress kernel: 0x%lx\n", status);
 		goto fail;
 	}
 
@@ -921,7 +921,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
-		efi_err("exit_boot() failed!\n");
+		efi_err("exit_boot() failed: 0x%lx\n", status);
 		goto fail;
 	}
 
@@ -935,7 +935,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	enter_kernel(kernel_entry, boot_params);
 fail:
-	efi_err("efi_stub_entry() failed!\n");
+	efi_err("efi_stub_entry() failed: 0x%lx\n", status);
 
 	efi_exit(handle, status);
 }
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index c47ace06f010..f7e7f68fea02 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -44,7 +44,7 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 	status = efi_bs_call(handle_protocol, handle,
 			     &LOADED_IMAGE_PROTOCOL_GUID, (void **)&image);
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to locate parent's loaded image protocol\n");
+		efi_err("Failed to locate parent's loaded image protocol 0x%lx\n", status);
 		return status;
 	}
 
@@ -86,7 +86,7 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 		status = efi_random_alloc(alloc_size, min_kimg_align, &image_base,
 					  seed, EFI_LOADER_CODE, 0, EFI_ALLOC_LIMIT);
 		if (status != EFI_SUCCESS) {
-			efi_err("Failed to allocate memory\n");
+			efi_err("Failed to allocate memory: 0x%lx\n", status);
 			return status;
 		}
 	}
-- 
2.49.0


