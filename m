Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79EB5F6507
	for <lists+linux-efi@lfdr.de>; Thu,  6 Oct 2022 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJFLOD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Oct 2022 07:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJFLNy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Oct 2022 07:13:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9448D10B7;
        Thu,  6 Oct 2022 04:13:53 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e732329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e732:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3AA481EC0409;
        Thu,  6 Oct 2022 13:13:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665054828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=okIIDtMox7za1/6DOQ1iRZehRlXMXl+Mt82R2yuiF9A=;
        b=hD22CKpJ0U1ZI76fh0TEtoRWfz4/yIiaSixCIEOpFPmGDO4c10CdqUplMJhrNDaOsxNUwX
        XYnWwKYupZhpWZXPaqyYdlfHO4NxJw1TN6DTE+rVp/sAyxdjGtyVmC2BGyJJXr3mO3Hukf
        gAzGAvMcXgk3rlaWrM9wq7fKr2ME7lQ=
Date:   Thu, 6 Oct 2022 13:13:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2 02/16] x86/compressed: efi-mixed: move 32-bit
 entrypoint code into .text section
Message-ID: <Yz64aMVo4W+D70Fz@zn.tnic>
References: <20220921145422.437618-1-ardb@kernel.org>
 <20220921145422.437618-3-ardb@kernel.org>
 <Yz6xBROUBPyaUSoB@zn.tnic>
 <CAMj1kXGCWmay_=cncZpZwXoyLgzt7=2dVuXHaaQU=K6NEXrezQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGCWmay_=cncZpZwXoyLgzt7=2dVuXHaaQU=K6NEXrezQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 06, 2022 at 12:56:09PM +0200, Ard Biesheuvel wrote:
> efi32_pe_entry() preserves and restores the caller's value of %ebx,
> because from there, we might actually return control to the firmware.
> The value it keeps in %ebx itself is not live when it jumps to
> efi32_entry - it stores its value into image_offset, which is reloaded
> from memory at a later point.

Hmm, might be prudent to have a comment there because it is using %ebx a
couple of insns before the JMP:

        subl    %esi, %ebx
		      ^^^^
        movl    %ebx, rva(image_offset)(%ebp)   // save image_offset

<--- I think you mean that after this, %ebx is not needed anymore?

        xorl    %esi, %esi
        jmp     efi32_entry

2:      popl    %edi                            // restore callee-save registers
        popl    %ebx

and this restores its original value ofc.

> efi32_stub_entry() is the 'EFI handover protocol' entry point, which
> cannot return to the firmware (and we discard the return address
> already) so %ebx can be clobbered.

That info would be good to have in a comment above it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
