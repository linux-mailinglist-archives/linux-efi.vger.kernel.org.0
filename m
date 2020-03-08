Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6CD717D289
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgCHIKa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgCHIK3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:10:29 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7879A2087F;
        Sun,  8 Mar 2020 08:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583655028;
        bh=61zAIEug0G89junb5vkt8lgu+Si/8PoRj9JLz6YCKio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRUlVpuYmm+12Sxumpx74WHm61HWxIHLnTT8eZHFc3ncSPgtePXw7nJdys3Wn28qH
         BW4V339mAe9/acs7sII4TMRvaYU5VD8VQb6KuaPCu1MMk2JOGtx/WBPj9G8BGBtTbg
         8f8oS/k0wSbD1PsRPWCSz1EV2MCXW+b2gP+9FnUY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 23/28] efi: fix a race and a buffer overflow while reading efivars via sysfs
Date:   Sun,  8 Mar 2020 09:08:54 +0100
Message-Id: <20200308080859.21568-24-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Vladis Dronov <vdronov@redhat.com>

There is a race and a buffer overflow corrupting a kernel memory while
reading an efi variable with a size more than 1024 bytes via the older
sysfs method. This happens because accessing struct efi_variable in
efivar_{attr,size,data}_read() and friends is not protected from
a concurrent access leading to a kernel memory corruption and, at best,
to a crash. The race scenario is the following:

CPU0:                                CPU1:
efivar_attr_read()
  var->DataSize = 1024;
  efivar_entry_get(... &var->DataSize)
    down_interruptible(&efivars_lock)
                                     efivar_attr_read() // same efi var
                                       var->DataSize = 1024;
                                       efivar_entry_get(... &var->DataSize)
                                         down_interruptible(&efivars_lock)
    virt_efi_get_variable()
    // returns EFI_BUFFER_TOO_SMALL but
    // var->DataSize is set to a real
    // var size more than 1024 bytes
    up(&efivars_lock)
                                         virt_efi_get_variable()
                                         // called with var->DataSize set
                                         // to a real var size, returns
                                         // successfully and overwrites
                                         // a 1024-bytes kernel buffer
                                         up(&efivars_lock)

This can be reproduced by concurrent reading of an efi variable which size
is more than 1024 bytes:

ts# for cpu in $(seq 0 $(nproc --ignore=1)); do ( taskset -c $cpu \
cat /sys/firmware/efi/vars/KEKDefault*/size & ) ; done

Fix this by using a local variable for a var's data buffer size so it
does not get overwritten.

Fixes: e14ab23dde12b80d ("efivars: efivar_entry API")
Reported-by: Bob Sanders <bob.sanders@hpe.com> and the LTP testsuite
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
Link: https://lore.kernel.org/r/20200305084041.24053-2-vdronov@redhat.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efivars.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index d309abca5091..485c592d7990 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -83,13 +83,16 @@ static ssize_t
 efivar_attr_read(struct efivar_entry *entry, char *buf)
 {
 	struct efi_variable *var = &entry->var;
+	unsigned long size = sizeof(var->Data);
 	char *str = buf;
+	int ret;
 
 	if (!entry || !buf)
 		return -EINVAL;
 
-	var->DataSize = 1024;
-	if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data))
+	ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
+	var->DataSize = size;
+	if (ret)
 		return -EIO;
 
 	if (var->Attributes & EFI_VARIABLE_NON_VOLATILE)
@@ -116,13 +119,16 @@ static ssize_t
 efivar_size_read(struct efivar_entry *entry, char *buf)
 {
 	struct efi_variable *var = &entry->var;
+	unsigned long size = sizeof(var->Data);
 	char *str = buf;
+	int ret;
 
 	if (!entry || !buf)
 		return -EINVAL;
 
-	var->DataSize = 1024;
-	if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data))
+	ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
+	var->DataSize = size;
+	if (ret)
 		return -EIO;
 
 	str += sprintf(str, "0x%lx\n", var->DataSize);
@@ -133,12 +139,15 @@ static ssize_t
 efivar_data_read(struct efivar_entry *entry, char *buf)
 {
 	struct efi_variable *var = &entry->var;
+	unsigned long size = sizeof(var->Data);
+	int ret;
 
 	if (!entry || !buf)
 		return -EINVAL;
 
-	var->DataSize = 1024;
-	if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data))
+	ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
+	var->DataSize = size;
+	if (ret)
 		return -EIO;
 
 	memcpy(buf, var->Data, var->DataSize);
@@ -250,14 +259,16 @@ efivar_show_raw(struct efivar_entry *entry, char *buf)
 {
 	struct efi_variable *var = &entry->var;
 	struct compat_efi_variable *compat;
+	unsigned long datasize = sizeof(var->Data);
 	size_t size;
+	int ret;
 
 	if (!entry || !buf)
 		return 0;
 
-	var->DataSize = 1024;
-	if (efivar_entry_get(entry, &entry->var.Attributes,
-			     &entry->var.DataSize, entry->var.Data))
+	ret = efivar_entry_get(entry, &var->Attributes, &datasize, var->Data);
+	var->DataSize = datasize;
+	if (ret)
 		return -EIO;
 
 	if (in_compat_syscall()) {
-- 
2.17.1

