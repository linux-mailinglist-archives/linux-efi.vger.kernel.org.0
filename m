Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBD16B90A1
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 11:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjCNKw7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 06:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCNKw5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 06:52:57 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D21974B2;
        Tue, 14 Mar 2023 03:52:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 4038B4076B3E;
        Tue, 14 Mar 2023 10:23:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4038B4076B3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678789406;
        bh=/4znEshL36zHB0h07IlC+ZODwPn07LA9fIruf/PmWac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNiT1r+tLEAlAtfLGE/fu4wtk4UXquo6znS0SYXSk4OevG9JTnxxbA6SIVpWIbDnd
         yiUAHQ1O/2bH+W6RQEW42WWg2OLHTmlXgc8o+FZmW/taJUxCRo5lEcIOUeTlw22PmM
         xxGmYSB5eAtzt45XNoor0WNXdofGTlS7VeXcbKTo=
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
Subject: [PATCH v5 27/27] efi/x86: don't try to set page attributes on 0-sized regions.
Date:   Tue, 14 Mar 2023 13:13:54 +0300
Message-Id: <465871c482bac0d996e81b5335fc6c307673517c.1678785672.git.baskov@ispras.ru>
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

In "efi/x86: Explicitly set sections memory attributes", the following
region is defined to help compute page permissions:

          /* .setup [image_base, _head] */
          efi_adjust_memory_range_protection(image_base,
                                             (unsigned long)_head - image_base,
                                             EFI_MEMORY_RO | EFI_MEMORY_XP);

In at least some cases, that will result in a size of 0, which will
produce an error and a message on the console, though no actual failure
will be caused in the boot process.

This patch checks that case in efi_adjust_memory_range_protection() and
returns the error without logging.

Signed-off-by: Peter Jones <pjones@redhat.com>
---
 drivers/firmware/efi/libstub/mem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index d58b552739ed..f18c797785ac 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -251,6 +251,9 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 	efi_physical_addr_t rounded_start, rounded_end;
 	unsigned long attr_clear;
 
+	if (size == 0)
+		return EFI_INVALID_PARAMETER;
+
 	/*
 	 * This function should not be used to modify attributes
 	 * other than writable/executable.
-- 
2.39.2

