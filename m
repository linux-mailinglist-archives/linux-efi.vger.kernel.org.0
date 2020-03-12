Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D77A182682
	for <lists+linux-efi@lfdr.de>; Thu, 12 Mar 2020 02:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbgCLBMp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Mar 2020 21:12:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:43701 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387518AbgCLBMo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 11 Mar 2020 21:12:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 18:12:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="231882808"
Received: from qiuxu-lab.sh.intel.com ([10.239.53.133])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2020 18:12:42 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     ardb@kernel.org, keescook@chromium.org
Cc:     tony.luck@intel.com, matt@codeblueprint.co.uk,
        liming.gao@intel.com, linux-efi@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH v6 1/2] efi: Add 'nr_config_table' variable in efi structure
Date:   Thu, 12 Mar 2020 09:13:24 +0800
Message-Id: <20200312011324.70701-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The 'nr_config_table' and 'config_table' (already in efi structure)
in efi structure provide a way for some driver(e.g. capsule-pstore
goes through the configuration table to extract crash capsules to
aid in debugging) to iterate over the EFI configuration table array.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 arch/x86/platform/efi/efi.c     | 1 +
 drivers/firmware/efi/arm-init.c | 4 +++-
 drivers/firmware/efi/efi.c      | 1 +
 include/linux/efi.h             | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index ae923ee8e2b4..2f3065905e8a 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -456,6 +456,7 @@ void __init efi_init(void)
 		return;
 
 	efi.config_table = (unsigned long)efi.systab->tables;
+	efi.nr_config_table = (unsigned long)efi.systab->nr_tables;
 	efi.fw_vendor	 = (unsigned long)efi.systab->fw_vendor;
 	efi.runtime	 = (unsigned long)efi.systab->runtime;
 
diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index d99f5b0c8a09..f2e2e1c1624b 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -143,8 +143,10 @@ static int __init uefi_init(void)
 					 sizeof(efi_config_table_t),
 					 arch_tables);
 
-	if (!retval)
+	if (!retval) {
 		efi.config_table = (unsigned long)efi.systab->tables;
+		efi.nr_config_table = (unsigned long)efi.systab->nr_tables;
+	}
 
 	early_memunmap(config_tables, table_size);
 out:
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 621220ab3d0e..1b599941bad3 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -46,6 +46,7 @@ struct efi __read_mostly efi = {
 	.fw_vendor		= EFI_INVALID_TABLE_ADDR,
 	.runtime		= EFI_INVALID_TABLE_ADDR,
 	.config_table		= EFI_INVALID_TABLE_ADDR,
+	.nr_config_table	= 0,
 	.esrt			= EFI_INVALID_TABLE_ADDR,
 	.properties_table	= EFI_INVALID_TABLE_ADDR,
 	.mem_attr_table		= EFI_INVALID_TABLE_ADDR,
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7efd7072cca5..13b3fe069f1f 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -913,6 +913,7 @@ extern struct efi {
 	unsigned long fw_vendor;	/* fw_vendor */
 	unsigned long runtime;		/* runtime table */
 	unsigned long config_table;	/* config tables */
+	unsigned long nr_config_table; /* the number of config tables */
 	unsigned long esrt;		/* ESRT table */
 	unsigned long properties_table;	/* properties table */
 	unsigned long mem_attr_table;	/* memory attributes table */
-- 
2.17.1

