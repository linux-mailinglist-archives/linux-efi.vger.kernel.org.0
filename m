Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B606FE7B8
	for <lists+linux-efi@lfdr.de>; Thu, 11 May 2023 00:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbjEJWzq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 May 2023 18:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjEJWzp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 10 May 2023 18:55:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B2535AE;
        Wed, 10 May 2023 15:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D10760F72;
        Wed, 10 May 2023 22:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB92C4339B;
        Wed, 10 May 2023 22:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683759336;
        bh=CDgu2O3o+dnDHiRpEYgrb9cYoQ7pkoAOCNXyrg0YN3I=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=FMTBOrto5u3AWnFPfw1R6nHm9n9/GmNSTY5pLBbQjqlk5MXbsAOGW/oGg73tW6oGG
         0h957BmY+LIaeAtLSqt/FgB57lK++Zgr+4667E+3uyJlDkHI7RxQh/W6b8CEbTfIta
         i7JCar9lXqm34XeShwjD1FQDInsIMD9TsMTMfbGoSwSUqkSiw9qfYBka0M0khMVK0I
         pBJAn82liuqoq/qlUM///LxM8ty2bXz/+DsW/hMFJIxff9Hq26DuvBqRhEJHTWpbEe
         WlrqnRy7JAvmUcwK+u9oWHGklsv6k880xmwY7e4cxZRHy9rPXdR9rL2PIEM02vCujG
         Tva+QA/llFzFA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 11 May 2023 01:55:30 +0300
Message-Id: <CSIYV9UAFYWZ.3KMD32LKER5NS@suppilovahvero>
Cc:     <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
        <James.Bottomley@hansenpartnership.com>, <luto@amacapital.net>,
        <nivedita@alum.mit.edu>, <kanth.ghatraju@oracle.com>,
        <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v6 09/14] x86: Secure Launch SMP bringup support
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Ross Philipson" <ross.philipson@oracle.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-10-ross.philipson@oracle.com>
In-Reply-To: <20230504145023.835096-10-ross.philipson@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu May 4, 2023 at 5:50 PM EEST, Ross Philipson wrote:
> On Intel, the APs are left in a well documented state after TXT performs
> the late launch. Specifically they cannot have #INIT asserted on them so
> a standard startup via INIT/SIPI/SIPI cannot be performed. Instead the
> early SL stub code parked the APs in a pause/jmp loop waiting for an NMI.
> The modified SMP boot code is called for the Secure Launch case. The
> jump address for the RM piggy entry point is fixed up in the jump where
> the APs are waiting and an NMI IPI is sent to the AP. The AP vectors to
> the Secure Launch entry point in the RM piggy which mimics what the real
> mode code would do then jumps to the standard RM piggy protected mode
> entry point.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/include/asm/realmode.h      |  3 ++
>  arch/x86/kernel/smpboot.c            | 86 ++++++++++++++++++++++++++++++=
++++++
>  arch/x86/realmode/rm/header.S        |  3 ++
>  arch/x86/realmode/rm/trampoline_64.S | 37 ++++++++++++++++
>  4 files changed, 129 insertions(+)
>
> diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realm=
ode.h
> index f6a1737..576fe62 100644
> --- a/arch/x86/include/asm/realmode.h
> +++ b/arch/x86/include/asm/realmode.h
> @@ -38,6 +38,9 @@ struct real_mode_header {
>  #ifdef CONFIG_X86_64
>  	u32	machine_real_restart_seg;
>  #endif
> +#ifdef CONFIG_SECURE_LAUNCH
> +	u32	sl_trampoline_start32;
> +#endif

Cool I was implementing this relocatable realmode blob back in 2012 :-)

>  };
> =20
>  /* This must match data at realmode/rm/trampoline_{32,64}.S */
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 352f0ce..07d740be 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -57,6 +57,7 @@
>  #include <linux/pgtable.h>
>  #include <linux/overflow.h>
>  #include <linux/stackprotector.h>
> +#include <linux/slaunch.h>
> =20
>  #include <asm/acpi.h>
>  #include <asm/cacheinfo.h>
> @@ -1068,6 +1069,83 @@ int common_cpu_up(unsigned int cpu, struct task_st=
ruct *idle)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_SECURE_LAUNCH
> +
> +static atomic_t first_ap_only =3D {1};

This should be documented.

> +
> +/*
> + * Called to fix the long jump address for the waiting APs to vector to
> + * the correct startup location in the Secure Launch stub in the rmpiggy=
.
> + */
> +static int
> +slaunch_fixup_jump_vector(void)

Please put the same line.

> +{
> +	struct sl_ap_wake_info *ap_wake_info;
> +	u32 *ap_jmp_ptr =3D NULL;
> +
> +	if (!atomic_dec_and_test(&first_ap_only))
> +		return 0;
> +
> +	ap_wake_info =3D slaunch_get_ap_wake_info();
> +
> +	ap_jmp_ptr =3D (u32 *)__va(ap_wake_info->ap_wake_block +
> +				 ap_wake_info->ap_jmp_offset);
> +
> +	*ap_jmp_ptr =3D real_mode_header->sl_trampoline_start32;
> +
> +	pr_debug("TXT AP long jump address updated\n");
> +
> +	return 0;
> +}
> +
> +/*
> + * TXT AP startup is quite different than normal. The APs cannot have #I=
NIT
> + * asserted on them or receive SIPIs. The early Secure Launch code has p=
arked
> + * the APs in a pause loop waiting to receive an NMI. This will wake the=
 APs
> + * and have them jump to the protected mode code in the rmpiggy where th=
e rest
> + * of the SMP boot of the AP will proceed normally.
> + */
> +static int
> +slaunch_wakeup_cpu_from_txt(int cpu, int apicid)

