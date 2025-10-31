Return-Path: <linux-efi+bounces-5281-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77CCC23DE9
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 09:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6006718930CE
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A562F7AB3;
	Fri, 31 Oct 2025 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Shpy9pJ1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AF12F261F
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900112; cv=none; b=rQEmO+9RG+h25mzeMF5Cbi4SH4z3VPMN41k7pVBANvv/iG16SujKtOiXRrQfpMMY0KwuyVI5+UZ0vUfdJlYx38PffebkC3hQ+0vhMDnzA7g32nvhXyqRmOFGl3zRrlXfFbRzfspR6gy3ghWbkc1+gHwJ5z34K/WWlDs8caRqb9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900112; c=relaxed/simple;
	bh=2lUvWhdB4NGL1LqZv/NPiW3WqcOoMBXkMooN1SEI71Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKOycpqS6vOjDHKScgMYIncirwvDQtSitJrFleXxr+Gf0HcIkOqQpni8Hc9wv++kR/qKhHAnbRjuYhq6ow0SzUkApQPDBJDBmHLfkkPBfHXilMj5w3tj0CcfmqysB+eVy5glswWEJqOfRkRUnQFuVTGMmxrZHMwloA9DNhGj1F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Shpy9pJ1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-295291fdde4so623265ad.2
        for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 01:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761900110; x=1762504910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFAEjrMWY0ykRF/jVrSGE7UxJKIHOGktXm16t+/fBBQ=;
        b=Shpy9pJ1pX+VPBywXn2XBYS47VcPCO5ieTHaWN8Y391/9+jTtCU9bTxh/Sk7Zw4cZu
         4T/2VXfu+ZyVQqX92lN4uKsSTGEWnU+jvM42pzc7pJDFOnQoBoVuleaaAW1ouXpRRVuk
         2U3a5YyivAC42MU7+W8Rf73t1nYcu1sVB/FzjaHlB4lr1q+De7s48aky/VtFUInie04P
         eR7lEixjrWr/8tkjAZi7IAEJguEa8DqRoWa5cRZH0UWxmdhsr4+30gXpDqvYiU6VPIhG
         exqIeP0P10/j3G2gGxJXYvb+2GT7iR6Ivu9b80/AW2E5dyLkKzBXnsgFlZeIlyGErmSp
         YANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761900110; x=1762504910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFAEjrMWY0ykRF/jVrSGE7UxJKIHOGktXm16t+/fBBQ=;
        b=GNBQe6JnxJt6VBIAnYuJBvpp7DK1QkYnrCbZiDpKRF4Q209adYzAauCACnMmfUmqv4
         sUHjALr2bLyB7408U4/XG3FFakOlfuzyL2RHxLPCqZj7M1NRA9YEaV7b/c3nAv5EYPJI
         7EVwgmbZEfWHmdaXFAR7OvnWwWuL6nWMvQDNksYfb8bAkfRTeJONbd08LLVTJ0EOnvgY
         BAx08UVSpDACO0PD+XiVKxBmuAAnzHg9E2emCBrqHutAkWMuUq9OqvtN+zCqW2RaHXpV
         UOIKfmKijlsidgnTpJj+xxlTddqtSmv0Cq1OhnOBhjTmOv8sKDpijgJqX+Kfaq29kKkV
         5l5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXePa/jVFIvjk9L97Kq/J2ZPZthO2Q3SqYpd3RT9Qak7RgsdUYKcOueSnojbvbU9BpTUNieRMxhcD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYnYCff7IH9bVJnwXjMPUtqk+zM1GDfifu3xyeK39iIka8YBTB
	TACjP2Bn7YSth4tvQLjne7w0f56mOGSzvyPoFLKal8GySjOssq/e0+48zdQ6TgqYug==
X-Gm-Gg: ASbGncu78gyuH6flSOG7uy88fRLLbRrMdAVjr4uIpqHlP6kewNOztmeVINwUcQMOeWB
	9OsSG09wnH1PhZ9QNrqcIBqUD1qfpbd6BMY7uWz4+E8Hq2bb/uABZVUQOPYCs8ZT40K9CRTfVVR
	8K/fMozgCmmmbFlpXj29DALLXO9+cTrL+psNizlH856lFnLcfUMF3FyyQqZ1leQBrnQCVma2lq6
	95GKiQxgZXIkYFXLodF7PvckBfhnLnic3n52dvArzvnT3S//JCXxSNSYnPB5u+mjHKhC4zQiqfU
	c6FnwYHMzzZgx/zTiAzviF4/EgmCITFS4ttyljYb+xWKd85feKdUJ8QedLgDb2ypG+RW5bQp80g
	H2Pk/ao90R7NfPkFAHmHWSqQhIA4t7SyAinwGNsdtB19EL/ER0azKRr0PSQm4JM8BwN6Fi/S03D
	UGM7hu4QxBPSBcqnlzaWVXeyqMEyvqIMWrNUMyPzTGjVjqE0zhJtpFo/Ga4A==
