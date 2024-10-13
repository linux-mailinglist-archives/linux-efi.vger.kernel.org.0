Return-Path: <linux-efi+bounces-1958-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AC599B84C
	for <lists+linux-efi@lfdr.de>; Sun, 13 Oct 2024 07:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A701C209FE
	for <lists+linux-efi@lfdr.de>; Sun, 13 Oct 2024 05:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F13136345;
	Sun, 13 Oct 2024 05:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="c7kXOqTK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D86E13C67C
	for <linux-efi@vger.kernel.org>; Sun, 13 Oct 2024 05:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728796617; cv=none; b=pIn8dH/T4DRO1U3i1RfM/Qg/579ANjxB7lX8o1z9TU2ZcxU6rCmXDH4dQiECzLvcFzIqUwjH0HWGllCXxIUceEe9vXweH11AXlOyhHK0QbkwGyqJ8z23r/Gjg/AT8toossmApvcnduHKnW2krNIZYAEWP/b3sZ+3USkJ4kLTuBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728796617; c=relaxed/simple;
	bh=fIzRBXSOO+dxpaYVoJyqkg9GLudSmxuh9CFKoFX8k14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTHN/sKrH6Jd21f+gddFC5yc9W/4acBiox8blmCzM39Be2AqbmZQVhA/okBXcdN5aEbk+cjnBrKr/UdUCb/Rh7y+ATSLgTRM/2+uASRPlQzVT2xd3b/uWJDYkf5OrzxfFGqCXgJhcVEQHQW0m9mm+vOH59Gykmg86uoRQ4vBoPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=c7kXOqTK; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46041d86566so17204681cf.3
        for <linux-efi@vger.kernel.org>; Sat, 12 Oct 2024 22:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728796613; x=1729401413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFCs9PVCOi6nYpoct0VXtnvh8Q54CTxgvHENhcgbqFw=;
        b=c7kXOqTKuWxcUSIXOLiWlQnthDTpRpzu1Bmp32d1jXx/eC8BUzpZczF9Sh2TXG5e8y
         9oiTCYwomBROXwtUhzLaRS+eMrfQ9QlN8+0tFuVW7vbh6H90Ar8aiXuS+VmO5ZWaQHXp
         +IKFdncOptkUvcvJ/Q0KQSx8SBrq7HicTdjFSDkLd/w6prZPd3tUsCyLoL8BBw5Ho6AL
         /3grdBKgqeaP44hmgl1RNiKXRzwcQOYuoBLf1Tx3vFuiusZnfK3qyqrd/u/Oso+0fCrw
         PAC52Gny/DuMnoq8pnqvJ1dIBO8u9NWC0gwL0KP1P0+r6OgqO8gfJvIsgQM0HglttYuR
         O4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728796613; x=1729401413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFCs9PVCOi6nYpoct0VXtnvh8Q54CTxgvHENhcgbqFw=;
        b=N/K1KMrtgEik9KLHywV5QdaEdOggJWgNOg7X3aAuhfxHPgBGSBdljCHz4rjpKebgp4
         31knFwo2rQyyD8vZRE/AxqCFQXjSliVYFNzExwQSHXoFwadcw2LGwX11cp9MCPPC5ryu
         d7vK3Goamrzstlxiku/9MdTScpXqOYSQEYEhpRbc7jwoJZt5o6yQrSw17CzWG8ugUwWW
         yRFCvSFva3TGShBW4KEakvrba205CPlVvKoFT571Z0wfEQlvydDuXXjYcvaRyPfwSoJt
         n71BygJ6goUs4vs4j5kG24smA7c6K+0DCNHOBZDiVM67bVKS9pttmR/Z29T6aAVwW1PC
         WhKg==
X-Gm-Message-State: AOJu0Yy7AGKLwwLN8XaSVqIGyH/kMwgz7794SyBmQHbDsq4GsCJbVVzg
	FCyGvf0Ksp1WnYXBNokRT6N7zgSWMWKwrOct8Ox6SIYKEXD5crP65A9tgC3Ybjh3nuPYgeaJL84
	GnxA=
