Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCB076CEE7
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjHBNhO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 09:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjHBNhN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 09:37:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562FD1BFD;
        Wed,  2 Aug 2023 06:37:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E37A0619A0;
        Wed,  2 Aug 2023 13:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1794AC433C7;
        Wed,  2 Aug 2023 13:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690983431;
        bh=G9zmLiFSpecw8ctEO3ge2OHHsPe2CBUCD36nteV4xlE=;
        h=From:To:Cc:Subject:Date:From;
        b=ldNed6p9PZXcShVntQ9qGUYOGnYzh+o+lNION7A/J72hDBB0p8scBj6omuez8vk4v
         ZrQzaBaGLNB7VPOSE1kheenUne2WdErK5o3xa2SyxNlKhD1sHCQwcnDWnkSGcx1QNI
         cqw1PMnTkAMfFE23ILr6m1SdJEASKYGi9C8frVeh+AANq/h6fP66hBFV4HuKyur6E2
         JWjX+iHzvmtsBHrGA3FzM1pejYOH1xX5UOI/NNK2oovt3OoG6qkJ+VLKEvLPHhZd16
         eMKkuQ0rd2GcBNZ/qIVjLp/Wt+BihDn7bDaPbQylBhnmTO+4XO3b1PJqWkghaUys9P
         DHFXN5QNR++Fg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] efi/x86: Ensure that EFI_RUNTIME_MAP is enabled for kexec
Date:   Wed,  2 Aug 2023 15:37:04 +0200
Message-Id: <20230802133704.2146580-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=ardb@kernel.org; h=from:subject; bh=G9zmLiFSpecw8ctEO3ge2OHHsPe2CBUCD36nteV4xlE=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVUDEPVBeFlV7V66tJy+/k3mk9bvWCjYPKeG/9NZKfHy 8uUP1XrKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOp5GJk2Gm1ffYB9iyP30n7 pqS3ty87rlqu6T1pr/NeE5/QX7NYXjIyXO/XXji1+H7drbKDJYrv/YvKvKduT3JOW8n499mGa/c UeAE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/x86/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7422db4097701c96..616498cdc91e8f01 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2027,10 +2027,14 @@ config EFI_MAX_FAKE_MEM
 	  Ranges can be set up to this value using comma-separated list.
 	  The default value is 8.
 
+config EFI_NEED_RUNTIME_MAP
+	def_bool y
+	depends on EFI && KEXEC_CORE
+	select EFI_RUNTIME_MAP
+
 config EFI_RUNTIME_MAP
 	bool "Export EFI runtime maps to sysfs" if EXPERT
 	depends on EFI
-	default KEXEC_CORE
 	help
 	  Export EFI runtime memory regions to /sys/firmware/efi/runtime-map.
 	  That memory map is required by the 2nd kernel to set up EFI virtual
-- 
2.39.2

