Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C196B3FA4
	for <lists+linux-efi@lfdr.de>; Fri, 10 Mar 2023 13:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCJMuh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Mar 2023 07:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCJMuh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Mar 2023 07:50:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ED0F6009
        for <linux-efi@vger.kernel.org>; Fri, 10 Mar 2023 04:50:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15AC661564
        for <linux-efi@vger.kernel.org>; Fri, 10 Mar 2023 12:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C40CC4339B;
        Fri, 10 Mar 2023 12:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678452635;
        bh=Q2hOEReJ8XL6o95bm/6W8U9iYAmkT6SKYEkF7NI1eIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XoiL+vJBoLsAmX7P8HQkr4D55apLMLxZaJaUCSJrV9J1Kx+QzH+rF5to/b5fvDdvE
         5J5bScmOsuvOdfz2er5gq0Br2NaJQ5zQmJu096jBgVSUuitwlAynvtA2exRj6WnOuD
         mQaDr6eALypLDiNZ980OYby6dJ+6jSmQjt/T/qZtrhD0BYJ2iSGunYYLGjHldGNWtB
         5caQI7c3m+aCsUAOEjhxc1WjUTiq0ajCcrFOCH1DFMMfm8G3OiwEq4Tr5AoBkMq38u
         PceoZvpuT0NaSCJof+78Ua59YdxANzTK4SvWykDiMlR3jCBRFFIBGqY+vFQpYf5uH/
         MLTkkm2EZ/Ozg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 2/3] efi/libstub: arm64: Remap relocated image with strict permissions
Date:   Fri, 10 Mar 2023 13:50:25 +0100
Message-Id: <20230310125026.3390928-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310125026.3390928-1-ardb@kernel.org>
References: <20230310125026.3390928-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=ardb@kernel.org; h=from:subject; bh=Q2hOEReJ8XL6o95bm/6W8U9iYAmkT6SKYEkF7NI1eIw=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYVbfWKK9zeVjV22gjuF5uRNe374UkPTX735e3cw96x9v 2D/JNbzHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiBcsZGZ5W7fvSdHshb8jE QFbVW0qS/T8OBjKvWqXMzS688EPj7UkM/9PjfVaYij98tG797J/z/iw00M9+NenJusoGw/Ico3J HaW4A
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

After relocating the executable image, use the EFI memory attributes
protocol to remap the code and data regions with the appropriate
permissions.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index d4a6b12a87413024..b996553cdb4c3587 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -139,6 +139,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	*image_addr = *reserve_addr;
 	memcpy((void *)*image_addr, _text, kernel_size);
 	caches_clean_inval_pou(*image_addr, *image_addr + kernel_codesize);
+	efi_remap_image(*image_addr, *reserve_size, kernel_codesize);
 
 	return EFI_SUCCESS;
 }
-- 
2.39.2

