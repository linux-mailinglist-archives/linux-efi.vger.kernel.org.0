Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 552B2E7D25
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2019 00:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfJ1Xmi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Oct 2019 19:42:38 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34783 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfJ1Xmi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 28 Oct 2019 19:42:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 472B8n2r5Nz9sPT;
        Tue, 29 Oct 2019 10:42:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1572306153;
        bh=zM9aG91VYCIzqsK3fq3CpiFSFcyS/yCl9U34kBR9aKw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Zacx0/8bXcg8sPp6+Ng1v5UyQ8KpygDaig8MLEjvgywnCoQ+G+aHX9jxWyuIodIz8
         HJCWxp4jnFFNzuZqsojXmhLN1F1BKsLa9Fh1Nf8valLJZ6f7ZhCAg+qI4/EkCtgdRQ
         1k81BercgHnWGujjMgTJr6w2+64y5b9INeZ6q43Z8Gz6pPK+0KX1uSxBg+dflEIZBo
         agl5374DzJXd4RfLr7zyBeYvzSaGurPG76Kncd52kXOIKRl4DHSVWJVoxbYEh7Iz7R
         CiFmds3M8JWQJq7Z6gOSyHrt7kIfmZRMUwrdbM+jNE8nr7A/4/9Uff/iqT1dpUSNhq
         zG/OKMl+0qOwA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: Re: [PATCH v9 2/8] powerpc/ima: add support to initialize ima policy rules
In-Reply-To: <482b2f08-f810-6ed0-4b32-0d5e64246ece@linux.microsoft.com>
References: <20191024034717.70552-1-nayna@linux.ibm.com> <20191024034717.70552-3-nayna@linux.ibm.com> <dd7e04fc-25e8-280f-b565-bdb031939655@linux.microsoft.com> <27dbe08e-5473-4dd0-d2ad-2df591e23f5e@linux.vnet.ibm.com> <482b2f08-f810-6ed0-4b32-0d5e64246ece@linux.microsoft.com>
Date:   Tue, 29 Oct 2019 10:42:32 +1100
Message-ID: <87lft4h1xz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Lakshmi,

Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> On 10/25/2019 10:02 AM, Nayna Jain wrote:
>
>  >> Is there any way to not use conditional compilation in
>  >> the above array definition? Maybe define different functions to get
>  >> "secure_rules" for when CONFIG_MODULE_SIG_FORCE is defined and when
>  >> it is not defined.
>  >
>  > How will you decide which function to be called ?
>
> Define the array in the C file:
>
> const char *const secure_rules_kernel_check[] = {
>     "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
>     NULL
> };
>
> const char *const secure_rules_kernel_module_check[] = {
>     "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
>     "appraise func=MODULE_CHECK appraise_type=imasig|modsig",
>     NULL
> };
>
> And, in the header file :

But there's no reason for any of this to be in a header, it's all
contained in one file.

Moving things into a header purely to avoid a single #ifdef in a C file
is a backward step.

> extern const char *const secure_rules_kernel_check;
> extern const char *const secure_rules_kernel_module_check;
>
> #ifdef CONFIG_MODULE_SIG_FORCE
> const char *secure_rules() { return secure_rules_kernel_check; }
> #else
> const char *secure_rules() { return secure_rules_kernel_module_check;}
> #endif // #ifdef CONFIG_MODULE_SIG_FORCE
>
> If you want to avoid duplication, secure_rules_kernel_check and 
> secure_rules_kernel_module_check could be defined in separate C files 
> and conditionally compiled (in Makefile).

Again that's just lots of added complication for no real benefit.

> I was just trying to suggest the guidelines given in
> "Section 21) Conditional Compilation" in coding-style.rst.
>
> It says:
> Whenever possible don't use preprocessor conditionals (#ifdef, #if) in 
> .c files;...

The key phrase being "guideline" :)

That suggestion is aimed at avoiding code with lots of ifdefs sprinkled
through the body of functions. Code written in that way can be very hard
to read because you have to mentally pre-process it first, and then read
the C-level logic. See below for an example.

Moving the pre-processing out of line into helpers means when you're
reading the function you can just reason about the C control flow.

The reference to ".c files" is really talking about moving logic that is
#ifdef'ed into static inline helpers. Those typically go in headers, but
they don't have to if there's no other reason for them to be in a
header.

So where the code is all in one C file it would be completely fine to
have an #ifdef in the C file around a static inline helper.

But in this case where the #ifdef is just in an array I think it's
entirely fine to just keep the #ifdef. Its presence there doesn't
complicate the logic in anyway.

