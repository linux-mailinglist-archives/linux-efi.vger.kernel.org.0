Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F226ED2F7
	for <lists+linux-efi@lfdr.de>; Mon, 24 Apr 2023 18:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjDXQ6E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Apr 2023 12:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjDXQ57 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Apr 2023 12:57:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A741AA26B;
        Mon, 24 Apr 2023 09:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FF876272F;
        Mon, 24 Apr 2023 16:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD3AC4339C;
        Mon, 24 Apr 2023 16:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682355468;
        bh=r/rF9eDTXhHmlrkb2lsJlgyLhYQxh0Hseo352Wqu2+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=my7xhwSkW6ZiIiIYMlrS49valDwR9XPU+7UEgHKhK/8yi+F/VZFrxbvy0m21Rc7sm
         UzcBnn2OUdXmfJ4H99y3qn4ZID7nbaIaGnjKLJ9PYECIMhsY2BSs9KbddcvGh5JxMC
         GHAyrpXVnRYUoSY0seRh/wCOra6PWFocfbMPEAw/SnQUWgCCWnUJRwyiZ5AinvrnIG
         xmzxf2LP13OI8ygnrZxWcnlnVz+dM9tzTPtHU7GnLy9+mDa5T4LYlOeFTG6Dh/Q+tZ
         4Xq00RobvlP/RvKmVbo0rzqajnwNDc8cZxE4VUrVylliUVqdlxfrlroT37OZ2BRHuz
         Gp6YqaR2V4y6w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/6] x86: efistub: Obtain ACPI RSDP address while running in the stub
Date:   Mon, 24 Apr 2023 18:57:23 +0200
Message-Id: <20230424165726.2245548-4-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424165726.2245548-1-ardb@kernel.org>
References: <20230424165726.2245548-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; i=ardb@kernel.org; h=from:subject; bh=r/rF9eDTXhHmlrkb2lsJlgyLhYQxh0Hseo352Wqu2+Y=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcVty8dvM+dItfbu4b80N7Sy/OvTQLfZIn/5XKZK+fhsE I4Pj4/pKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOZ3sfwv0DDddqvaRv+T7Rn XfjU2OCBZjDH2ZjnU9k+VFuctRSPVGP4p2tvZvfwamN53fRvFcl9th9lt1meX1z6okS+zzSTn/k LEwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

One of the actions performed by the decompressor is populating the RSDP
address field in the boot_params struct, and when doing EFI boot, EFI
configuration tables are the preferred source for this information.

In preparation for removing the decompressor code from the EFI stub boot
path, set this field from the EFI stub code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index a0bfd31358ba97b1..e136c94037dda8d3 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -787,6 +787,11 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 		efi_dxe_table = NULL;
 	}
 
+	if (!boot_params->acpi_rsdp_addr)
+		boot_params->acpi_rsdp_addr = (unsigned long)
+				(get_efi_config_table(ACPI_20_TABLE_GUID) ?:
+				 get_efi_config_table(ACPI_TABLE_GUID));
+
 	/*
 	 * If the kernel isn't already loaded at a suitable address,
 	 * relocate it.
-- 
2.39.2

