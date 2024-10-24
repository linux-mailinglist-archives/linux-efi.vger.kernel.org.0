Return-Path: <linux-efi+bounces-2014-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD239ADF1E
	for <lists+linux-efi@lfdr.de>; Thu, 24 Oct 2024 10:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC0D1F23456
	for <lists+linux-efi@lfdr.de>; Thu, 24 Oct 2024 08:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5B3189BBC;
	Thu, 24 Oct 2024 08:31:02 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF526F305;
	Thu, 24 Oct 2024 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758662; cv=none; b=kUXkgE6DISU5Tqu3dydJV7+6e+kTfe+kLb1muosJ0ItEOPKnez8lLsrzADx6KbeO3Sf9Wh83Bjg2//hrPJrX17O+vGp/xpYjvFwmQ8j0k6A614zQSjVxM6SfDeojioKpDE6Vb5eejoxGtEqzfQXMNBgGmdQNTBsHuEqNGoRb/2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758662; c=relaxed/simple;
	bh=mnuase4KjjRfWvoiy0xsaSM8UmdLqsG14Aah3SnoHwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EeyZKHdb8DMDQAOyhPcIcRh9QM4OacALPgoiVlWdTyIn+xr3ZCFbuXWUVgC3U0/4cpvxMeBt69591OF9b39VUpy503nQE6d3a80vlHWjMpCcNJDa9q4KnWOsK87xF4onfL8CJnoBoKptokKiUZJjOJduxsOW+qq9VJB/cGROW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XYzdc5Y02z1ynPv;
	Thu, 24 Oct 2024 16:31:00 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CFCD1400CB;
	Thu, 24 Oct 2024 16:30:53 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Oct
 2024 16:30:52 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <bp@suse.de>, <javierm@redhat.com>, <ardb@kernel.org>,
	<tzimmermann@suse.de>, <simona.vetter@ffwll.ch>
CC: <linux-kernel@vger.kernel.org>, <bobo.shaobowang@huawei.com>,
	<linux-efi@vger.kernel.org>
Subject: [PATCH] drivers/firmware: Fix unused const variable 'efifb_fwnode_ops'
Date: Thu, 24 Oct 2024 16:44:35 +0800
Message-ID: <20241024084435.165333-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Fix the following compilation warning:

drivers/firmware/efi/sysfb_efi.c:345:39: warning:
‘efifb_fwnode_ops’ defined but not used [-Wunused-const-variable=]
  345 | static const struct fwnode_operations efifb_fwnode_ops = {

drivers/firmware/efi/sysfb_efi.c:238:35: warning:
‘efifb_dmi_swap_width_height’ defined but not used
[-Wunused-const-variable=]
  238 | static const struct dmi_system_id
	efifb_dmi_swap_width_height[] __initconst = {

drivers/firmware/efi/sysfb_efi.c:188:35: warning:
‘efifb_dmi_system_table’ defined but not used
[-Wunused-const-variable=]
  188 | static const struct dmi_system_id
	efifb_dmi_system_table[] __initconst = {

Only define the const variables when the CONFIG_EFI is enabled.

Fixes: 8633ef82f101 ("drivers/firmware: consolidate EFI framebuffer setup for all arches")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/firmware/efi/sysfb_efi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index cc807ed35aed..f75bfe9b197c 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -185,6 +185,7 @@ static int __init efifb_set_system(const struct dmi_system_id *id)
 		&efifb_dmi_list[enumid]				\
 	}
 
+#ifdef CONFIG_EFI
 static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
 	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "iMac4,1", M_I17),
 	/* At least one of these two will be right; maybe both? */
@@ -282,6 +283,7 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
 	},
 	{},
 };
+#endif
 
 static bool efifb_overlaps_pci_range(const struct of_pci_range *range)
 {
@@ -342,10 +344,6 @@ static int efifb_add_links(struct fwnode_handle *fwnode)
 	return 0;
 }
 
-static const struct fwnode_operations efifb_fwnode_ops = {
-	.add_links = efifb_add_links,
-};
-
 #ifdef CONFIG_EFI
 static struct fwnode_handle efifb_fwnode;
 
@@ -365,6 +363,10 @@ __init void sysfb_apply_efi_quirks(void)
 	}
 }
 
+static const struct fwnode_operations efifb_fwnode_ops = {
+	.add_links = efifb_add_links,
+};
+
 __init void sysfb_set_efifb_fwnode(struct platform_device *pd)
 {
 	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI && IS_ENABLED(CONFIG_PCI)) {
-- 
2.25.1


