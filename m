Return-Path: <linux-efi+bounces-2022-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CFB9B1586
	for <lists+linux-efi@lfdr.de>; Sat, 26 Oct 2024 08:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C067B21D82
	for <lists+linux-efi@lfdr.de>; Sat, 26 Oct 2024 06:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2481632F4;
	Sat, 26 Oct 2024 06:48:56 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB98429CE5;
	Sat, 26 Oct 2024 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729925336; cv=none; b=i7ux70FxOeIAI3z8chXGFc/izZgQni6fjg0btilFskRjAWquhhRhag9Nvpa/pEWTDgrLw9NfGTdjNKe26Y7xR6imt0TlID3czxqj6RiDZO8QWsHC3JB0op9JykuoGwmvM/QwoAEzINcFXtwZJcglAEyPqeISnUkO4i1J0dUCEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729925336; c=relaxed/simple;
	bh=cvqGneQGGub8/U4EpGyH4uuPlIxfrPXBqsIovPe5Hoc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GryBUbi/z3TrXQrNLCEI1UvAXQB37X4rsUbUBsp0m6JRoFqMHmJqpSjbe04UcPM00brdK3ARsFXT6UqTsErnfZJl4bTdzkNqDqAdPhxfvTFFqExC8wQ4EOsFjheOGLQx592FsXWbon21xf7eBlWFAo6lNeEGcpqlZtlIPPvdPt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Xb9F66h4jz1SD2V;
	Sat, 26 Oct 2024 14:47:22 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FCE1180041;
	Sat, 26 Oct 2024 14:48:50 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 26 Oct
 2024 14:48:49 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <tzimmermann@suse.de>, <javierm@redhat.com>,
	<andriy.shevchenko@intel.com>, <ardb@kernel.org>, <bp@suse.de>,
	<simona.vetter@ffwll.ch>
CC: <bobo.shaobowang@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-efi@vger.kernel.org>
Subject: [PATCH v2] efi: sysfb_efi: Fix unused const variable 'efifb_fwnode_ops'
Date: Sat, 26 Oct 2024 15:02:28 +0800
Message-ID: <20241026070228.3240177-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

In addition to the above warning messages, a series of unused warnings
because of cascading dependencies were found. The variables and functions
related to warnings are only used after CONFIG_EFI enabled. Therefore,
these warnings are addressed and fixed in this commit.

Fixes: 8633ef82f101 ("drivers/firmware: consolidate EFI framebuffer setup for all arches")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/firmware/efi/sysfb_efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index cc807ed35aed..0cfc11ecc98b 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -82,6 +82,7 @@ void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
 	}
 }
 
+#ifdef CONFIG_EFI
 #define choose_value(dmivalue, fwvalue, field, flags) ({	\
 		typeof(fwvalue) _ret_ = fwvalue;		\
 		if ((flags) & (field))				\
@@ -346,7 +347,6 @@ static const struct fwnode_operations efifb_fwnode_ops = {
 	.add_links = efifb_add_links,
 };
 
-#ifdef CONFIG_EFI
 static struct fwnode_handle efifb_fwnode;
 
 __init void sysfb_apply_efi_quirks(void)
-- 
2.25.1


