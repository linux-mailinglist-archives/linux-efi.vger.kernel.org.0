Return-Path: <linux-efi+bounces-4570-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F92B2BCE7
	for <lists+linux-efi@lfdr.de>; Tue, 19 Aug 2025 11:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601C216745F
	for <lists+linux-efi@lfdr.de>; Tue, 19 Aug 2025 09:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DB61A08BC;
	Tue, 19 Aug 2025 09:16:12 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A211DED49;
	Tue, 19 Aug 2025 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594972; cv=none; b=NmuahH/UClQOA4yqWxK2UKiubr/uMrUBQcSEQJCRFWcTrlLE2KqFC8re9qN+8rAD+5B8LqiTia3i5yO6hv9/5jJrVrOrAOQqc5g42roTy4UN91PX+edPj7tlhpsR3T+iN9gHve3CirIZsKuUlIlTY2ZEWRJQKHDkAIcizkKNhk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594972; c=relaxed/simple;
	bh=FFqTG0zQin3KQrCUcziYyo9SGSp+Ohq8o/OYYQ/4d0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HwxYxVsoLTpuTBaAm++wngiLfInyns6eEWuXb57zsN3nTbvtrDj3wRloHnzNG/XsYJEe02fcetdp/d69NhaFEYvyHNI4mSTx6dicT4LirjXP1Im9wo4M2tXiiA+iYvi19rOmXdPNUmPgF/OInYO5bsmF53NwTt/0Tn+LpNzzbXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c5kTg67qDzKHMwW;
	Tue, 19 Aug 2025 17:16:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 480221A0C33;
	Tue, 19 Aug 2025 17:16:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBn4hLVQKRoW1jLEA--.62787S4;
	Tue, 19 Aug 2025 17:16:07 +0800 (CST)
From: linan666@huaweicloud.com
To: jk@ozlabs.org,
	ardb@kernel.org,
	matt.fleming@intel.com
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yangerkun@huawei.com,
	yi.zhang@huawei.com
Subject: [PATCH v2] efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare
Date: Tue, 19 Aug 2025 17:08:02 +0800
Message-Id: <20250819090802.2258766-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBn4hLVQKRoW1jLEA--.62787S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1rWF18Wr1rGFyrXw47urg_yoW8AF48p3
	4rGF1IgFZ5Ww1jy3yrZFn7Ja4jgas2qr47XFsFgryaqFyxXr18Wr9rKr1jgFyj9r1rXFyD
	Wa1DKw48Ka13AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	WUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5g4SUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

Observed on kernel 6.6 (present on master as well):

  BUG: KASAN: slab-out-of-bounds in memcmp+0x98/0xd0
  Call trace:
   kasan_check_range+0xe8/0x190
   __asan_loadN+0x1c/0x28
   memcmp+0x98/0xd0
   efivarfs_d_compare+0x68/0xd8
   __d_lookup_rcu_op_compare+0x178/0x218
   __d_lookup_rcu+0x1f8/0x228
   d_alloc_parallel+0x150/0x648
   lookup_open.isra.0+0x5f0/0x8d0
   open_last_lookups+0x264/0x828
   path_openat+0x130/0x3f8
   do_filp_open+0x114/0x248
   do_sys_openat2+0x340/0x3c0
   __arm64_sys_openat+0x120/0x1a0

If dentry->d_name.len < EFI_VARIABLE_GUID_LEN , 'guid' can become
negative, leadings to oob. The issue can be triggered as below:

  T1			T2
  lookup_open
   ->lookup
    simple_lookup
     d_add
     // invalid dentry is added to hash list

			lookup_open
			 d_alloc_parallel
			  __d_lookup_rcu
			   __d_lookup_rcu_op_compare
			    hlist_bl_for_each_entry_rcu
			    // invalid dentry can be retrieved
			     ->d_compare
			      efivarfs_d_compare

Fix it by checking len before cmp.

Fixes: da27a24383b2 ("efivarfs: guid part of filenames are case-insensitive")
Signed-off-by: Li Nan <linan122@huawei.com>
Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
---
v2: optimize commit message

 fs/efivarfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 23ff4e873651..c30d758e303a 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -152,7 +152,7 @@ static int efivarfs_d_compare(const struct dentry *dentry,
 {
 	int guid = len - EFI_VARIABLE_GUID_LEN;
 
-	if (name->len != len)
+	if (name->len != len || len <= EFI_VARIABLE_GUID_LEN)
 		return 1;
 
 	/* Case-sensitive compare for the variable name */
-- 
2.39.2