cheers



This is a "good" (bad) example of what we're trying to avoid:

static long ppc_set_hwdebug(struct task_struct *child,
		     struct ppc_hw_breakpoint *bp_info)
{
#ifdef CONFIG_HAVE_HW_BREAKPOINT
	int len = 0;
	struct thread_struct *thread = &(child->thread);
	struct perf_event *bp;
	struct perf_event_attr attr;
#endif /* CONFIG_HAVE_HW_BREAKPOINT */
#ifndef CONFIG_PPC_ADV_DEBUG_REGS
	struct arch_hw_breakpoint brk;
#endif

	if (bp_info->version != 1)
		return -ENOTSUPP;
#ifdef CONFIG_PPC_ADV_DEBUG_REGS
	/*
	 * Check for invalid flags and combinations
	 */
	if ((bp_info->trigger_type == 0) ||
	    (bp_info->trigger_type & ~(PPC_BREAKPOINT_TRIGGER_EXECUTE |
				       PPC_BREAKPOINT_TRIGGER_RW)) ||
	    (bp_info->addr_mode & ~PPC_BREAKPOINT_MODE_MASK) ||
	    (bp_info->condition_mode &
	     ~(PPC_BREAKPOINT_CONDITION_MODE |
	       PPC_BREAKPOINT_CONDITION_BE_ALL)))
		return -EINVAL;
#if CONFIG_PPC_ADV_DEBUG_DVCS == 0
	if (bp_info->condition_mode != PPC_BREAKPOINT_CONDITION_NONE)
		return -EINVAL;
#endif

	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_EXECUTE) {
		if ((bp_info->trigger_type != PPC_BREAKPOINT_TRIGGER_EXECUTE) ||
		    (bp_info->condition_mode != PPC_BREAKPOINT_CONDITION_NONE))
			return -EINVAL;
		return set_instruction_bp(child, bp_info);
	}
	if (bp_info->addr_mode == PPC_BREAKPOINT_MODE_EXACT)
		return set_dac(child, bp_info);

#ifdef CONFIG_PPC_ADV_DEBUG_DAC_RANGE
	return set_dac_range(child, bp_info);
#else
	return -EINVAL;
#endif
#else /* !CONFIG_PPC_ADV_DEBUG_DVCS */
	/*
	 * We only support one data breakpoint
	 */
	if ((bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_RW) == 0 ||
	    (bp_info->trigger_type & ~PPC_BREAKPOINT_TRIGGER_RW) != 0 ||
	    bp_info->condition_mode != PPC_BREAKPOINT_CONDITION_NONE)
		return -EINVAL;

	if ((unsigned long)bp_info->addr >= TASK_SIZE)
		return -EIO;

	brk.address = bp_info->addr & ~7UL;
	brk.type = HW_BRK_TYPE_TRANSLATE;
	brk.len = 8;
	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
		brk.type |= HW_BRK_TYPE_READ;
	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
		brk.type |= HW_BRK_TYPE_WRITE;
#ifdef CONFIG_HAVE_HW_BREAKPOINT
	/*
	 * Check if the request is for 'range' breakpoints. We can
	 * support it if range < 8 bytes.
	 */
	if (bp_info->addr_mode == PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE)
		len = bp_info->addr2 - bp_info->addr;
	else if (bp_info->addr_mode == PPC_BREAKPOINT_MODE_EXACT)
		len = 1;
	else
		return -EINVAL;
	bp = thread->ptrace_bps[0];
	if (bp)
		return -ENOSPC;

	/* Create a new breakpoint request if one doesn't exist already */
	hw_breakpoint_init(&attr);
	attr.bp_addr = (unsigned long)bp_info->addr & ~HW_BREAKPOINT_ALIGN;
	attr.bp_len = len;
	arch_bp_generic_fields(brk.type, &attr.bp_type);

	thread->ptrace_bps[0] = bp = register_user_hw_breakpoint(&attr,
					       ptrace_triggered, NULL, child);
	if (IS_ERR(bp)) {
		thread->ptrace_bps[0] = NULL;
		return PTR_ERR(bp);
	}

	return 1;
#endif /* CONFIG_HAVE_HW_BREAKPOINT */

	if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT)
		return -EINVAL;

	if (child->thread.hw_brk.address)
		return -ENOSPC;

	if (!ppc_breakpoint_available())
		return -ENODEV;

	child->thread.hw_brk = brk;

	return 1;
#endif /* !CONFIG_PPC_ADV_DEBUG_DVCS */
}

