Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B2613C984
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2020 17:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgAOQgN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jan 2020 11:36:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38491 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729030AbgAOQgN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Jan 2020 11:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579106172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qDJ9COGKe9oeS7jXhhstJzQSFIkMed5HXZMmGfFMgjE=;
        b=V+xzOHsF8W66vvFMb/d8OnxlKnJcSTKIf42QNgPmokEHHFJmjpYprYjVykEBoNvfGYoqyY
        drfuVqsDzQU5C51xNiGOPf24aUcjaxpqh2AAAzLE9jaW2KhZvZ8vu6EGmvqOHT2zl4PZHP
        apoT3SvCWt5MruDEllZnjAKCOldqjvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-1zLwxP2SOj-mQOk5Ez8P3g-1; Wed, 15 Jan 2020 11:36:10 -0500
X-MC-Unique: 1zLwxP2SOj-mQOk5Ez8P3g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1750C107ACC5;
        Wed, 15 Jan 2020 16:36:08 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-188.ams2.redhat.com [10.36.116.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA8DA5DA80;
        Wed, 15 Jan 2020 16:36:00 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
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
        linux-input@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v12 01/10] efi: Export boot-services code and data as debugfs-blobs
Date:   Wed, 15 Jan 2020 17:35:45 +0100
Message-Id: <20200115163554.101315-2-hdegoede@redhat.com>
In-Reply-To: <20200115163554.101315-1-hdegoede@redhat.com>
References: <20200115163554.101315-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Sometimes it is useful to be able to dump the efi boot-services code and
data. This commit adds these as debugfs-blobs to /sys/kernel/debug/efi,
but only if efi=3Ddebug is passed on the kernel-commandline as this requi=
res
not freeing those memory-regions, which costs 20+ MB of RAM.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v8:
-Add pr_warn if there are mode then EFI_DEBUGFS_MAX_BLOBS boot service se=
gments
-Document how the boot_service_code? files can be used to check for embed=
ded
 firmware. Note since this is related to the firmware EFI embedded fw sup=
port,
 these docs are added in the 4th patch of this patch-set, not in this one=
.

Changes in v5:
-Rename the EFI_BOOT_SERVICES flag to EFI_PRESERVE_BS_REGIONS

Changes in v4:
-Add new EFI_BOOT_SERVICES flag and use it to determine if the boot-servi=
ces
 memory segments are available (and thus if it makes sense to register th=
e
 debugfs bits for them)

Changes in v2:
-Do not call pr_err on debugfs call failures
---
 arch/x86/platform/efi/efi.c    |  1 +
 arch/x86/platform/efi/quirks.c |  4 +++
 drivers/firmware/efi/efi.c     | 57 ++++++++++++++++++++++++++++++++++
 include/linux/efi.h            |  1 +
 4 files changed, 63 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 59f7f6d60cf6..51ee2e2a18d6 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -243,6 +243,7 @@ int __init efi_memblock_x86_reserve_range(void)
 	     efi.memmap.desc_version);
=20
 	memblock_reserve(pmap, efi.memmap.nr_map * efi.memmap.desc_size);
+	set_bit(EFI_PRESERVE_BS_REGIONS, &efi.flags);
=20
 	return 0;
 }
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirk=
s.c
index 46807b7606da..d5e822373450 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -409,6 +409,10 @@ void __init efi_free_boot_services(void)
 	int num_entries =3D 0;
 	void *new, *new_md;
=20
+	/* Keep all regions for /sys/kernel/debug/efi */
+	if (efi_enabled(EFI_DBG))
+		return;
+
 	for_each_efi_memory_desc(md) {
 		unsigned long long start =3D md->phys_addr;
 		unsigned long long size =3D md->num_pages << EFI_PAGE_SHIFT;
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 621220ab3d0e..201a6799671d 100644
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
@@ -325,6 +326,59 @@ static __init int efivar_ssdt_load(void)
 static inline int efivar_ssdt_load(void) { return 0; }
 #endif
=20
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
+	int type_count[EFI_BOOT_SERVICES_DATA + 1] =3D {};
+	int i =3D 0;
+
+	efi_debugfs =3D debugfs_create_dir("efi", NULL);
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
+		if (i >=3D EFI_DEBUGFS_MAX_BLOBS) {
+			pr_warn("More then %d EFI boot service segments, only showing first %=
d in debugfs\n",
+				EFI_DEBUGFS_MAX_BLOBS, EFI_DEBUGFS_MAX_BLOBS);
+			break;
+		}
+
+		debugfs_blob[i].size =3D md->num_pages << EFI_PAGE_SHIFT;
+		debugfs_blob[i].data =3D memremap(md->phys_addr,
+						debugfs_blob[i].size,
+						MEMREMAP_WB);
+		if (!debugfs_blob[i].data)
+			continue;
+
+		debugfs_create_blob(name, 0400, efi_debugfs, &debugfs_blob[i]);
+		i++;
+	}
+}
+#else
+static inline void efi_debugfs_init(void) {}
+#endif
+
 /*
  * We register the efi subsystem with the firmware subsystem and the
  * efivars subsystem with the efi subsystem, if the system was booted wi=
th
@@ -381,6 +435,9 @@ static int __init efisubsys_init(void)
 		goto err_remove_group;
 	}
=20
+	if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
+		efi_debugfs_init();
+
 	return 0;
=20
 err_remove_group:
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7efd7072cca5..a6e1a2d8511e 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1124,6 +1124,7 @@ extern int __init efi_setup_pcdp_console(char *);
 #define EFI_NX_PE_DATA		9	/* Can runtime data regions be mapped non-exec=
utable? */
 #define EFI_MEM_ATTR		10	/* Did firmware publish an EFI_MEMORY_ATTRIBUTE=
S table? */
 #define EFI_MEM_NO_SOFT_RESERVE	11	/* Is the kernel configured to ignore=
 soft reservations? */
+#define EFI_PRESERVE_BS_REGIONS	12	/* Are EFI boot-services memory segme=
nts available? */
=20
 #ifdef CONFIG_EFI
 /*
--=20
2.24.1

