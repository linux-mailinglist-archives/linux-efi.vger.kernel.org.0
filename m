Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948F47C5D9E
	for <lists+linux-efi@lfdr.de>; Wed, 11 Oct 2023 21:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjJKTZg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Oct 2023 15:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjJKTZf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Oct 2023 15:25:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289B38F;
        Wed, 11 Oct 2023 12:25:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A0FBA1F37C;
        Wed, 11 Oct 2023 19:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697052329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=anEJTRIydYLWffQhvtknX2NId1N4/R6qNf26dj/T/lU=;
        b=C3/IP0sJu1DQ/uI7jwD/LB9P+8mZ9Rt+CG4c9KYkDSiqnHyyf6Oaiydmwa8lh+rUPDDhTu
        JyZ5sDL/www3pWkK8EyitgMzLgCRgb+xR0U3ypfhzh/qWtrzEGqBBSBvSmHcenTthkHpYy
        jDG1HKrKlyr/N1gqwGapgxScJKSgn6g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BF12138EF;
        Wed, 11 Oct 2023 19:25:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7NXKD6n2JmVqfgAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Wed, 11 Oct 2023 19:25:29 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     ardb@kernel.org, kirill.shutemov@linux.intel.com
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] x86/efistub: Don't try to print after ExitBootService()
Date:   Wed, 11 Oct 2023 22:25:28 +0300
Message-Id: <20231011192528.262425-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

setup_e820() is executed after UEFI's ExitBootService has been called.
This causes the firmware to throw an exception because Console IO
protocol handler is supposed to work only during boot service
environment. As per UEFI 2.9, section 12.1:

 "This protocol isused to handle input and output of text-based
 information intended for the system user during the operation of code
 in the boot services environment."

Running a TDX guest with TDVF with unaccepted memory disabled results in
the following output:

!!!! X64 Exception Type - 06(#UD - Invalid Opcode)  CPU Apic ID - 00000000 !!!!
RIP  - 0000000000603D51, CS  - 0000000000000038, RFLAGS - 0000000000010046
RAX  - 0000000000000000, RCX - 0000000000000000, RDX - 000000007EC27530
RBX  - 0000000001C227A1, RSP - 000000007EC274D8, RBP - 000000007EC27530
RSI  - 000000000000000A, RDI - 000000007EC27530
R8   - 00000000AC1C4720, R9  - 000000007D2C5F18, R10 - 0000000000400000
R11  - 0000000000000000, R12 - 0000000001C22B0E, R13 - 0000000000000000
R14  - 0000000000000032, R15 - 000000007C6022D0
DS   - 0000000000000030, ES  - 0000000000000030, FS  - 0000000000000030
GS   - 0000000000000030, SS  - 0000000000000030
CR0  - 0000000080010031, CR2 - 0000000000000000, CR3 - 000000007EA01000
CR4  - 0000000000000268, CR8 - 0000000000000000
DR0  - 0000000000000000, DR1 - 0000000000000000, DR2 - 0000000000000000
DR3  - 0000000000000000, DR6 - 00000000FFFF0FF0, DR7 - 0000000000000400
GDTR - 000000007E7E6000 0000000000000047, LDTR - 0000000000000000
IDTR - 000000007D2BD018 0000000000000FFF,   TR - 0000000000000000
FXSAVE_STATE - 000000007EC27130
!!!! Can't find image information. !!!!

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 2fee52ed335d..3b8bccd7c216 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -605,11 +605,8 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
 			break;
 
 		case EFI_UNACCEPTED_MEMORY:
-			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
-				efi_warn_once(
-"The system has unaccepted memory,  but kernel does not support it\nConsider enabling CONFIG_UNACCEPTED_MEMORY\n");
+			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
 				continue;
-			}
 			e820_type = E820_TYPE_RAM;
 			process_unaccepted_memory(d->phys_addr,
 						  d->phys_addr + PAGE_SIZE * d->num_pages);
-- 
2.34.1

