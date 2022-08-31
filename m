Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA705A737D
	for <lists+linux-efi@lfdr.de>; Wed, 31 Aug 2022 03:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiHaBt3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 30 Aug 2022 21:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiHaBt3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 30 Aug 2022 21:49:29 -0400
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB57AD99D;
        Tue, 30 Aug 2022 18:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-83-ed;
 t=1661908369; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=zrzsrwj0wClSUEOaE4YZoUIMY9GUyLtBeJ8Vw6+yGMw=;
 b=ohR/KvlJlyYwfRM5s2fVY6j73vy4qK/uU7GQrrm+TqSZZf2/iDK93SzmjK58rEt61nnHB
 h00ZeMQnWEjNa6/Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-83-rsa; t=1661908369; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=zrzsrwj0wClSUEOaE4YZoUIMY9GUyLtBeJ8Vw6+yGMw=;
 b=KQz0v4yKIDowJncFA9xIIURPwTBxjDtQPSPNGsVMHZjPXys03iy6WyV+LxPLJtTq/Eo1Y
 7puiNKi06JPV8M/ZbIgaiw3mAfw/gtJvb1q9i1gvE7AYihCRUca56vJYL7zG0IX6+pAvZOS
 iKzEHgJZrGh9GQhHDy57kW+of6PKZe7ouxsIcv4qeJztVDFJTCkfQ4eLxP6qANIC1q0gBX7
 GFpO+lX2pK45UvlYV75R4Ms7p39y0d6NqWUzCkuU732OiC/34XBGtZYqA7t6qtdk1jxxdt/
 u7nZxWaxk9WcKXRX8AhWMefxSNM7KhSsPqugTECze8b1xfBGKeiuCmB9JJCw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 12B8516051F;
        Tue, 30 Aug 2022 18:12:49 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 0315320162; Tue, 30 Aug 2022 18:12:49 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Michael Roth <michael.roth@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH 1/4] Remove unused variable et in efi_get_system_table()
Date:   Tue, 30 Aug 2022 18:12:45 -0700
Message-Id: <20220831011248.28632-2-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220831011248.28632-1-michel@lespinasse.org>
References: <20220831011248.28632-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This avoids a build warning with CONFIG_EFI enabled.

Fixes: 7c4146e88855 (x86/compressed/acpi: Move EFI detection to helper)
Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/x86/boot/compressed/efi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index 6edd034b0b30..c42ee7874eb9 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -59,7 +59,6 @@ unsigned long efi_get_system_table(struct boot_params *bp)
 {
 	unsigned long sys_tbl_pa;
 	struct efi_info *ei;
-	enum efi_type et;
 
 	/* Get systab from boot params. */
 	ei = &bp->efi_info;
-- 
2.20.1

