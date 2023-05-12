Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDEB700E5D
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 20:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbjELSE4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 14:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbjELSEo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 14:04:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB65AD06;
        Fri, 12 May 2023 11:04:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683914651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gFxNOuozAXli2+8g1C7PNYQPp9ZAqOWKvaCJaJ4AfAc=;
        b=LbHwvTDEc0hV4KAq1PUZc94tVWyRgGsAAeeXU0VmCuW3TAeKZs2uZEyLzwUfs7KS4dD38i
        wgoTZ0gz12qJirbvixaWm6i2mya+exWUqbRFt0i3/Tf1gQD9dPblbc9NTvC0Xe1aCGMexi
        BS7/VZkQmFzIJ5m36zKm8RbQWIYGqLYcL84XsZJ+d65i+DSDWSPr4o5pomszVzJd0/0UZy
        hcMpcxnoj0ioBJ8HqpZicvOhhb+2j86/n4Bc20WWyH634r6ZCt1jUTk592kO+imzmhlfXf
        SsTaJUjliki/XDWEbhkzSBFzVpkLuP2Vx9y3ZLr0tntD//WJEdHNGQVrpwEhdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683914651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gFxNOuozAXli2+8g1C7PNYQPp9ZAqOWKvaCJaJ4AfAc=;
        b=cDKb0AjjgsU6KeETTwLx/yZcsZ5RLmSVquWPcafZOE/qRkv8tzXB+St5rDZRLL9PYByy2g
        ey9n95kLHFWhEzDg==
To:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
        mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
        luto@amacapital.net, nivedita@alum.mit.edu,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 07/14] x86: Secure Launch kernel early boot stub
In-Reply-To: <20230504145023.835096-8-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-8-ross.philipson@oracle.com>
Date:   Fri, 12 May 2023 20:04:11 +0200
Message-ID: <87ednlbf50.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On Thu, May 04 2023 at 14:50, Ross Philipson wrote:
> +
> +/* CPUID: leaf 1, ECX, SMX feature bit */
> +#define X86_FEATURE_BIT_SMX	(1 << 6)
> +
> +/* Can't include apiddef.h in asm */

Why not? All it needs is a #ifndef __ASSEMBLY__ guard around the C parts.

> +#define XAPIC_ENABLE	(1 << 11)
> +#define X2APIC_ENABLE	(1 << 10)
> +
> +/* Can't include traps.h in asm */

NMI_VECTOR is defined in irq_vectors.h which just has a include
<linux/threads.h> for no real good reason.

> +#define X86_TRAP_NMI	2

<SNIP>

> +/*
> + * See the comment in head_64.S for detailed informatoin on what this macro
> + * is used for.
> + */
> +#define rva(X) ((X) - sl_stub_entry)

I'm having a hard time to find that comment in head_64.S. At least it's
not in this patch.

> +.Lsl_ap_cs:
> +	/* Load the relocated AP IDT */
[ 11 more citation lines. Click/Enter to show. ]
> +	lidt	(sl_ap_idt_desc - sl_txt_ap_wake_begin)(%ecx)
> +
> +	/* Fixup MTRRs and misc enable MSR on APs too */
> +	call	sl_txt_load_regs
> +
> +	/* Enable SMI with GETSEC[SMCTRL] */
> +	GETSEC $(SMX_X86_GETSEC_SMCTRL)
> +
> +	/* IRET-to-self can be used to enable NMIs which SENTER disabled */
> +	leal	rva(.Lnmi_enabled_ap)(%ebx), %eax
> +	pushfl
> +	pushl	$(__SL32_CS)
> +	pushl	%eax
> +	iret

So from here on any NMI which hits the AP before it can reach the wait
loop will corrupt EDX...

> +/* This is the beginning of the relocated AP wake code block */
> +	.global sl_txt_ap_wake_begin
[ 10 more citation lines. Click/Enter to show. ]
> +sl_txt_ap_wake_begin:
> +
> +	/*
> +	 * Wait for NMI IPI in the relocated AP wake block which was provided
> +	 * and protected in the memory map by the prelaunch code. Leave all
> +	 * other interrupts masked since we do not expect anything but an NMI.
> +	 */
> +	xorl	%edx, %edx
> +
> +1:
> +	hlt
> +	testl	%edx, %edx
> +	jz	1b

This really makes me nervous. A stray NMI and the AP starts going.

Can't this NMI just bring the AP out of HLT w/o changing any state and
the AP evaluates a memory location which indicates whether it should
start up or not.

> +	/*
> +	 * This is the long absolute jump to the 32b Secure Launch protected
> +	 * mode stub code in the rmpiggy. The jump address will be fixed in

Providing an actual name for the stub might spare to rummage through
code to figure out where this is supposed to jump to.

> +	 * the SMP boot code when the first AP is brought up. This whole area
> +	 * is provided and protected in the memory map by the prelaunch code.
[ 2 more citation lines. Click/Enter to show. ]
> +	 */
> +	.byte	0xea
> +sl_ap_jmp_offset:
> +	.long	0x00000000
> +	.word	__SL32_CS

Thanks,

	tglx
