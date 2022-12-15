Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D69964DB7E
	for <lists+linux-efi@lfdr.de>; Thu, 15 Dec 2022 13:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiLOMnK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Dec 2022 07:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiLOMnC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Dec 2022 07:43:02 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACB820F59;
        Thu, 15 Dec 2022 04:42:30 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 0E73240737AF;
        Thu, 15 Dec 2022 12:42:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0E73240737AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1671108147;
        bh=vztQ7u4MmeffEsRSTEqzIF242WNEvNuMgKhdYE1vtQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ljb1/2povbonR9yWOyTDLbgWJV5pgA+tzHeC3kYznBneI1ff+TX9u3KbL4KlbUY0o
         CVKQpvvfHJSHqzxy1raMDEsLdy87oeyO1ISgSpUNdP9of8+qOFKStp+ZCj6Og70A+r
         bZmHgg3d8wTayX5rmBBclnRlkSpUNlSDX4wmG/rg=
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
Subject: [PATCH v4 25/26] efi/x86: don't try to set page attributes on 0-sized regions.
Date:   Thu, 15 Dec 2022 15:38:16 +0300
Message-Id: <53ae7c223875633ee8246b6139b226aa16e0512e.1671098103.git.baskov@ispras.ru>
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
index b31d1975caa2..50a0b649b75a 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -249,6 +249,9 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 	efi_physical_addr_t rounded_start, rounded_end;
 	unsigned long attr_clear;
 
+	if (size == 0)
+		return EFI_INVALID_PARAMETER;
+
 	/*
 	 * This function should not be used to modify attributes
 	 * other than writable/executable.
-- 
2.37.4

