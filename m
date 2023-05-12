Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B63B700E5A
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 20:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbjELSD5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 14:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbjELSDz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 14:03:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31F330F0;
        Fri, 12 May 2023 11:03:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683914574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7fvD2GdqOQNGxWui4lgM0lmaDQ5NzqVVPg5OJ46+K8=;
        b=TMd9YWufj4C4apzXCv73MfS74eNHfpwEzirL39R43AEm4JtQ/rZDmZjBcGVu5Ow4Vrqt0e
        NJdEiZcLMr9bq0ibxtc6k+wtKEVmlqrg4UskEvfS1+mdOAjN8wVz6VbmRJ7uRp3ww9u94k
        kBJ6qvtlf0a3Rs783+AOemGAGRPDryYG2hSg+lxbWOugs4+iQrSuhzxYE+er0YAcfLaI/9
        OemvWNTAPZ2+E8/J526Lqg73bmUENRUpAnH+7HHgytx37HLehdL9V9uu2ARuZ3tacUT1M1
        ebyw2jpt/ycGLwGs6c1fwMQ+K9YhsWyjqSAh+KVcD236nVYYQ72+k6LQEMb5ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683914574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7fvD2GdqOQNGxWui4lgM0lmaDQ5NzqVVPg5OJ46+K8=;
        b=BZpOsxtvuF9Uu+TyQ/KB7ss5HC4P0Yz6Ag1UfGx/W9nQkzEswHiifo6E0TaXFFhUpgdJ3Y
        9IRce0wATfBqCDCA==
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
Subject: Re: [PATCH v6 09/14] x86: Secure Launch SMP bringup support
In-Reply-To: <20230504145023.835096-10-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-10-ross.philipson@oracle.com>
Date:   Fri, 12 May 2023 20:02:53 +0200
Message-ID: <87h6shbf76.ffs@tglx>
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
>  
> +#ifdef CONFIG_SECURE_LAUNCH
> +
> +static atomic_t first_ap_only = {1};

ATOMIC_INIT(1) if at all.

> +
> +/*
> + * Called to fix the long jump address for the waiting APs to vector to
> + * the correct startup location in the Secure Launch stub in the rmpiggy.
> + */
> +static int
> +slaunch_fixup_jump_vector(void)

One line please.

> +{
> +	struct sl_ap_wake_info *ap_wake_info;
> +	u32 *ap_jmp_ptr = NULL;
> +
> +	if (!atomic_dec_and_test(&first_ap_only))
> +		return 0;

Why does this need an atomic? CPU bringup is fully serialized and even
with the upcoming parallel bootup work, there is no concurrency on this
function.

Aside of that. Why isn't this initialized during boot in a __init function?

> +	ap_wake_info = slaunch_get_ap_wake_info();
> +
> +	ap_jmp_ptr = (u32 *)__va(ap_wake_info->ap_wake_block +
> +				 ap_wake_info->ap_jmp_offset);
> +
> +	*ap_jmp_ptr = real_mode_header->sl_trampoline_start32;
> +
> +	pr_debug("TXT AP long jump address updated\n");
> +
> +	return 0;

Why does this need a return code of all return paths return 0?

> +}
> +
> +/*
> + * TXT AP startup is quite different than normal. The APs cannot have #INIT
> + * asserted on them or receive SIPIs. The early Secure Launch code has parked
> + * the APs in a pause loop waiting to receive an NMI. This will wake the APs
> + * and have them jump to the protected mode code in the rmpiggy where the rest
> + * of the SMP boot of the AP will proceed normally.
> + */
> +static int
> +slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
> +{
> +	unsigned long send_status = 0, accept_status = 0;
> +
> +	/* Only done once */

Yes. But not here.

> +	if (slaunch_fixup_jump_vector())
> +		return -1;
> +
> +	/* Send NMI IPI to idling AP and wake it up */
> +	apic_icr_write(APIC_DM_NMI, apicid);
> +
> +	if (init_udelay == 0)
> +		udelay(10);
> +	else
> +		udelay(300);

The wonders of copy & pasta. This condition is pointless because this
code only runs on systems which force init_udelay to 0.

> +	send_status = safe_apic_wait_icr_idle();

Moar copy & pasta. As this is guaranteed to be X2APIC mode, this
function is a nop and returns 0 unconditionally.

> +	if (init_udelay == 0)
> +		udelay(10);
> +	else
> +		udelay(300);
> +
> +	accept_status = (apic_read(APIC_ESR) & 0xEF);

The point of this is? Bit 0-3 are Pentium and P6 only.

Bit 4 Tried to send low prio IPI but not supported
Bit 5 Illegal Vector sent
Bit 6 Illegal Vector received
Bit 7 X2APIC illegal register access

IOW, there is no accept error here. That would be bit 2 which is never set
on anything modern

But aside of that the read is moot anyway because the CPU has the APIC
error vector enabled so if this would happen the APIC error interrupt
would have swallowed and cleared the error condition.

IOW. Everything except the apic_icr_write() here is completely useless.

> +#else
> +
> +#define slaunch_wakeup_cpu_from_txt(cpu, apicid)	0

inline stub please. 

> +
> +#endif  /* !CONFIG_SECURE_LAUNCH */
> +
>  /*
>   * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
>   * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
> @@ -1132,6 +1210,13 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>  	cpumask_clear_cpu(cpu, cpu_initialized_mask);
>  	smp_mb();
>  
> +	/* With Intel TXT, the AP startup is totally different */
> +	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) ==
> +	   (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) {

Stick this condition into a helper function please

> +		boot_error = slaunch_wakeup_cpu_from_txt(cpu, apicid);
> +		goto txt_wake;
> +	}
> +
>  	/*
>  	 * Wake up a CPU in difference cases:
>  	 * - Use a method from the APIC driver if one defined, with wakeup
> @@ -1147,6 +1232,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>  		boot_error = wakeup_cpu_via_init_nmi(cpu, start_ip, apicid,
>  						     cpu0_nmi_registered);
>  
> +txt_wake:

Sorry, but what has this to do with TXT ? And why can't the above just
be yet another if clause in the existing if/else if maze?

Now that brings me to another question. How is this supposed to work
with CPU hotplug post boot?

It will simply not work at all because once a CPU is offlined it is
going to sit in an endless loop and wait for INIT/SIPI/SIPI. So it will
get that NMI and go back to wait.

So you need a TXT specific cpu_play_dead() implementation, which should
preferrably use monitor/mwait where each "offline" CPU sits and waits
until a condition becomes true. Then you don't need a NMI for wakeup at
all. Just writing the condition into that per CPU cache line should be
enough.

Thanks,

        tglx

