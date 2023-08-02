Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05AB76D1C5
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 17:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjHBPYB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 11:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbjHBPXB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 11:23:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5E43C3F;
        Wed,  2 Aug 2023 08:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E050619F7;
        Wed,  2 Aug 2023 15:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0CCC433C9;
        Wed,  2 Aug 2023 15:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690989506;
        bh=tRQPMDxU+F3jAUXl9q55Kx+aMQJoipoNjURVaaxY4UM=;
        h=From:To:Cc:Subject:Date:From;
        b=gXRkQn0BN6bkcNs7HUTgvw8CBgYUu1WUoq4n2EXGZPCNUeKZbqtQFQbRBnsuM8pGQ
         pxtBrLUPZwV0zNRnbwPpkuxq62aT75dBr4a6uKJHpFuCLLyMUOSApkQgHkkbYQJ+9Y
         GdEgdzPKWmniUTo1RUf9s12pjM/IzSBeBALuw7sSPEGsnNLabFzOpAOyWhwMW/L+a3
         KCCtlhWZfRarqQeJOIlTUrsRcFrLpDe2lyJDoNZ7LQSnpvBWnp8aa4SWuQ8/eieCmV
         xuUfXmNto8uY3OK/YO9yQY4zjaF3ENEiQhGg6jR7y5IRS/MSH/RT/UY+fmMQ5PnXv0
         5wX40+pZDv0bA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v2] efi/x86: Ensure that EFI_RUNTIME_MAP is enabled for kexec
Date:   Wed,  2 Aug 2023 17:17:04 +0200
Message-Id: <20230802151704.2147028-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659; i=ardb@kernel.org; h=from:subject; bh=tRQPMDxU+F3jAUXl9q55Kx+aMQJoipoNjURVaaxY4UM=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVUcf66rqmbvzCaX1km8nPlqUmKu2+vSrgr7bd1lXN5S UjkdTuBjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCR/FRGhoX9a9KvhaV8qnt2 Ijx/XvddG4tJx7tzlERirEXD1Tp2/GD4HzF575vLVhxep3lUVv43PlBXW9D1755B4pYu317lT80 vuAE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

CONFIG_EFI_RUNTIME_MAP needs to be enabled in order for kexec to be able
to provide the required information about the EFI runtime mappings to
the incoming kernel, regardless of whether kexec_load() or
kexec_file_load() is being used. Without this information, kexec boot in
EFI mode is not possible.

The CONFIG_EFI_RUNTIME_MAP option is currently directly configurable if
CONFIG_EXPERT is enabled, so that it can be turned on for debugging
purposes even if KEXEC is. However, the upshot of this is that it can
also be disabled even when it shouldn't.

So tweak the Kconfig declarations to avoid this situation.

Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v2: use simpler conditional 'select EFI_RUNTIME_MAP' in CONFIG_EFI

 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7422db4097701c96..bfbf53b49fee95a3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1955,6 +1955,7 @@ config EFI
 	select UCS2_STRING
 	select EFI_RUNTIME_WRAPPERS
 	select ARCH_USE_MEMREMAP_PROT
+	select EFI_RUNTIME_MAP if KEXEC_CORE
 	help
 	  This enables the kernel to use EFI runtime services that are
 	  available (such as the EFI variable services).
@@ -2030,7 +2031,6 @@ config EFI_MAX_FAKE_MEM
 config EFI_RUNTIME_MAP
 	bool "Export EFI runtime maps to sysfs" if EXPERT
 	depends on EFI
-	default KEXEC_CORE
 	help
 	  Export EFI runtime memory regions to /sys/firmware/efi/runtime-map.
 	  That memory map is required by the 2nd kernel to set up EFI virtual
-- 
2.39.2

