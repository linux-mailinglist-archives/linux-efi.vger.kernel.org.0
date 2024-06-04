Return-Path: <linux-efi+bounces-1141-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 992A18FBD0C
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 22:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CCD1F25EC7
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 20:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC46F14B941;
	Tue,  4 Jun 2024 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJGAjhvB"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91C61350FD;
	Tue,  4 Jun 2024 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531542; cv=none; b=tqCLvsGX9yNPmpCJBzfFpbfgQxc4nEAlSQ1WHozygnHU0FP7Nid6u7xkjqnQA6I9zDKUrf9u7iDkUS+T4PAJagz3hjEVarKUHQ53KWHq/z/wstNov72/KgLYlKToWUTgsE7K5jAbME4SZ0V4eBTWVg5NJLTKN9Q0QjF0TGol/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531542; c=relaxed/simple;
	bh=QLqs9WHSOcHHhkgiaiakjAA0F6yNAaoAq+qiyxzHWdI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eMykEQLDjfAoPDLals97pDAAnuJyl42iKhs/PGDROvdFTIxmzJ65Zc4whRncLctlCBD/KT6BwxGFqoC/QEwKt57A3blZXPKXdWLAweJhi0E8IU53AFM+pnjupsEJtwPm8V04/uN3j4AL0w3L0J5L9UJwTlJGAutXfbB4tDJkTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJGAjhvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2A3C2BBFC;
	Tue,  4 Jun 2024 20:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531542;
	bh=QLqs9WHSOcHHhkgiaiakjAA0F6yNAaoAq+qiyxzHWdI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=MJGAjhvB+Xghx5Zt1mN7lrbKgKYJzpdLiUP3UIYJTEVSzjDezPhUgxLfWeM+XSlxy
	 d7xQl557WklPewcEGbPNvc68StJMzAdeLB89n0HTzoaPD+GB/rb+s5orzTYSRNvGX1
	 yYcNKwEAATao/C0+n7oqXcoW3CWefkgZPjiljdFbdpaeTqy7jwriWyqJaMRbMTgDm7
	 KRWPAr66+yOe8gDXKFHlz/pBlEKCQ6zUDpaPeKCi3mxboYTq03gu77u9XALv//oi4T
	 e5ceTYkB2tAVYKVDc+Nr2tmfgufFvl0B1pSoRxoLagUhZ6UswqK5DT2uCJG+eY7vFR
	 yVdi8y//tvCKg==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 23:05:34 +0300
Message-Id: <D1RI46IG5GSA.17H7M0DIQGRQ0@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 10/19] x86: Secure Launch SMP bringup support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-11-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-11-ross.philipson@oracle.com>

On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> On Intel, the APs are left in a well documented state after TXT performs
> the late launch. Specifically they cannot have #INIT asserted on them so
> a standard startup via INIT/SIPI/SIPI cannot be performed. Instead the
> early SL stub code uses MONITOR and MWAIT to park the APs. The realmode/i=
nit.c
> code updates the jump address for the waiting APs with the location of th=
e
> Secure Launch entry point in the RM piggy after it is loaded and fixed up=
.
> As the APs are woken up by writing the monitor, the APs jump to the Secur=
e
> Launch entry point in the RM piggy which mimics what the real mode code w=
ould
> do then jumps to the standard RM piggy protected mode entry point.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/include/asm/realmode.h      |  3 ++
>  arch/x86/kernel/smpboot.c            | 58 +++++++++++++++++++++++++++-
>  arch/x86/realmode/init.c             |  3 ++
>  arch/x86/realmode/rm/header.S        |  3 ++
>  arch/x86/realmode/rm/trampoline_64.S | 32 +++++++++++++++
>  5 files changed, 97 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realm=
ode.h
> index 87e5482acd0d..339b48e2543d 100644
> --- a/arch/x86/include/asm/realmode.h
> +++ b/arch/x86/include/asm/realmode.h
> @@ -38,6 +38,9 @@ struct real_mode_header {
>  #ifdef CONFIG_X86_64
>  	u32	machine_real_restart_seg;
>  #endif
> +#ifdef CONFIG_SECURE_LAUNCH
> +	u32	sl_trampoline_start32;
> +#endif
>  };
> =20
>  /* This must match data at realmode/rm/trampoline_{32,64}.S */
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 0c35207320cb..adb521221d6c 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -60,6 +60,7 @@
>  #include <linux/stackprotector.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/mc146818rtc.h>
> +#include <linux/slaunch.h>
> =20
>  #include <asm/acpi.h>
>  #include <asm/cacheinfo.h>
> @@ -868,6 +869,56 @@ int common_cpu_up(unsigned int cpu, struct task_stru=
ct *idle)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_SECURE_LAUNCH
> +
> +static bool slaunch_is_txt_launch(void)
> +{
> +	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) =3D=3D
> +	    (SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT))
> +		return true;
> +
> +	return false;
> +}

