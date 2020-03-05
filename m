Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89D5717A188
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2020 09:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgCEIlu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Mar 2020 03:41:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42506 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725880AbgCEIlu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Mar 2020 03:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583397709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZjPWVpRUeksGAEeLl+ykYm6riq5bWsuGzHKsKXAXrc=;
        b=TxnBYMHuUrBtAXYAHwpuwtZIMmFhwNzsF8DazE5lmWXT+tc/tYVx2IsH6rwUfXlD3kA9d+
        r9zmsvdM2KKiVYozUXhpmvHd0wnjMvvqqBwh6Djgq0p+VzRyTBzZT6MR0ch0FVgmpN7aVa
        zg0BefdokXO9ozJtTwlNzdoHenXgaio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-ByDnBE4NPTuRnjw-EkcEkQ-1; Thu, 05 Mar 2020 03:41:45 -0500
X-MC-Unique: ByDnBE4NPTuRnjw-EkcEkQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5450413FC;
        Thu,  5 Mar 2020 08:41:44 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-204-231.brq.redhat.com [10.40.204.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C55E19C6A;
        Thu,  5 Mar 2020 08:41:40 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        joeyli <jlee@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] efi: fix a race and a buffer overflow while reading efivars via sysfs
Date:   Thu,  5 Mar 2020 09:40:39 +0100
Message-Id: <20200305084041.24053-2-vdronov@redhat.com>
In-Reply-To: <20200305084041.24053-1-vdronov@redhat.com>
References: <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com>
 <20200305084041.24053-1-vdronov@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
does not get overwritten.

Reported-by: Bob Sanders <bob.sanders@hpe.com> and the LTP testsuite
Link: https://lore.kernel.org/linux-efi/20200303085528.27658-1-vdronov@re=
dhat.com/T/#u
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 drivers/firmware/efi/efivars.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivar=
s.c
index 7576450c8254..69f13bc4b931 100644
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
@@ -250,14 +259,16 @@ efivar_show_raw(struct efivar_entry *entry, char *b=
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
+	var->DataSize =3D datasize;
+	if (ret)
 		return -EIO;
=20
 	if (in_compat_syscall()) {
--=20
2.20.1

