Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EC16E6657
	for <lists+linux-efi@lfdr.de>; Tue, 18 Apr 2023 15:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjDRNuJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Apr 2023 09:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDRNuI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Apr 2023 09:50:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310505267
        for <linux-efi@vger.kernel.org>; Tue, 18 Apr 2023 06:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C10A162822
        for <linux-efi@vger.kernel.org>; Tue, 18 Apr 2023 13:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3689C433D2;
        Tue, 18 Apr 2023 13:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681825806;
        bh=NN1vX7GS8UcvvMTsQiKYpCnrGd1Eg9mW+O4yymmSSt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qd3ui+f8dEpD4/5QJfvORJNIux1XawcE0g94nedKnxMrii9QykTiOCZdb9jaXRVuo
         dqNY1blHi+Fxtl5Wttyq/EAlJr9LR4wrLkmnEbbZWohqp8AtJk7bqiQKlzpZdyYepZ
         nQHrFOcM922XMqGeBgSAhMHHQZfsoM9UebEJAF/XetBL65VdHL3pUCyhernIuvlsfD
         8hhxVIxQItS+Y3SGtLDj1czzABdl/2Ca0SUako3JcSuYuKDKeqVUEEx7QSYDb06707
         +q75JJBN5UV/+5j9Qm4XN9Loj9z7/qbZwkmgkdlO/k2tO5v64a6dtXVNgU17ZShP/u
         4loZn1tOyLmAQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        broonie@kernel.org, will@kernel.org, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 1/6] efi/pe: Import new BTI/IBT header flags from the spec
Date:   Tue, 18 Apr 2023 15:49:47 +0200
Message-Id: <20230418134952.1170141-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418134952.1170141-1-ardb@kernel.org>
References: <20230418134952.1170141-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294; i=ardb@kernel.org; h=from:subject; bh=NN1vX7GS8UcvvMTsQiKYpCnrGd1Eg9mW+O4yymmSSt8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcVu/s8k7iT33yaTPF47XttwKeGXtKGUAOfpZ/634k4EJ rTES5Z3lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImoPmb4w/FtuaTQ/mtu9Ycb 6+aXRiks+CuYuyzo2lTpJVPWaWuHlTL8FZxbM+Xdy4nV+xQ/rshJaa2+m5D4uojnuufO2WKht/O ucQIA
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

The latest version of your favorite fork of the PE/COFF spec includes a
new type of header flag that is intended to be used in the context of
EFI firmware to indicate to the image loader that the executable regions
of an image can be mapped with BTI/IBT enforcement enabled.

So let's import these definitions so we can use them in subsequent
patches.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/pe.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pe.h b/include/linux/pe.h
index 6ffabf1e6d039e67..5e1e115408702c77 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -118,6 +118,9 @@
 #define IMAGE_DLLCHARACTERISTICS_WDM_DRIVER             0x2000
 #define IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE  0x8000
 
+#define IMAGE_DLLCHARACTERISTICS_EX_CET_COMPAT		0x0001
+#define IMAGE_DLLCHARACTERISTICS_EX_FORWARD_CFI_COMPAT	0x0040
+
 /* they actually defined 0x00000000 as well, but I think we'll skip that one. */
 #define IMAGE_SCN_RESERVED_0	0x00000001
 #define IMAGE_SCN_RESERVED_1	0x00000002
@@ -165,6 +168,7 @@
 #define IMAGE_SCN_MEM_WRITE	0x80000000 /* writeable */
 
 #define IMAGE_DEBUG_TYPE_CODEVIEW	2
+#define IMAGE_DEBUG_TYPE_EX_DLLCHARACTERISTICS	20
 
 #ifndef __ASSEMBLY__
 
-- 
2.39.2