X-Google-Smtp-Source: AGHT+IHG/xSyGmuyE8zwbcJNVk9iuBjHLpkXy8T1dg6AUG/GGj7Wobe9jHwQHwbRGzlAQ/O6I9nPgQ==
X-Received: by 2002:ac8:7d47:0:b0:458:4eae:6c6c with SMTP id d75a77b69052e-4604bbcccb2mr102971461cf.30.1728796613223;
        Sat, 12 Oct 2024 22:16:53 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427dafc0sm31457681cf.35.2024.10.12.22.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 22:16:52 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Aditya Garg <gargaditya08@live.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] efi/libstub: remove unnecessary cmd_line_len from efi_convert_cmdline()
Date: Sun, 13 Oct 2024 01:11:57 -0400
Message-ID: <20241013051239.22564-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241013051239.22564-1-jonathan@marek.ca>
References: <20241013051239.22564-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

efi_convert_cmdline() always sets cmdline_size to at least 1 on success,
so the "cmdline_size > 0" does nothing and can be removed (the intent was
to avoid parsing an empty string, but there is nothing wrong with parsing
an empty string, it is only making boot negligibly slower).

Then the cmd_line_len argument to efi_convert_cmdline can be removed
because there is nothing left using it.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 3 +--
 drivers/firmware/efi/libstub/efi-stub.c        | 5 ++---
 drivers/firmware/efi/libstub/efistub.h         | 2 +-
 drivers/firmware/efi/libstub/x86-stub.c        | 3 +--
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index de659f6a815fd..e7346f8edb38c 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -327,7 +327,7 @@ static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
  * Size of memory allocated return in *cmd_line_len.
  * Returns NULL on error.
  */
-char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
+char *efi_convert_cmdline(efi_loaded_image_t *image)
 {
 	const efi_char16_t *options = efi_table_attr(image, load_options);
 	u32 options_size = efi_table_attr(image, load_options_size);
@@ -405,7 +405,6 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 	snprintf((char *)cmdline_addr, options_bytes, "%.*ls",
 		 options_bytes - 1, options);
 
-	*cmd_line_len = options_bytes;
 	return (char *)cmdline_addr;
 }
 
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 2a1b43f9e0fa2..f09e277ba2108 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -112,7 +112,6 @@ static u32 get_supported_rt_services(void)
 
 efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 {
-	int cmdline_size = 0;
 	efi_status_t status;
 	char *cmdline;
 
@@ -121,7 +120,7 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 	 * protocol. We are going to copy the command line into the
 	 * device tree, so this can be allocated anywhere.
 	 */
-	cmdline = efi_convert_cmdline(image, &cmdline_size);
+	cmdline = efi_convert_cmdline(image);
 	if (!cmdline) {
 		efi_err("getting command line via LOADED_IMAGE_PROTOCOL\n");
 		return EFI_OUT_OF_RESOURCES;
@@ -137,7 +136,7 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 		}
 	}
 
-	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && cmdline_size > 0) {
+	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
 		status = efi_parse_options(cmdline);
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to parse options\n");
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 685098f9626f2..76e44c185f29e 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1056,7 +1056,7 @@ void efi_free(unsigned long size, unsigned long addr);
 
 void efi_apply_loadoptions_quirk(const void **load_options, u32 *load_options_size);
 
-char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len);
+char *efi_convert_cmdline(efi_loaded_image_t *image);
 
 efi_status_t efi_get_memory_map(struct efi_boot_memmap **map,
 				bool install_cfg_tbl);
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f8e465da344d5..188c8000d245e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -537,7 +537,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
 	struct boot_params *boot_params;
 	struct setup_header *hdr;
-	int options_size = 0;
 	efi_status_t status;
 	unsigned long alloc;
 	char *cmdline_ptr;
@@ -569,7 +568,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	hdr->initrd_addr_max = INT_MAX;
 
 	/* Convert unicode cmdline to ascii */
-	cmdline_ptr = efi_convert_cmdline(image, &options_size);
+	cmdline_ptr = efi_convert_cmdline(image);
 	if (!cmdline_ptr) {
 		efi_free(PARAM_SIZE, alloc);
 		efi_exit(handle, EFI_OUT_OF_RESOURCES);
-- 
2.45.1


