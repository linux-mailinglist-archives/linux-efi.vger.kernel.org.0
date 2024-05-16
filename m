Return-Path: <linux-efi+bounces-1040-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CD88C7374
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 11:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304561F23A20
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 09:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562B2142E75;
	Thu, 16 May 2024 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SdRdpQPZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F2142E8E
	for <linux-efi@vger.kernel.org>; Thu, 16 May 2024 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850358; cv=none; b=Rb1GTWI/vXIih2/hT73BIVF0qIqf1gYKKD2g8746S6lpaLtM8H7/qO90e9N61+wg5WmRvpLF/oW6Gd/ophU+0H2KHzURuSjRNXF2FQhz/GTuULP0brUMRgC33gliIrO8WImtIgJMOk2wfmo+E3rvNtId5RWVj723qP6DTVyy878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850358; c=relaxed/simple;
	bh=0E+gPqH6jSJafScL9pyYv33ymYZlJA8AedYepE0ldGY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gno0+fR4T2OIl/Mp4ZRQzl3bHk8NMfUutoKpuWcVa30P2m6/8uE/JRhEXa+RyjJLpE1NV3MhU6hizWOYHAC0UCEq/X199dF7Y+Mn5iONnXEQpcH9EOiHx58J1VrYS1XBd1YzcGILPJ2SyXyhWZuY9Ie+QOcgsTEWNymYjkftATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SdRdpQPZ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4200e6a9901so29610895e9.3
        for <linux-efi@vger.kernel.org>; Thu, 16 May 2024 02:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715850355; x=1716455155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eCVjg4sqSDfY9TI5zH06fjgzS/36wYmW5IVSJ2sv/qA=;
        b=SdRdpQPZUsg7VDeysAh0OEXsppk9PcbWNAimh5KzdU8ojMTRQ1U8RxGxNrYVZzco12
         u9eM8fsn2hjDZtxJbMQmQ7m27tIDX5ogq5IT0DXdyWeUVgD3PYC2wabooCdwhFleovKt
         XoO4ksK7yKHXkDacT+iIZJKluRviDnsc73mQPn0Kej15PyCFE+nXYXDjtL5hl0Tn+siI
         FGy7yLbZiFRmfC4Bvo8QZYP+oXSAlZMZSnzgt1qSCftE/AIz1HPpAA7652jd3xiQoasE
         9xuqCZ7mdU8ai1Ak+QfmwtQEhgLV/UDwaQ+kTXaznY3Qny3XxfFa20RBOHNILQ0/7IIC
         lbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715850355; x=1716455155;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eCVjg4sqSDfY9TI5zH06fjgzS/36wYmW5IVSJ2sv/qA=;
        b=Y/RF8m0vHDmfVZmpOVXUxdyANbzZIRWMdjjze61wSGP5tzSnVCOMloekcELEebcgqe
         0LClPSL6t/udRu3+gXH/TSjot5xmL2XN4ckvMSV6923mGXzJxt3tIInVTBmLm07P9urN
         t06jr8UPUXjAB/OUxrGoXY0kH/EkHEg6aZ2dVIjVlucORBanPilOe6QiGwF/fK+0xhiz
         PvzDswzmYWXhBi3WCQjgKzh6kg4wGeWn8voCprvO1WFycmv5qmjJmSVuEppjtRJQ71ki
         0DWeW9bDNUx3rTE9StgTgBm08dCXegdJbkjwYcrVoOaJnIFR6B5R14w9tSjefpFJ5FzJ
         +edQ==
X-Gm-Message-State: AOJu0Yy4d3eP4rKtqHPj0Udsh+rWHm8U4W4TvlW+qIHNWGNX+bO3Y3va
	04lre8LL8+jKB+sFqEfvruvMIz9BysoRoeMCxHvmz3Ie1PkmJGfvg1Ti5/EFnrw1TzCzn3U+h10
	slYR73Uo89tpfwLrqE2BwrBZ9zWhucSruvOK6Le4p1dLaZy8XvbNMTgyliK6L09aA2ve7JufFJz
	y0knjRbrT3GtEvLwW1HEtjFNbRrQ==
