Return-Path: <linux-efi+bounces-5289-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56374C24621
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 11:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE4D1A6022B
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BED339B5A;
	Fri, 31 Oct 2025 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NhSEC7Cc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6124027F16A
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905439; cv=none; b=co8tPMlHivaEQp1l8DdlBKR0p7Ex8IG8nELRqqUWO2edK+1hDV+3j1dItIZ3nZZCpun37Q5Ip2zH7t3UbavJGszCDFHZWSFFfSdr8jVLGZhUiL8a8ac9HhnxMbcHtOAL/aDfw4R77xJ9RlYJ1ZBev5pTOeGcd1RxprDwATrGUMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905439; c=relaxed/simple;
	bh=wMJte6XNIxKtOzu/Q9qpqBQzJfIqmGjSeN8ThIGDy+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfXpCeYwN3S0XfbppwhCH2ikhj4yr8aUsFRZi7stGNQgCVBebtM/3YRGoQ78VIS9lXnYl+lLZuJEwMJoR5quj7SjKATH872gisbji9d+9rCq+rv719N8OXEuD/PonQwn7ovX93obAmaj5DmxlFX6bgLD+lj+7wEbKIwKjkqbkDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=NhSEC7Cc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-295395ceda3so217735ad.2
        for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 03:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761905431; x=1762510231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/e5tjl72pLoATST6uvgUSXblWbJCqEWY7WIs3qpXwQ=;
        b=NhSEC7CcYqfHB4s4LPlvjaEXfqtKuVxTJnqf9mbG9UhvbCJeoKAPadm4tNKeokIeH5
         VMGYjZWOamtT1y7TMX/xmHdQslOCSTJmMTiBijsPo8x05ZOYRJ9SEPDhI5osqQvDpqB6
         HxRCtDmzjtEZzPREov29hH7uSN7lhNq4LzzT9RQjXRaoC3ng+aakJ4Yfiu4S7qGcuAD7
         8uv2paCiuLCpXWPphx20ugmNWIxCzeNWy2pzpwVLf582m8qFoD1gj7WdP/xw+tccOQXr
         o3c0zm8mrMjer++dKgXiAek9AaEy5whxmor2DLc2VhDdXRwt1bHD1SAwm8mDRYOeOjqq
         a6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905431; x=1762510231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/e5tjl72pLoATST6uvgUSXblWbJCqEWY7WIs3qpXwQ=;
        b=m6I8o/Y/1UUndAL7xBLp001OfroqoMdGwmKj+mLqaegcz72R0jq3spGA+JnI3Fp+yP
         McaIpyzGxcQzSl+4x+fGcXgZsGN6Wv1gCKNz7ABtEAMzqq/g0+OjAshKPIGqpwfK655p
         dzid0tB0mdKd8yrFQBd9QRvi40BPAcFFs3VAbgy21iIE0Y7AN8INK0cfPY2B7ARlwzO+
         Bj0aYtLaTZQOsQX9VOzVt6mtuYDsjitCdY8N/hAreu+nB1g9AesN3uZ3DiPQPFGl7uH/
         +Cm+ShVF8ayYfnnLZZaZp9D3TauCViUjU8VcfX+xTgD5ssIt4h2n+Q0NLaLYcE7rdYis
         LpEw==
X-Forwarded-Encrypted: i=1; AJvYcCU+54tQB7JoUiAC5kQE9vs0PeP5Uo5vC8q2w4KRnx4SQp1+7KKeVpPyvrVbSRAnzDjL/443+gouG6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywot1JyTULHCJL1YJDnth8wjw5NkP6D9UYIFAX1dTou88frSY0F
	/oRRW/u9BfZBbrxwDmiZjQTdIlsvsBzd64S4dOkTOI9Zm8g9nzm2nCTO5t2gKOZMDQ==
X-Gm-Gg: ASbGncuKVeBqldQ++p7ARPGE8z+g0QdypyfamRz7XXWgKOWYPhyRhPRKEkFEEGgykUs
	wazpxSwglglZOorQB+lSFwAGHt6VYTVaHa6QNz0sQmbrg19md0AOITg/zXHrUEOCcRDN4VLucd3
	eYmwQQ1IgMe7LJoIE8FiF7XB38wo4IMjcYtJbs75KFJlOVKV6xo6SzJv3knUMGJO+bzow1UFcv1
	eSC1BDOny3tzsCrtthdKxBm/98KIlF3usY6lcFcU25BuApIzNP8urV6a2n4fFCN7xm9kpm22vXm
	ZampTJxsrYe7YJ5qP6ssEXk4OyYSv99UYr/DS9Ixe+iP4cMnwoRuUBZUo76ZRNG2NjMKEURO2Vm
	c91AGUqQ0TjQkbAXGQc+4EsUnYpIlcum17hca9/17X+bVP9435CWYPGPqvX0/gtbyVhdD2UVENi
	/PhdGf7xd3XAIb4DeohyVVcj1TqOEmixuwJ5kqRPp2e5OcSk0=
