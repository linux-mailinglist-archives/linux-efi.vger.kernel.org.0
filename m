Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C45E725597
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 09:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbjFGH0o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 03:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbjFGH0H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 03:26:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9482712;
        Wed,  7 Jun 2023 00:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FE3A63B5E;
        Wed,  7 Jun 2023 07:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7C3C433EF;
        Wed,  7 Jun 2023 07:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686122700;
        bh=TDhagb7/1BjVNI9fsBOdvguiTH1+pJKnlE7Km5AKGt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lI7VBfh3FTa+/2DGIQjc1gr3ILzC2t6Ms0aGwGTwrUtF4VPlbF1RALiGUY0dH0QRD
         A3ggROvDAfMP5yaR3Cf5kue7TsSvwVOR//bIpbHe4ZzAPU2gB3rt6RnuFeQAyzA5st
         O9PN3yhOwKJVjdCNZKObitd6C5vcBlDidZVw4xrll42+QvQHFHsNlANBGeQa4XFLDC
         GCz95IjoX0p2HVE/XT19Lt3pYrTsAgEbXVg+au5gnMLwe3VM4lPvqgNRRZNoULc20H
         xeGe82bRE7yfX9H/j9PMHg6L4Xjf06k8iPP1zi7gU7+cD/qn8ILEGjMTYQ8ru27Euv
         oeQ8cSu29UZOQ==
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
Subject: [PATCH v5 15/20] decompress: Use 8 byte alignment
Date:   Wed,  7 Jun 2023 09:23:37 +0200
Message-Id: <20230607072342.4054036-16-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607072342.4054036-1-ardb@kernel.org>
References: <20230607072342.4054036-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=ardb@kernel.org; h=from:subject; bh=TDhagb7/1BjVNI9fsBOdvguiTH1+pJKnlE7Km5AKGt0=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaXBoNwx+Byz1Ywd4vxs4ZLqct3rK24U3ZBefYk5ou4gx 1T+gDsdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCICJxj+CpbPu3D/CcsitZol Eht9De+3R/xcu7zg3NfQn78EuLIeHWP4p/9kduedmXcF1pc/XPt+lnXrSbsHZ6b/7W+++l7v19z Lp7gA
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

