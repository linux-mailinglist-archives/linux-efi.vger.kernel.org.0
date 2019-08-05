Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD5C81323
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2019 09:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfHEH1R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Aug 2019 03:27:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45197 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEH1R (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Aug 2019 03:27:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so39162291pfq.12;
        Mon, 05 Aug 2019 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7V3vHCmvIyymKb6Z8EX6Xtx5UX/ukka4A2oRBOP7X8=;
        b=DXZoBd9DYaNN+Z+siZf6HZa0aO4n+LYEfrBldhcH7WiXXTk7ruOWbdjHNf5Lombh/X
         TKAiq1VgX3FKz1pahP9g/JkFbQyk00dc5YNEyLzHbTn5oa0OolDtNX2yYHilMIrb7FEc
         dwjHGhcQc3CMQbi8jXplmjAgA50xncfNU31mI3DRk9pzIdEzn4NWSxIyBvoQhJGngAhw
         JJfF7RYEx54J6AmABZPZwQL6Zrm60y9K/HPuY/weLwwa6XUeZKIc6hxdL8FhztCcv5Ra
         qzJ7cxgXcG3weVEebsHma+qOIs8gwiAT/CTiyUm2n/rjBzGUsS8DtG2jn9KUbEiFQRr4
         DaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7V3vHCmvIyymKb6Z8EX6Xtx5UX/ukka4A2oRBOP7X8=;
        b=GIh6T2b0F4DcS8RUfrpQ99RHRWBBnwi8T9gXa2NFPdt32CApO0WSE+zHaoU/uNio1G
         XrWhu2+UVrkn41NUM7ec8L1WYYQNWKQiYpKIlXHCd/6f8K0k/Quw0E6bplHDUNDZyYjv
         d/PTcUxFi6Ot81hcAeVsNVhsWlSnmCcatPfYd5w5zl4rJtjz/NcyVDnqLeS6Vhc1pCv2
         HJN1qYBZQVEhDegTbF5OwTAb6k+ZdfIF/tsFY4FsMUC15TkKf/F4JV5IDpWzHRhqJxY7
         BIA+bREMxaMRZ3j2/b0yEU7XXpqbE0r1I8wxAp8tbmDyYBbvz4MFruDlZITtQZ+bXmnJ
         KXsw==
X-Gm-Message-State: APjAAAXapPZ7hBZD96Kj3+CtAC0vxJkJIxYhr3KA78XhZoqWbLlcE8sF
        3tMp5rUP78u45q5qFGvFHFs=
X-Google-Smtp-Source: APXvYqztqaX/P9wlIIwN2Nt3ZpFTaWhrIp7Yw6rsZdMkJ0QIEYpYO2N7vrmHssIIzug1PtRv+pU7PQ==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr16517668pjz.140.1564990036698;
        Mon, 05 Aug 2019 00:27:16 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id o3sm15840301pje.1.2019.08.05.00.27.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 00:27:16 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 2/2] ia64: Replace strncmp with str_has_prefix
Date:   Mon,  5 Aug 2019 15:27:09 +0800
Message-Id: <20190805072709.345-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

strncmp(str, const, len) is error-prone since the len is
easy to be wrong because of counting error or sizeof(const)
without - 1.

Use the newly introduced str_has_prefix() to substitute
it to make code better.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 arch/ia64/kernel/acpi.c | 9 ++++-----
 arch/ia64/kernel/efi.c  | 2 +-
 arch/ia64/kernel/esi.c  | 2 +-
 arch/ia64/kernel/sal.c  | 2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index c597ab5275b8..f01e6fb2f962 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -77,7 +77,7 @@ acpi_get_sysname(void)
 	}
 
 	rsdp = (struct acpi_table_rsdp *)__va(rsdp_phys);
-	if (strncmp(rsdp->signature, ACPI_SIG_RSDP, sizeof(ACPI_SIG_RSDP) - 1)) {
+	if (!str_has_prefix(rsdp->signature, ACPI_SIG_RSDP)) {
 		printk(KERN_ERR
 		       "ACPI 2.0 RSDP signature incorrect, default to \"dig\"\n");
 		return "dig";
@@ -85,7 +85,7 @@ acpi_get_sysname(void)
 
 	xsdt = (struct acpi_table_xsdt *)__va(rsdp->xsdt_physical_address);
 	hdr = &xsdt->header;
-	if (strncmp(hdr->signature, ACPI_SIG_XSDT, sizeof(ACPI_SIG_XSDT) - 1)) {
+	if (!str_has_prefix(hdr->signature, ACPI_SIG_XSDT)) {
 		printk(KERN_ERR
 		       "ACPI 2.0 XSDT signature incorrect, default to \"dig\"\n");
 		return "dig";
@@ -106,8 +106,7 @@ acpi_get_sysname(void)
 			 sizeof(xsdt->table_offset_entry[0]);
 	for (i = 0; i < nentries; i++) {
 		hdr = __va(xsdt->table_offset_entry[i]);
-		if (strncmp(hdr->signature, ACPI_SIG_DMAR,
-			sizeof(ACPI_SIG_DMAR) - 1) == 0)
+		if (str_has_prefix(hdr->signature, ACPI_SIG_DMAR))
 			return "dig_vtd";
 	}
 #endif
@@ -348,7 +347,7 @@ acpi_parse_nmi_src(union acpi_subtable_headers * header, const unsigned long end
 
 static void __init acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
-	if (!strncmp(oem_id, "IBM", 3) && (!strncmp(oem_table_id, "SERMOW", 6))) {
+	if (str_has_prefix(oem_id, "IBM") && (str_has_prefix(oem_table_id, "SERMOW"))) {
 
 		/*
 		 * Unfortunately ITC_DRIFT is not yet part of the
diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index 3795d18276c4..615e73bd88fd 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -434,7 +434,7 @@ static void __init handle_palo(unsigned long phys_addr)
 	struct palo_table *palo = __va(phys_addr);
 	u8  checksum;
 
-	if (strncmp(palo->signature, PALO_SIG, sizeof(PALO_SIG) - 1)) {
+	if (!str_has_prefix(palo->signature, PALO_SIG)) {
 		printk(KERN_INFO "PALO signature incorrect.\n");
 		return;
 	}
diff --git a/arch/ia64/kernel/esi.c b/arch/ia64/kernel/esi.c
index cb514126ef7f..d929689a99e4 100644
--- a/arch/ia64/kernel/esi.c
+++ b/arch/ia64/kernel/esi.c
@@ -70,7 +70,7 @@ static int __init esi_init (void)
 
 	systab = __va(esi);
 
-	if (strncmp(systab->signature, "ESIT", 4) != 0) {
+	if (!str_has_prefix(systab->signature, "ESIT")) {
 		printk(KERN_ERR "bad signature in ESI system table!");
 		return -ENODEV;
 	}
diff --git a/arch/ia64/kernel/sal.c b/arch/ia64/kernel/sal.c
index 9b2331ac10ce..9f02e3ec28e5 100644
--- a/arch/ia64/kernel/sal.c
+++ b/arch/ia64/kernel/sal.c
@@ -315,7 +315,7 @@ ia64_sal_init (struct ia64_sal_systab *systab)
 		return;
 	}
 
-	if (strncmp(systab->signature, "SST_", 4) != 0)
+	if (!str_has_prefix(systab->signature, "SST_"))
 		printk(KERN_ERR "bad signature in system table!");
 
 	check_versions(systab);
-- 
2.20.1

