Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB27772AD0
	for <lists+linux-efi@lfdr.de>; Mon,  7 Aug 2023 18:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjHGQ3F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Aug 2023 12:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjHGQ2u (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Aug 2023 12:28:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2601BCC;
        Mon,  7 Aug 2023 09:28:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB2BF61F28;
        Mon,  7 Aug 2023 16:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872F3C433C7;
        Mon,  7 Aug 2023 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691425699;
        bh=TDhagb7/1BjVNI9fsBOdvguiTH1+pJKnlE7Km5AKGt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ul3SIvwusScw6W/Rrx5lb8XHh6GsbWplmPgj0h8ekG8xmjqlPJn35HT0KLTgnzC6e
         VFiOq8htDLZ+EhzdtzfIHjA/Mfe8FTCbU9T3otANY+n3mitML29lnkHKJnGKr/Oja0
         4nNb8EScvrTPEDZ+VSRS4c1HLTBnl4TfzSYc5pRIijM6X/LceuRWlNdX26s18x7RG8
         /oaRItIUArju3fOu1QrNppOBwpfBKtIWF8ZTlrxj82PxPFzZ4CVeynTiZ8zCvx0Nrz
         0BuZV8eGdhCoXw8H6NjSvsFMmf6SUfGj35ZhRlYhkx8wMNUqnvogDEv/6df048lZBD
         V9ZNVV/1uxxZg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v9 18/23] decompress: Use 8 byte alignment
Date:   Mon,  7 Aug 2023 18:27:15 +0200
Message-Id: <20230807162720.545787-19-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807162720.545787-1-ardb@kernel.org>
References: <20230807162720.545787-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=ardb@kernel.org; h=from:subject; bh=TDhagb7/1BjVNI9fsBOdvguiTH1+pJKnlE7Km5AKGt0=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWidKJj8Dlmqxk7xPnZwiXV5brXV9wouiG9+hJzRN1Bj qn8AXc6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETmeTEy7Kktmt8zyy3xd86T WmvX+8fat53lZn9/ZqXlmdNpGq+aTzAyND1ZezVKZ3qd0p2YyRoLn30OPamkuOmP4173NccM7tV d5AEA
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