Ditto.


> +{
> +	unsigned long send_status =3D 0, accept_status =3D 0;

I would put these to separate lines. Maybe a matter of taste but
it is easier to spot initializations.

> +
> +	/* Only done once */
> +	if (slaunch_fixup_jump_vector())
> +		return -1;
> +
> +	/* Send NMI IPI to idling AP and wake it up */
> +	apic_icr_write(APIC_DM_NMI, apicid);
> +
> +	if (init_udelay =3D=3D 0)
> +		udelay(10);
> +	else
> +		udelay(300);
> +
> +	send_status =3D safe_apic_wait_icr_idle();
> +
> +	if (init_udelay =3D=3D 0)
> +		udelay(10);
> +	else
> +		udelay(300);

Magic numbers and no inline comment.

> +
> +	accept_status =3D (apic_read(APIC_ESR) & 0xEF);
> +
> +	if (send_status)
> +		pr_err("Secure Launch IPI never delivered???\n");
> +	if (accept_status)
> +		pr_err("Secure Launch IPI delivery error (%lx)\n",
> +			accept_status);
> +
> +	return (send_status | accept_status);
> +}
> +
> +#else
> +
> +#define slaunch_wakeup_cpu_from_txt(cpu, apicid)	0
> +
> +#endif  /* !CONFIG_SECURE_LAUNCH */
> +
>  /*
>   * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
>   * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
> @@ -1132,6 +1210,13 @@ static int do_boot_cpu(int apicid, int cpu, struct=
 task_struct *idle,
>  	cpumask_clear_cpu(cpu, cpu_initialized_mask);
>  	smp_mb();
> =20
> +	/* With Intel TXT, the AP startup is totally different */
> +	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) =3D=3D
> +	   (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) {
> +		boot_error =3D slaunch_wakeup_cpu_from_txt(cpu, apicid);
> +		goto txt_wake;
> +	}
> +
>  	/*
>  	 * Wake up a CPU in difference cases:
>  	 * - Use a method from the APIC driver if one defined, with wakeup
> @@ -1147,6 +1232,7 @@ static int do_boot_cpu(int apicid, int cpu, struct =
task_struct *idle,
>  		boot_error =3D wakeup_cpu_via_init_nmi(cpu, start_ip, apicid,
>  						     cpu0_nmi_registered);
> =20
> +txt_wake:
>  	if (!boot_error) {
>  		/*
>  		 * Wait 10s total for first sign of life from AP
> diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.=
S
> index 2eb62be..3b5cbcb 100644
> --- a/arch/x86/realmode/rm/header.S
> +++ b/arch/x86/realmode/rm/header.S
> @@ -37,6 +37,9 @@ SYM_DATA_START(real_mode_header)
>  #ifdef CONFIG_X86_64
>  	.long	__KERNEL32_CS
>  #endif
> +#ifdef CONFIG_SECURE_LAUNCH
> +	.long	pa_sl_trampoline_start32
> +#endif
>  SYM_DATA_END(real_mode_header)
> =20
>  	/* End signature, used to verify integrity */
> diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/=
trampoline_64.S
> index e38d61d..8bb4b0d 100644
> --- a/arch/x86/realmode/rm/trampoline_64.S
> +++ b/arch/x86/realmode/rm/trampoline_64.S
> @@ -104,6 +104,43 @@ SYM_CODE_END(sev_es_trampoline_start)
> =20
>  	.section ".text32","ax"
>  	.code32
> +#ifdef CONFIG_SECURE_LAUNCH
> +	.balign 4
> +SYM_CODE_START(sl_trampoline_start32)
> +	/*
> +	 * The early secure launch stub AP wakeup code has taken care of all
> +	 * the vagaries of launching out of TXT. This bit just mimics what the
> +	 * 16b entry code does and jumps off to the real startup_32.
> +	 */
> +	cli
> +	wbinvd
> +
> +	/*
> +	 * The %ebx provided is not terribly useful since it is the physical
> +	 * address of tb_trampoline_start and not the base of the image.
> +	 * Use pa_real_mode_base, which is fixed up, to get a run time
> +	 * base register to use for offsets to location that do not have
> +	 * pa_ symbols.
> +	 */
> +	movl    $pa_real_mode_base, %ebx
> +
> +	/*
> +	 * This may seem a little odd but this is what %esp would have had in
> +	 * it on the jmp from real mode because all real mode fixups were done
> +	 * via the code segment. The base is added at the 32b entry.
> +	 */
> +	movl	rm_stack_end, %esp
> +
> +	lgdt    tr_gdt(%ebx)
> +	lidt    tr_idt(%ebx)
> +
> +	movw	$__KERNEL_DS, %dx	# Data segment descriptor
> +
> +	/* Jump to where the 16b code would have jumped */
> +	ljmpl	$__KERNEL32_CS, $pa_startup_32
> +SYM_CODE_END(sl_trampoline_start32)
> +#endif
> +
>  	.balign 4
>  SYM_CODE_START(startup_32)
>  	movl	%edx, %ss
> --=20
> 1.8.3.1


The trampoline_64.S changes look reasonable to me (with a quick look).

BR, Jarkko
