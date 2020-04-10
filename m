Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFFC1A48E5
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 19:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgDJR2t (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 13:28:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38140 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJR2t (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Apr 2020 13:28:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id f20so3377437wmh.3
        for <linux-efi@vger.kernel.org>; Fri, 10 Apr 2020 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kkZO9wjv1lCCkeoEK6Ljuo5h5k/g1QNEHLNIt3Mmh/o=;
        b=fr8bha5sl/nHdSK4PcK17mUKFzLrOvPmUEvkhYhae6F5MQecoUfRcNQg5jtegJUKoF
         N336q0mwGjjGz6tDuHUkuW4pvteoqApCjZOeiEkV8xIou/5sS/0og8xDyeZx7Bb0KQ0Y
         l4fAVF2j04hQethL7wkzhQF/rBImggeycZ8f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kkZO9wjv1lCCkeoEK6Ljuo5h5k/g1QNEHLNIt3Mmh/o=;
        b=ORxVRM+eNgp0eldp21w8RZ/k8nkIu8kCEYX1uk8FBjUWj6rBkWOGllIbySfcEYqQK0
         2jk/F2jRO12UWkyUJkVIycO3QZ4HGaRrORA/JLWLWqkbbX6mn76bSecglDVRHDrJ6r1k
         81HQ9wISoFSfHhUAeHY7VLAkOKRjDb2cbIsvXflZZit6D2o50c1Mp3kKBX+3aVjJpnyx
         KfIxZ+CwzhaXvXU98de3yH9n690T1VBFjSdn19ia4Bbbb0tmp1BPAdq9x/uL65WMvO6i
         XESHmvw4uv155BF8/msqd8rAxNpDt6JXOB9Mko8WDkiAxPNgVZyDEGMr41BzOBnpqC0s
         p1RQ==
X-Gm-Message-State: AGi0PuYyvlDl3xVpxM5vrHYyLSb2einWlVxeKM11djkgnvIL4TsBV/0r
        ili3+atRGpkAXziYGXXEb0h88A==
X-Google-Smtp-Source: APiQypJF9PZoLnZPYH8SK32CKc4PmuGYB4xmfRR5Tb2qedNW2xJaCaOdfm8kUc1kCsUf+bUafEkJMA==
X-Received: by 2002:a7b:c147:: with SMTP id z7mr3196121wmi.52.1586539726595;
        Fri, 10 Apr 2020 10:28:46 -0700 (PDT)
Received: from localhost.localdomain ([88.144.89.159])
        by smtp.gmail.com with ESMTPSA id 17sm900662wmo.2.2020.04.10.10.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:28:45 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     ardb@kernel.org, linux-efi@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH] efi/x86: Expose number of entries in the EFI configuration table via sysfs
Date:   Fri, 10 Apr 2020 18:28:24 +0100
Message-Id: <20200410172824.86217-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently Linux exposes the physical address of the EFI configuration table via
sysfs, but not the number of entries.

The number of entries for the EFI configuration table is located in the EFI
system table and the EFI system table is not exposed, so there is no way for
a userspace application to reliably navigate the EFI configuration table.

One potential use case for such a userspace program would be a monitoring agent,
which parses Image Execution Information Table from the EFI configuration table
and reports all the UEFI executables, which have been denied execution due to
the enforced Secure Boot policy thus providing intrusion detection capabilities.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 Documentation/ABI/testing/sysfs-firmware-efi | 12 +++++++++-
 arch/x86/platform/efi/efi.c                  | 24 +++++++++++++++-----
 drivers/firmware/efi/efi.c                   |  2 ++
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-firmware-efi b/Documentation/ABI/testing/sysfs-firmware-efi
index 5e4d0b27cdfe..37d0364c16cb 100644
--- a/Documentation/ABI/testing/sysfs-firmware-efi
+++ b/Documentation/ABI/testing/sysfs-firmware-efi
@@ -17,7 +17,9 @@ Date:		December 2013
 Contact:	Dave Young <dyoung@redhat.com>
 Description:	It shows the physical address of config table entry in the EFI
 		system table.
-Users:		Kexec
+Users:		Kexec, userspace tools for reading information from UEFI
+		configuration table (for example, Image Execution Information
+		Table)
 
 What:		/sys/firmware/efi/systab
 Date:		April 2005
@@ -36,3 +38,11 @@ Description:	Displays the content of the Runtime Configuration Interface
 		Table version 2 on Dell EMC PowerEdge systems in binary format
 Users:		It is used by Dell EMC OpenManage Server Administrator tool to
 		populate BIOS setup page.
+
+What:		/sys/firmware/efi/nr_tables
+Date:		April 2020
+Contact:	linux-efi@vger.kernel.org
+Description:	It shows number of entries in the config table entry in the EFI
+		system table.
+Users:		Userspace tools for reading information from UEFI configuration
+		table (for example, Image Execution Information Table)
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 1aae5302501d..83574db489d4 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -57,9 +57,9 @@
 static unsigned long efi_systab_phys __initdata;
 static unsigned long prop_phys = EFI_INVALID_TABLE_ADDR;
 static unsigned long uga_phys = EFI_INVALID_TABLE_ADDR;
-static unsigned long efi_runtime, efi_nr_tables;
+static unsigned long efi_runtime;
 
-unsigned long efi_fw_vendor, efi_config_table;
+unsigned long efi_fw_vendor, efi_config_table, efi_nr_tables;
 
 static const efi_config_table_type_t arch_tables[] __initconst = {
 	{EFI_PROPERTIES_TABLE_GUID, "PROP", &prop_phys},
@@ -963,20 +963,29 @@ char *efi_systab_show_arch(char *str)
 
 #define EFI_FIELD(var) efi_ ## var
 
-#define EFI_ATTR_SHOW(name) \
+#define EFI_ATTR_SHOW_ADDR(name) \
 static ssize_t name##_show(struct kobject *kobj, \
 				struct kobj_attribute *attr, char *buf) \
 { \
 	return sprintf(buf, "0x%lx\n", EFI_FIELD(name)); \
 }
 
-EFI_ATTR_SHOW(fw_vendor);
-EFI_ATTR_SHOW(runtime);
-EFI_ATTR_SHOW(config_table);
+#define EFI_ATTR_SHOW_ULONG(name) \
+static ssize_t name##_show(struct kobject *kobj, \
+                                struct kobj_attribute *attr, char *buf) \
+{ \
+        return sprintf(buf, "%lu\n", EFI_FIELD(name)); \
+}
+
+EFI_ATTR_SHOW_ADDR(fw_vendor);
+EFI_ATTR_SHOW_ADDR(runtime);
+EFI_ATTR_SHOW_ADDR(config_table);
+EFI_ATTR_SHOW_ULONG(nr_tables);
 
 struct kobj_attribute efi_attr_fw_vendor = __ATTR_RO(fw_vendor);
 struct kobj_attribute efi_attr_runtime = __ATTR_RO(runtime);
 struct kobj_attribute efi_attr_config_table = __ATTR_RO(config_table);
