Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C611E1771A0
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 09:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgCCIzz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 03:55:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30935 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726661AbgCCIzy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Mar 2020 03:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583225753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4Wusuvt+f0QxuyOhtSB3+Z724RtHbJNgXVRXwJqiQnk=;
        b=WUy+qF4AXB6c7DYp0SNFoLcgOIDGsFAOr2GMRE1/VQrBVT96EdIGq4cDiuI2q9welbt9DQ
        8clW+QBU5GT76FPibj/NMsF4SqoPJ9PNdE37TuEe49+x6ATvwo7zkKNjE/Hpst319sxZ90
        NPR0+5qkK7PqR6IwS4RuXIUzDlSmHJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-IVfHtlhvNZWTRNUNpvbj-w-1; Tue, 03 Mar 2020 03:55:51 -0500
X-MC-Unique: IVfHtlhvNZWTRNUNpvbj-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4896618FF660;
        Tue,  3 Mar 2020 08:55:50 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-204-56.brq.redhat.com [10.40.204.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E21421001B0B;
        Tue,  3 Mar 2020 08:55:46 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] efi: fix a race and a buffer overflow while reading efivars via sysfs
Date:   Tue,  3 Mar 2020 09:55:28 +0100
Message-Id: <20200303085528.27658-1-vdronov@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Fix this by protecting struct efi_variable access by efivars_lock by usin=
g
efivar_entry_iter_begin()/efivar_entry_iter_end(). Brush up and unify
efivar_entry_[gs]et() and __efivar_entry_[gs]et() for this. This looks
simpler than introducing a separate lock for every struct efi_variable.

Also fix the same race in efivar_store_raw() and efivar_show_raw(). The
call in efi_pstore_read_func() is protected like this already.

Reported-by: Bob Sanders <bob.sanders@hpe.com> and the LTP testsuite
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 drivers/firmware/efi/efi-pstore.c |  2 +-
 drivers/firmware/efi/efivars.c    | 72 ++++++++++++++++++++++++-------
 drivers/firmware/efi/vars.c       | 47 ++++++++++++--------
 include/linux/efi.h               |  2 +
 4 files changed, 90 insertions(+), 33 deletions(-)

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
index 7576450c8254..f415cf863ee0 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -88,9 +88,15 @@ efivar_attr_read(struct efivar_entry *entry, char *buf=
)
 	if (!entry || !buf)
 		return -EINVAL;
=20
+	if (efivar_entry_iter_begin())
+		return -EINTR;
+
 	var->DataSize =3D 1024;
-	if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data=
))
+	if (__efivar_entry_get(entry, &var->Attributes, &var->DataSize,
+			var->Data)) {
+		efivar_entry_iter_end();
 		return -EIO;
+	}
=20
 	if (var->Attributes & EFI_VARIABLE_NON_VOLATILE)
 		str +=3D sprintf(str, "EFI_VARIABLE_NON_VOLATILE\n");
@@ -109,6 +115,8 @@ efivar_attr_read(struct efivar_entry *entry, char *bu=
f)
 			"EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS\n");
 	if (var->Attributes & EFI_VARIABLE_APPEND_WRITE)
 		str +=3D sprintf(str, "EFI_VARIABLE_APPEND_WRITE\n");
+
+	efivar_entry_iter_end();
 	return str - buf;
 }
=20
@@ -121,11 +129,19 @@ efivar_size_read(struct efivar_entry *entry, char *=
buf)
 	if (!entry || !buf)
 		return -EINVAL;
=20
+	if (efivar_entry_iter_begin())
+		return -EINTR;
+
 	var->DataSize =3D 1024;
-	if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data=
))
+	if (__efivar_entry_get(entry, &var->Attributes, &var->DataSize,
+			var->Data)) {
+		efivar_entry_iter_end();
 		return -EIO;
+	}
=20
 	str +=3D sprintf(str, "0x%lx\n", var->DataSize);
+
+	efivar_entry_iter_end();
 	return str - buf;
 }
