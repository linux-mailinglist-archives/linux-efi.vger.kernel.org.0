Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2299862FA9A
	for <lists+linux-efi@lfdr.de>; Fri, 18 Nov 2022 17:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242225AbiKRQo2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Nov 2022 11:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241647AbiKRQo2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Nov 2022 11:44:28 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5DF14080;
        Fri, 18 Nov 2022 08:44:25 -0800 (PST)
Received: from zn.tnic (p200300ea9733e767329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e767:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5DCDF1EC05DD;
        Fri, 18 Nov 2022 17:44:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668789864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vXBGlFZAui3ZpQP37+GpYQWkbrvn/6/DDXXoJBl5Vyw=;
        b=bDROuXKWw1CYUBGZIYncsZdFd2BmdxgH6bj1Ur1M7aoiPMadLEOtbPmA7aRrvdbp+TyhEa
        UXJAPn/QPvi5s1bw4irROO49ezs+7PL3KmzLwFFeOuyJJg+xGIMx3RlY0AhCe6IOlCZr2Y
        a3gjpdpF8P0ijvAernuQICt6qLyP17I=
Date:   Fri, 18 Nov 2022 17:44:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2 11/16] x86/compressed: move startup32_load_idt() into
 .text section
Message-ID: <Y3e2ZMh5TlfuqreF@zn.tnic>
References: <20220921145422.437618-1-ardb@kernel.org>
 <20220921145422.437618-12-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220921145422.437618-12-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 21, 2022 at 04:54:17PM +0200, Ard Biesheuvel wrote:
> Convert startup32_load_idt() into an ordinary function and move it into
> the .text section. This involves turning the rva() immediates into ones
> derived from a local label, and preserving/restoring the %ebp and %ebx
> as per the calling convention.
> 
> Also move the #ifdef to the only existing call site. This makes it clear
> that the function call does nothing if support for memory encryption is
> not compiled in.

I'm not crazy about all that ifdeffery in there but this will need a
serious look.

Btw, you can drop one, diff ontop:

---
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index bc5bd639217e..a862fd8ac0bd 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -726,9 +726,7 @@ SYM_DATA_START(boot32_idt)
 	.quad 0
 	.endr
 SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
-#endif
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
 	.text
 	.code32
 /*

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
