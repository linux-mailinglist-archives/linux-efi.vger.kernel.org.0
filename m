Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3622A6B12F6
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 21:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCHUWo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Mar 2023 15:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCHUWg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Mar 2023 15:22:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D706BD7BA
        for <linux-efi@vger.kernel.org>; Wed,  8 Mar 2023 12:22:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C1166195A
        for <linux-efi@vger.kernel.org>; Wed,  8 Mar 2023 20:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95884C433A1;
        Wed,  8 Mar 2023 20:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678306945;
        bh=oDVQklf0HyjpB9GjDuwqrJvWUVKodcvf0lOXOKX18h4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pL24yLVVe91ZjBUf0vVX++qsGJW/vD3YBo9OzybIy4MaYlHMsy6lOsXNh0JUgCUPt
         SHz9pwr1ItPbPmgcukptwbFHjKr3x07EdoKWndyFMHbxvrO8pDUmPTXLH8z8BSji69
         c0s6vfT/KHVWp2hu7CCb6zqy9XJU/XWnZKclJR56lmG5O0ou2gDMrjiSy59xa5+lGg
         s/IjVn4APo1GeuXIhNbn7ezXjgy+p0Fc33OcSt3mKpJySFgfBoraUoKYoad1PU0qoO
         9zZrG1QgPgyymgfwUgJItGz5c26Pa/WW0uAZfd2yTbGyzsjZ/H4rdyJKiVtEpos5T4
         7z6ju7vh24YbA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: [RFC PATCH 3/4] efi: x86: Drop alignment section header flags
Date:   Wed,  8 Mar 2023 21:22:08 +0100
Message-Id: <20230308202209.2980947-4-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308202209.2980947-1-ardb@kernel.org>
References: <20230308202209.2980947-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405; i=ardb@kernel.org; h=from:subject; bh=oDVQklf0HyjpB9GjDuwqrJvWUVKodcvf0lOXOKX18h4=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXjXUHTgZhuhbMsU5e9K66zfTJ1ZarydZ3go5cO8/AGP eZ5W7Czo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzk/HGG/87HUuZWv1qzZ4Wo hkTPqRP6M7dmRKxQqr3wdv+SdZrfLoQx/DP2n+dsLn5x1a3iuu53Jn3h05Uaw5dVSSkrlf7+d/D OJgYA
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

The section header flags for alignment are documented as only being
applicable to PE object files, not PE executables, so let's drop them.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index aba499404d8b870e..4f1e1791cda4d316 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -212,8 +212,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 
 #ifdef CONFIG_EFI_MIXED
 	#
@@ -231,8 +230,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 #endif
 
 	#
@@ -253,8 +251,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_CODE		| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		| \
-		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
+		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
 	.set	section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */
-- 
2.39.2

