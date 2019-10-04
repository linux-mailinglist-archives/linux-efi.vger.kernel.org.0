Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10277CBDEE
	for <lists+linux-efi@lfdr.de>; Fri,  4 Oct 2019 16:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389361AbfJDOvQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Oct 2019 10:51:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388870AbfJDOvQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Oct 2019 10:51:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35057308C1E6;
        Fri,  4 Oct 2019 14:51:15 +0000 (UTC)
Received: from dhcp-44-196.space.revspace.nl (ovpn-112-43.ams2.redhat.com [10.36.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEC875C3F8;
        Fri,  4 Oct 2019 14:51:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v7 1/8] efi: Export boot-services code and data as debugfs-blobs
Date:   Fri,  4 Oct 2019 16:50:49 +0200
Message-Id: <20191004145056.43267-2-hdegoede@redhat.com>
In-Reply-To: <20191004145056.43267-1-hdegoede@redhat.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 04 Oct 2019 14:51:15 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Sometimes it is useful to be able to dump the efi boot-services code and
data. This commit adds these as debugfs-blobs to /sys/kernel/debug/efi,
but only if efi=debug is passed on the kernel-commandline as this requires
not freeing those memory-regions, which costs 20+ MB of RAM.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v5:
-Rename the EFI_BOOT_SERVICES flag to EFI_PRESERVE_BS_REGIONS

Changes in v4:
-Add new EFI_BOOT_SERVICES flag and use it to determine if the boot-services
 memory segments are available (and thus if it makes sense to register the
 debugfs bits for them)

Changes in v2:
-Do not call pr_err on debugfs call failures
---
 arch/x86/platform/efi/efi.c    |  1 +
 arch/x86/platform/efi/quirks.c |  4 +++
 drivers/firmware/efi/efi.c     | 53 ++++++++++++++++++++++++++++++++++
 include/linux/efi.h            |  1 +
 4 files changed, 59 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index c202e1b07e29..847730f7e74b 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -232,6 +232,7 @@ int __init efi_memblock_x86_reserve_range(void)
 	     efi.memmap.desc_version);
 
 	memblock_reserve(pmap, efi.memmap.nr_map * efi.memmap.desc_size);
+	set_bit(EFI_PRESERVE_BS_REGIONS, &efi.flags);
 
 	return 0;
 }
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 3b9fd679cea9..fab12ebf0ada 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -411,6 +411,10 @@ void __init efi_free_boot_services(void)
 	int num_entries = 0;
 	void *new, *new_md;
 
+	/* Keep all regions for /sys/kernel/debug/efi */
+	if (efi_enabled(EFI_DBG))
+		return;
+
 	for_each_efi_memory_desc(md) {
 		unsigned long long start = md->phys_addr;
 		unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 8d3e778e988b..abba49c4c46d 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -17,6 +17,7 @@
 #include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/efi.h>
 #include <linux/of.h>
@@ -314,6 +315,55 @@ static __init int efivar_ssdt_load(void)
 static inline int efivar_ssdt_load(void) { return 0; }
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+
+#define EFI_DEBUGFS_MAX_BLOBS 32
+
+static struct debugfs_blob_wrapper debugfs_blob[EFI_DEBUGFS_MAX_BLOBS];
+
+static void __init efi_debugfs_init(void)
+{
+	struct dentry *efi_debugfs;
+	efi_memory_desc_t *md;
+	char name[32];
+	int type_count[EFI_BOOT_SERVICES_DATA + 1] = {};
+	int i = 0;
+
+	efi_debugfs = debugfs_create_dir("efi", NULL);
+	if (IS_ERR_OR_NULL(efi_debugfs))
+		return;
+
+	for_each_efi_memory_desc(md) {
+		switch (md->type) {
+		case EFI_BOOT_SERVICES_CODE:
+			snprintf(name, sizeof(name), "boot_services_code%d",
+				 type_count[md->type]++);
+			break;
+		case EFI_BOOT_SERVICES_DATA:
+			snprintf(name, sizeof(name), "boot_services_data%d",
+				 type_count[md->type]++);
+			break;
+		default:
+			continue;
+		}
+
+		debugfs_blob[i].size = md->num_pages << EFI_PAGE_SHIFT;
+		debugfs_blob[i].data = memremap(md->phys_addr,
+						debugfs_blob[i].size,
+						MEMREMAP_WB);
+		if (!debugfs_blob[i].data)
+			continue;
+
+		debugfs_create_blob(name, 0400, efi_debugfs, &debugfs_blob[i]);
+		i++;
+		if (i == EFI_DEBUGFS_MAX_BLOBS)
+			break;
+	}
+}
+#else
+static inline void efi_debugfs_init(void) {}
+#endif
+
 /*
  * We register the efi subsystem with the firmware subsystem and the
  * efivars subsystem with the efi subsystem, if the system was booted with
@@ -370,6 +420,9 @@ static int __init efisubsys_init(void)
 		goto err_remove_group;
 	}
 
+	if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
+		efi_debugfs_init();
+
 	return 0;
 
 err_remove_group:
diff --git a/include/linux/efi.h b/include/linux/efi.h
index bd3837022307..2a30a1bd8bdf 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1202,6 +1202,7 @@ extern int __init efi_setup_pcdp_console(char *);
 #define EFI_DBG			8	/* Print additional debug info at runtime */
 #define EFI_NX_PE_DATA		9	/* Can runtime data regions be mapped non-executable? */
 #define EFI_MEM_ATTR		10	/* Did firmware publish an EFI_MEMORY_ATTRIBUTES table? */
+#define EFI_PRESERVE_BS_REGIONS	11	/* Are EFI boot-services memory segments available? */
 
 #ifdef CONFIG_EFI
 /*
-- 
2.23.0

