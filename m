Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E006B8F9F
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 11:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCNKUW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 06:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCNKTp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 06:19:45 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03747B98A;
        Tue, 14 Mar 2023 03:19:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 09D0C4076B51;
        Tue, 14 Mar 2023 10:18:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 09D0C4076B51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678789084;
        bh=TGo4XV8+4rYhPXDaghQExWmkbcLCrUD/7A+lIMbYivo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DinlFVoZPtOfiUrfZLz2HeYSH7RAVDDFhltsS7dtCieoqHQpcphDbfmqFesJNJgVw
         8ycZ7pWdCvXpHhrWXRLbfAmXx67RPiTByKTod9FpOFjD2eenBKyGUdBjhKr2xTiGX7
         528XoSo853o76fvBIgzLR8VDp6Nd6A7swa/y8yGA=
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
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v5 16/27] x86/boot: Reduce lower limit of physical KASLR
Date:   Tue, 14 Mar 2023 13:13:43 +0300
Message-Id: <5a05045877c25c9ed08287e3ed829332de0ac667.1678785672.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678785672.git.baskov@ispras.ru>
References: <cover.1678785672.git.baskov@ispras.ru>
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
index 69966481b82d..806df3912396 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -850,10 +850,10 @@ void choose_random_location(unsigned long input,
 
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
2.39.2