+struct kobj_attribute efi_attr_nr_tables = __ATTR_RO(nr_tables);
 
 umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
 {
@@ -990,6 +999,9 @@ umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
 	} else if (attr == &efi_attr_config_table.attr) {
 		if (efi_config_table == EFI_INVALID_TABLE_ADDR)
 			return 0;
+	} else if (attr == &efi_attr_nr_tables.attr) {
+		if (efi_config_table == EFI_INVALID_TABLE_ADDR)
+			return 0;
 	}
 	return attr->mode;
 }
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 911a2bd0f6b7..0fe064582f33 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -150,6 +150,7 @@ static ssize_t fw_platform_size_show(struct kobject *kobj,
 extern __weak struct kobj_attribute efi_attr_fw_vendor;
 extern __weak struct kobj_attribute efi_attr_runtime;
 extern __weak struct kobj_attribute efi_attr_config_table;
+extern __weak struct kobj_attribute efi_attr_nr_tables;
 static struct kobj_attribute efi_attr_fw_platform_size =
 	__ATTR_RO(fw_platform_size);
 
@@ -159,6 +160,7 @@ static struct attribute *efi_subsys_attrs[] = {
 	&efi_attr_fw_vendor.attr,
 	&efi_attr_runtime.attr,
 	&efi_attr_config_table.attr,
+	&efi_attr_nr_tables.attr,
 	NULL,
 };
 
-- 
2.20.1

