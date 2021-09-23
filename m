Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4694155A0
	for <lists+linux-efi@lfdr.de>; Thu, 23 Sep 2021 04:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbhIWCxT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Sep 2021 22:53:19 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16284 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbhIWCxS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Sep 2021 22:53:18 -0400
Received: from dggeme751-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HFKRS5ljlz8tJl;
        Thu, 23 Sep 2021 10:51:00 +0800 (CST)
Received: from huawei.com (10.67.174.96) by dggeme751-chm.china.huawei.com
 (10.3.19.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 23
 Sep 2021 10:51:45 +0800
From:   Zhang Jianhua <chris.zjh@huawei.com>
To:     <ardb@kernel.org>
CC:     <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] efi: Change down_interruptible() in virt_efi_reset_system() to down_trylock()
Date:   Thu, 23 Sep 2021 10:53:40 +0800
Message-ID: <20210923025340.1469836-1-chris.zjh@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.96]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme751-chm.china.huawei.com (10.3.19.97)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

While reboot the system by sysrq, the following bug will be occur.

BUG: sleeping function called from invalid context at kernel/locking/semaphore.c:90
in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 10052, name: rc.shutdown
CPU: 3 PID: 10052 Comm: rc.shutdown Tainted: G        W O      5.10.0 #1
Call trace:
 dump_backtrace+0x0/0x1c8
 show_stack+0x18/0x28
 dump_stack+0xd0/0x110
 ___might_sleep+0x14c/0x160
 __might_sleep+0x74/0x88
 down_interruptible+0x40/0x118
 virt_efi_reset_system+0x3c/0xd0
 efi_reboot+0xd4/0x11c
 machine_restart+0x60/0x9c
 emergency_restart+0x1c/0x2c
 sysrq_handle_reboot+0x1c/0x2c
 __handle_sysrq+0xd0/0x194
 write_sysrq_trigger+0xbc/0xe4
 proc_reg_write+0xd4/0xf0
 vfs_write+0xa8/0x148
 ksys_write+0x6c/0xd8
 __arm64_sys_write+0x18/0x28
 el0_svc_common.constprop.3+0xe4/0x16c
 do_el0_svc+0x1c/0x2c
 el0_svc+0x20/0x30
 el0_sync_handler+0x80/0x17c
 el0_sync+0x158/0x180

The reason for this problem is that irq has been disabled in
machine_restart() and then it calls down_interruptible() in
virt_efi_reset_system(), which would occur sleep in irq context,
it is dangerous! Commit 99409b935c9a("locking/semaphore: Add
might_sleep() to down_*() family") add might_sleep() in
down_interruptible(), so the bug info is here. down_trylock()
can solve this problem, cause there is no might_sleep.

--------

Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
---
 drivers/firmware/efi/runtime-wrappers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 1410beaef5c3..f3e54f6616f0 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -414,7 +414,7 @@ static void virt_efi_reset_system(int reset_type,
 				  unsigned long data_size,
 				  efi_char16_t *data)
 {
-	if (down_interruptible(&efi_runtime_lock)) {
+	if (down_trylock(&efi_runtime_lock)) {
 		pr_warn("failed to invoke the reset_system() runtime service:\n"
 			"could not get exclusive access to the firmware\n");
 		return;
-- 
2.31.0

