Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2825C70B517
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 08:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjEVGdd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 02:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEVGdb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 02:33:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BF79B
        for <linux-efi@vger.kernel.org>; Sun, 21 May 2023 23:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7812160F57
        for <linux-efi@vger.kernel.org>; Mon, 22 May 2023 06:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06A5C433EF;
        Mon, 22 May 2023 06:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684737209;
        bh=eKvv483qoocwBvxQBu+5/toDJWg0QOalsJ2unskv7xM=;
        h=From:To:Cc:Subject:Date:From;
        b=gKnkfZDGXDyx2s3049W/IUxZ5TmEn9aPSZKTXdWbW4xy7WGCqYYj/6fitaeL82r2a
         ltRat/cDiIIBr26qZXOHzuxfQ9Yo/qw3HzEDzSPe39+NJ3vx5zb0ajga/5MKuogSJc
         Rn/oMPKG6/oh9VdD8bTEeI7ZSADOTOaOmGvhBXXjeVQtih8KwMS+QnLhPaI82jX9/t
         Nz/Eli+Sxvu3d/Z0Fw5js4hcY7pJke9UKK9q6RZntRgQ+qkgODYVkGCkrSFVZT9SYp
         2H31bplaPTv2mUp/ViMaVkcugxJw/RSaLfGaCaf8NNYejwtrGNC5ISVEVE0K9ScWBh
         KTb7231tZOq/A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     bagasdotme@gmail.com, ajb@elrepo.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH] efi/libstub: zboot: Avoid eager evaluation of objcopy flags
Date:   Mon, 22 May 2023 08:33:19 +0200
Message-Id: <20230522063319.501481-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=ardb@kernel.org; h=from:subject; bh=eKvv483qoocwBvxQBu+5/toDJWg0QOalsJ2unskv7xM=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISWbZ/2ESu+25z4RShLHuud05H3mcWPnNg6zO6qic+OZ5 XqTqT4dpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCK2Kgz/nd/fm5RxMfXiWiX5 /ZWh8usWvFBIDvD7xfDLS3SdV3h7IcNf+Y0V+l+XzTCbmXzmLf/2vuMvz6xgbLRa/uCWsbPOkyx nbgA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The Make variable containing the objcopy flags may be constructed from
the output of build tools operating on build artifacts, and these may
not exist when doing a make clean.

So avoid evaluating them eagerly, to prevent spurious build warnings.

Suggested-by: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile.zboot | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 89ef820f3b34483a..2c489627a8078945 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -32,7 +32,8 @@ zboot-size-len-$(CONFIG_KERNEL_GZIP)   := 0
 $(obj)/vmlinuz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,$(zboot-method-y))
 
-OBJCOPYFLAGS_vmlinuz.o := -I binary -O $(EFI_ZBOOT_BFD_TARGET) $(EFI_ZBOOT_OBJCOPY_FLAGS) \
+# avoid eager evaluation to prevent references to non-existent build artifacts
+OBJCOPYFLAGS_vmlinuz.o = -I binary -O $(EFI_ZBOOT_BFD_TARGET) $(EFI_ZBOOT_OBJCOPY_FLAGS) \
 			  --rename-section .data=.gzdata,load,alloc,readonly,contents
 $(obj)/vmlinuz.o: $(obj)/vmlinuz FORCE
 	$(call if_changed,objcopy)
-- 
2.39.2