X-Google-Smtp-Source: AGHT+IExAYePWaQ3A5GVUKfOSn5p57YB46bPWL6/P0sXj67q8bQsgVt0zHPnfetLFURFlbMeUdkLlKxe
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1d86:b0:420:2962:242d with SMTP id
 5b1f17b1804b1-4202962261cmr141205e9.8.1715850354957; Thu, 16 May 2024
 02:05:54 -0700 (PDT)
Date: Thu, 16 May 2024 11:05:42 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4092; i=ardb@kernel.org;
 h=from:subject; bh=TsQg8UBvrS233z0bzqtKVfmyw4Ycif6w17yanCPXV7E=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIc31TBpHW/RC/rlrTUxnZcf/uLb3/ESheT/barJqLDtiq
 jO2qT/qKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOJ3s7I8KtS7ou1ytW3Sswh
 c9W+XfX6vcPqrIfP98XVXFe+39F4EcPwzzBp5vzKGrUX64NiNJ5+vGxuy8HzPdHQMu3c8t5a99e 8vAA=
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240516090541.4164270-2-ardb+git@google.com>
Subject: [PATCH] x86/efistub: Omit physical KASLR when memory reservations exist
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: keescook@chromium.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Ben Chaney <bchaney@akamai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The legacy decompressor has elaborate logic to ensure that the
randomized physical placement of the decompressed kernel image does not
conflict with any memory reservations, including ones specified on the
command line using mem=, memmap=, efi_fake_mem= or hugepages=, which are
taken into account by the kernel proper at a later stage.

When booting in EFI mode, it is the firmware's job to ensure that the
chosen range does not conflict with any memory reservations that it
knows about, and this is trivially achieved by using the firmware's
memory allocation APIs.

That leaves reservations specified on the command line, though, which
the firmware knows nothing about, as these regions have no other special
significance to the platform. Since commit

  a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")

these reservations are not taken into account when randomizing the
physical placement, which may result in conflicts where the memory
cannot be reserved by the kernel proper because its own executable image
resides there.

To avoid having to duplicate or reuse the existing complicated logic,
disable physical KASLR entirely when such overrides are specified. These
are mostly diagnostic tools or niche features, and physical KASLR (as
opposed to virtual KASLR, which is much more important as it affects the
memory addresses observed by code executing in the kernel) is something
we can live without.

Closes: https://lkml.kernel.org/r/FA5F6719-8824-4B04-803E-82990E65E627%40akamai.com
Reported-by: Ben Chaney <bchaney@akamai.com>
Fixes: a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
Cc: <stable@vger.kernel.org> # v6.1+
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 28 +++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index d5a8182cf2e1..1983fd3bf392 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -776,6 +776,26 @@ static void error(char *str)
 	efi_warn("Decompression failed: %s\n", str);
 }
 
+static const char *cmdline_memmap_override;
+
+static efi_status_t parse_options(const char *cmdline)
+{
+	static const char opts[][14] = {
+		"mem=", "memmap=", "efi_fake_mem=", "hugepages="
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(opts); i++) {
+		const char *p = strstr(cmdline, opts[i]);
+
+		if (p == cmdline || (p > cmdline && isspace(p[-1]))) {
+			cmdline_memmap_override = opts[i];
+			break;
+		}
+	}
+
+	return efi_parse_options(cmdline);
+}
+
 static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 {
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
@@ -807,6 +827,10 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 		    !memcmp(efistub_fw_vendor(), ami, sizeof(ami))) {
 			efi_debug("AMI firmware v2.0 or older detected - disabling physical KASLR\n");
 			seed[0] = 0;
+		} else if (cmdline_memmap_override) {
+			efi_info("%s detected on the kernel command line - disabling physical KASLR\n",
+				 cmdline_memmap_override);
+			seed[0] = 0;
 		}
 
 		boot_params_ptr->hdr.loadflags |= KASLR_FLAG;
@@ -883,7 +907,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	}
 
 #ifdef CONFIG_CMDLINE_BOOL
-	status = efi_parse_options(CONFIG_CMDLINE);
+	status = parse_options(CONFIG_CMDLINE);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to parse options\n");
 		goto fail;
@@ -892,7 +916,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
 		unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
 					       ((u64)boot_params->ext_cmd_line_ptr << 32));
-		status = efi_parse_options((char *)cmdline_paddr);
+		status = parse_options((char *)cmdline_paddr);
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to parse options\n");
 			goto fail;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


