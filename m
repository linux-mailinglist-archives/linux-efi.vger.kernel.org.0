Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A399FFCA94
	for <lists+linux-efi@lfdr.de>; Thu, 14 Nov 2019 17:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfKNQLU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Nov 2019 11:11:20 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40833 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfKNQLU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Nov 2019 11:11:20 -0500
Received: by mail-qt1-f193.google.com with SMTP id o49so7340737qta.7;
        Thu, 14 Nov 2019 08:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BOPJip910ImC+qHUP+LwyRp/oWfN3GE0KkiS0ZFAdXY=;
        b=JFqOShpAQwGsjh6wLpsyuqLJxoGdJccNiUfQnqYuCbgTheAXRifadAOEVww1bQ4WFB
         Erdq8+2oNXLndOTe/OeBTEbh0ShhY1kPzAHMlFOnzNiadJXLpT8wWzETdpSNgQ0qRnnY
         Gw7aCbLweyFmgA4TTogBVYIsBM0pO+yBwxfnkYhOb2cUZ9+uq/4+pYbicdzIDxNN+3ie
         vA9w0m+NJT6iIekM9JH5EXsMckNwFqO9Hl0q3WwKx7bu/ri6fKVyKYdSPgkS+DKdsmy1
         lKf1sCbGVJcgEILeZh/1OWGhomskzvhLjWhwgiP8DRIqta15Go/2/HKuHULlWcKYjCGm
         MHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BOPJip910ImC+qHUP+LwyRp/oWfN3GE0KkiS0ZFAdXY=;
        b=gtdcEENL83HFTrK5MkcQYQZHWFNP87+X0QoLCeTE4yWBVtIbkXODfApJ+t4RT+NAHd
         1eA/hWsy0sEM6VOdCjWnvSRTDHFAm1TylpvB164A9goWPY1d/cxSVW/QNym7Qs7ci0oB
         yr+ZjQ8xvJ+gmIPMgmPRx0FWHCvhQUrCgKimSlSBwM5XbWNxeAiXFWauVB/aq+CxerPm
         /ugQdNqrXO0F5vswLJRaAHIn/RGhRuveTpWnpdg9D9zdyE3x7+4udr6BfMw9yxWXFc3u
         if06QZgll9hxvZzzvSR0pHFUaPhfdeJFGUxFUpFIDaKgfDvPtRuMEqQ5blOdUi841EKb
         A3Cw==
X-Gm-Message-State: APjAAAXwFTH8M90X+iQsTXxSOEGnWofS7YgOB8KbtNEclppodDF5xHMU
        E0npjCksdG1kp4hScFYKXA==
X-Google-Smtp-Source: APXvYqw6Dq8NsnAZHxKC+SggPkyY6aakIFXBizI56tHuEt8ZVZViIZUPvxZNCEcDeeTEetmpkm5O+Q==
X-Received: by 2002:ac8:60cc:: with SMTP id i12mr5729392qtm.103.1573747878621;
        Thu, 14 Nov 2019 08:11:18 -0800 (PST)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n20sm2767705qkn.118.2019.11.14.08.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 08:11:17 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        d.hatayama@fujitsu.com
Subject: [RFC PATCH v2] efi: arm64: Introduce /sys/firmware/efi/memreserve to tell the persistent pages
Date:   Thu, 14 Nov 2019 11:10:19 -0500
Message-Id: <20191114161019.8735-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

kexec reboot stops in early boot sequence because efi_config_parse_tables()
refers garbage data. We can see the log with memblock=debug kernel option:

  efi:  ACPI 2.0=0x9821790014  PROP=0x8757f5c0  SMBIOS 3.0=0x9820740000  MEMRESERVE=0x9820bfdc58
  memblock_reserve: [0x0000009820bfdc58-0x0000009820bfdc67] efi_config_parse_tables+0x228/0x278
  memblock_reserve: [0x0000000082760000-0x00000000324d07ff] efi_config_parse_tables+0x228/0x278
  memblock_reserve: [0xcc4f84ecc0511670-0x5f6e5214a7fd91f9] efi_config_parse_tables+0x244/0x278
  memblock_reserve: [0xd2fd4144b9af693d-0xad0c1db1086f40a2] efi_config_parse_tables+0x244/0x278
  memblock_reserve: [0x0c719bb159b1fadc-0x5aa6e62a1417ce12] efi_config_parse_tables+0x244/0x278
  ...

