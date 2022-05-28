Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3322D5369E0
	for <lists+linux-efi@lfdr.de>; Sat, 28 May 2022 03:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiE1Bl5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 May 2022 21:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiE1Bl4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 May 2022 21:41:56 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1987A13C1DE;
        Fri, 27 May 2022 18:41:55 -0700 (PDT)
Received: from LT2ubnt.fritz.box (ip-062-143-094-109.um16.pools.vodafone-ip.de [62.143.94.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3544D3FBFA;
        Sat, 28 May 2022 01:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653702113;
        bh=xKW+dUOE1K1RtN/DU5IwGfeJQMsUXHQODp6XmKq+3mY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=cRG8KJWu4uAZXkaZPT88oYE3h06bFTKhYdj267Mv3JKxusu/up8L8tQkRcFxhkXso
         /R4EL8n7ine4jmI7AztkSQAYA75UjbEvhAxeJSWuLXEUMKrBgVcEPvv2IJmnB21d+0
         2yc+P4ukts1x+wZXK+xrI4vQ6j8RavH6fXNLmSWZ9PkiZrFAaqvN7FAKk/0Rc30QjS
         x77uAad5aHGimmGOQcq/gc7j8A2I4whLWUcS/M0pmh1PjVuOSGYDZwBM8KwjXQ0aig
         HZecP8w6I7Zp2609twGdpSnPdlw98QRkuE19awCBJYaZaVJpVvZcxcTY5IoGWXFBCF
         ypu9p2TlVFIsA==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] riscv: read-only pages should not be writable
Date:   Sat, 28 May 2022 03:41:32 +0200
Message-Id: <20220528014132.91052-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If EFI pages are marked as read-only,
we should remove the _PAGE_WRITE flag.

The current code overwrites an unused value.

Fixes: b91540d52a08b ("RISC-V: Add EFI runtime services")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/kernel/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/efi.c b/arch/riscv/kernel/efi.c
index 024159298231..1aa540350abd 100644
--- a/arch/riscv/kernel/efi.c
+++ b/arch/riscv/kernel/efi.c
@@ -65,7 +65,7 @@ static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
 
 	if (md->attribute & EFI_MEMORY_RO) {
 		val = pte_val(pte) & ~_PAGE_WRITE;
-		val = pte_val(pte) | _PAGE_READ;
+		val |= _PAGE_READ;
 		pte = __pte(val);
 	}
 	if (md->attribute & EFI_MEMORY_XP) {
-- 
2.36.1