=20
@@ -137,11 +153,19 @@ efivar_data_read(struct efivar_entry *entry, char *=
buf)
 	if (!entry || !buf)
 		return -EINVAL;
=20
+	if (efivar_entry_iter_begin())
+		return -EINTR;
+
 	var->DataSize =3D 1024;
-	if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data=
))
+	if (__efivar_entry_get(entry, &var->Attributes, &var->DataSize,
+			var->Data)) {
+		efivar_entry_iter_end();
 		return -EIO;
+	}
=20
 	memcpy(buf, var->Data, var->DataSize);
+
+	efivar_entry_iter_end();
 	return var->DataSize;
 }
=20
@@ -197,13 +221,21 @@ efivar_store_raw(struct efivar_entry *entry, const =
char *buf, size_t count)
 	efi_guid_t vendor;
 	u32 attributes;
 	u8 *data;
-	int err;
+	int err =3D 0;
+
+	if (!entry || !buf)
+		return -EINVAL;
+
+	if (efivar_entry_iter_begin())
+		return -EINTR;
=20
 	if (in_compat_syscall()) {
 		struct compat_efi_variable *compat;
=20
-		if (count !=3D sizeof(*compat))
-			return -EINVAL;
+		if (count !=3D sizeof(*compat)) {
+			err =3D -EINVAL;
+			goto out;
+		}
=20
 		compat =3D (struct compat_efi_variable *)buf;
 		attributes =3D compat->Attributes;
@@ -214,12 +246,14 @@ efivar_store_raw(struct efivar_entry *entry, const =
char *buf, size_t count)
=20
 		err =3D sanity_check(var, name, vendor, size, attributes, data);
 		if (err)
-			return err;
+			goto out;
=20
 		copy_out_compat(&entry->var, compat);
 	} else {
-		if (count !=3D sizeof(struct efi_variable))
-			return -EINVAL;
+		if (count !=3D sizeof(struct efi_variable)) {
+			err =3D -EINVAL;
+			goto out;
+		}
=20
 		new_var =3D (struct efi_variable *)buf;
=20
@@ -231,18 +265,20 @@ efivar_store_raw(struct efivar_entry *entry, const =
char *buf, size_t count)
=20
 		err =3D sanity_check(var, name, vendor, size, attributes, data);
 		if (err)
-			return err;
+			goto out;
=20
 		memcpy(&entry->var, new_var, count);
 	}
=20
-	err =3D efivar_entry_set(entry, attributes, size, data, NULL);
+	err =3D __efivar_entry_set(entry, attributes, size, data, NULL);
 	if (err) {
 		printk(KERN_WARNING "efivars: set_variable() failed: status=3D%d\n", e=
rr);
-		return -EIO;
+		err =3D -EIO;
 	}
=20
-	return count;
+out:
+	efivar_entry_iter_end();
+	return err ?: count;
 }
=20
 static ssize_t
@@ -255,10 +291,15 @@ efivar_show_raw(struct efivar_entry *entry, char *b=
uf)
 	if (!entry || !buf)
 		return 0;
=20
+	if (efivar_entry_iter_begin())
+		return -EINTR;
+
 	var->DataSize =3D 1024;
-	if (efivar_entry_get(entry, &entry->var.Attributes,
-			     &entry->var.DataSize, entry->var.Data))
+	if (__efivar_entry_get(entry, &var->Attributes, &var->DataSize,
+			var->Data)) {
+		efivar_entry_iter_end();
 		return -EIO;
+	}
=20
 	if (in_compat_syscall()) {
 		compat =3D (struct compat_efi_variable *)buf;
@@ -276,6 +317,7 @@ efivar_show_raw(struct efivar_entry *entry, char *buf=
)
 		memcpy(buf, var, size);
 	}
=20
+	efivar_entry_iter_end();
 	return size;
 }
=20
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 436d1776bc7b..4a47e20a7667 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -636,7 +636,7 @@ int efivar_entry_delete(struct efivar_entry *entry)
 EXPORT_SYMBOL_GPL(efivar_entry_delete);
