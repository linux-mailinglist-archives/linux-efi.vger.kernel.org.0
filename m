Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DE05F4906
	for <lists+linux-efi@lfdr.de>; Tue,  4 Oct 2022 20:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiJDSHl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Oct 2022 14:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJDSHl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Oct 2022 14:07:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BCD53D3F;
        Tue,  4 Oct 2022 11:07:36 -0700 (PDT)
Date:   Tue, 04 Oct 2022 18:07:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664906855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eY2DWEEsNVLOS2vTQvlgLOYzWOASEQKGPb+PmiY9Yvg=;
        b=tw5FDHmr+caSLOcJ2uTKG8xq857H2mRp/lXPkSWFdYzNlhCotQl2b7hpYzcVnWImOrRcmi
        jgs/yUik6hROJ4o4UrW4AOaVT56Ivjm6hVQwsKwUl0XWfutOcAM2fkJq3MBOhdf81okFyO
        sBbpM14fygs6m5TU5cWFa11+ODo4Nj4q6D8nN+CM9dEUGejbhuuF5ZXNqfgZIlkNfidOVt
        U5mQioK55W76lQG0GiX7J7V7e4cxpykDrlCslBAtYGnq7H6Y5aTggekBGaeLDGDo4edSNZ
        Xk1AVx62c4SoIXia92HbKBFrXb4QXKf9JJY4q2sFqDHUXsROFrWVgkpY55wcDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664906855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eY2DWEEsNVLOS2vTQvlgLOYzWOASEQKGPb+PmiY9Yvg=;
        b=okv/dvpZP/6q7Bb7VOMHRppHmR6+b2HN2p03upwoeujGbnqg7tVvtimID36CWBRRhaOyNZ
        TVu8/svjA8XeLzBQ==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Disable W^X detection and enforcement on 32-bit
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166490685372.401.8724006488941040622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     8c4934f4754057e3577bb1536c6ecc0efa2c966e
Gitweb:        https://git.kernel.org/tip/8c4934f4754057e3577bb1536c6ecc0efa2c966e
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 23 Sep 2022 14:29:45 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 03 Oct 2022 13:12:23 -07:00

x86/mm: Disable W^X detection and enforcement on 32-bit

The 32-bit code is in a weird spot.  Some 32-bit builds (non-PAE) do not
even have NX support.  Even PAE builds that support NX have to contend
with things like EFI data and code mixed in the same pages where W+X
is unavoidable.

The folks still running X86_32=y kernels are unlikely to care much about
NX.  That combined with the fundamental inability fix _all_ of the W+X
things means this code had little value on X86_32=y.  Disable the checks.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: linux-efi@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com/
---
 arch/x86/mm/pat/set_memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 20b1e24..efe882c 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -587,6 +587,14 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 {
 	unsigned long end;
 
+	/*
+	 * 32-bit has some unfixable W+X issues, like EFI code
+	 * and writeable data being in the same page.  Disable
+	 * detection and enforcement there.
+	 */
+	if (IS_ENABLED(CONFIG_X86_32))
+		return new;
+
 	/* Only enforce when NX is supported: */
 	if (!(__supported_pte_mask & _PAGE_NX))
 		return new;
