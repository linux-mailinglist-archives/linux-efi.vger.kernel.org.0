Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D2761ECF4
	for <lists+linux-efi@lfdr.de>; Mon,  7 Nov 2022 09:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiKGIbs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Nov 2022 03:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiKGIbp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Nov 2022 03:31:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3471140D0
        for <linux-efi@vger.kernel.org>; Mon,  7 Nov 2022 00:31:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E372B80E37
        for <linux-efi@vger.kernel.org>; Mon,  7 Nov 2022 08:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501F6C433B5;
        Mon,  7 Nov 2022 08:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667809902;
        bh=fNj3hhzSgXAraaKMvVH4kCzuimMQkgBp9WqcCIOrN1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VAInlatytNslbbHxGCfA7YFLVGvThlaFifBfyoHUD1iOFeveHl0eOqVKx87XWc7ck
         WzIynkZRKilIR22T6dnE2gHCX3p/B1NyDvWPCVyFssF3WHvC/kuRvw4T1+S3tQ910j
         d1r+KJ68yQtslolNDlaC8jt2DdGvdZeELwxb8HTdFi/PRlg8Vp+uiQXcER7ELB0oOd
         sCSnF7Klt3hlertspwXSujEWLnf87PZbkePIXreTUVpi5EQHZatSSwuKoVqPbUkjFc
         nlVPjd6FVLWsUF+1IOzciHWQAkI1S6yAvCoeAfuBdNbA31ynhCSk/sPX/NYxbF068Z
         jUxs6/k8UikCw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     dyoung@redhat.com, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 1/2] efi: runtime-maps: Clarify purpose and enable by default for kexec
Date:   Mon,  7 Nov 2022 09:31:33 +0100
Message-Id: <20221107083134.234918-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221107083134.234918-1-ardb@kernel.org>
References: <20221107083134.234918-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472; i=ardb@kernel.org; h=from:subject; bh=fNj3hhzSgXAraaKMvVH4kCzuimMQkgBp9WqcCIOrN1U=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjaMJjiyCi1BKBGblujiTnT6qR78OtIfgVjwQwHZbs j8p+gSmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2jCYwAKCRDDTyI5ktmPJESyC/ wJ2j0AzI/27A+b0iTwc31e/SFjWuXlMKFxH9Xa6sFvLmjQj5hOhc1ELS2Waayx2hIZJzSw6uSXMpsk 7alTFDUH7wO2g49JoOB1jT8QOFjZQ3WT/Gfp72LdUkK2NoMLzTdp8D/qV2X/8Khb301IwfTNFdCuzD k2gecD677U6oDP95S6/XPVpOBgJwIFDNLjph6fFVExmZVz9AluweT0CHvMXWl7uLiU6OsYhJ5e23Bs pT0V4IhL9jgRKJnAqx9eEfXbUrJ16CgnEqkgEyr3kmOV2C6/EAawZt/LGNO2VilX/Iej6ctrkjttQe UlMdjBpgJo1DhUGqN0pBmyA97BjLxaOViLRdiH+L4D5q0z4Z+2cE91tOUIOBvpfWdRVx1IoRNdqhDj 6g4qo/4nFxFWbz14/3pgKUSzU+1JrRoZbx6VlTgY2oQBE9t7CeWfxwMls5YJl9uohqZNtFv7dZLQsQ XNi+iP6hh+YUxFO7+OWUGItmPLR+8CBRDZy+uNx2kxJtg=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The current Kconfig logic for CONFIG_EFI_RUNTIME_MAPS does not convey
that without it, a kexec kernel is not able to boot in EFI mode at all.
So clarify this, and make the option only configurable via the menu
system if CONFIG_EXPERT is set.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 0d5201e4984189bc..552512f211a1f5e7 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -27,13 +27,13 @@ config EFI_VARS_PSTORE_DEFAULT_DISABLE
 	  using the efivars module's pstore_disable parameter.
 
 config EFI_RUNTIME_MAP
-	bool "Export efi runtime maps to sysfs"
-	depends on X86 && EFI && KEXEC_CORE
-	default y
+	bool "Export EFI runtime maps to sysfs" if EXPERT
+	depends on X86 && EFI
+	default KEXEC_CORE
 	help
-	  Export efi runtime memory maps to /sys/firmware/efi/runtime-map.
-	  That memory map is used for example by kexec to set up efi virtual
-	  mapping the 2nd kernel, but can also be used for debugging purposes.
+	  Export EFI runtime memory regions to /sys/firmware/efi/runtime-map.
+	  That memory map is required by the 2nd kernel to set up EFI virtual
+	  mappings after kexec, but can also be used for debugging purposes.
 
 	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
 
-- 
2.35.1

