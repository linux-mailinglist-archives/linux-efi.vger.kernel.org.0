Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC066FBA44
	for <lists+linux-efi@lfdr.de>; Wed, 13 Nov 2019 21:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfKMU5F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Nov 2019 15:57:05 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33233 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMU5F (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Nov 2019 15:57:05 -0500
Received: by mail-qt1-f194.google.com with SMTP id y39so4222989qty.0;
        Wed, 13 Nov 2019 12:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Kzg+cr/dhrJgO1piPaEyuVjoZZjMZrA15PeHen3UdLk=;
        b=X8mPkt1ZPwhWdTiBFBZIdxjOQBH5ouQPaS7ooGnrnQyOJcHvgWpdTF25RTTSiBmSeI
         VQvje+ClweqXmuLAJydKPlXEmovxHyfJKADlzpJ3yI0gAwdsePObf27dl9woJhiqZB3y
         bRHDKNqPCbESjmqDXRM4ovcBCqTAbHACj4SEfhMWaByeHMhRaLvHuh3QTRkUONdBxaML
         7Wui6zRaOXqphBoI61ggiZLixp3aQDxnIvAElonuD3SnOGcRzSR4qXq4Lcj+71K/ePLN
         TUm3EfONQYXAIidpZkdvwxE5TXx++6BWhvAfVVeq+sBp7xu68Amfu+y+9JBH8aU/V894
         i3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kzg+cr/dhrJgO1piPaEyuVjoZZjMZrA15PeHen3UdLk=;
        b=LFHePliU4pJ+OSkK6P6MTFVj+W4hyfTq1Wcmt/W5kmpnUsOZuU0IAN2Gp7X2kq/ZZq
         rujE44OHM2y0u/pSWdHeQ8YRBi0wAcNQwT6ewUCIvCOuhGd0/mOrVtyAzIvcInbY8BG9
         kDSGTQpOOU1R7gx/pWkU4cyYOy1VU3VcMnEajKp1WcO5YLD9CCArfyd18+SuDPb0dahT
         Q9ktWGzvJWVTeo26kGqZPz72U18LyQ2Cid7r2pX22tz1rQxXy88C6u1PwQqETY+HVhmE
         ol+F7qh2SvgIT/7RgcN/Ff+5yTe5F2bFGLPiHFd8aHfGu4ztKmvm8Fys/uxrP3iw6B7F
         Z6Dg==
X-Gm-Message-State: APjAAAUnUGM8puxZWDxHPtaqC4BQjt28dkYgdtEAdCbxHJwHgeTx2unJ
        NX/dtOcCRpJgN9gZOcHE6A==
X-Google-Smtp-Source: APXvYqyGN52CkIGaKAaKnnTB25qDeA9XucxkFiqpm2S8rSpOIT+/ghaPhsN08FgFQpf7dKL3NIbjdw==
X-Received: by 2002:aed:3282:: with SMTP id z2mr4932353qtd.221.1573678624271;
        Wed, 13 Nov 2019 12:57:04 -0800 (PST)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h12sm1500140qkh.123.2019.11.13.12.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 12:57:03 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH] efi: sanity check in case memermap() at efi_mem_reserve_persistent() returns NULL
Date:   Wed, 13 Nov 2019 15:56:30 -0500
Message-Id: <20191113205630.28434-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

System may crash as NULL pointer dereference in case memremap()
at efi_mem_reserve_persistent() returns NULL.

Add a sanity check to avoid that.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reported-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 drivers/firmware/efi/efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 07812d697..1d5ae7b95 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -1036,6 +1036,8 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	/* first try to find a slot in an existing linked list entry */
 	for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
 		rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
+		if (!rsv)
+			return -ENOMEM;
 		index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
 		if (index < rsv->size) {
 			rsv->entry[index].base = addr;
-- 
2.21.0

