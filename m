Return-Path: <linux-efi+bounces-1645-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CDD96A0B7
	for <lists+linux-efi@lfdr.de>; Tue,  3 Sep 2024 16:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2641C21359
	for <lists+linux-efi@lfdr.de>; Tue,  3 Sep 2024 14:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBBB374CC;
	Tue,  3 Sep 2024 14:32:46 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8E81F937
	for <linux-efi@vger.kernel.org>; Tue,  3 Sep 2024 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373966; cv=none; b=ErFQVaeZum5lPAUv+q7V3C3rxgJClvVpZMhoRQbXfjDX1cznPZ1WU1I92wiKMULLsgepsoEFt2+GbSt6xmBQhrMe2r/S58wRiovH8qX3h+l1+0WnGrUIY49bXUDkamaYtdAVOlt5s+3ow4cZhjjBZGr4DF6bi8BywKsgahBqcZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373966; c=relaxed/simple;
	bh=zE5EjYvVJJiYE21GO+n8Clgo0B9gewNMONBTl3j/+eI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lpNKBrw2ZhiKKqoSIOR0RdvMcx84CpnKFzXUL/DEhy2o6Mu4+ybqJ8fL9+8xypUH1MN/133RnFB4zq0UUj2wRL0XcNu8yBYR+8FvQaSl4u8mbmJobCFNNfcP5cTOsWyRMQ3iaDVqUa16TCY5hjo/ACA+FqlBFMXFqm+8Q7JuKuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wyp463r7Dz2Cp7q;
	Tue,  3 Sep 2024 22:32:22 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id C3E7F140136;
	Tue,  3 Sep 2024 22:32:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 3 Sep
 2024 22:32:41 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <ardb@kernel.org>
CC: <lizetao1@huawei.com>, <linux-efi@vger.kernel.org>
Subject: [PATCH -next] efi: Remove redundant null pointer checks in efi_debugfs_init()
Date: Tue, 3 Sep 2024 22:41:15 +0800
Message-ID: <20240903144115.2005448-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Since the debugfs_create_dir() never returns a null pointer, checking
the return value for a null pointer is redundant, and using IS_ERR is
safe enough.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index fdf07dd6f459..70490bf2697b 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -349,7 +349,7 @@ static void __init efi_debugfs_init(void)
 	int i = 0;
 
 	efi_debugfs = debugfs_create_dir("efi", NULL);
-	if (IS_ERR_OR_NULL(efi_debugfs))
+	if (IS_ERR(efi_debugfs))
 		return;
 
 	for_each_efi_memory_desc(md) {
-- 
2.34.1