=20
 /**
- * efivar_entry_set - call set_variable()
+ * __efivar_entry_set - call set_variable()
  * @entry: entry containing the EFI variable to write
  * @attributes: variable attributes
  * @size: size of @data buffer
@@ -655,8 +655,12 @@ EXPORT_SYMBOL_GPL(efivar_entry_delete);
  * Returns 0 on success, -EINTR if we can't grab the semaphore,
  * -EEXIST if a lookup is performed and the entry already exists on
  * the list, or a converted EFI status code if set_variable() fails.
+ *
+ * The caller MUST call efivar_entry_iter_begin() and
+ * efivar_entry_iter_end() before and after the invocation of this
+ * function, respectively.
  */
-int efivar_entry_set(struct efivar_entry *entry, u32 attributes,
+int __efivar_entry_set(struct efivar_entry *entry, u32 attributes,
 		     unsigned long size, void *data, struct list_head *head)
 {
 	const struct efivar_operations *ops;
@@ -664,9 +668,6 @@ int efivar_entry_set(struct efivar_entry *entry, u32 =
attributes,
 	efi_char16_t *name =3D entry->var.VariableName;
 	efi_guid_t vendor =3D entry->var.VendorGuid;
=20
-	if (down_interruptible(&efivars_lock))
-		return -EINTR;
-
 	if (!__efivars) {
 		up(&efivars_lock);
 		return -EINVAL;
@@ -682,10 +683,28 @@ int efivar_entry_set(struct efivar_entry *entry, u3=
2 attributes,
 		status =3D ops->set_variable(name, &vendor,
 					   attributes, size, data);
=20
-	up(&efivars_lock);
-
 	return efi_status_to_err(status);
+}
+EXPORT_SYMBOL_GPL(__efivar_entry_set);
=20
+/**
+ * efivar_entry_set - call set_variable()
+ *
+ * This function takes efivars_lock and calls __efivar_entry_set()
+ */
+int efivar_entry_set(struct efivar_entry *entry, u32 attributes,
+		     unsigned long size, void *data, struct list_head *head)
+{
+	int ret;
+
+	if (down_interruptible(&efivars_lock))
+		return -EINTR;
+
+	ret =3D __efivar_entry_set(entry, attributes, size, data, head);
+
+	up(&efivars_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(efivar_entry_set);
=20
@@ -914,22 +933,16 @@ EXPORT_SYMBOL_GPL(__efivar_entry_get);
 int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
 		     unsigned long *size, void *data)
 {
-	efi_status_t status;
+	int ret;
=20
 	if (down_interruptible(&efivars_lock))
 		return -EINTR;
=20
-	if (!__efivars) {
-		up(&efivars_lock);
-		return -EINVAL;
-	}
+	ret =3D __efivar_entry_get(entry, attributes, size, data);
=20
-	status =3D __efivars->ops->get_variable(entry->var.VariableName,
-					      &entry->var.VendorGuid,
-					      attributes, size, data);
 	up(&efivars_lock);
=20
-	return efi_status_to_err(status);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(efivar_entry_get);
=20
@@ -1071,7 +1084,7 @@ EXPORT_SYMBOL_GPL(efivar_entry_iter_end);
  * entry on the list. It is safe for @func to remove entries in the
  * list via efivar_entry_delete().
  *
- * You MUST call efivar_enter_iter_begin() before this function, and
+ * You MUST call efivar_entry_iter_begin() before this function, and
  * efivar_entry_iter_end() afterwards.
  *
  * It is possible to begin iteration from an arbitrary entry within
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7efd7072cca5..5c3db088d375 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1414,6 +1414,8 @@ int __efivar_entry_get(struct efivar_entry *entry, =
u32 *attributes,
 		       unsigned long *size, void *data);
 int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
 		     unsigned long *size, void *data);
+int __efivar_entry_set(struct efivar_entry *entry, u32 attributes,
+		     unsigned long size, void *data, struct list_head *head);
 int efivar_entry_set(struct efivar_entry *entry, u32 attributes,
 		     unsigned long size, void *data, struct list_head *head);
 int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes=
,
--=20
2.20.1

