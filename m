Return-Path: <linux-efi+bounces-1537-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92B694BF21
	for <lists+linux-efi@lfdr.de>; Thu,  8 Aug 2024 16:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D812889E8
	for <lists+linux-efi@lfdr.de>; Thu,  8 Aug 2024 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0963D18E052;
	Thu,  8 Aug 2024 14:08:09 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E718C90C;
	Thu,  8 Aug 2024 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126088; cv=none; b=MWHIRKLSXgM1fD0BtCx5kCanTsygSR2ko4p5dfT2TAycOTH3ooPXP4m769+aI2k2Zx18SIHVDsCiQVyD6iMezYdyfklufmqbph4IT+tofHSsbjOsqjxIhsDfDrnsCsOp1x+rcC937Nn3ti5ACot5VgqaCl6nGZ5k4cADGqpB+kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126088; c=relaxed/simple;
	bh=jUWTMyOw24El92k4qsB0MCjub1KUx+N7wb4tKB9ZL6U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eCIiUUq0EubN5moQSyUgIAOSCOT/t9Sygf7iRNYC65bn1jM9kHMjWjwgnSTbG0qenD4u4DBsgCpgigxrtPyASHqpR4sxqbz3laHqkf5C7sGBbNIpcksfHHh3t8JiLjiiIpCyEb3udN/7xaseafWpB9ZQXtMVuw47SvPdxBQz89E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wfpjq4V4VzDqc3;
	Thu,  8 Aug 2024 22:06:07 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DD2D140796;
	Thu,  8 Aug 2024 22:08:02 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 8 Aug
 2024 22:08:01 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <ardb@kernel.org>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] efi: Remove unused declaration efi_initialize_iomem_resources()
Date: Thu, 8 Aug 2024 22:05:54 +0800
Message-ID: <20240808140554.2498398-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Since commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture"),
this is not used anymore.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/efi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 6bf3c4fe8511..e28d88066033 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -764,8 +764,6 @@ extern int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md);
 extern int __efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md);
 extern void efi_mem_reserve(phys_addr_t addr, u64 size);
 extern int efi_mem_reserve_persistent(phys_addr_t addr, u64 size);
-extern void efi_initialize_iomem_resources(struct resource *code_resource,
-		struct resource *data_resource, struct resource *bss_resource);
 extern u64 efi_get_fdt_params(struct efi_memory_map_data *data);
 extern struct kobject *efi_kobj;
 
-- 
2.34.1


