Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C649E10DF0D
	for <lists+linux-efi@lfdr.de>; Sat, 30 Nov 2019 20:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfK3TvC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Nov 2019 14:51:02 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38017 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfK3TvB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Nov 2019 14:51:01 -0500
Received: by mail-pj1-f66.google.com with SMTP id l4so3486750pjt.5;
        Sat, 30 Nov 2019 11:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XQ0WVvKPti4m7G1M9ywd0P6+oN8xaAUrgiUlxFUrE+w=;
        b=MQDiihvIgqv8OJtBS3E/N79ZiyuxeqOb3YqW9Hv89TGaQZDGi6Y+kaRTnsCzx94sHo
         RVT4IIPkWWp/Ne/2/o69b3r0b215cWMT66QENyWSOdquUfen81VHjSzNHgbJiba4wKPE
         uiZBdsXqU2QEr93mzl2F0YO5VoE0I90hxtSsqsmWYluYhpGfbDipm4v+mP0clPK5ElEV
         BlTYLM9HmWAhFN+dHs7VF563RocBSJsUIZ5KSjRWkBXYTHkUrL9J9S2OarGaZL04N+Xw
         gYnxoDnXNxg7Hanod50F2ffTLwtc4Am+NzswjkHg8X2dpDAGAq/okeqysdyiodGflRmP
         r1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XQ0WVvKPti4m7G1M9ywd0P6+oN8xaAUrgiUlxFUrE+w=;
        b=SVx5xSzYKflvggGwbwhvKtI79lL8ysedn/QXsbkWxKkTxxONKKYYdgqOYBLC6w4iPz
         1RFtDvAY6/0JB/Cb7e9kWh29YeK8hGkiQ1UTy4Rz9IsB1folJRRCqRgPVyRoA3FNxThb
         7STxhwC+5BPaFu+tBGSwBq5+sLtY244lKrhZcF0Vmof2YZAPBmBnI/nzFMnEM1skACyj
         FA2LvfkHtlUXZbccCb7ab6tJeNMG0o8O+BJfRCcoTPu8oxoPGrBp4yNr2eYfBd5AUfCf
         pRdoCna3oODZKX1OBxrfiQjdK9CBbNzwni91FiGu4e1XJU1u/K/qv8ybnewDxZZyBP9Z
         f5WA==
X-Gm-Message-State: APjAAAXZUVMceatW9KIzjVyjLhVC2xIvAf0b4XyAK3GVlRW2o/WSABP6
        pWaGD7tiEmhqwLcz+LkTE6g=
X-Google-Smtp-Source: APXvYqwPIKDM5mOq0z2IU1691NERggjwlWnPLuUQiF2ypfVKl6jjlKl+1l4PnkBlzWUS2I3L42DDrw==
X-Received: by 2002:a17:902:6802:: with SMTP id h2mr19776704plk.135.1575143460449;
        Sat, 30 Nov 2019 11:51:00 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id r10sm26605259pgn.68.2019.11.30.11.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 11:50:59 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     Leif Lindholm <leif.lindholm@linaro.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kairui Song <kasong@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        linux-efi@vger.kernel.org (open list:EXTENSIBLE FIRMWARE INTERFACE
        (EFI)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] efi/fdt: install new fdt config table
Date:   Sat, 30 Nov 2019 11:50:40 -0800
Message-Id: <20191130195045.2005835-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

If there is an fdt config table, replace it with the newly allocated one
before calling ExitBootServices().

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
The DtbLoader.efi[1] driver, which Leif created for EBBR boot on the
"windows" aarch64 laptops, tries to detect in an EBS hook, whether the
HLOS is using DT.  It does this by realizing that the kernel cmdline is
patched in to the fdt, and comparing the CRC.  If the CRC has changed,
that means the HLOS is using DT boot, so it removes the ACPI config
tables, so that the HLOS does not see two conflicting sets of config
tables.

However, I realized this mechanism does not work when directly loading
the linux kernel as an efi executable (ie. without an intermediary like
grub doing it's own DT modifications), because efi/libstub is modifying
a copy of the DT config table.

If we update the config table with the new DT, then it will realize
properly that the HLOS is using DT.

[1] https://git.linaro.org/people/leif.lindholm/edk2.git/log/?h=dtbloader

 .../firmware/efi/libstub/efi-stub-helper.c    | 32 +++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h        |  2 ++
 drivers/firmware/efi/libstub/fdt.c            |  2 ++
 3 files changed, 36 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 35dbc2791c97..210070f3b231 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -953,3 +953,35 @@ void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid)
 	else
 		return get_efi_config_table32(sys_table, guid);
 }
+
+#define REPLACE_EFI_CONFIG_TABLE(bits)					\
+static void *replace_efi_config_table##bits(efi_system_table_t *_sys_table, \
+					efi_guid_t guid, void *table)	\
+{									\
+	efi_system_table_##bits##_t *sys_table;				\
+	efi_config_table_##bits##_t *tables;				\
+	int i;								\
+									\
+	sys_table = (typeof(sys_table))_sys_table;			\
+	tables = (typeof(tables))(unsigned long)sys_table->tables;	\
+									\
+	for (i = 0; i < sys_table->nr_tables; i++) {			\
+		if (efi_guidcmp(tables[i].guid, guid) != 0)		\
+			continue;					\
+									\
+		tables[i].table = (uintptr_t)table;			\
+		return;							\
+	}								\
+}
+REPLACE_EFI_CONFIG_TABLE(32)
+REPLACE_EFI_CONFIG_TABLE(64)
+
+/* replaces an existing config table: */
+void replace_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid,
+			  void *table)
+{
+	if (efi_is_64bit())
+		replace_efi_config_table64(sys_table, guid, table);
+	else
+		replace_efi_config_table32(sys_table, guid, table);
+}
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 7f1556fd867d..66f2927ce26f 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -66,6 +66,8 @@ efi_status_t check_platform_features(efi_system_table_t *sys_table_arg);
 efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg);
 
 void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid);
+void replace_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid,
+			  void *table);
 
 /* Helper macros for the usual case of using simple C variables: */
 #ifndef fdt_setprop_inplace_var
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 0bf0190917e0..15887ec2dc3b 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -313,6 +313,8 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 	priv.runtime_entry_count	= &runtime_entry_count;
 	priv.new_fdt_addr		= (void *)*new_fdt_addr;
 
+	replace_efi_config_table(sys_table, DEVICE_TREE_GUID, priv.new_fdt_addr);
+
 	status = efi_exit_boot_services(sys_table, handle, &map, &priv, exit_boot_func);
 
 	if (status == EFI_SUCCESS) {
-- 
2.23.0

