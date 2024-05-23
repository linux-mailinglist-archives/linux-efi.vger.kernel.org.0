Return-Path: <linux-efi+bounces-1075-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3956B8CD0D5
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 13:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654731C20FB4
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 11:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9C61448D2;
	Thu, 23 May 2024 11:06:01 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C3546AF;
	Thu, 23 May 2024 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462361; cv=none; b=Cw2Y4HG0bVyADl/F/Qi4rweT+5WGSPo9/g6OJYfhljI75trSCBSgsp2Fhctcw8/riS12cc7N6lXmwseALINX7wdQSIq57wjMbtfYuIFQd5gsmCvzyh7J8tUCO7jEN/LUXrRaPmPucv2TvCX+LSpBpiV4kuLtMp7YBeokp9sR/Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462361; c=relaxed/simple;
	bh=1iwYUuxtNs1jjZ796ZpZFQ+C43XWPyywwcrX4m2EB9A=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=jCFA0A//+1NrV9LmRgPlTC/ZliYtEpjeS3pXnF9L67FCcB3OhUW4dxgFIK6kshM3dimmxwm1QbsEllIZX++qiDavZrW80/+sAe13WbFPpAbyFeLEx4mDSv4fgezPKS2lJQZ836HbfYpxOvY+PRdsM6EP4d9A4PRQoLODamSB9Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id BFDF41029124C;
	Thu, 23 May 2024 13:00:02 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 6AD8F603EE84;
	Thu, 23 May 2024 13:00:02 +0200 (CEST)
X-Mailbox-Line: From 05f4290439a58730738a15b0c99cd8576c4aa0d9 Mon Sep 17 00:00:00 2001
Message-ID: <05f4290439a58730738a15b0c99cd8576c4aa0d9.1716461752.git.lukas@wunner.de>
In-Reply-To: <2024052334-nape-wanting-0a2a@gregkh>
References: <2024052334-nape-wanting-0a2a@gregkh>
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 23 May 2024 13:00:00 +0200
Subject: [PATCH] sysfs: Unbreak the build around sysfs_bin_attr_simple_read()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>, intel-gvt-dev@lists.freedesktop.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org

Günter reports build breakage for m68k "m5208evb_defconfig" plus
CONFIG_BLK_DEV_INITRD=y caused by commit 66bc1a173328 ("treewide:
Use sysfs_bin_attr_simple_read() helper").

The defconfig disables CONFIG_SYSFS, so sysfs_bin_attr_simple_read()
is not compiled into the kernel.  But init/initramfs.c references
that function in the initializer of a struct bin_attribute.

Add an empty static inline to avoid the build breakage.

Fixes: 66bc1a173328 ("treewide: Use sysfs_bin_attr_simple_read() helper")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/r/e12b0027-b199-4de7-b83d-668171447ccc@roeck-us.net
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 include/linux/sysfs.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index a7d725fbf739..c4e64dc11206 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -750,6 +750,15 @@ static inline int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
 {
 	return 0;
 }
+
+static inline ssize_t sysfs_bin_attr_simple_read(struct file *file,
+						 struct kobject *kobj,
+						 struct bin_attribute *attr,
+						 char *buf, loff_t off,
+						 size_t count)
+{
+	return 0;
+}
 #endif /* CONFIG_SYSFS */
 
 static inline int __must_check sysfs_create_file(struct kobject *kobj,
-- 
2.43.0


