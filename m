Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0ED633B0F
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 12:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiKVLSd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 06:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiKVLRc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 06:17:32 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD994E094;
        Tue, 22 Nov 2022 03:14:46 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id DDAB640737BC;
        Tue, 22 Nov 2022 11:14:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru DDAB640737BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1669115685;
        bh=ECseb6siPLZccH2FNtVbbnERJUQobRq291fpKz8aIww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPiJwsYdfgZtNzI/9Q3y26cnwCKwOz8T5jNsOKhxqG+V8x4LYrDU0adtar4OlsOgy
         qRD5XGs0+z9uv6irj0VH1T6YWpybVM3LpujcnTpu9536RR6LfSdSJG5SMCNkTl2MP3
         EEXskEdyftMKZmSQZKHsKg6uYn0VPF+yQTVlZ6no=
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
Subject: [PATCH v3 17/24] x86/boot: Reduce size of the DOS stub
Date:   Tue, 22 Nov 2022 14:12:26 +0300
Message-Id: <c66c4efbf8c650f0b055aba3235191100cf2115f.1668958803.git.baskov@ispras.ru>
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

This is required to fit more sections in PE section tables,
since its size is restricted by zero page located at specific offset
after the PE header.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/header.S | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index f912d7770130..e4de831b2f64 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -59,17 +59,16 @@ start2:
 	cld
 
 	movw	$bugger_off_msg, %si
+	movw	$bugger_off_msg_size, %cx
 
 msg_loop:
 	lodsb
-	andb	%al, %al
-	jz	bs_die
 	movb	$0xe, %ah
 	movw	$7, %bx
 	int	$0x10
-	jmp	msg_loop
+	decw	%cx
+	jnz	msg_loop
 
-bs_die:
 	# Allow the user to press a key, then reboot
 	xorw	%ax, %ax
 	int	$0x16
@@ -89,10 +88,9 @@ bs_die:
 
 	.section ".bsdata", "a"
 bugger_off_msg:
-	.ascii	"Use a boot loader.\r\n"
-	.ascii	"\n"
-	.ascii	"Remove disk and press any key to reboot...\r\n"
-	.byte	0
+	.ascii	"Use a boot loader. "
+	.ascii	"Press a key to reboot"
+	.set	bugger_off_msg_size, . - bugger_off_msg
 
 #ifdef CONFIG_EFI_STUB
 pe_header:
-- 
2.37.4

