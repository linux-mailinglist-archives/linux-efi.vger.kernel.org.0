Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145A26B90E4
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 12:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCNLCU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 07:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCNLCS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 07:02:18 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A36E94A4E;
        Tue, 14 Mar 2023 04:02:02 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 0C9EB4076B3D;
        Tue, 14 Mar 2023 10:23:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0C9EB4076B3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678789406;
        bh=xWgPhy9flM1A9RQwR6AaR8Ed4LhIfck7ee61NCgDLok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6KKotKUXYAemnX5XK5UnGMWprOHJmI/0GF4uIjSOryzlLFL1wE+0pU+PcyK/yTTx
         IbRu8Q7UFzpNUgeTHtF8FuoIcdQ0ayamdvlh7+LLD7HJD0HeyifAZdjdWZ3DUNL+lD
         yyzj+ch5Ewns83S/bxivutfRQkjDBtbDVaAbfGeU=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Jones <pjones@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v5 26/27] efi/libstub: make memory protection warnings include newlines.
Date:   Tue, 14 Mar 2023 13:13:53 +0300
Message-Id: <3d60d0fa9fc96cbb85938042ad7be0d9884ff70c.1678785672.git.baskov@ispras.ru>
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

From: Peter Jones <pjones@redhat.com>

efi_warn() doesn't put newlines on messages, and that makes reading
warnings without newlines hard to do.

Signed-off-by: Peter Jones <pjones@redhat.com>
---
 drivers/firmware/efi/libstub/mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 77cf745ade0d..d58b552739ed 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -298,7 +298,7 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 				rounded_end - rounded_start,
 				attr_clear);
 	if (status != EFI_SUCCESS) {
-		efi_warn("Failed to clear memory attributes at [%08lx,%08lx]: %lx",
+		efi_warn("Failed to clear memory attributes at [%08lx,%08lx]: %lx\n",
 			 (unsigned long)rounded_start,
 			 (unsigned long)rounded_end,
 			 status);
@@ -311,7 +311,7 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 				rounded_end - rounded_start,
 				attributes);
 	if (status != EFI_SUCCESS) {
-		efi_warn("Failed to set memory attributes at [%08lx,%08lx]: %lx",
+		efi_warn("Failed to set memory attributes at [%08lx,%08lx]: %lx\n",
 			 (unsigned long)rounded_start,
 			 (unsigned long)rounded_end,
 			 status);
-- 
2.39.2

