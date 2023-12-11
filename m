Return-Path: <linux-efi+bounces-173-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835E980D503
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 19:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08CB8B21623
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 18:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDA24F1FD;
	Mon, 11 Dec 2023 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCqSWBoO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CF799
	for <linux-efi@vger.kernel.org>; Mon, 11 Dec 2023 10:11:27 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a541b720aso5202826276.0
        for <linux-efi@vger.kernel.org>; Mon, 11 Dec 2023 10:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702318287; x=1702923087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/5pZH83xd40lf8mshPHV4Bu4fE2RRzNDXL+mXoIHOvg=;
        b=GCqSWBoO0h6KE5kNmht8Y9f0yMmSR1eu8x6cobiiL+bWS+ljVYlTzv1lDR99cwYyfq
         nmfCQazTKULLO5w35xR75pTmwU4iWYJ6P/g2VnL7YfERfpOiWJOywNp+BpnWkJF7QFt6
         TDC7LxENsdNTdkYP9zo76btwvazqGNDskIuUWZUwwjyezsBZPoz+BrONp5K4B0Dg/X1c
         YGuuD6j3V2Ic0dMQiecP/mY3D7wT1DXfRM1BPIlSrxYVrycekCHi+tv/Es0pAsSfTaw8
         CL4/csXBEok8qw8fCKaqOEwl78/EQYxsKI6qcCNCfSxN8hMekGO2PSsN2YHlN2ZC3nzO
         2yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702318287; x=1702923087;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5pZH83xd40lf8mshPHV4Bu4fE2RRzNDXL+mXoIHOvg=;
        b=qfp8ksK7KTgvz77Qx2+ioWAIPm0VHEd6l/VRrAlLoxwszALjCEz3KOULZwrgEBi+xe
         buqN3EmZXO1QB8TvyR6m09mY+g+V8TuLKQxJWLbYO/RR/zbHg+3SPDHE12xS7Ova4jH/
         81zcyxiixgGFxzWihoeuGdUB2cqjot6cu8PsNHl3R93UXIkPALUPwsSJgU6iFrUHchn4
         OTkWvXlYCRqqnVmdRh6+0oGqNACuBgsp5Oc/NnsA8/1pm9cCOBlZV3qrxVML1h94OROb
         wsOUhvf1EUt0F0sQ/5TWrZajbELI8xWuoFTt7VVXKdScmfORr27O4wEP+fmJVoaw8cUB
         YJ2w==
X-Gm-Message-State: AOJu0Yz+xtWZsOq6eT581XRzycmn1prfv8Ddp5RBBYaVVO566thuLkLw
	fd6nvOmxtUwGlj7JqlwL0RkbLclVmY1AOAUCjWv2X3VWoVtrXI4vU5jHJcP8QcdFg3RIka4R1A7
	t1tDaF4c57/D6Y+JNCZmmSBTL7/omvtv2riEJn7paicwm+6tJnoReUsnEUq8G
X-Google-Smtp-Source: AGHT+IH5MdbS+buTqjf7LhwE9e9GRK1VawS6UjN6m5J0dQasxQvdelrWQAgVmBR6qZpxQKktAE2QdA7s
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:5cb:0:b0:dbc:6715:4a34 with SMTP id
 194-20020a2505cb000000b00dbc67154a34mr34707ybf.0.1702318286692; Mon, 11 Dec
 2023 10:11:26 -0800 (PST)
Date: Mon, 11 Dec 2023 19:11:21 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3328; i=ardb@kernel.org;
 h=from:subject; bh=mSK88QAWbTUGeXQUfyCIixRzqHJSZYrlTdfQrVmvKfg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIbU84OQfsV/+c5P9qt6qbazIl5V/7c3fZKZ2MqbmYtfHi
 l2fbcI7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETYnjD8s1R4KRW4xMv5/bIO
 AbmJyS7pZ1vf5/QIXqwIjd3Yv1T1EcM/vRM3Z8hf1e7asnDRE2OGrkk744I7aqZsCVgTrMN/TiK WGQA=
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211181121.1689992-2-ardb@google.com>
Subject: [PATCH] efi/x86: Avoid physical KASLR on older Dell systems
From: Ard Biesheuvel <ardb@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

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
 drivers/firmware/efi/libstub/x86-stub.c | 31 +++++++++++++++++++------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 1bfdae34df39..da9b7b8d0716 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -307,17 +307,20 @@ static void setup_unaccepted_memory(void)
 		efi_err("Memory acceptance protocol failed\n");
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
@@ -765,11 +768,25 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 
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
2.43.0.472.g3155946c3a-goog