That happens because 0x82760000, struct linux_efi_memreserve, is destroyed.
0x82760000 is pointed from efi.mem_reseve, and efi.mem_reserve points the
head page of LPI pending table and LPI property table which are allocated by
gic_reserve_range().

The destroyer is kexec. kexec locates the initrd to the area:

  ]# kexec -d -l /boot/vmlinuz-5.4.0-rc7 /boot/initramfs-5.4.0-rc7.img --reuse-cmdline
  ...
  initrd: base 82290000, size 388dd8ah (59301258)
  ...

From dynamic debug log. initrd is located in segment[1]:
  machine_kexec_prepare:70:
    kexec kimage info:
      type:        0
      start:       85b30680
      head:        0
      nr_segments: 4
        segment[0]: 0000000080480000 - 0000000082290000, 0x1e10000 bytes, 481 pages
        segment[1]: 0000000082290000 - 0000000085b20000, 0x3890000 bytes, 905 pages
        segment[2]: 0000000085b20000 - 0000000085b30000, 0x10000 bytes, 1 pages
        segment[3]: 0000000085b30000 - 0000000085b40000, 0x10000 bytes, 1 pages

kexec searches the memory region to locate initrd through
"System RAM" in /proc/iomem. The pending tables are included in
"System RAM" because they are allocated by alloc_pages(), so kexec
destroys the LPI pending tables.

Introduce /sys/firmware/efi/memreserve to tell the pages pointed by
efi.mem_reserve so that kexec can avoid the area to locate initrd.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 drivers/firmware/efi/efi.c | 41 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 0b6b0c19a..07812d697 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -149,6 +149,45 @@ static ssize_t systab_show(struct kobject *kobj,
 
 static struct kobj_attribute efi_attr_systab = __ATTR_RO_MODE(systab, 0400);
 
+static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
+static ssize_t memreserve_show(struct kobject *kobj,
+			   struct kobj_attribute *attr, char *buf)
+{
+	struct linux_efi_memreserve *rsv;
+	phys_addr_t start, end;
+	unsigned long prsv;
+	char *str = buf;
+	int count, i;
+
+	if (!kobj || !buf)
+		return -EINVAL;
+
+	if ((efi_memreserve_root == (void *)ULONG_MAX) ||
+			(!efi_memreserve_root))
+		return -ENODEV;
+
+	for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
+		rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
+		if (!rsv) {
+			pr_err("Could not map efi_memreserve\n");
+			return -ENOMEM;
+		}
+		count = atomic_read(&rsv->count);
+		for (i = 0; i < count; i++) {
+			start = rsv->entry[i].base;
+			end = start + rsv->entry[i].size - 1;
+
+			str += sprintf(str, "%pa-%pa\n", &start, &end);
+		}
+		memunmap(rsv);
+	}
+
+	return str - buf;
+}
+
+static struct kobj_attribute efi_attr_memreserve =
+			__ATTR_RO_MODE(memreserve, 0444);
+
 #define EFI_FIELD(var) efi.var
 
 #define EFI_ATTR_SHOW(name) \
@@ -180,6 +219,7 @@ static struct attribute *efi_subsys_attrs[] = {
 	&efi_attr_runtime.attr,
 	&efi_attr_config_table.attr,
 	&efi_attr_fw_platform_size.attr,
+	&efi_attr_memreserve.attr,
 	NULL,
 };
 
@@ -964,7 +1004,6 @@ int efi_status_to_err(efi_status_t status)
 }
 
 static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
-static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
 
 static int __init efi_memreserve_map_root(void)
 {
-- 
2.21.0

