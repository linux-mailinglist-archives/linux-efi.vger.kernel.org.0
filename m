Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFD76D6712
	for <lists+linux-efi@lfdr.de>; Tue,  4 Apr 2023 17:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbjDDPUL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Apr 2023 11:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDDPUK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Apr 2023 11:20:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E316446B6
        for <linux-efi@vger.kernel.org>; Tue,  4 Apr 2023 08:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B931635AD
        for <linux-efi@vger.kernel.org>; Tue,  4 Apr 2023 15:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C191C433D2;
        Tue,  4 Apr 2023 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680621608;
        bh=NN1vX7GS8UcvvMTsQiKYpCnrGd1Eg9mW+O4yymmSSt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MeYDBCPmAPj9dc7jnexw4cX8cbFyMj1wHuEfW9YKhA3K+0McpPu32F5m5Athdpd2T
         aJ1ud/evrdfR1ByV9TbhOiqiQMwGrVpZ0YZ0wk3IoLpPXUcVANvBS6FTUIu69kbtN4
         xlWqINE1R20TwzN229/yuxgf+4vA1aKNwKwuHI1oLNICv6BMLlm9Mj3Ey/bvf1xrQB
         9XHJjxK476gK5nnvvKwSc+TlYWGUAAwr3SCEFzQb5yxgosOitXIvJTYTQkRqfUv9zy
         +3bVCeYOHJ2Z6WjRU2zHU5OZ2fqguMyrX8JaYBeHA1ArNhzof6P4FFiTA1IZKF8piG
         ULvC9hRMkeOfg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, broonie@Kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 1/6] efi/pe: Import new BTI/IBT header flags from the spec
Date:   Tue,  4 Apr 2023 17:19:54 +0200
Message-Id: <20230404151959.2774612-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404151959.2774612-1-ardb@kernel.org>
References: <20230404151959.2774612-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294; i=ardb@kernel.org; h=from:subject; bh=NN1vX7GS8UcvvMTsQiKYpCnrGd1Eg9mW+O4yymmSSt8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUXHQSKJO8n9t8kkj9eO1zZcSvglbSglwHn6mf+tuBOBC S3xkuUdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCKifxkZtpenP3txLsn2T1Ko qf+d09MaDK7Jqrr5ZE2q/m4zs6r1McN/hw5zN7O2ue7F6aaXeY4H/Lv42Ow629qO02cTuSVf8J7 mAQA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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

