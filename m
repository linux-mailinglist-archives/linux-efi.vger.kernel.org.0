Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530E064DB78
	for <lists+linux-efi@lfdr.de>; Thu, 15 Dec 2022 13:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiLOMnH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Dec 2022 07:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiLOMnB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Dec 2022 07:43:01 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDD51F2DB;
        Thu, 15 Dec 2022 04:42:30 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id D094640737AC;
        Thu, 15 Dec 2022 12:42:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D094640737AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1671108146;
        bh=/3aykElKH4pn5SEXDyJ1EneJ0wHiEtYgi6a9UlywDnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=euKzKEG8WaY8e4TbcSYrwQuaFPPQOJzEJNpzhDqKCqsjUaTZxReb8Yt5QZGY1JpFx
         rFfecsbHF2vp2jxg14K4y/XhNCvwDG3iY5zqRLELY9RUz2QdCdQLoTSKYqG7jaJVbf
         sMV0XXHNSDKwLjGj/K9d4EOQ1NWo071JDJ1qElkA=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Jones <pjones@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v4 24/26] efi/libstub: make memory protection warnings include newlines.
Date:   Thu, 15 Dec 2022 15:38:15 +0300
Message-Id: <b7815cff5f497d19a656e1bdea0a319f846beeef.1671098103.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1671098103.git.baskov@ispras.ru>
References: <cover.1671098103.git.baskov@ispras.ru>
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

From: Peter Jones <pjones@redhat.com>

efi_warn() doesn't put newlines on messages, and that makes reading
warnings without newlines hard to do.

Signed-off-by: Peter Jones <pjones@redhat.com>
---
 drivers/firmware/efi/libstub/mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 07d54c88c62e..b31d1975caa2 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -297,7 +297,7 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 				rounded_end - rounded_start,
 				attr_clear);
 	if (status != EFI_SUCCESS) {
-		efi_warn("Failed to clear memory attributes at [%08lx,%08lx]: %lx",
+		efi_warn("Failed to clear memory attributes at [%08lx,%08lx]: %lx\n",
 			 (unsigned long)rounded_start,
 			 (unsigned long)rounded_end,
 			 status);
@@ -310,7 +310,7 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 				rounded_end - rounded_start,
 				attributes);
 	if (status != EFI_SUCCESS) {
-		efi_warn("Failed to set memory attributes at [%08lx,%08lx]: %lx",
+		efi_warn("Failed to set memory attributes at [%08lx,%08lx]: %lx\n",
 			 (unsigned long)rounded_start,
 			 (unsigned long)rounded_end,
 			 status);
-- 
2.37.4

