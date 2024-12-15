Return-Path: <linux-efi+bounces-2380-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11AC9F245A
	for <lists+linux-efi@lfdr.de>; Sun, 15 Dec 2024 15:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560CE188494C
	for <lists+linux-efi@lfdr.de>; Sun, 15 Dec 2024 14:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D644417C208;
	Sun, 15 Dec 2024 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="I/VdOhWR"
X-Original-To: linux-efi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC13D23DE;
	Sun, 15 Dec 2024 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734272154; cv=none; b=hUjehRxbuA0SYls5SNsydlgGZoZ/a7uHqsOhFpfhCReDR05f9rIL71nPCEzJWg+hfYDbOKM+M4G0ETvpOI8gKtX7patWwOBXWbossVnGouY0EqB7L4YqFsMEbthxsg2S7ndZq38SLob6v6uadwauL6v2S/6HoptTx+Vzr2SdgIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734272154; c=relaxed/simple;
	bh=/bN1xOCiMkmH5hf6Worwh/k4fuOBgN2GMpOl9WV1TRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xq417KjuTT8RoHxhA2LgZTujK5Dv+3aX6GVJwlWkpw7bV6wNRfxPcjfh6dOR1DqiMuwYcd7BRItR5slq2aFKb4X7Nce6DpHRB3Ss2vYOkGA+ApWhgoLv4rABoUVK0TbF+m7AKkldrcE3pXj52OGhNncxD4Ifiqk+ttdfVINIu8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=I/VdOhWR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734272150;
	bh=/bN1xOCiMkmH5hf6Worwh/k4fuOBgN2GMpOl9WV1TRA=;
	h=From:Date:Subject:To:Cc:From;
	b=I/VdOhWRm8mLJVEp/44JhCZdf/w1iOWOeZvp7sVRm53C/a2GDYbJxuhg897NVdYJR
	 PqHvxcbFbAhLpXmXnIe32U0wuq6EOinHTxYFqzXQ6rHDAHB69iYm/Oz2sHzP/W7lu2
	 IUQ+9l4NaGX7mxXbY0+ObQBY8Xl7SyA3Gg45xe1c=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 15 Dec 2024 15:15:48 +0100
Subject: [PATCH] efi/mokvar: Use const 'struct bin_attribute' callback
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-sysfs-const-bin_attr-mokvar-v1-1-d5a3d1fff8d1@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAJPkXmcC/x3MUQrCMAwA0KuMfBtoyyy6q4iMuiUaZK0kZUzG7
 m7x8/28HYxUyGDodlBaxaTkBn/qYHql/CSUuRmCC70P/oz2NTacSraKD8ljqlVxKe81Kc4cOcX
 o2F2u0IaPEsv232/34/gB78PCEG0AAAA=
X-Change-ID: 20241215-sysfs-const-bin_attr-mokvar-df6fa660f089
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734272150; l=1635;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/bN1xOCiMkmH5hf6Worwh/k4fuOBgN2GMpOl9WV1TRA=;
 b=q9Eoel5Uge8U4bhpCLAJvumkhN+esbL/rNwcTN/sU4SKrp8q25f/yO/uzCc1Ivz60BeG4Vgvh
 WsZzhZhw5jxBA8Salye7YLkmNN3nlJxQXoWd0gpOYipErdNnXcylWd+
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now provides callback variants that explicitly take a
const pointer. Use them so the non-const variants can be removed.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/firmware/efi/mokvar-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
index 5ed0602c2f75f06a247971ade04b87069d59ffa6..59b090849a2a80e013f2537dfdeed50eef871771 100644
--- a/drivers/firmware/efi/mokvar-table.c
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -266,7 +266,7 @@ struct efi_mokvar_table_entry *efi_mokvar_entry_find(const char *name)
  * amount of data in this mokvar config table entry.
  */
 static ssize_t efi_mokvar_sysfs_read(struct file *file, struct kobject *kobj,
-				 struct bin_attribute *bin_attr, char *buf,
+				 const struct bin_attribute *bin_attr, char *buf,
 				 loff_t off, size_t count)
 {
 	struct efi_mokvar_table_entry *mokvar_entry = bin_attr->private;
@@ -343,7 +343,7 @@ static int __init efi_mokvar_sysfs_init(void)
 		mokvar_sysfs->bin_attr.attr.name = mokvar_entry->name;
 		mokvar_sysfs->bin_attr.attr.mode = 0400;
 		mokvar_sysfs->bin_attr.size = mokvar_entry->data_size;
-		mokvar_sysfs->bin_attr.read = efi_mokvar_sysfs_read;
+		mokvar_sysfs->bin_attr.read_new = efi_mokvar_sysfs_read;
 
 		err = sysfs_create_bin_file(mokvar_kobj,
 					   &mokvar_sysfs->bin_attr);

---
base-commit: 2d8308bf5b67dff50262d8a9260a50113b3628c6
change-id: 20241215-sysfs-const-bin_attr-mokvar-df6fa660f089

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


