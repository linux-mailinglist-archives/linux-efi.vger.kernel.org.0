Return-Path: <linux-efi+bounces-4560-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3336B27E16
	for <lists+linux-efi@lfdr.de>; Fri, 15 Aug 2025 12:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3192A03E74
	for <lists+linux-efi@lfdr.de>; Fri, 15 Aug 2025 10:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACC32FD7C4;
	Fri, 15 Aug 2025 10:12:12 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EC272627;
	Fri, 15 Aug 2025 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252732; cv=none; b=ahqUms5/rdjLNbWlbV/nVVTa+tswyM+maMcY5koYUfbei26qqGvUUDkHG98MOuWcB0EdPZTqs3Es6RAkk3I0IwfMw68OtY1V2t47hdlorp2FexGNHuWQLKK2TSzAkX+yZSeTQb4RaXcb0B54h8WDRz8KWJhKi3xywa9rvtFZamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252732; c=relaxed/simple;
	bh=RUKzeToynFXaZuihyCw9I2ar0pbrHz+dGDuOu5uRoD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eRuNWAf0wuh9QyFHnpgACEQCqSvOZxH3u8lxdJI5re7b0qfEiEva2mOW+h7d9Dco1rFbR7xmplcRW8ideDFwOkROPMvXUzF6w6OALfq+GUJIqiL2S27U6NdjE0VjGGqyLJGOR4ko3qPq754ag026AKAjLucO82IrtqOWrZNyLCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c3Hw80LHSzYQvFH;
	Fri, 15 Aug 2025 18:12:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A39381A158D;
	Fri, 15 Aug 2025 18:12:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxD0B59otc8IDw--.55291S4;
	Fri, 15 Aug 2025 18:12:06 +0800 (CST)
From: linan666@huaweicloud.com
To: jk@ozlabs.org,
	ardb@kernel.org
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	wanghai38@huawei.com,
	yangerkun@huawei.com,
	yi.zhang@huawei.com
Subject: [PATCH] efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare
Date: Fri, 15 Aug 2025 18:04:16 +0800
Message-Id: <20250815100416.622236-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjxD0B59otc8IDw--.55291S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr17XrW8Aw43GFWxWw4Uurg_yoW8WFyDp3
	s5CFW8uFWDWw1qv39YqF1kAa4j9anaqwsrWFs7trW2qF92qw1UWrWvgF1I9ryUurWrJFyD
	Ga4DG3Z8ta1FyaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbfWrJUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

Observed in kernel 6.6 (likely present on master as well):

  Call trace:
   dump_backtrace+0xe4/0x1c0
   show_stack+0x34/0x50
   dump_stack_lvl+0x70/0x100
   print_address_description.constprop.0+0x84/0x3c0
   print_report+0xb0/0x280
   kasan_report+0x7c/0xc8
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
   invoke_syscall+0x78/0x1c8
   el0_svc_common.constprop.0+0x14c/0x188
   do_el0_svc+0x3c/0x58
   el0_svc+0x44/0x1b8
   el0t_64_sync_handler+0x100/0x130
   el0t_64_sync+0x3c8/0x3d0

Crash analysis shows dentry->d_name.len == 35, which makes 'guid'
subtraction negative and triggers the Call trace. Temporarily mitigate
the issue by checking len.

Signed-off-by: Li Nan <linan122@huawei.com>
---
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


