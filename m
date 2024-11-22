Return-Path: <linux-efi+bounces-2186-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DBE9D5D4A
	for <lists+linux-efi@lfdr.de>; Fri, 22 Nov 2024 11:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F81528355E
	for <lists+linux-efi@lfdr.de>; Fri, 22 Nov 2024 10:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E1216EB5D;
	Fri, 22 Nov 2024 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HgANCMKs"
X-Original-To: linux-efi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D331304BA;
	Fri, 22 Nov 2024 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732271485; cv=none; b=cHW2Vepo+13+rz2RsxFReYYOBIrhXwvVZR3SItZJCS7SX7pg48ab+hAZLNgSnYxJ4nETfortuwm5vBmdehWDDxRRP4ivbBdgcOXfbjCes3x81DI5rRab2hTedRKhVWnSIL/mYvM6/Acj5qj32XjZcqeXRvCPAnbTYaPDlYwSLcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732271485; c=relaxed/simple;
	bh=lz5JV+UPq/FCPgqu3dAGSu1fJIPEU5uoda5RjDr51TQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ibtnEgNvTEjy5PFN88HGIURKjt0GC4DhZTLDHLOXrq/2tn1ROAK5KbsHsMsZCa/6eFj4ig9nbIcaGotoz7772f+OLb99ctFFEv5EyBnxs+UYpnHTGSIb8hvHD6VmymCL3MnBqVyZNzCn4DJghSQlvDfUEkWHpNKjc4Ld6QB+9iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HgANCMKs; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732271479;
	bh=lz5JV+UPq/FCPgqu3dAGSu1fJIPEU5uoda5RjDr51TQ=;
	h=From:Date:Subject:To:Cc:From;
	b=HgANCMKsnGedoo7ZS+kRhaiiJ7a361nd/PFP6nvGhTI6rqly5nqN5Grtmp9TlRO5Q
	 UvgSuVHElPLizP5dieltnj3KDDAQq90RNYjVnXSYOHCZ/vINiPEbS8NHne2A3Kkl6P
	 8BWxdq05ZkBDRdshFKo701N+6XMXmBBGMdskfh5g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 22 Nov 2024 11:31:15 +0100
Subject: [PATCH] efi: rci2: mark bin_attribute as __ro_after_init
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241122-sysfs-const-bin_attr-rci2-v1-1-3db1ec9aa203@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAHJdQGcC/x3MwQqDMAyA4VeRnBewoazgq8iQtktnLnUkRSbiu
 1t2/A7/f4KxChtMwwnKu5hstcM9BshrrB9GeXcDjeSdI0I7rBjmrVrDJHWJrSlqFsLgc0r+WQL
 HAL3/Khf5/d/z67puaMnut2sAAAA=
X-Change-ID: 20241122-sysfs-const-bin_attr-rci2-74cbb46f7ea7
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732271477; l=1011;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=lz5JV+UPq/FCPgqu3dAGSu1fJIPEU5uoda5RjDr51TQ=;
 b=fHUOrtR7NIQS7KukROanGonWdnybWrd6DyZ4LfFK9Iecs0gt9uH6ca95iyRlvlWOqvs4yqCK7
 AtKoLXbjr0vAM9LYqFd6sKcp2PcKM/a0DvKYfJ3xByJ11V+b/apnIKL
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The attribute is only modified during __init phase.
Protect it against accidental or intentional modifications afterwards.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/firmware/efi/rci2-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/rci2-table.c b/drivers/firmware/efi/rci2-table.c
index 4fd45d6f69a4d8b3233b2e49dc91f0b734a338e9..c1bedd244817b2c53d6cfc4cc8b13f479ba3caa9 100644
--- a/drivers/firmware/efi/rci2-table.c
+++ b/drivers/firmware/efi/rci2-table.c
@@ -40,7 +40,7 @@ static u8 *rci2_base;
 static u32 rci2_table_len;
 unsigned long rci2_table_phys __ro_after_init = EFI_INVALID_TABLE_ADDR;
 
-static BIN_ATTR_SIMPLE_ADMIN_RO(rci2);
+static __ro_after_init BIN_ATTR_SIMPLE_ADMIN_RO(rci2);
 
 static u16 checksum(void)
 {

---
base-commit: 28eb75e178d389d325f1666e422bc13bbbb9804c
change-id: 20241122-sysfs-const-bin_attr-rci2-74cbb46f7ea7

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


