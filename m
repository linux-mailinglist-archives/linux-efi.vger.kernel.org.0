Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0103364DB7A
	for <lists+linux-efi@lfdr.de>; Thu, 15 Dec 2022 13:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiLOMnJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Dec 2022 07:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiLOMnC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Dec 2022 07:43:02 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A36A6273;
        Thu, 15 Dec 2022 04:42:30 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 41F2340737B0;
        Thu, 15 Dec 2022 12:42:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 41F2340737B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1671108147;
        bh=jwVZfRAAiFqcCVLSCdZEn7wStGxjBCy240Fe15tVLDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AhwQace4BSscXLSgOx45uS18mgI/sJ/7ATrZ1HBbOWSm47BpNor8Dgw4rpM6rLl/O
         h3XVVePg7nHJgcvqEbo1++n0PQto1GFsR0RcbgU8EcubXWeZ1NGxJjDhTrgiaE9Vho
         KjEzhGPGYIS5CwvD+Sshg2tO4IvfgIIbv1Ka7gn8=
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
Subject: [PATCH v4 26/26] efi/x86: don't set unsupported memory attributes
Date:   Thu, 15 Dec 2022 15:38:17 +0300
Message-Id: <b88490c5b7da3a95976f88fbb6b6cbfe561e5f6a.1671098103.git.baskov@ispras.ru>
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

On platforms where the firmware uses DXE, but which do not implement the
EFI Memory Attribute Protocol, we implement W^X support using DXE's
set_memory_attributes() call.  This call will fail without making any
changes if an attribute is set that isn't supported on the platform.

This patch changes efi_adjust_memory_range_protection() to avoid trying
to set any attribute bits that aren't set in the memory region's
capability flags.

Signed-off-by: Peter Jones <pjones@redhat.com>
---
 drivers/firmware/efi/libstub/mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 50a0b649b75a..b86ea2920d5e 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -195,6 +195,7 @@ static efi_status_t adjust_mem_attrib_dxe(efi_physical_addr_t rounded_start,
 
 		desc.attributes &= ~(EFI_MEMORY_RO | EFI_MEMORY_XP);
 		desc.attributes |= attributes;
+		desc.attributes &= desc.capabilities;
 
 		unprotect_start = max(rounded_start, desc.base_address);
 		unprotect_size = min(rounded_end, next) - unprotect_start;
-- 
2.37.4

