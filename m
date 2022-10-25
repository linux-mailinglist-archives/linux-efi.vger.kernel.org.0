Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C81B60CE89
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 16:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiJYONV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 10:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiJYONU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 10:13:20 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B1D9C23B;
        Tue, 25 Oct 2022 07:13:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 4B05C419E9CE;
        Tue, 25 Oct 2022 14:13:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4B05C419E9CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666707196;
        bh=GUsxEZYsjagqsnIlo2HdS3ccrH9SY23SsZJ1t0JcDlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X6dhjPzAU9dm7k8w7yB3bDXecalPdxUvRW9oxgirXw/MoH9p4cYkOshbLwILP4S3S
         gGLz/3JOL9dT3NS1Hv/HlnNmY23Vxp0kBbVYEmD5A7NIlIwMyz7/rA7hF98msrbbae
         3FCD2JmOLln5/XJA2ujE1bKt7wXznWndmBj7PQ2g=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 03/23] x86/boot: Set cr0 to known state in trampoline
Date:   Tue, 25 Oct 2022 17:12:41 +0300
Message-Id: <7286289c51a932f804a694bd7f605e70160534ea.1666705333.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1666705333.git.baskov@ispras.ru>
References: <cover.1666705333.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ensure WP bit to be set to prevent boot code from writing to
non-writable memory pages.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/head_64.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index d33f060900d2..2a4372b84fc8 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -684,9 +684,8 @@ SYM_CODE_START(trampoline_32bit_src)
 	pushl	$__KERNEL_CS
 	pushl	%eax
 
-	/* Enable paging again. */
-	movl	%cr0, %eax
-	btsl	$X86_CR0_PG_BIT, %eax
+	/* Enable paging and set CR0 to known state (this also sets WP flag) */
+	movl	$CR0_STATE, %eax
 	movl	%eax, %cr0
 
 	lret
-- 
2.37.4

