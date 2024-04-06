Return-Path: <linux-efi+bounces-927-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA8F89AB27
	for <lists+linux-efi@lfdr.de>; Sat,  6 Apr 2024 15:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C912821E4
	for <lists+linux-efi@lfdr.de>; Sat,  6 Apr 2024 13:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB303374EA;
	Sat,  6 Apr 2024 13:53:08 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576552C1A3;
	Sat,  6 Apr 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712411588; cv=none; b=JkDPo/hgkErCJLHIK3A4aMJa8VQZwEWl0phz3RP7yq2d9WpbR2FO2e2EY8pDKclckjzBlAFrjR0WY2tD+Dq73GNa32Gy6PmZK3AoJx4iY8rvbE8zO7lSUlr1hPZd0dLK7jQMPDfuBjRZWHdIHzj7HiTIJINGOKbH6sJVUIsR6Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712411588; c=relaxed/simple;
	bh=KaB+H/QNRD1ZBpVagmhzPb+DI/HWOBbGyYx+42MjjhA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc; b=QACPOzWN+wOGQs43EFd28mp/05k0NeU6ez/KBaEgmxI19H6XqSjixDpKdKnTtC84c+TXFK0zPiu2vAZDLWxd+7LwageR0/JBDqaB+nD32zzDyWV6yZQgqdqPrD1PihWecEquxPgEEdudlwGBoc4n9xxL9mtN4n1gsCI1ntXj7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 71931100DA1BC;
	Sat,  6 Apr 2024 15:53:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 483384E2B1B; Sat,  6 Apr 2024 15:53:04 +0200 (CEST)
Message-Id: <5ed62b197a442ec6db53d8746d9d806dd0576e2d.1712410202.git.lukas@wunner.de>
In-Reply-To: <cover.1712410202.git.lukas@wunner.de>
References: <cover.1712410202.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 6 Apr 2024 15:52:01 +0200
Subject: [PATCH 1/2] sysfs: Add sysfs_bin_attr_simple_read() helper
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>, intel-gvt-dev@lists.freedesktop.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

When drivers expose a bin_attribute in sysfs which is backed by a buffer
in memory, a common pattern is to set the @private and @size members in
struct bin_attribute to the buffer's location and size.

The ->read() callback then merely consists of a single memcpy() call.
It's not even necessary to perform bounds checks as these are already
handled by sysfs_kf_bin_read().

However each driver is so far providing its own ->read() implementation.
The pattern is sufficiently frequent to merit a public helper, so add
sysfs_bin_attr_simple_read() as well as BIN_ATTR_SIMPLE_RO() and
BIN_ATTR_SIMPLE_ADMIN_RO() macros to ease declaration of such
bin_attributes and reduce LoC and .text section size.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 fs/sysfs/file.c       | 27 +++++++++++++++++++++++++++
 include/linux/sysfs.h | 15 +++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 6b7652f..289b57d 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -783,3 +783,30 @@ int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
 	return len;
 }
 EXPORT_SYMBOL_GPL(sysfs_emit_at);
+
+/**
+ *	sysfs_bin_attr_simple_read - read callback to simply copy from memory.
+ *	@file:	attribute file which is being read.
+ *	@kobj:	object to which the attribute belongs.
+ *	@attr:	attribute descriptor.
+ *	@buf:	destination buffer.
+ *	@off:	offset in bytes from which to read.
+ *	@count:	maximum number of bytes to read.
+ *
+ * Simple ->read() callback for bin_attributes backed by a buffer in memory.
+ * The @private and @size members in struct bin_attribute must be set to the
+ * buffer's location and size before the bin_attribute is created in sysfs.
+ *
+ * Bounds check for @off and @count is done in sysfs_kf_bin_read().
+ * Negative value check for @off is done in vfs_setpos() and default_llseek().
+ *
+ * Returns number of bytes written to @buf.
+ */
+ssize_t sysfs_bin_attr_simple_read(struct file *file, struct kobject *kobj,
+				   struct bin_attribute *attr, char *buf,
+				   loff_t off, size_t count)
+{
+	memcpy(buf, attr->private + off, count);
+	return count;
+}
+EXPORT_SYMBOL_GPL(sysfs_bin_attr_simple_read);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 326341c..a7d725f 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -371,6 +371,17 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR_ADMIN_RO(_name, _size)
 #define BIN_ATTR_ADMIN_RW(_name, _size)					\
 struct bin_attribute bin_attr_##_name = __BIN_ATTR_ADMIN_RW(_name, _size)
 
+#define __BIN_ATTR_SIMPLE_RO(_name, _mode) {				\
+	.attr	= { .name = __stringify(_name), .mode = _mode },	\
+	.read	= sysfs_bin_attr_simple_read,				\
+}
+
+#define BIN_ATTR_SIMPLE_RO(_name)					\
+struct bin_attribute bin_attr_##_name = __BIN_ATTR_SIMPLE_RO(_name, 0444)
+
+#define BIN_ATTR_SIMPLE_ADMIN_RO(_name)					\
+struct bin_attribute bin_attr_##_name = __BIN_ATTR_SIMPLE_RO(_name, 0400)
+
 struct sysfs_ops {
 	ssize_t	(*show)(struct kobject *, struct attribute *, char *);
 	ssize_t	(*store)(struct kobject *, struct attribute *, const char *, size_t);
@@ -478,6 +489,10 @@ int sysfs_group_change_owner(struct kobject *kobj,
 __printf(3, 4)
 int sysfs_emit_at(char *buf, int at, const char *fmt, ...);
 
+ssize_t sysfs_bin_attr_simple_read(struct file *file, struct kobject *kobj,
+				   struct bin_attribute *attr, char *buf,
+				   loff_t off, size_t count);
+
 #else /* CONFIG_SYSFS */
 
 static inline int sysfs_create_dir_ns(struct kobject *kobj, const void *ns)
-- 
2.43.0


