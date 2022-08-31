Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9BD5A7380
	for <lists+linux-efi@lfdr.de>; Wed, 31 Aug 2022 03:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiHaBtc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 30 Aug 2022 21:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiHaBtb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 30 Aug 2022 21:49:31 -0400
X-Greylist: delayed 1201 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 Aug 2022 18:49:28 PDT
Received: from server.lespinasse.org (server.lespinasse.org [63.205.204.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBACAD9A3;
        Tue, 30 Aug 2022 18:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-83-ed;
 t=1661908369; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=dQJIwUvhGNjX092Phs0xdl9MfbbYPTx9oCj6UYxXh5g=;
 b=4HicKEvVRL7E+lmDSjVEcLsiD1QOTMNuQstm3DwBEfZeieP4K7ucrTb5EXfjM3P05/pSW
 dWd55+sR2b1smcpDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-83-rsa; t=1661908369; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=dQJIwUvhGNjX092Phs0xdl9MfbbYPTx9oCj6UYxXh5g=;
 b=mVEewu2UAPsTPNp59LLDa0lr52qDw0DsqGkGsj3OFX6udzMDK2TNzsfuJIfrkDfXdr6IQ
 sBcg1xVdT6npNX0UeozgG5vVqcNwi9xbl0+Kb6ZPIQGh8Z/ozDBsxeT8/ZZFAPv4Umt7Dc1
 +9czjjOk6/bb9PMPNXGUc4DiMkQmAX6HK93HBLIN7VtZ+VbcOFKfv7vQzbEPZLDqHmssT+V
 JldWMNaGfqvRgt5v02SfodN3yLqPFG3HYpiRP63Yap9ORVUMdxWBkBjvRA3iPs5XyFtCZXX
 keLheD2piRC658c8hdCHwQBOngM7V6cQQZKlyFM6YhK6PRWy8+UrQwIh6ohw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 1A824160522;
        Tue, 30 Aug 2022 18:12:49 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 08997203E1; Tue, 30 Aug 2022 18:12:49 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Michael Roth <michael.roth@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH 3/4] Remove unused variable ret in efi_get_conf_table()
Date:   Tue, 30 Aug 2022 18:12:47 -0700
Message-Id: <20220831011248.28632-4-michel@lespinasse.org>
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

Fixes: 61c14ceda840 (x86/compressed/acpi: Move EFI config table lookup to helper)
Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/x86/boot/compressed/efi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index c42ee7874eb9..6ffd22710ed2 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -130,7 +130,6 @@ int efi_get_conf_table(struct boot_params *bp, unsigned long *cfg_tbl_pa,
 {
 	unsigned long sys_tbl_pa;
 	enum efi_type et;
-	int ret;
 
 	if (!cfg_tbl_pa || !cfg_tbl_len)
 		return -EINVAL;
-- 
2.20.1

