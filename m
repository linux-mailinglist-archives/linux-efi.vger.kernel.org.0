Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2301C6C4D94
	for <lists+linux-efi@lfdr.de>; Wed, 22 Mar 2023 15:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjCVO0f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Mar 2023 10:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjCVO0e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Mar 2023 10:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B10958B70
        for <linux-efi@vger.kernel.org>; Wed, 22 Mar 2023 07:26:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DEB462150
        for <linux-efi@vger.kernel.org>; Wed, 22 Mar 2023 14:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CFBC4339B;
        Wed, 22 Mar 2023 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679495191;
        bh=/pQl1T/l+bkRAhDaMaRrFUb1vkonMeAYR0omTnvlKko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4GxiiM8EbOLGONlgb8ht8bNuGR65CpQ6PmZxseV/QEwpCy9T9prJyxfLTsZQu6BL
         A7Ez6CFlGYzk3OWYNnkmg3DvKczLdlBfR2cTIRBXGXRAQELMZqLz9rZfCNKMqgqJ1i
         YIl22knKo6pEUaaWMauMd5vmwDiSI/FXk1x/Vc+yhmBg/FfDcfvsk83kgSFnFAD47j
         PFSt+83XK3FcUd6r3dUNqhoW58qYU9jcnRtIqjVDXoHpqFiXe5+XS8hCfrtDOkhl2c
         XcbJhQbikWDm6o/RMqJ22P7oCzb/GqRzONs6N5l/IF8G4XI2B8NiJdzyxQWbcCAE7K
         5wey3pZ4M1Xqg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH 1/3] efi/libstub: smbios: Use length member instead of record struct size
Date:   Wed, 22 Mar 2023 15:26:19 +0100
Message-Id: <20230322142621.3685058-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322142621.3685058-1-ardb@kernel.org>
References: <20230322142621.3685058-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1003; i=ardb@kernel.org; h=from:subject; bh=/pQl1T/l+bkRAhDaMaRrFUb1vkonMeAYR0omTnvlKko=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUVagOvs/4sTZurG/6i/YXdjvYRX5CNN5e3BB5U/J2+36 HCP0BPsKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOJSmD477koyyjKNfZe0EmG wy+LgvpOzWjft8uJJfnDj6Iy4VbGNkaGA5Y5Ehb389t7kxpuPvb4dk938wanuvASvZ+FTMxbagW YAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The type 1 SMBIOS record happens to always be the same size, but there
are other record types which have been augmented over time, and so we
should really use the length field in the header to decide where the
string table starts.

Fixes: 550b33cfd4452968 ("arm64: efi: Force the use of ...")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/smbios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/smbios.c b/drivers/firmware/efi/libstub/smbios.c
index 460418b7f5f5e9ab..aadb422b9637dfc0 100644
--- a/drivers/firmware/efi/libstub/smbios.c
+++ b/drivers/firmware/efi/libstub/smbios.c
@@ -36,7 +36,7 @@ const u8 *__efi_get_smbios_string(u8 type, int offset, int recsize)
 	if (status != EFI_SUCCESS)
 		return NULL;
 
-	strtable = (u8 *)record + recsize;
+	strtable = (u8 *)record + record->length;
 	for (int i = 1; i < ((u8 *)record)[offset]; i++) {
 		int len = strlen(strtable);
 
-- 
2.39.2