X-Google-Smtp-Source: AGHT+IEBP5bjyyzwFFW9rk5+yU8llkt/2A95S3HRbdUz8eFDWn98s8uULia4xAwJsfbPjA7zk4U3Mg==
X-Received: by 2002:a17:903:38c8:b0:295:37ac:8d54 with SMTP id d9443c01a7336-29537ac8ec7mr3467745ad.9.1761905430618;
        Fri, 31 Oct 2025 03:10:30 -0700 (PDT)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952774570bsm17458545ad.99.2025.10.31.03.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:10:30 -0700 (PDT)
From: adriana <adriana@arista.com>
To: ilias.apalodimas@linaro.org,
	ardb@kernel.org,
	trini@konsulko.com
Cc: robh@kernel.org,
	krzk@kernel.org,
	jdelvare@suse.com,
	frowand.list@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	vasilykh@arista.com,
	arm.ebbr-discuss@arm.com,
	boot-architecture@lists.linaro.org,
	linux-efi@vger.kernel.org,
	uefi-discuss@lists.uefi.org,
	linux-arm-kernel@lists.infradead.org,
	adriana <adriana@arista.com>
Subject: [PATCH v4 2/2] drivers: firmware: dmi_scan: Add support for reading SMBIOS from DT
Date: Fri, 31 Oct 2025 03:10:09 -0700
Message-ID: <20251031101009.704759-3-adriana@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031101009.704759-1-adriana@arista.com>
References: <20251031084101.701159-1-adriana@arista.com>
 <20251031101009.704759-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some bootloaders provide SMBIOS/DMI tables at a specific memory address,
particularly on non-EFI ARM platforms. The kernel's standard EFI DMI
scanner cannot find these tables.

This patch adds a fallback mechanism to the DMI scanner to read the
physical address of the SMBIOS3 entry point from the device tree.

This scan is performed only if the standard EFI check fails.

Signed-off-by: adriana <adriana@arista.com>
---
 drivers/firmware/dmi_scan.c | 54 +++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 70d39adf50dc..c29ca98f09b5 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -10,10 +10,12 @@
 #include <linux/random.h>
 #include <asm/dmi.h>
 #include <linux/unaligned.h>
+#include <linux/of.h>
 
 #ifndef SMBIOS_ENTRY_POINT_SCAN_START
 #define SMBIOS_ENTRY_POINT_SCAN_START 0xF0000
 #endif
+#define SMBIOS3_ENTRY_POINT_SIZE 32
 
 struct kobject *dmi_kobj;
 EXPORT_SYMBOL_GPL(dmi_kobj);
@@ -670,6 +672,51 @@ static int __init dmi_smbios3_present(const u8 *buf)
 	return 1;
 }
 
+/**
+ * dmi_scan_from_dt - Find SMBIOS3 entrypoint address via Device Tree
+ *
+ * Checks if the bootloader has passed the physical address of the
+ * SMBIOS3 entrypoint structure via the "linux,smbios3-entrypoint"
+ * property in the /chosen node.
+ * Returns true if a valid entrypoint is found.
+ */
+static bool __init dmi_scan_from_dt(void)
+{
+	struct device_node *chosen;
+	const __be64 *prop;
+	char buf[SMBIOS3_ENTRY_POINT_SIZE];
+	void __iomem *p;
+	bool dmi_available = false;
+	u64 addr;
+	int len;
+
+	if(!IS_ENABLED(CONFIG_OF))
+		return false;
+
+	chosen = of_find_node_by_path("/chosen");
+	if (!chosen)
+		return false;
+
+	prop = of_get_property(chosen, "linux,smbios3-entrypoint", &len);
+	if (prop && len >= sizeof(u64)) {
+		addr = be64_to_cpup(prop);
+
+		p = dmi_early_remap(addr, SMBIOS3_ENTRY_POINT_SIZE);
+		if (!p)
+			goto out;
+
+		memcpy_fromio(buf, p, sizeof(buf));
+		dmi_early_unmap(p, SMBIOS3_ENTRY_POINT_SIZE);
+
+		if (!dmi_smbios3_present(buf))
+			dmi_available = true;
+	}
+
+out:
+	of_node_put(chosen);
+	return dmi_available;
+}
+
 static void __init dmi_scan_machine(void)
 {
 	char __iomem *p, *q;
@@ -718,6 +765,13 @@ static void __init dmi_scan_machine(void)
 			dmi_available = 1;
 			return;
 		}
+	} else if (dmi_scan_from_dt()) {
+		/*
+		 * If EFI is not present or failed, try getting SMBIOS3
+		 * entrypoint from the Device Tree.
+		 */
+		dmi_available = 1;
+		return;
 	} else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) {
 		p = dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10000);
 		if (p == NULL)
-- 
2.51.0


