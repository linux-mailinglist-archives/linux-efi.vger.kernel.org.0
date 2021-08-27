Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE573F9AB6
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 16:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245267AbhH0OPc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 10:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241260AbhH0OPb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Aug 2021 10:15:31 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132D3C061757;
        Fri, 27 Aug 2021 07:14:43 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1117006e0d6268a9fc7b3e.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1700:6e0d:6268:a9fc:7b3e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2FD8E1EC0493;
        Fri, 27 Aug 2021 16:14:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630073677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3hBv70kaJ7xEYPUSElnsV+8ktxYO20ij25UtBpP2GHs=;
        b=RvUnxtHP5ZBZ7z5DJaIp60qjgWYo4OZEBia83SzIl3zY4GMzFkUSp0X8fXVP4csuFG9OL7
        cwZQf9i50aJTbvYkf29NQruKb+VvUU37WJVWvPmbdC1X59BTOfEV0O0yIhxB0pnKNH23+N
        bxOk1W2hd7hfH8IjKvYrjLnoIREET4E=
Date:   Fri, 27 Aug 2021 16:15:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 30/38] x86/compressed/64: store Confidential
 Computing blob address in bootparams
Message-ID: <YSjzcgQDubOY1pGI@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-31-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820151933.22401-31-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:25AM -0500, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> When the Confidential Computing blob is located by the boot/compressed
> kernel, store a pointer to it in bootparams->cc_blob_address to avoid
> the need for the run-time kernel to rescan the EFI config table to find
> it again.
> 
> Since this function is also shared by the run-time kernel, this patch

Here's "this patch" again... but you know what to do.

> also adds the logic to make use of bootparams->cc_blob_address when it
> has been initialized.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/sev-shared.c | 40 ++++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 651980ddbd65..6f70ba293c5e 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -868,7 +868,6 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
>  	return ES_OK;
>  }
>  
> -#ifdef BOOT_COMPRESSED
>  static struct setup_data *get_cc_setup_data(struct boot_params *bp)
>  {
>  	struct setup_data *hdr = (struct setup_data *)bp->hdr.setup_data;
> @@ -888,6 +887,16 @@ static struct setup_data *get_cc_setup_data(struct boot_params *bp)
>   *   1) Search for CC blob in the following order/precedence:
>   *      - via linux boot protocol / setup_data entry
>   *      - via EFI configuration table
> + *   2) If found, initialize boot_params->cc_blob_address to point to the
> + *      blob so that uncompressed kernel can easily access it during very
> + *      early boot without the need to re-parse EFI config table
> + *   3) Return a pointer to the CC blob, NULL otherwise.
> + *
> + * For run-time/uncompressed kernel:
> + *
> + *   1) Search for CC blob in the following order/precedence:
> + *      - via linux boot protocol / setup_data entry

Why would you do this again if the boot/compressed kernel has already
searched for it?

> + *      - via boot_params->cc_blob_address

Yes, that is the only thing you need to do in the runtime kernel - see
if cc_blob_address is not 0. And all the work has been done by the
decompressor kernel already.

>   *   2) Return a pointer to the CC blob, NULL otherwise.
>   */
>  static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
> @@ -897,9 +906,11 @@ static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
>  		struct setup_data header;
>  		u32 cc_blob_address;
>  	} *sd;
> +#ifdef __BOOT_COMPRESSED
>  	unsigned long conf_table_pa;
>  	unsigned int conf_table_len;
>  	bool efi_64;
> +#endif

That function turns into an unreadable mess with that #ifdef
__BOOT_COMPRESSED slapped everywhere.

It seems the cleanest thing to do is to do what we do with
acpi_rsdp_addr: do all the parsing in boot/compressed/ and pass it on
through boot_params. Kernel proper simply reads the pointer.

Which means, you can stick all that cc_blob figuring out functionality
in arch/x86/boot/compressed/sev.c instead.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