static inline bool slaunch_is_txt_launch(void)
{
	u32 mask =3D  SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT;

	return slaunch_get_flags() & mask =3D=3D mask;
}


> +
> +/*
> + * TXT AP startup is quite different than normal. The APs cannot have #I=
NIT
> + * asserted on them or receive SIPIs. The early Secure Launch code has p=
arked
> + * the APs using monitor/mwait. This will wake the APs by writing the mo=
nitor
> + * and have them jump to the protected mode code in the rmpiggy where th=
e rest
> + * of the SMP boot of the AP will proceed normally.
> + */
> +static void slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
> +{
> +	struct sl_ap_wake_info *ap_wake_info;
> +	struct sl_ap_stack_and_monitor *stack_monitor =3D NULL;

struct sl_ap_stack_and_monitor *stack_monitor; /* note: no initialization *=
/
struct sl_ap_wake_info *ap_wake_info;


> +
> +	ap_wake_info =3D slaunch_get_ap_wake_info();
> +
> +	stack_monitor =3D (struct sl_ap_stack_and_monitor *)__va(ap_wake_info->=
ap_wake_block +
> +							       ap_wake_info->ap_stacks_offset);
> +
> +	for (unsigned int i =3D TXT_MAX_CPUS - 1; i >=3D 0; i--) {
> +		if (stack_monitor[i].apicid =3D=3D apicid) {
> +			/* Write the monitor */

I'd remove this comment.

> +			stack_monitor[i].monitor =3D 1;
> +			break;
> +		}
> +	}
> +}
> +
> +#else
> +
> +static inline bool slaunch_is_txt_launch(void)
> +{
> +	return false;
> +}
> +
> +static inline void slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
> +{
> +}
> +
> +#endif  /* !CONFIG_SECURE_LAUNCH */
> +
>  /*
>   * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
>   * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
> @@ -877,7 +928,7 @@ int common_cpu_up(unsigned int cpu, struct task_struc=
t *idle)
>  static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
>  {
>  	unsigned long start_ip =3D real_mode_header->trampoline_start;
> -	int ret;
> +	int ret =3D 0;
> =20
>  #ifdef CONFIG_X86_64
>  	/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
> @@ -922,12 +973,15 @@ static int do_boot_cpu(u32 apicid, int cpu, struct =
task_struct *idle)
> =20
>  	/*
>  	 * Wake up a CPU in difference cases:
> +	 * - Intel TXT DRTM launch uses its own method to wake the APs
>  	 * - Use a method from the APIC driver if one defined, with wakeup
>  	 *   straight to 64-bit mode preferred over wakeup to RM.
>  	 * Otherwise,
>  	 * - Use an INIT boot APIC message
>  	 */
> -	if (apic->wakeup_secondary_cpu_64)
> +	if (slaunch_is_txt_launch())
> +		slaunch_wakeup_cpu_from_txt(cpu, apicid);
> +	else if (apic->wakeup_secondary_cpu_64)
>  		ret =3D apic->wakeup_secondary_cpu_64(apicid, start_ip);
>  	else if (apic->wakeup_secondary_cpu)
>  		ret =3D apic->wakeup_secondary_cpu(apicid, start_ip);
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index f9bc444a3064..d95776cb30d3 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -4,6 +4,7 @@
>  #include <linux/memblock.h>
>  #include <linux/cc_platform.h>
>  #include <linux/pgtable.h>
> +#include <linux/slaunch.h>
> =20
>  #include <asm/set_memory.h>
>  #include <asm/realmode.h>
> @@ -210,6 +211,8 @@ void __init init_real_mode(void)
> =20
>  	setup_real_mode();
>  	set_real_mode_permissions();
> +
> +	slaunch_fixup_jump_vector();
>  }
> =20
>  static int __init do_init_real_mode(void)
> diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.=
S
> index 2eb62be6d256..3b5cbcbbfc90 100644
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
> index 14d9c7daf90f..b0ce6205d7ea 100644
> --- a/arch/x86/realmode/rm/trampoline_64.S
> +++ b/arch/x86/realmode/rm/trampoline_64.S
> @@ -122,6 +122,38 @@ SYM_CODE_END(sev_es_trampoline_start)
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
> +	LOCK_AND_LOAD_REALMODE_ESP lock_pa=3D1
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

BR, Jarkko

