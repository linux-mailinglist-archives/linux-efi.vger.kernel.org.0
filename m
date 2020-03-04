Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D08017940C
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 16:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgCDPuE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 10:50:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33649 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726263AbgCDPuD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 10:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583337002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgEu8A8FiWPzLf0KWg6FbMQx8pJX80XqDuYn9zCA2SU=;
        b=W4V4QpLS9RX9g3Y390UPwwMaj3olsSTAjVyeviS59MVcG6kL2A7lQcwm45Hsb68zSnpSHS
        OKgS2geZOTie3flFkf6Cv7qt4lw09JjLX2f4bvlJYUzyI8I3o+aUCC1WPhPfaG/2uymBIk
        u2c4AzY8VSYmJmBS7wJ3pcQrUh6Iqoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-2Zm1YcOwMs6pRN_n4Gy4pQ-1; Wed, 04 Mar 2020 10:50:00 -0500
X-MC-Unique: 2Zm1YcOwMs6pRN_n4Gy4pQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A3C5A0CDE;
        Wed,  4 Mar 2020 15:49:59 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-204-205.brq.redhat.com [10.40.204.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 024C65DA85;
        Wed,  4 Mar 2020 15:49:55 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        joeyli <jlee@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] efi: fix a race and a buffer overflow while reading efivars via sysfs
Date:   Wed,  4 Mar 2020 16:49:36 +0100
Message-Id: <20200304154936.24206-1-vdronov@redhat.com>
In-Reply-To: <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com>
References: <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There is a race and a buffer overflow corrupting a kernel memory while
reading an efi variable with a size more than 1024 bytes via the older
sysfs method. This happens because accessing struct efi_variable in
efivar_{attr,size,data}_read() and friends is not protected from
a concurrent access leading to a kernel memory corruption and, at best,
to a crash. The race scenario is the following:

CPU0:                                CPU1:
efivar_attr_read()
  var->DataSize =3D 1024;
  efivar_entry_get(... &var->DataSize)
    down_interruptible(&efivars_lock)
                                     efivar_attr_read() // same efi var
                                       var->DataSize =3D 1024;
                                       efivar_entry_get(... &var->DataSiz=
e)
                                         down_interruptible(&efivars_lock=
)
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

This can be reproduced by concurrent reading of an efi variable which siz=
e
is more than 1024 bytes:

ts# for cpu in $(seq 0 $(nproc --ignore=3D1)); do ( taskset -c $cpu \
cat /sys/firmware/efi/vars/KEKDefault*/size & ) ; done

Fix this by using a local variable for a var's data buffer size so it
does not get overwritten. Also add a sanity check to efivar_store_raw().

Reported-by: Bob Sanders <bob.sanders@hpe.com> and the LTP testsuite
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 drivers/firmware/efi/efi-pstore.c |  2 +-
 drivers/firmware/efi/efivars.c    | 32 ++++++++++++++++++++++---------
 drivers/firmware/efi/vars.c       |  2 +-
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi=
-pstore.c
index 9ea13e8d12ec..e4767a7ce973 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -161,7 +161,7 @@ static int efi_pstore_scan_sysfs_exit(struct efivar_e=
ntry *pos,
  *
  * @record: pstore record to pass to callback
  *
- * You MUST call efivar_enter_iter_begin() before this function, and
+ * You MUST call efivar_entry_iter_begin() before this function, and
  * efivar_entry_iter_end() afterwards.
  *
  */
diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivar=
s.c
index 7576450c8254..16a617f9c5cf 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -83,13 +83,16 @@ static ssize_t
 efivar_attr_read(struct efivar_entry *entry, char *buf)
 {
 	struct efi_variable *var =3D &entry->var;
+	unsigned long size =3D sizeof(var->Data);
 	char *str =3D buf;
+	int ret;
=20
 	if (!entry || !buf)
 		return -EINVAL;
=20
-	var->DataSize =3D 1024;
-	if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data=
))
+	ret =3D efivar_entry_get(entry, &var->Attributes, &size, var->Data);
+	var->DataSize =3D size;
+	if (ret)
 		return -EIO;
=20
 	if (var->Attributes & EFI_VARIABLE_NON_VOLATILE)
@@ -116,13 +119,16 @@ static ssize_t
 efivar_size_read(struct efivar_entry *entry, char *buf)
 {
 	struct efi_variable *var =3D &entry->var;
+	unsigned long size =3D sizeof(var->Data);
 	char *str =3D buf;
+	int ret;
=20
 	if (!entry || !buf)
 		return -EINVAL;
=20
-	var->DataSize =3D 1024;
-	if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data=
))
+	ret =3D efivar_entry_get(entry, &var->Attributes, &size, var->Data);
+	var->DataSize =3D size;
+	if (ret)
 		return -EIO;
=20
 	str +=3D sprintf(str, "0x%lx\n", var->DataSize);
@@ -133,12 +139,15 @@ static ssize_t
 efivar_data_read(struct efivar_entry *entry, char *buf)
 {
 	struct efi_variable *var =3D &entry->var;
+	unsigned long size =3D sizeof(var->Data);
+	int ret;
=20
 	if (!entry || !buf)
 		return -EINVAL;
=20
-	var->DataSize =3D 1024;
-	if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data=
))
+	ret =3D efivar_entry_get(entry, &var->Attributes, &size, var->Data);
+	var->DataSize =3D size;
+	if (ret)
 		return -EIO;
=20
 	memcpy(buf, var->Data, var->DataSize);
@@ -199,6 +208,9 @@ efivar_store_raw(struct efivar_entry *entry, const ch=
ar *buf, size_t count)
 	u8 *data;
 	int err;
=20
+	if (!entry || !buf)
+		return -EINVAL;
+
 	if (in_compat_syscall()) {
 		struct compat_efi_variable *compat;
=20
@@ -250,14 +262,16 @@ efivar_show_raw(struct efivar_entry *entry, char *b=
uf)
 {
 	struct efi_variable *var =3D &entry->var;
 	struct compat_efi_variable *compat;
+	unsigned long datasize =3D sizeof(var->Data);
 	size_t size;
+	int ret;
=20
 	if (!entry || !buf)
 		return 0;
=20
-	var->DataSize =3D 1024;
-	if (efivar_entry_get(entry, &entry->var.Attributes,
-			     &entry->var.DataSize, entry->var.Data))
+	ret =3D efivar_entry_get(entry, &var->Attributes, &datasize, var->Data)=
;
+	var->DataSize =3D size;
+	if (ret)
 		return -EIO;
=20
 	if (in_compat_syscall()) {
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 436d1776bc7b..5f2a4d162795 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -1071,7 +1071,7 @@ EXPORT_SYMBOL_GPL(efivar_entry_iter_end);
  * entry on the list. It is safe for @func to remove entries in the
  * list via efivar_entry_delete().
  *
- * You MUST call efivar_enter_iter_begin() before this function, and
+ * You MUST call efivar_entry_iter_begin() before this function, and
  * efivar_entry_iter_end() afterwards.
  *
  * It is possible to begin iteration from an arbitrary entry within
--=20
2.20.1

