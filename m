Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA14358FE92
	for <lists+linux-efi@lfdr.de>; Thu, 11 Aug 2022 16:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiHKOwH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Aug 2022 10:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbiHKOwH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 11 Aug 2022 10:52:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C2DE005
        for <linux-efi@vger.kernel.org>; Thu, 11 Aug 2022 07:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22114615B5
        for <linux-efi@vger.kernel.org>; Thu, 11 Aug 2022 14:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7A8C433D7;
        Thu, 11 Aug 2022 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660229524;
        bh=ZeXm80HFuVEMhgIFHbVOMl4kIdO+nl/dXmzVPtdURQg=;
        h=From:To:Cc:Subject:Date:From;
        b=RoPCb1JcFC9mmdBODm2ot5kiTbmR2Ql98rcc7VcY3CqUgvFCOQv72raNz65ntGiRk
         zn/7kGI0hTTN2xeqbjFhAvWsGf2ImhPdxU+Ja6sO3wYioBRk2tYQC+rl2NloiCS7fZ
         716+//XWbqTBi8Gu6InMZB7XpqBK7f7hL27PIzVdh4eF0RpRIukgA7urxsYcSUJi3I
         w/W0Wjs4oLtk8vySB5NGOCWTl3CbZN6rsrAlpcHsZgjYvP+Tnb1N22csPaWfdtJlz2
         BI5KFZ9ZmScklbM3A3Xtxrg4c8QntJ1AYl0T8S7M6GDeeCv3nVq8HX+CWUkik4v8Kf
         Uaou5ONdqocng==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     grub-devel@gnu.org
Cc:     daniel.kiper@oracle.com, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] arm64/linux: Remove magic number header field check
Date:   Thu, 11 Aug 2022 16:51:57 +0200
Message-Id: <20220811145157.3237840-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The 'ARM\x64' magic number in the file header identifies an image as one
that implements the bare metal boot protocol, allowing the loader to
simply move the file to a suitably aligned address in memory, with
sufficient headroom for the trailing .bss segment (the required memory
size is described in the header as well).

Note of this matters for GRUB, as it only supports EFI boot. EFI does
not care about this magic number, and nor should GRUB: this prevents us
from booting other PE linux images, such as the generic EFI zboot
decompressor, which is a pure PE/COFF image, and does not implement the
bare metal boot protocol.

So drop the magic number check.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 grub-core/loader/arm64/linux.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
index ef3e9f9444ca..4c92e48ac91c 100644
--- a/grub-core/loader/arm64/linux.c
+++ b/grub-core/loader/arm64/linux.c
@@ -51,9 +51,6 @@ static grub_addr_t initrd_end;
 grub_err_t
 grub_arch_efi_linux_check_image (struct linux_arch_kernel_header * lh)
 {
-  if (lh->magic != GRUB_LINUX_ARMXX_MAGIC_SIGNATURE)
-    return grub_error(GRUB_ERR_BAD_OS, "invalid magic number");
-
   if ((lh->code0 & 0xffff) != GRUB_PE32_MAGIC)
     return grub_error (GRUB_ERR_NOT_IMPLEMENTED_YET,
 		       N_("plain image kernel not supported - rebuild with CONFIG_(U)EFI_STUB enabled"));
-- 
2.35.1

