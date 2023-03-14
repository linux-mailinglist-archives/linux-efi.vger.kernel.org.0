Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993936B90E6
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 12:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjCNLCY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 07:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCNLCT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 07:02:19 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABB395E1A;
        Tue, 14 Mar 2023 04:02:02 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6E10A40755D2;
        Tue, 14 Mar 2023 10:23:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6E10A40755D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678789405;
        bh=h+bkgqPm7b7uPEaroJgzVv9itrgVunPxx6RhvF4UiD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LllV8BRJ4K+NnkNRyF8DlukEoGrApXJeih+vpRc/nGWBLcqSAAajZRaoP7HKrLI3O
         jH7ukC0VE8qSvCoJlTCXmhgXJ2qsh9FcgiNs1gzBGl++zm2eLTR7id94S3tc2zvyHi
         fXASBwRFAO+bDu9KAS9q/E72xBJs7RNnXvV9d0JA=
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
Subject: [PATCH v5 23/27] efi/libstub: Don't set ramdisk_image/ramdisk_size
Date:   Tue, 14 Mar 2023 13:13:50 +0300
Message-Id: <f89c9b4d5d1ed9a95a51b63b196e45e4263a6da5.1678785672.git.baskov@ispras.ru>
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

The local copy of the boot_params made during build time is used now,
so setting ramdisk_image/ramdisk_size fields is no longer needed,
since they are already set to 0.

Remove no longer required assignments.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 drivers/firmware/efi/libstub/x86-stub.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 5dbc9c7a4aa3..7c5561aaba71 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -389,9 +389,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_set_u64_split((unsigned long)cmdline_ptr, &hdr->cmd_line_ptr,
 			  &efi_boot_params.ext_cmd_line_ptr);
 
-	hdr->ramdisk_image = 0;
-	hdr->ramdisk_size = 0;
-
 	efi_stub_entry(handle, sys_table_arg, &efi_boot_params);
 	/* not reached */
 
-- 
2.39.2

