Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2431093B4
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2019 19:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfKYSt6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Nov 2019 13:49:58 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42970 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKYSt6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Nov 2019 13:49:58 -0500
Received: by mail-qt1-f193.google.com with SMTP id t20so18326114qtn.9;
        Mon, 25 Nov 2019 10:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vOdEYfSLcSRQ2bXNji+76Jh95fAHCd8bgzGlm9iUFu0=;
        b=l4S6IFBopNG2XYv2TWjpGqM1oX7mHASdcW4up6r/2cKf116uoE6EatDpr0XvEC9DFN
         MYyMcB7D56QLLfQyZqx4295anORTx+i483ZJDuqQgtcmdKfCxFn9/Om9HLganmfWWd69
         MMvpsxqYwaQGT6Z8d0tWYTu8MZpmgQfD+eDQOh8EuEJA1dxXinNRdlwJALo5tvxq9oLz
         +azHJxug2hAjfYnwVKgyWUg625FLNM6wQOKPiky0b75GFMbtJfuZIWzkuQJhpIxQwgRc
         HXbAnSLWi7t0fA2q7g9uLkADh73DKPINf8yY9pPdskCHeW19vnEKfy8LBrdjVNkwb4oy
         1ndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vOdEYfSLcSRQ2bXNji+76Jh95fAHCd8bgzGlm9iUFu0=;
        b=YCSgFZiF0QPOO7qMNOd18npDy69IA9F+m2vuTn9pcuXv1An8g2wUJ+qFjy8V6o7Os+
         b2aQWAbpayN0n9IulkrYBKbXo+Ty8bCNR5Rp4ud7+IOnEmzDCGv0+w0yKuJm3O8u3BFT
         MGKI/vFFVZFYn6UszibwujCd1HUCPfYAMmqxcv0LZWF1YEKMxNga+uDNAsDh2IPOL+ZJ
         q0ZkuiE18txn46QDmt3MHsnldtKOK7UL9dZXrUogttwL2dARN2xZI2W0m35nBUKnxmGy
         8iFtMiMy8XuJGzje9D1i2N9s2P1SajzyzsDIDih3yv5/XxaZYy1RztVCMx71E8RqgRqA
         B9MA==
X-Gm-Message-State: APjAAAWsMjLjWzOa80FhNSGSyrbRVAnHBs/h8I5MfuyG0Zh9ZIHD8pnA
        +lz0jBAVwmuk45XVr/L6Qg==
X-Google-Smtp-Source: APXvYqyH+uQBIhmLXQh7YB6SztVR4zZD2fmZQuMaCu8+shPUERS1F7LZfSu4IjRmRE+8csgZg4mj2A==
X-Received: by 2002:aed:3924:: with SMTP id l33mr13196213qte.6.1574707797093;
        Mon, 25 Nov 2019 10:49:57 -0800 (PST)
Received: from gabell.redhat.com (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id f7sm3780315qkb.79.2019.11.25.10.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 10:49:56 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        d.hatayama@fujitsu.com, Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH] efi: arm64: Introduce /sys/firmware/efi/memreserve to tell the persistent pages
Date:   Mon, 25 Nov 2019 13:49:44 -0500
Message-Id: <20191125184944.15556-1-msys.mizuma@gmail.com>
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
 drivers/firmware/efi/efi.c | 45 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index e98bbf8e5..0aa07cc09 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -141,6 +141,47 @@ static ssize_t systab_show(struct kobject *kobj,
 
 static struct kobj_attribute efi_attr_systab = __ATTR_RO_MODE(systab, 0400);
 
+static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
+#ifdef CONFIG_KEXEC
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
+#endif /* CONFIG_KEXEC */
+
 #define EFI_FIELD(var) efi.var
 
 #define EFI_ATTR_SHOW(name) \
@@ -172,6 +213,9 @@ static struct attribute *efi_subsys_attrs[] = {
 	&efi_attr_runtime.attr,
 	&efi_attr_config_table.attr,
 	&efi_attr_fw_platform_size.attr,
+#ifdef CONFIG_KEXEC
+	&efi_attr_memreserve.attr,
+#endif
 	NULL,
 };
 
@@ -955,7 +999,6 @@ int efi_status_to_err(efi_status_t status)
 }
 
 static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
-static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
 
 static int __init efi_memreserve_map_root(void)
 {
-- 
2.18.1

