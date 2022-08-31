Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C7A5A7359
	for <lists+linux-efi@lfdr.de>; Wed, 31 Aug 2022 03:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiHaB33 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 30 Aug 2022 21:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaB32 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 30 Aug 2022 21:29:28 -0400
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E018B0B30
        for <linux-efi@vger.kernel.org>; Tue, 30 Aug 2022 18:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-83-ed;
 t=1661908369; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=T80tVGeeu2pNX6r4SyDC31jnBdPqXosCrg4+diPypRI=;
 b=F8SV8l+9s3sa7Ue0csxKYcXV3g8Fb8K1d05osoDq3i+/IoLAGBMuZYHO6+YEyxV/FFEcQ
 Oi0/yKgo0ZzQ3RgAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-83-rsa; t=1661908369; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=T80tVGeeu2pNX6r4SyDC31jnBdPqXosCrg4+diPypRI=;
 b=elLk/ZmyTh70+A+BuevYD5PchLZUtZ+gbP3/gOCkAb0yOINaCOTZ7PqmnCh6bpuWMn1pe
 5YzUQ5WH2PmX7h92QksK1ytvsvJzqOuW9T3ilnqUzZIpBbGg6hljpj4/nBCaI0F/sZAHYbQ
 jKRijJmbs3z5ZitT3uSvhEInzIMzP3L/Zx2a3fK6zCLcmrJUw+hs+NRZNamj+HoS/ojQn8X
 Drah4VgZKB2T6Qhc9yGlqeekiW9DhCholNC5fPbXOTtG5UrWMMMA7rIKXeDccI6x0vgaQln
 prPRI8Vsuy+Ey/vIAel/tpAUlOmYZufkermyUIHU/uVz2MPdlbR78atfWwrw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 22323160525;
        Tue, 30 Aug 2022 18:12:49 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 0B94C20407; Tue, 30 Aug 2022 18:12:49 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Michael Roth <michael.roth@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH 4/4] Remove unused variable ret in __efi_get_rsdp_addr()
Date:   Tue, 30 Aug 2022 18:12:48 -0700
Message-Id: <20220831011248.28632-5-michel@lespinasse.org>
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

Fixes: dee602dd5d14 (x86/compressed/acpi: Move EFI vendor table lookup to helper)
Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/x86/boot/compressed/acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 83a7977ef56f..21febd9f21ab 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -24,7 +24,6 @@ __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
 {
 #ifdef CONFIG_EFI
 	unsigned long rsdp_addr;
-	int ret;
 
 	/*
 	 * Search EFI system tables for RSDP. Preferred is ACPI_20_TABLE_GUID to
-- 
2.20.1

