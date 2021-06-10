Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0303A331E
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jun 2021 20:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFJSc4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Jun 2021 14:32:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44002 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhFJSc4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 10 Jun 2021 14:32:56 -0400
Received: from zn.tnic (p200300ec2f0cf6005d9c12d1298a6408.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:f600:5d9c:12d1:298a:6408])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B2B5F1EC047D;
        Thu, 10 Jun 2021 20:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623349858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=P0fqhRcl57YROYpdd2weFfboDPACqF8I33taAeG4/KY=;
        b=Ct9WjQAnUgQWR9PfmielTJ80rQZ4pldOlL7WwwWixhXcnVScDF2tp9OC4GgyKWS1iyaODx
        7lvOh1XdD/3IiyresJ3SD+96lU8PSKuXw2Mat9I5vEBpa++l/OFeR2602sCf1FLk2HTLC8
        OYazZTmMnP2zATmWRGpvsqRQorWrI6g=
Date:   Thu, 10 Jun 2021 20:30:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org,
        Thomas.Lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        brijesh.singh@amd.com, linux-efi@vger.kernel.org
Subject: Re: [PATCH v3 3/5] mm: x86: Invoke hypercall when page encryption
 status is changed
Message-ID: <YMJaXGoVMzyR/cP6@zn.tnic>
References: <cover.1623174621.git.ashish.kalra@amd.com>
 <41f3cc3be60571ebe4d5c6d51f1ed27f32afd58c.1623174621.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41f3cc3be60571ebe4d5c6d51f1ed27f32afd58c.1623174621.git.ashish.kalra@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 08, 2021 at 06:06:26PM +0000, Ashish Kalra wrote:
> +void notify_range_enc_status_changed(unsigned long vaddr, int npages,
> +				    bool enc)

You don't need to break this line.

> @@ -285,12 +333,13 @@ static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
>  static int __init early_set_memory_enc_dec(unsigned long vaddr,
>  					   unsigned long size, bool enc)
>  {
> -	unsigned long vaddr_end, vaddr_next;
> +	unsigned long vaddr_end, vaddr_next, start;
>  	unsigned long psize, pmask;
>  	int split_page_size_mask;
>  	int level, ret;
>  	pte_t *kpte;
>  
> +	start = vaddr;
>  	vaddr_next = vaddr;
>  	vaddr_end = vaddr + size;
>  
> @@ -345,6 +394,8 @@ static int __init early_set_memory_enc_dec(unsigned long vaddr,
>  
>  	ret = 0;
>  
> +	notify_range_enc_status_changed(start, PAGE_ALIGN(size) >> PAGE_SHIFT,
> +					enc);

Ditto.

>  out:
>  	__flush_tlb_all();
>  	return ret;
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 156cd235659f..9729cb0d99e3 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2020,6 +2020,13 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
>  	 */
>  	cpa_flush(&cpa, 0);
>  
> +	/*
> +	 * Notify hypervisor that a given memory range is mapped encrypted
> +	 * or decrypted. The hypervisor will use this information during the
> +	 * VM migration.
> +	 */

Simplify that comment:

        /*
         * Notify the hypervisor about the encryption status change of the memory
	 * range. It will use this information during the VM migration.
         */


With those nitpicks fixed:

Reviewed-by: Borislav Petkov <bp@suse.de>

Paulo, if you want me to take this, lemme know, but I think it'll
conflict with patch 5 so perhaps it all should go together through the
kvm tree...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
