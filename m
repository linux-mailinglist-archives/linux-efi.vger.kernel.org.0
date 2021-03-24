Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108E8347E4B
	for <lists+linux-efi@lfdr.de>; Wed, 24 Mar 2021 17:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhCXQzh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 Mar 2021 12:55:37 -0400
Received: from foss.arm.com ([217.140.110.172]:36442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236624AbhCXQza (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 24 Mar 2021 12:55:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89B40D6E;
        Wed, 24 Mar 2021 09:55:28 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 336FE3F7D7;
        Wed, 24 Mar 2021 09:55:26 -0700 (PDT)
Date:   Wed, 24 Mar 2021 16:55:19 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     will@kernel.org, catalin.marinas@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Subject: Re: [PATCH v9 1/7] smccc: Add HVC call variant with result registers
 other than 0 thru 3
Message-ID: <20210324165519.GA24528@C02TD0UTHF1T.local>
References: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
 <1615233439-23346-2-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615233439-23346-2-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Michael,

On Mon, Mar 08, 2021 at 11:57:13AM -0800, Michael Kelley wrote:
> Hypercalls to Hyper-V on ARM64 may return results in registers other
> than X0 thru X3, as permitted by the SMCCC spec version 1.2 and later.
> Accommodate this by adding a variant of arm_smccc_1_1_hvc that allows
> the caller to specify which 3 registers are returned in addition to X0.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
> There are several ways to support returning results from registers
> other than X0 thru X3, and Hyper-V usage should be compatible with
> whatever the maintainers prefer.  What's implemented in this patch
> may be the most flexible, but it has the downside of not being a
> true function interface in that args 0 thru 2 must be fixed strings,
> and not general "C" expressions.

For the benefit of others here, SMCCCv1.2 allows:

* SMC64/HVC64 to use all of x1-x17 for both parameters and return values
* SMC32/HVC32 to use all of r1-r7 for both parameters and return values

The rationale for this was to make it possible to pass a large number of
arguments in one call without the hypervisor/firmware needing to access
the memory of the caller.

My preference would be to add arm_smccc_1_2_{hvc,smc}() assembly
functions which read all the permitted argument registers from a struct,
and write all the permitted result registers to a struct, leaving it to
callers to set those up and decompose them.

That way we only have to write one implementation that all callers can
use, which'll be far easier to maintain. I suspect that in general the
cost of temporarily bouncing the values through memory will be dominated
by whatever the hypervisor/firmware is going to do, and if it's not we
can optimize that away in future.

> Other alternatives include:
> * Create a variant that hard codes to return X5 thru X7, though
>   in the future there may be Hyper-V hypercalls that need a
>   different hard-coded variant.
> * Return all of X0 thru X7 in a larger result structure. That
>   approach may execute more memory stores, but performance is unlikely
>   to be an issue for the Hyper-V hypercalls that would use it.
>   However, it's possible in the future that Hyper-V results might
>   be beyond X7, as allowed by the SMCCC v1.3 spec.

As above, something of this sort would be my preferred approach.

Thanks,
Mark.

> * The macro __arm_smccc_1_1() could be cloned in Hyper-V specific
>   code and modified to meet Hyper-V specific needs, but this seems
>   undesirable since Hyper-V is operating within the v1.2 spec.
> 
> In any of these cases, the call might be renamed from "_1_1_" to
> "_1_2_" to reflect conformance to the later spec version.
> 
> 
>  include/linux/arm-smccc.h | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index f860645..acda958 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -300,12 +300,12 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
>   * entitled to optimise the whole sequence away. "volatile" is what
>   * makes it stick.
>   */
> -#define __arm_smccc_1_1(inst, ...)					\
> +#define __arm_smccc_1_1(inst, reg1, reg2, reg3, ...)			\
>  	do {								\
>  		register unsigned long r0 asm("r0");			\
> -		register unsigned long r1 asm("r1");			\
> -		register unsigned long r2 asm("r2");			\
> -		register unsigned long r3 asm("r3"); 			\
> +		register unsigned long r1 asm(reg1);			\
> +		register unsigned long r2 asm(reg2);			\
> +		register unsigned long r3 asm(reg3);			\
>  		__declare_args(__count_args(__VA_ARGS__), __VA_ARGS__);	\
>  		asm volatile(inst "\n" :				\
>  			     "=r" (r0), "=r" (r1), "=r" (r2), "=r" (r3)	\
> @@ -328,7 +328,8 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
>   * to the SMC instruction. The return values are updated with the content
>   * from register 0 to 3 on return from the SMC instruction if not NULL.
>   */
> -#define arm_smccc_1_1_smc(...)	__arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
> +#define arm_smccc_1_1_smc(...)\
> +	__arm_smccc_1_1(SMCCC_SMC_INST, "r1", "r2", "r3", __VA_ARGS__)
>  
>  /*
>   * arm_smccc_1_1_hvc() - make an SMCCC v1.1 compliant HVC call
> @@ -344,7 +345,23 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
>   * to the HVC instruction. The return values are updated with the content
>   * from register 0 to 3 on return from the HVC instruction if not NULL.
>   */
> -#define arm_smccc_1_1_hvc(...)	__arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
> +#define arm_smccc_1_1_hvc(...) \
> +	__arm_smccc_1_1(SMCCC_HVC_INST, "r1", "r2", "r3", __VA_ARGS__)
> +
> +/*
> + * arm_smccc_1_1_hvc_reg() - make an SMCCC v1.1 compliant HVC call
> + * specifying output registers
> + *
> + * This is a variant of arm_smccc_1_1_hvc() that allows specifying
> + * three registers from which result values will be returned in
> + * addition to r0.
> + *
> + * @a0-a2: register specifications for 3 return registers (e.g., "r5")
> + * @a3-a10: arguments passed in registers 0 to 7
> + * @res: result values from register 0 and the three registers specified
> + * in a0-a2.
> + */
> +#define arm_smccc_1_1_hvc_reg(...) __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
>  
>  /*
>   * Like arm_smccc_1_1* but always returns SMCCC_RET_NOT_SUPPORTED.
> -- 
> 1.8.3.1
> 
