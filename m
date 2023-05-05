Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5452C6F883B
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 19:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjEERz7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 13:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjEERzt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 13:55:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2031F496;
        Fri,  5 May 2023 10:55:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 268AC635D0;
        Fri,  5 May 2023 17:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4700C433D2;
        Fri,  5 May 2023 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683309290;
        bh=iGxlMMfHq5zekP1cLLlA597ifNT3g2z8NHymFlQCd4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwja6AwnW4smOMGRvawHd98VsnoIFBSK6V0Q7CWqwqpW+qLg4TnkjoEXb5RTczp2T
         H07bIqfn8yxspOmufiM8hf7fNhnsOdCexce9/d/ezR8WycIYoieyrINfU54O74/CF8
         BkTMvbNq2yJFNqMqCs71QXMf7i7+w3t+L20j8nrckRfVZ/KwKnjDEXJ5oY4B5cqTnv
         Lsk1y/8yD+JH/9r19Orhvb8pvG1Io1rOzioDerHmQfbQhl0TZ9VEstOquq01RaGDPp
         nhSu9KZwx8NAF+ojYagr0e1ZZ5hoboZprPhyn+OeFJ0qg0HkwHdgVtIRLdu9NvEQek
         uq9EJ14iow/xQ==
Date:   Fri, 5 May 2023 19:54:44 +0200
From:   Simon Horman <horms@kernel.org>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 09/14] x86: Secure Launch SMP bringup support
Message-ID: <ZFVC5Fv0wO0Awt0N@kernel.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-10-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-10-ross.philipson@oracle.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 04, 2023 at 02:50:18PM +0000, Ross Philipson wrote:
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

Hi Ross,

just one minor nit on this one.

>  /*
>   * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
>   * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
> @@ -1132,6 +1210,13 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>  	cpumask_clear_cpu(cpu, cpu_initialized_mask);
>  	smp_mb();
>  
> +	/* With Intel TXT, the AP startup is totally different */
> +	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) ==

nit: spaces around '|'

> +	   (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) {
> +		boot_error = slaunch_wakeup_cpu_from_txt(cpu, apicid);
> +		goto txt_wake;
> +	}
