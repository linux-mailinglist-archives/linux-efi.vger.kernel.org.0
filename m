Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8207360CEA2
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 16:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiJYOOQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 10:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbiJYOOH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 10:14:07 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A605F9B5;
        Tue, 25 Oct 2022 07:14:05 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2720940737B6;
        Tue, 25 Oct 2022 14:14:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2720940737B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666707244;
        bh=r8nCG+BSFMZKNWwE0pHsrN0ffee0dDoDl2C/gh/xQ4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5YTbnVct96Q5WoGPafr04RLpBH2PEo1QCEmDD8Tkty7iD60sHwC1d9QjPlFcEYzt
         2Y6ngA/HFyjIs5z/D6xXG9+gXjXGVDvZ0CG4sOqZRyuLlBWsT2Wnz/SgX5T5vjY0lD
         z6M9RgYzN/1RRfx1NdIM7sd/CV1xeMYfi2vuxPt4=
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
Subject: [PATCH v2 16/23] x86/boot: Reduce lower limit of physical KASLR
Date:   Tue, 25 Oct 2022 17:12:54 +0300
Message-Id: <663de36ee68f37998a809b315fa81b360ce5e2a5.1666705333.git.baskov@ispras.ru>
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

Set lower limit of physical KASLR to 64M.

Previously is was set to 512M when kernel is loaded higher than that.
That prevented physical KASLR from being performed on x86_32, where
upper limit is also set to 512M. The limit is pretty arbitrary, and the
most important is to set it above the ISA hole, i.e. higher than 16M.

It was not that important before, but now kernel is not getting
relocated to the lower address when booting via EFI, exposing the
KASLR failures.

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

