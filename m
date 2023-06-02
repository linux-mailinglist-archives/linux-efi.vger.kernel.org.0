Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9302371FF22
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 12:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbjFBKY0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 06:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjFBKXq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 06:23:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F11E10E4;
        Fri,  2 Jun 2023 03:23:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A89A664E63;
        Fri,  2 Jun 2023 10:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1853FC4339E;
        Fri,  2 Jun 2023 10:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685701393;
        bh=TDhagb7/1BjVNI9fsBOdvguiTH1+pJKnlE7Km5AKGt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JDWx2x8NS3EXWONbS4ao2cLywwjBkOxSVub0aB4TdyV8RL9twr4aztr/IY/zCAljA
         K2quBW9clDp8TUhlmV9LD7TzM4L//8fZFYHZxvLElvz+tgnqe5I6lJvMhD7jblttSS
         1N1vZZRsCxgUl/E46/JyddBynvcCdonJFVvlc+uuAJM52e6vBet/2QZaRFHfx+Cut9
         kDEFCXx3l8l31o6QLZXmYpe6EdwwX2LiIBnkKJ+Ez4/OIGufEmZEr10tw3rXyWY14F
         UCzGLja/1kx6eg7oMFgPqx5tOR1ZsTRI6M8pmsxCLN/hL0tsJdjZm0+enwFpL9tMHp
         MLatLcXPzWj8Q==
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v4 15/21] decompress: Use 8 byte alignment
Date:   Fri,  2 Jun 2023 12:13:07 +0200
Message-Id: <20230602101313.3557775-16-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230602101313.3557775-1-ardb@kernel.org>
References: <20230602101313.3557775-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=ardb@kernel.org; h=from:subject; bh=TDhagb7/1BjVNI9fsBOdvguiTH1+pJKnlE7Km5AKGt0=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaXywCbH4HPMVjN2iPOzhUuqy3Wvr7hRdEN69SXmiLqDH FP5A+50lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlE32b4pxNVkM2cIBzz1En+ xx4jBomCA/ICNzRFHvntseObOCV2CyPD4fyFE/jqUv6/lGutyexOcKy+msrx/7ZPzWwdR2abMxq sAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

