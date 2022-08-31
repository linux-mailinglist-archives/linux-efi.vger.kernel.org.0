Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9073B5A737E
	for <lists+linux-efi@lfdr.de>; Wed, 31 Aug 2022 03:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiHaBta (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 30 Aug 2022 21:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiHaBt3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 30 Aug 2022 21:49:29 -0400
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC39AD9AA;
        Tue, 30 Aug 2022 18:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-83-ed;
 t=1661908369; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=vSoUAaOGn/xCpVT7xIuPnYP+3A9mzSdbLNxp3aYE+kE=;
 b=Yvg7XcIa5aGW2rfkDbtI21478eJwnjnmzSWQbJFzY3XZAFMAjZmCP1VnfgceCg70fEHVh
 /RIh444getTgrpsDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-83-rsa; t=1661908369; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=vSoUAaOGn/xCpVT7xIuPnYP+3A9mzSdbLNxp3aYE+kE=;
 b=YQLAL6BEHSu2bC2CY0ZQtDRppemfZXBLUCYheqGu2jCqwcEs5sPIKVG7jwlcE/BC3PXLR
 t66N94V9KRPgFx+5EEctstB7f1AsZeNEUOMQpyIJmVQ+Lpr18lOt03GN22EOLnq2sePWTvZ
 GWv3mZPFXk3f3x7aEN5zbs+PlWX6oH9grcFHIEcHgYWimHOEhbPon76lslAuzoSpFYSlmbx
 PiedHm3nLUtJhzoVwC9xntCM+wJomc0gUlPYmtjNaYcZ8cQpmohiI2gEZgejFz94rH5pr1a
 HOUU5O207YdG4fB4L8zTAZiD+6ImJPrxHhsMmuD4u8FE+kAeb2cP7TXYv+Lg==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 21580160523;
        Tue, 30 Aug 2022 18:12:49 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 058E3201FC; Tue, 30 Aug 2022 18:12:49 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Michael Roth <michael.roth@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH 2/4] Remove unused variable nr_tables in efi_get_rsdp_addr()
Date:   Tue, 30 Aug 2022 18:12:46 -0700
Message-Id: <20220831011248.28632-3-michel@lespinasse.org>
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
 arch/x86/boot/compressed/acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 9caf89063e77..83a7977ef56f 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -52,7 +52,6 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	unsigned long cfg_tbl_pa = 0;
 	unsigned int cfg_tbl_len;
 	unsigned long systab_pa;
-	unsigned int nr_tables;
 	enum efi_type et;
 	int ret;
 
-- 
2.20.1