X-Google-Smtp-Source: AGHT+IFFLWa19f/FrNdVnPDEN0o0mcIg80kenGGv9VHwXgspqh1uTCGkvt60mnvGNp1nA2FhcS1EEQ==
X-Received: by 2002:a17:902:c412:b0:264:cda8:7fd3 with SMTP id d9443c01a7336-2951a46d112mr24813365ad.6.1761900110413;
        Fri, 31 Oct 2025 01:41:50 -0700 (PDT)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699c9dbsm15333505ad.84.2025.10.31.01.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:41:50 -0700 (PDT)
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
	Adriana Nicolae <adriana@arista.com>
Subject: [PATCH v3 2/2] drivers: firmware: dmi_scan: Add support for reading SMBIOS from DT
Date: Fri, 31 Oct 2025 01:41:01 -0700
Message-ID: <20251031084101.701159-3-adriana@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031084101.701159-1-adriana@arista.com>
References: <20251022114527.618908-1-adriana@arista.com>
 <20251031084101.701159-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adriana Nicolae <adriana@arista.com>

Signed-off-by: Adriana Nicolae <adriana@arista.com>
---
 drivers/firmware/dmi_scan.c | 58 +++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 70d39adf50dc..acc0e18b8d0f 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -10,6 +10,9 @@
 #include <linux/random.h>
 #include <asm/dmi.h>
 #include <linux/unaligned.h>
+#if IS_ENABLED(CONFIG_OF)
+#include <linux/of.h>
+#endif
 
 #ifndef SMBIOS_ENTRY_POINT_SCAN_START
 #define SMBIOS_ENTRY_POINT_SCAN_START 0xF0000
@@ -670,6 +673,54 @@ static int __init dmi_smbios3_present(const u8 *buf)
 	return 1;
 }
 
+#if IS_ENABLED(CONFIG_OF)
+/**
+ * dmi_scan_from_dt - Find and parse DMI/SMBIOS tables from the Device Tree
+ *
+ * Checks if the bootloader has passed SMBIOS table addresses via the /chosen
+ * node in the Device Tree. This follows the standard kernel DT bindings and
+ * assumes a fixed 32-byte mapping for the entry point.
+ * Returns true if a valid table is found and successfully parsed.
+ */
+static bool __init dmi_scan_from_dt(void)
+{
+	struct device_node *chosen;
+	const __be64 *prop;
+	char buf[32];
+	void __iomem *p;
+	bool dmi_available = false;
+	u64 addr;
+	int len;
+
+	chosen = of_find_node_by_path("/chosen");
+	if (!chosen)
+		return false;
+
+	prop = of_get_property(chosen, "linux,smbios3-table", &len);
+	if (prop && len >= sizeof(u64)) {
+		addr = be64_to_cpup(prop);
+
+		p = dmi_early_remap(addr, 32);
+		if (p == NULL)
+			goto out;
+
+		memcpy_fromio(buf, p, sizeof(buf));
+		dmi_early_unmap(p, 32);
+
+		if (!dmi_smbios3_present(buf)) {
+			dmi_available = true;
+			goto out;
+		}
+	}
+
+out:
+	of_node_put(chosen);
+	return dmi_available;
+}
+#else
+static bool __init dmi_scan_from_dt(void) { return false; }
+#endif /* IS_ENABLED(CONFIG_OF) */
+
 static void __init dmi_scan_machine(void)
 {
 	char __iomem *p, *q;
@@ -718,6 +769,13 @@ static void __init dmi_scan_machine(void)
 			dmi_available = 1;
 			return;
 		}
+	} else if (IS_ENABLED(CONFIG_OF) && dmi_scan_from_dt()) {
+		/*
+		 * If EFI is not present or failed, try getting SMBIOS
+		 * tables from the Device Tree.
+		 */
+		dmi_available = 1;
+		return;
 	} else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) {
 		p = dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10000);
 		if (p == NULL)
-- 
2.51.0


