Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5256F633B0E
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 12:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbiKVLSc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 06:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbiKVLRc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 06:17:32 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A488DEE9;
        Tue, 22 Nov 2022 03:14:46 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 91753419E9FE;
        Tue, 22 Nov 2022 11:14:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 91753419E9FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1669115684;
        bh=hDUzGiUVmLaacOXu/z6JftlYgMxorcNB1P4zYdNcUVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fGp+oA9iDBAPhlVYXBcZfYbMN02qaqGsTRz7H2BSjs+/7jTtObG+4M1M1MvcrYwyS
         rYutse9d68YK6zjZDvAzrCSHnlnmMKYENCBqkOjK7G3Nonpj+4/J67ocO4x5QqnaD1
         9pQax7kYHukdsFvsRvMvpiQU/uMqsb/hTPSoqBjk=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 16/24] x86/boot: Reduce lower limit of physical KASLR
Date:   Tue, 22 Nov 2022 14:12:25 +0300
Message-Id: <0e6a4c9c7655d3f42f624e1174b223fec5b2b087.1668958803.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1668958803.git.baskov@ispras.ru>
References: <cover.1668958803.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Set lower limit of physical KASLR to 64M.

Previously is was set to 512M when kernel is loaded higher than that.
That prevented physical KASLR from being performed on x86_32, where
upper limit is also set to 512M. The limit is pretty arbitrary, and the
most important is to set it above the ISA hole, i.e. higher than 16M.

It was not that important before, but now kernel is not getting
relocated to the lower address when booting via EFI, exposing the
KASLR failures.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/kaslr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 7e09d65f7b57..672550686f62 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -852,10 +852,10 @@ void choose_random_location(unsigned long input,
 
 	/*
 	 * Low end of the randomization range should be the
-	 * smaller of 512M or the initial kernel image
+	 * smaller of 64M or the initial kernel image
 	 * location:
 	 */
-	min_addr = min(*output, 512UL << 20);
+	min_addr = min(*output, 64UL << 20);
 	/* Make sure minimum is aligned. */
 	min_addr = ALIGN(min_addr, CONFIG_PHYSICAL_ALIGN);
 
-- 
2.37.4

