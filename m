Return-Path: <linux-efi+bounces-3901-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2790AE28D5
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 13:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500E4171157
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 11:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270DC210184;
	Sat, 21 Jun 2025 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ae78bcYu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B0C1F3FF8;
	Sat, 21 Jun 2025 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750505660; cv=none; b=mvpOxjbaf5kq2rRXsK1mwny+KO1n56+6uf3hOt3hB0SOiMQ0qcx1TVhXp0MWNM0t/7lYA2ooBDYL0/CIFitirXCSQKBMK57sTNbhkALLIpXpH7mdPunat5AEDihYHX+OBiSoopelErWPD9KOWoPVbyiE6agocIZiDZDf/dVdpzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750505660; c=relaxed/simple;
	bh=SxfvbnWricSVk2rr9LYbXJtXiy8oTDx7l02AiN+NxP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D68maEipUNz+MASjnv24tA31kvXcs26Wy2ZjlO/pVGeXDSsETPguOtSAsySYRjMRohp5Ii15v88lxQBYGEt+9DQwtUjUhb/BWSOoFQJ0PrxwVdUHAfIBOg6fyvwwDiGh8EMmcuXbKRjoE6pgiOzGskR1bgt1KVGTn+Fa9XLL1Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ae78bcYu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45348bff79fso30012585e9.2;
        Sat, 21 Jun 2025 04:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750505657; x=1751110457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hzc1DejGfVwQjMkwxmm6tr2D5X64wbt/M5/qE0zLhZA=;
        b=ae78bcYum3nIzwsO4ZYnDpqs136J4uMNEsZoI4DEIq+kFgCaghy+TeYnCAyCZCbCoL
         1Icu4rdW8IlAXZN5EgFloak2qxcxanV7+QEOzS3hveEXic1CPxye/O6nOjQ4k5LdQW3n
         SVKm08XeVdcydDdlWHy5Op1vqpRpH5SoMwBPuu1OqAiFZMwdjfQz7Smj1+CtSV+KkO43
         iDjknqETkoT4XJdy/+9OGv+GucvRmaxVy5wS2RXP2x0YCDWlR0qMbB+sY0Q9cBiZvrPS
         t/tydk8Pz/yn10Fp38QcjKKFdXbZboYVfR3WKslTzX4vRHSWUEoBYO3vvjRMensnn60u
         iisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750505657; x=1751110457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzc1DejGfVwQjMkwxmm6tr2D5X64wbt/M5/qE0zLhZA=;
        b=P0cFbe9rRUpwvqRohYspUeawtG8yGB+bwBcEFGTbRJcsSX6NGFEmSnpxOMv2ofeV9N
         GheAN/7+cFXmiECg7XvEQcU0oFeCXXk5bOMEHo1yl97iRJetj7PEsAcsuxFowSVCPDDI
         zXSG4Lzqcr+BiZ1Ibzc9umy2eKLtgUF8hDQ3uJVsg8LOxM/dJ8plW+XcSEuMJq8Oe3T7
         rVrnpqfm7WKroVnMWZOqXehlpTIAz7rwiQKZu6mzq34U7LN76Sk3LfzSrotnsJeSJI77
         9dLZm8SRABiW64kBs36xwBe/Cycg72LGzWbdeOICp+PPkHrj5wZvC4Z5o271FwDNemxu
         4kwg==
X-Forwarded-Encrypted: i=1; AJvYcCV2vD+ZCr5znown9HFGY39Q/w7g1quRGyf65YthhmGhHIXAdu6n5IyytUx9qLxZdGyvUauqpt6TbuXy+os=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyG7TDOeyQ1RiZ8nIUlwtal+WfJA1xbXzVhVckmulzm6x5JYBs
	XYLnFp9VxbR5l77PZwhiWQVM2PspWG6KSjzHMKsHAPCu/1dz/zlZFkbX
X-Gm-Gg: ASbGncs6H78oYKzCTQaKAuHC6IsIhJOi9fTEuy/PZIJz9jhqzSHHWiGEOzeUeYcoA+F
	t8kbWVWNCzmEbESHJSrXdkDqqsm4S+qdexoYvRkq/rJp97vzphA9sLsQ9SwAh0wnbR+HVj2QfZB
	7h14KgyGkfJWRZolFk910OodE0yIRVJTiPB7UICzeE4Us8EG7fOjvjgYMa8SkSHhEkyan5SF8ka
	pfobABZuJvWLFZJ7sjCMkDwGhxgYav6IMjPr+L6pKYsnPuseIzkbZ+y+RSDBHEdnv7416RkRPbY
	TSqJ/MhBSam4cZlaBMLTaVmLKhdVMvJR5Kc4E6vtIx3lUV9t2NcX3LNCuBxaDJZafwaTIs0Dwu8
	nTw==
X-Google-Smtp-Source: AGHT+IGx+D4eCsVnjUnX6B9AebadC3/x2ggnJ0+naCHpyvZdZHYNfxv+XTEfeB2PCW7TVHieUw5hTA==
X-Received: by 2002:a05:600c:34c4:b0:450:30e4:bdf6 with SMTP id 5b1f17b1804b1-453659dccb8mr52620085e9.19.1750505656402;
        Sat, 21 Jun 2025 04:34:16 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d1187df7sm4490910f8f.66.2025.06.21.04.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 04:34:16 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: ardb@kernel.org,
	lukas@wunner.de,
	bp@alien8.de
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khalid Ali <khaliidcaliy@gmail.com>
Subject: [PATCH] efi/libstub: Print status codes on failure
Date: Sat, 21 Jun 2025 11:33:32 +0000
Message-ID: <20250621113334.7789-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khalid Ali <khaliidcaliy@gmail.com>

Print status codes on errors. This makes easier to understand the reason
of failure.

Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cafc90d4caaf..09ed1c122106 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -846,14 +846,14 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	status = efi_setup_5level_paging();
 	if (status != EFI_SUCCESS) {
-		efi_err("efi_setup_5level_paging() failed!\n");
+		efi_err("efi_setup_5level_paging() failed, status %lu\n", status);
 		goto fail;
 	}
 
 #ifdef CONFIG_CMDLINE_BOOL
 	status = parse_options(CONFIG_CMDLINE);
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to parse options\n");
+		efi_err("Failed to parse options, status %lu\n", status);
 		goto fail;
 	}
 #endif
@@ -862,7 +862,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 					       ((u64)boot_params->ext_cmd_line_ptr << 32));
 		status = parse_options((char *)cmdline_paddr);
 		if (status != EFI_SUCCESS) {
-			efi_err("Failed to parse options\n");
+			efi_err("Failed to parse options status %lu\n", status);
 			goto fail;
 		}
 	}
@@ -872,7 +872,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	status = efi_decompress_kernel(&kernel_entry, boot_params);
 	if (status != EFI_SUCCESS) {
-		efi_err("Failed to decompress kernel\n");
+		efi_err("Failed to decompress kernel, status %lu\n", status);
 		goto fail;
 	}
 
@@ -921,7 +921,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
-		efi_err("exit_boot() failed!\n");
+		efi_err("exit_boot() failed, status %lu\n", status);
 		goto fail;
 	}
 
@@ -935,7 +935,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	enter_kernel(kernel_entry, boot_params);
 fail:
-	efi_err("efi_stub_entry() failed!\n");
+	efi_err("efi_stub_entry() failed, status %lu\n", status);
 
 	efi_exit(handle, status);
 }
-- 
2.49.0


