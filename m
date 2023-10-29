Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FDF7DAF43
	for <lists+linux-efi@lfdr.de>; Sun, 29 Oct 2023 23:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjJ2W6O (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 29 Oct 2023 18:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjJ2W6K (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 29 Oct 2023 18:58:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93981FD4;
        Sun, 29 Oct 2023 15:55:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41ACCC433CC;
        Sun, 29 Oct 2023 22:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620136;
        bh=wzcO2YZyhAPiGj+xh3G1vn+3GTn7JHd86F6iAmmOXGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulydMYDtryU+Tn0q7bwoa1sVJx4azvOVeVDjrfwdKH88YiMqyhmxNeqDFEtoM/w3p
         9dhCnSPvPXTdCkfausbUGt9ruj+P0lV4K7j9wpKJYf2wq2veno7UQRwEisJSsuSb0B
         954ct7u+OSp2ssdD+kgYCJ4w0xWTE9HJQ0bJFNWJKX9XLKkKZX8xOHBXmVEcjV/qC+
         kDfnRcZBQdtBvEywie0ZwngaOQF02+A8z5RjKtLEuHbgPiAEzjsbbmsBX7b3cKjZ3Z
         +b+K+483Zg+oXGFEhPydgjx6DQXjmg9G1SDqeBm4VWXKUucUlTFCBDZOI+xQ5tgMbI
         mEfFTfxMTGYQA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nikolay Borisov <nik.borisov@suse.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sasha Levin <sashal@kernel.org>, bp@alien8.de,
        kirill.shutemov@linux.intel.com, bp@suse.de,
        thomas.lendacky@amd.com, mikel@mikelr.com, dionnaglaze@google.com,
        linux-efi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 26/52] x86/efistub: Don't try to print after ExitBootService()
Date:   Sun, 29 Oct 2023 18:53:13 -0400
Message-ID: <20231029225441.789781-26-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Nikolay Borisov <nik.borisov@suse.com>

[ Upstream commit ff07186b4d774ac22a5345d30763045af4569416 ]

setup_e820() is executed after UEFI's ExitBootService has been called.
This causes the firmware to throw an exception because the Console IO
protocol is supposed to work only during boot service environment. As
per UEFI 2.9, section 12.1:

 "This protocol is used to handle input and output of text-based
 information intended for the system user during the operation of code
 in the boot services environment."

So drop the diagnostic warning from this function. We might add back a
warning that is issued later when initializing the kernel itself.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 146477da2b98c..a5a856a7639e1 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -648,11 +648,8 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
 			break;
 
 		case EFI_UNACCEPTED_MEMORY:
-			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
-				efi_warn_once(
-"The system has unaccepted memory,  but kernel does not support it\nConsider enabling CONFIG_UNACCEPTED_MEMORY\n");
+			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
 				continue;
-			}
 			e820_type = E820_TYPE_RAM;
 			process_unaccepted_memory(d->phys_addr,
 						  d->phys_addr + PAGE_SIZE * d->num_pages);
-- 
2.42.0

