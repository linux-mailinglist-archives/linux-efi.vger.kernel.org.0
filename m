Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA8C16054D
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 19:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgBPSXs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 13:23:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:32994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgBPSXs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 13:23:48 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B7F22522;
        Sun, 16 Feb 2020 18:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581877428;
        bh=tBrRsneP/Qs4RsbmuuoI8w+sAxty14FJ/aFDIlwLcSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOXSSsDbKGxlhyfaC4IT+eNVuEAD9AuP2TVa9Alj/4cm90Z6U4OqzaSeYrmKcTy6l
         U/hbqdzyKYqz8NzxmcMrcDI5kGNWpEomsqQ0vfOUSLXam+7kEfo1xbKpHdZmmyfm+7
         wGVmGszOwGMcX6oTkzFJzw70ID3jwSq/jwZI6UHk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        x86@kernel.org
Subject: [PATCH 01/18] efi: drop handling of 'boot_info' configuration table
Date:   Sun, 16 Feb 2020 19:23:17 +0100
Message-Id: <20200216182334.8121-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200216182334.8121-1-ardb@kernel.org>
References: <20200216182334.8121-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Some plumbing exists to handle a UEFI configuration table of type
BOOT_INFO but since we never match it to a GUID anywhere, we never
actually register such a table, or access it, for that matter. So
simply drop all mentions of it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi.c | 1 -
 drivers/firmware/efi/efi.c  | 3 ---
 include/linux/efi.h         | 1 -
 3 files changed, 5 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index ae923ee8e2b4..383d1003c3dc 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -70,7 +70,6 @@ static const unsigned long * const efi_tables[] = {
 	&efi.acpi20,
 	&efi.smbios,
 	&efi.smbios3,
-	&efi.boot_info,
 	&efi.hcdp,
 	&efi.uga,
 #ifdef CONFIG_X86_UV
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 621220ab3d0e..5464e3849ee4 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -40,7 +40,6 @@ struct efi __read_mostly efi = {
 	.acpi20			= EFI_INVALID_TABLE_ADDR,
 	.smbios			= EFI_INVALID_TABLE_ADDR,
 	.smbios3		= EFI_INVALID_TABLE_ADDR,
-	.boot_info		= EFI_INVALID_TABLE_ADDR,
 	.hcdp			= EFI_INVALID_TABLE_ADDR,
 	.uga			= EFI_INVALID_TABLE_ADDR,
 	.fw_vendor		= EFI_INVALID_TABLE_ADDR,
@@ -139,8 +138,6 @@ static ssize_t systab_show(struct kobject *kobj,
 		str += sprintf(str, "SMBIOS=0x%lx\n", efi.smbios);
 	if (efi.hcdp != EFI_INVALID_TABLE_ADDR)
 		str += sprintf(str, "HCDP=0x%lx\n", efi.hcdp);
-	if (efi.boot_info != EFI_INVALID_TABLE_ADDR)
-		str += sprintf(str, "BOOTINFO=0x%lx\n", efi.boot_info);
 	if (efi.uga != EFI_INVALID_TABLE_ADDR)
 		str += sprintf(str, "UGA=0x%lx\n", efi.uga);
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 1bf482daa22d..c517d3b7986b 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -536,7 +536,6 @@ extern struct efi {
 	unsigned long acpi20;		/* ACPI table  (ACPI 2.0) */
 	unsigned long smbios;		/* SMBIOS table (32 bit entry point) */
 	unsigned long smbios3;		/* SMBIOS table (64 bit entry point) */
-	unsigned long boot_info;	/* boot info table */
 	unsigned long hcdp;		/* HCDP table */
 	unsigned long uga;		/* UGA table */
 	unsigned long fw_vendor;	/* fw_vendor */
-- 
2.17.1

