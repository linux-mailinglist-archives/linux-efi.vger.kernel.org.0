Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942F360CEB1
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 16:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiJYOOV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 10:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiJYOOH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 10:14:07 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53319B87D;
        Tue, 25 Oct 2022 07:14:05 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 5343E40737B7;
        Tue, 25 Oct 2022 14:14:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5343E40737B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666707244;
        bh=HI18v3+f+Pl+YyhFoHiqU9HpwMvARvOP6MXeGpCdq1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4Rw76ioj0sV5FcOz4mFluQTJQFBRHderUB+3PtsfLmRUHykCd4zoE9DfD/zWpjE3
         ZOD/8mpLuAe1pKFxE3UIxKT2VlzdDmT5d8b6HLPV0CStVtl8WyzdGzze4zFxXDCdTk
         4TQzY3EtG8UnXVDdOWdsLI/Nr/0hBx406Ov2CwVA=
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
Subject: [PATCH v2 17/23] x86/boot: Reduce size of the DOS stub
Date:   Tue, 25 Oct 2022 17:12:55 +0300
Message-Id: <2edb38e355437b1946e7fedcd4f5b4857a24be84.1666705333.git.baskov@ispras.ru>
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

This is required to fit more sections in PE section tables,
since its size is restricted by zero page located at specific offset
after the PE header.

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

