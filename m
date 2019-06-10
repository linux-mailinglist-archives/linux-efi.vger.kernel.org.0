Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8D83B7FD
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2019 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390128AbfFJPFk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jun 2019 11:05:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37251 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389368AbfFJPFj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jun 2019 11:05:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id 22so8517699wmg.2
        for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2019 08:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RkQ4CjPEDkGzkvOTsVe8hBovG/baYmxmmxTNcRwbQ6A=;
        b=cgDk7wTG4n038EhFmcAwzmy2sh3c3WnR4WUxrgOgCpgBWcRWcud2NzuopspUI5VY8y
         asGjnzPx86XbuC8jCJkrFmmlKwswDTLD365JhPYxCfBTpEv1B7izqOXPOuBeyR0OSp+E
         MpzXaxyZ36enUF41A16Z+IWIv5j0xfx0IzzIGjHTt4cNWQOvckBLLdOKwy4YJFsTfxVC
         Ko0ESWZYNyJjQ23Kjx/Rj+ii+91I2T//H9TLKgie9coGA9cGfZFiEehcSSiAEYxwJJvX
         /Bj2u6DWb8lpa6lJpqOMqp3XFwqmxkhgzVPV2yWbbeF/XJ2fbG44Mb02TBUJxx4SIe4i
         3wKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RkQ4CjPEDkGzkvOTsVe8hBovG/baYmxmmxTNcRwbQ6A=;
        b=R4B/cMcaF798/ZmFto/ymtB+xDwmGbo4fjSUZyMK3/IhNZJRKc3Jsv84ERa2qfaNa4
         ACwmbk3vcUkcJ5T3wskNQi1FQz5JbjbtEErdZXekaVL6k1BBEeDsfzYauROdnntBrUyh
         up2rfXb1/F7mrhjRp+dtuM7LRXGp7c5MMZd91oVDlGfpreHoQ2hWMtQGOM5xEtSpxBlO
         JtUtBGeO9FKCl4BgWeiLCKhN3ODYwqJMHGbcuKd6ccZbAulpYfgEKM9JMzi5sG171PuN
         kdj/MQUrsI1svDOkMqpr4S5x3M86oDwOnpoiRUCPrWdjTqSBsv63WNHYwxQ+GszDQhCG
         yqTw==
X-Gm-Message-State: APjAAAUrhrjghIQ/A3ntGMSoBBEZ5qTNhajV7Pgnm03cuYQRshexst10
        rOqINktvALuU+3qTl2ksWKBmPS2ai9D00A==
X-Google-Smtp-Source: APXvYqxJg943SALFFymt1y12G7kifsXfVhOXdBnuXAcUNu5l9BSYevC2+qtkoLgUaxAp73ncfkfUeg==
X-Received: by 2002:a1c:448b:: with SMTP id r133mr14454728wma.114.1560179136378;
        Mon, 10 Jun 2019 08:05:36 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:fc6b:c1c2:30ed:eca3])
        by smtp.gmail.com with ESMTPSA id e7sm8633054wmd.0.2019.06.10.08.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 08:05:35 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        bhsharma@redhat.com, ray.jui@broadcom.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jonathan Richardson <jonathan.richardson@broadcom.com>
Subject: [PATCH] efi/memreserve: deal with memreserve entries in unmapped memory
Date:   Mon, 10 Jun 2019 17:05:30 +0200
Message-Id: <20190610150530.10306-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ensure that the EFI memreserve entries can be accessed, even if they
are located in memory that the kernel (e.g., a crashkernel) omits from
the linear map.

Reported-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/efi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 16b2137d117c..4b7cf7bc0ded 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -1009,14 +1009,16 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 
 	/* first try to find a slot in an existing linked list entry */
 	for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
-		rsv = __va(prsv);
+		rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
 		index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
 		if (index < rsv->size) {
 			rsv->entry[index].base = addr;
 			rsv->entry[index].size = size;
 
+			memunmap(rsv);
 			return 0;
 		}
+		memunmap(rsv);
 	}
 
 	/* no slot found - allocate a new linked list entry */
@@ -1024,7 +1026,13 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	if (!rsv)
 		return -ENOMEM;
 
-	rsv->size = EFI_MEMRESERVE_COUNT(PAGE_SIZE);
+	/*
+	 * The memremap() call above assumes that a linux_efi_memreserve entry
+	 * never crosses a page boundary, so let's ensure that this remains true
+	 * even when kexec'ing a 4k pages kernel from a >4k pages kernel, by
+	 * using SZ_4K explicitly in the size calculation below.
+	 */
+	rsv->size = EFI_MEMRESERVE_COUNT(SZ_4K);
 	atomic_set(&rsv->count, 1);
 	rsv->entry[0].base = addr;
 	rsv->entry[0].size = size;
-- 
2.20.1

