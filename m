Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1C14836A0
	for <lists+linux-efi@lfdr.de>; Mon,  3 Jan 2022 19:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiACSLB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Jan 2022 13:11:01 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57436 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiACSLA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Jan 2022 13:11:00 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E884A210E8;
        Mon,  3 Jan 2022 18:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641233458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Op3ImOqOwCCgnIZralyZf3tGTao+t3Y622jP3bRdc3M=;
        b=C2zVimxxGBkbjHiUPECVcDKFMB2sv4FqZcW8GgohA812H99T/sYphGZEA629myHI1xwfUB
        EAkGvy3QcUL7w4mnTnl7szW5Fx/6/jwA9fnzECUU2Sma7xvOTmQrTquQlS23TiIHyoVOdi
        hXjehu5D/56NRpJ+CiRwuwIH541HAPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641233458;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Op3ImOqOwCCgnIZralyZf3tGTao+t3Y622jP3bRdc3M=;
        b=oSr9zFj9HMCbLGX5MoS/SaS6qozzC73ylXqxLdax9DGQnykLDDk2KqDo7iHeTOHc038jY8
        783kriuIq+Bu45Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7535E13B09;
        Mon,  3 Jan 2022 18:10:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UEjgGzI802FfKwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 03 Jan 2022 18:10:58 +0000
Message-ID: <91eb34b0-ff19-40a3-9744-ad80432d8317@suse.cz>
Date:   Mon, 3 Jan 2022 19:10:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>
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
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-21-brijesh.singh@amd.com> <Yc8jerEP5CrxfFi4@zn.tnic>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v8 20/40] x86/sev: Use SEV-SNP AP creation to start
 secondary CPUs
In-Reply-To: <Yc8jerEP5CrxfFi4@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/31/21 16:36, Borislav Petkov wrote:
> On Fri, Dec 10, 2021 at 09:43:12AM -0600, Brijesh Singh wrote:
>> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
>> index 123a96f7dff2..38c14601ae4a 100644
> 
>> +{
>> +	unsigned long pfn;
>> +	struct page *p;
>> +
>> +	/*
>> +	 * Allocate an SNP safe page to workaround the SNP erratum where
>> +	 * the CPU will incorrectly signal an RMP violation  #PF if a
>> +	 * hugepage (2mb or 1gb) collides with the RMP entry of VMSA page.
> 
> 		2MB or 1GB
> 
> Collides how? The 4K frame is inside the hugepage?
> 
>> +	 * The recommeded workaround is to not use the large page.
> 
> Unknown word [recommeded] in comment, suggestions:
>         ['recommended', 'recommend', 'recommitted', 'commended', 'commandeered']
> 
>> +	 *
>> +	 * Allocate one extra page, use a page which is not 2mb aligned
> 
> 2MB-aligned
> 
>> +	 * and free the other.
>> +	 */
>> +	p = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
>> +	if (!p)
>> +		return NULL;
>> +
>> +	split_page(p, 1);
>> +
>> +	pfn = page_to_pfn(p);
>> +	if (IS_ALIGNED(__pfn_to_phys(pfn), PMD_SIZE)) {
>> +		pfn++;
>> +		__free_page(p);
>> +	} else {
>> +		__free_page(pfn_to_page(pfn + 1));
>> +	}
> 
> AFAICT, this is doing all this stuff so that you can make sure you get a
> non-2M-aligned page. I wonder if there's a way to simply ask mm to give
> you such page directly.
> 
> vbabka?

AFAIK, not, as this is a very unusual constraint. Unless there are more
places that need it, should be fine to solve it like above. Maybe just also
be optimistic and try a plain order-0 first and only if it has the undesired
alignment (which should happen only once per 512 allocations), fallback to
the above?
