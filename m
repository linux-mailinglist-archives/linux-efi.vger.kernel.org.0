Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0DF33377A
	for <lists+linux-efi@lfdr.de>; Wed, 10 Mar 2021 09:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCJIhr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Mar 2021 03:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhCJIh1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 10 Mar 2021 03:37:27 -0500
X-Greylist: delayed 345 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 Mar 2021 00:37:26 PST
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2618FC06174A
        for <linux-efi@vger.kernel.org>; Wed, 10 Mar 2021 00:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=nnm8ucZ5LQ
        cGGIu3zt2kPvo+8H0RoC4x7aUGkFHxz0A=; b=SlfJWZkF4adwpYWN9axoLqr2o3
        By0SRWHgTpZA1GUeJgzH0zOv9cvn2oQ9GD6qC3Ust9EVGqkep4eqlXSW0C5PiPLE
        Gc+VPuSGWxr1oou65pqpjg8GEYPS4ft4u8sosEoLMIHdWieme6Qjj/5TMSBsl1Vo
        PYvdJIbAI2FlUCOMo=
Received: from ubuntu.localdomain (unknown [114.214.224.243])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBXRGHpg0hgL7ECAA--.3682S4;
        Wed, 10 Mar 2021 16:31:37 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     ardb@kernel.org, jonathan.richardson@broadcom.com
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] firmware/efi: Fix a use after bug in efi_mem_reserve_persistent
Date:   Wed, 10 Mar 2021 00:31:27 -0800
Message-Id: <20210310083127.5784-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygBXRGHpg0hgL7ECAA--.3682S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr1UZr47GryUuF4xAF4rAFb_yoWkKFcEkr
        4rJ395K3yUKrW2vanFyrsa9asayayDXw109FnFya4fC39rAFy3ZrWkur1ktF47Cwn7Kryr
        CF48tw4Ykw1xGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0D
        UUUUU==
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In the for loop in efi_mem_reserve_persistent(), prsv = rsv->next
use the unmapped rsv. Use the unmapped pages will cause segment
fault.

Fixes: 18df7577adae6 ("efi/memreserve: deal with memreserve entries in unmapped memory")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/firmware/efi/efi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index df3f9bcab581..4b7ee3fa9224 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -927,7 +927,7 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	}
 
 	/* first try to find a slot in an existing linked list entry */
-	for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
+	for (prsv = efi_memreserve_root->next; prsv; ) {
 		rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
 		index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
 		if (index < rsv->size) {
@@ -937,6 +937,7 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 			memunmap(rsv);
 			return efi_mem_reserve_iomem(addr, size);
 		}
+		prsv = rsv->next;
 		memunmap(rsv);
 	}
 
-- 
2.25.1


