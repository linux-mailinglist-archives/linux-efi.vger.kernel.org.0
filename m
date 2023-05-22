Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E444470B640
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 09:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjEVHQ4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 03:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjEVHQR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 03:16:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B68C10F4;
        Mon, 22 May 2023 00:15:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBB5961DF4;
        Mon, 22 May 2023 07:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A567FC433EF;
        Mon, 22 May 2023 07:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684739736;
        bh=TDhagb7/1BjVNI9fsBOdvguiTH1+pJKnlE7Km5AKGt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/k25RQrwho388uZuEtlF6MSH2EBdQnJmyiy5r1iU9TgEL5+t4CYqaj50iQtt75+u
         Qbqr1HwaRmOIAA7tpZ2RXqLdwR+pmCgRoTpQ6XB2SI4yYXYOKyKS3ruIbT3aCYv9Gm
         BadBzyHNU71Cut4XjqHwR/oPZVBfQU9FQAGzoR6jxLozp44/PzAqiTLdjLjyhIXzDL
         2pvV5pxM0B0NfsXs9YF5SA7j7oe3OPbaAxx/DGmNIG9Y0mefuXpPuEtREMYvLqBMIB
         2AWA8HVb9mCkDTj6/ng8cl4nwinPhOagqzaeX5vF7+z8TPN4iSsGLek5JCSV3LQCaZ
         KMKC1JT1BxKsA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v3 15/21] decompress: Use 8 byte alignment
Date:   Mon, 22 May 2023 09:14:09 +0200
Message-Id: <20230522071415.501717-16-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522071415.501717-1-ardb@kernel.org>
References: <20230522071415.501717-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=ardb@kernel.org; h=from:subject; bh=TDhagb7/1BjVNI9fsBOdvguiTH1+pJKnlE7Km5AKGt0=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVbzN4x+Byz1Ywd4vxs4ZLqct3rK24U3ZBefYk5ou4gx 1T+gDsdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJuFowMM8Uapp2MfjA5Yvqt yGfuB5VM3gd1rytn3aMTdf9rqf23n4wMH9Xfv3r8/8FEkdVGScfsb/9YxDCrYqv8iqazS94dmdj 5ghEA
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

The ZSTD decompressor requires malloc() allocations to be 8 byte
aligned, so ensure that this the case.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/decompress/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
index 9192986b1a731323..ac862422df158bef 100644
--- a/include/linux/decompress/mm.h
+++ b/include/linux/decompress/mm.h
@@ -48,7 +48,7 @@ MALLOC_VISIBLE void *malloc(int size)
 	if (!malloc_ptr)
 		malloc_ptr = free_mem_ptr;
 
-	malloc_ptr = (malloc_ptr + 3) & ~3;     /* Align */
+	malloc_ptr = (malloc_ptr + 7) & ~7;     /* Align */
 
 	p = (void *)malloc_ptr;
 	malloc_ptr += size;
-- 
2.39.2

