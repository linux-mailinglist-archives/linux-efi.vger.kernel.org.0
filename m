Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC862F961B
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2019 17:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfKLQx5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Nov 2019 11:53:57 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46390 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbfKLQx4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Nov 2019 11:53:56 -0500
Received: by mail-qt1-f196.google.com with SMTP id r20so6409607qtp.13;
        Tue, 12 Nov 2019 08:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7EvQZ65acdZe4jczSmDkYKhL0KXQjakh/QwGvq5Tfuw=;
        b=TFd5NnkVvKSi1dSsVVxYNyBFKoxu+1nznqgn3s5CTTblJfw6jqSPOgVfduVNwr7/ch
         I6hz3bvyGapGaBuWE5l2lZ6WcTtabTcUkrKGQGqL+Fcs/PMDzje7TNm7l7zu1Za36XIR
         eFPjJ7gv/7+/Ug6GugrPvgydtiXuClEx+K7DOW/4dmz9EyYsqQsjyN/01uweICA/J5Ts
         +Np4F6fKzKoluWNNT4p13tbQj90uHKrfBfjjP+HjOdY0LLOhA8EgSjNfPPceYz9lIKoC
         hPsAVnTseIY78PNI9wqn0Cs4iXxQQTc1HikxcISaH43Nky5sY0rJxlcj0GWbKJHYeE3B
         9Apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7EvQZ65acdZe4jczSmDkYKhL0KXQjakh/QwGvq5Tfuw=;
        b=VcEdnqarHr9xGOjE3HJFhqQsRJm9SOk+QKkephCtMfq6B32gwj+92bikFI5Ig0psZ7
         Ccv4rXvcMgLh+EkD7ey77L/yvIaRxHxZB+KikN3lGq7OHCyL1GLKW6ZCGULDrx9UftZO
         lX0+wEAzoMPDbAL/oUE8hzp6irUUMKrYFcWiaepImMlMsjfI8DZQ7Slgv+xgWqHN4IbE
         EVz672u0l4WeCbnYj80ImUEzwNI/5NGRt4w68VP1KE5w0z4BfEEh7nr54fcv4dYqVqdS
         9Wc7+ONGNSD8MTXYP/B0qDFbG4MsX/XTbJwwcTh5dX2kvR0LCZ50PdsbsBPwtTAolZs1
         G4Fw==
X-Gm-Message-State: APjAAAVaYGjRmdx2EmM3oxgMlnZ7oWPAH6w71F53uZ5GzWYQgNK+WK28
        y+NDTGdTyr/v7drwrg7cBg==
X-Google-Smtp-Source: APXvYqzvYjNrYH3zR5+ZaL30BwiDtlCwbGJLO0eh1gdpJYCl//2Uo/hJrUsaont6ZAj/PhxvvWUbow==
X-Received: by 2002:ac8:1209:: with SMTP id x9mr32665080qti.352.1573577635194;
        Tue, 12 Nov 2019 08:53:55 -0800 (PST)
Received: from gabell.redhat.com (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id x65sm9461856qkd.15.2019.11.12.08.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 08:53:54 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: [RFC PATCH] efi: arm64: Introduce /sys/firmware/efi/memreserve to tell the persistent pages
Date:   Tue, 12 Nov 2019 11:53:03 -0500
Message-Id: <20191112165303.24270-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

kexec reboot stucks because efi_config_parse_tables() refers garbage
 (with memblock=debug):

  efi:  ACPI 2.0=0x9821790014  PROP=0x8757f5c0  SMBIOS 3.0=0x9820740000  MEMRESERVE=0x9820bfdc58
  memblock_reserve: [0x0000009820bfdc58-0x0000009820bfdc67] efi_config_parse_tables+0x228/0x278
  memblock_reserve: [0x0000000082760000-0x00000000324d07ff] efi_config_parse_tables+0x228/0x278
  memblock_reserve: [0xcc4f84ecc0511670-0x5f6e5214a7fd91f9] efi_config_parse_tables+0x244/0x278
  memblock_reserve: [0xd2fd4144b9af693d-0xad0c1db1086f40a2] efi_config_parse_tables+0x244/0x278
  memblock_reserve: [0x0c719bb159b1fadc-0x5aa6e62a1417ce12] efi_config_parse_tables+0x244/0x278
  ...

That happens because 0x82760000, struct linux_efi_memreserve, is destroyed.
0x82760000 is pointed from efi.mem_reseve, and efi.mem_reserve points the
head page of pending table and prop table which are allocated by gic_reserve_range().

The destroyer is kexec. kexec locates the inird to the area:

# kexec -d -l /boot/vmlinuz-5.4.0-rc7 /boot/initramfs-5.4.0-rc7.img --reuse-cmdline
...
initrd: base 82290000, size 388dd8ah (59301258)
...

From dynamic debug log:
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

kexec searches the appropriate memory region to locate initrd through "System RAM"
in /proc/iomem. The pending tables are included in "System RAM" because they are
allocated by alloc_pages(), so kexec destroys the pending tables.

Introduce /sys/firmware/efi/memreserve to tell the pages pointed by efi.mem_reserve
so that kexec can avoid the area to locate initrd.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 drivers/firmware/efi/efi.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index e98bbf8e5..67b21ae7a 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -141,6 +141,36 @@ static ssize_t systab_show(struct kobject *kobj,
 
 static struct kobj_attribute efi_attr_systab = __ATTR_RO_MODE(systab, 0400);
 
+static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
+static ssize_t memreserve_show(struct kobject *kobj,
+			   struct kobj_attribute *attr, char *buf)
+{
+	struct linux_efi_memreserve *rsv;
+	unsigned long prsv;
+	char *str = buf;
+	int index, i;
+
+	if (!kobj || !buf)
+		return -EINVAL;
+
+	if (!efi_memreserve_root)
+		return -ENODEV;
+
+	for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
+		rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
+		index = atomic_read(&rsv->count);
+		for (i = 0; i < index; i++)
+			str += sprintf(str, "%llx-%llx\n",
+				rsv->entry[i].base,
+				rsv->entry[i].base + rsv->entry[i].size - 1);
+		memunmap(rsv);
+	}
+
+	return str - buf;
+}
+
+static struct kobj_attribute efi_attr_memreserve = __ATTR_RO_MODE(memreserve, 0444);
+
 #define EFI_FIELD(var) efi.var
 
 #define EFI_ATTR_SHOW(name) \
@@ -172,6 +202,7 @@ static struct attribute *efi_subsys_attrs[] = {
 	&efi_attr_runtime.attr,
 	&efi_attr_config_table.attr,
 	&efi_attr_fw_platform_size.attr,
+	&efi_attr_memreserve.attr,
 	NULL,
 };
 
@@ -955,7 +986,6 @@ int efi_status_to_err(efi_status_t status)
 }
 
 static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
-static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
 
 static int __init efi_memreserve_map_root(void)
 {
-- 
2.18.1

