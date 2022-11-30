Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC40A63CCD2
	for <lists+linux-efi@lfdr.de>; Wed, 30 Nov 2022 02:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiK3B2v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Nov 2022 20:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiK3B2t (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Nov 2022 20:28:49 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A73F5F46;
        Tue, 29 Nov 2022 17:28:48 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EA4765C0095;
        Tue, 29 Nov 2022 20:28:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 29 Nov 2022 20:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1669771724; x=1669858124; bh=N3
        PhtsYK5SSpRrnjY3chFLqAm0o6zorAXR4hySwwKpU=; b=rdL3sbh9Z+Gu6G6+xq
        Uk8Jrg76SkC24pupDzOkg3w4h7iV0y3m98HRrliySxdtKfeFfmxhWeLLlMtQKaxt
        VvjiRqUcgUj3od4l5HVR0VxkSFRJ/q7aebkYjm7SFmgZN4uJwYeLZOCVtXOxhmbg
        LbsnN+TjJUNU/vOoLIJffxVd52VydTHtv98F3kLMClETo/dITSLPQuh7GISrKCmv
        2SqmSv+YwP5vvNLHgTlR90GylsTLb1sPA5ttHZilIbnGBCu5xSndoYtLEfBPDtQh
        ia2Sfp4s9SblGeOfjTvVtirAYPamyzdWYRzJ8OWTncg7SSMEMAYH0WJUguQRElBP
        nNbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669771724; x=1669858124; bh=N3PhtsYK5SSpRrnjY3chFLqAm0o6
        zorAXR4hySwwKpU=; b=Nelvuy4D1HjsnimfhXJhbyrSXUjm5UPHrBdOi2vwjEc7
        3b2nQFrE5iQmzzVOLlYIbJjQ6lsZjZn5F9XGBLXIzrorV1iAVYMfyLRxg3y9wuzh
        LNj+RpiFLctbQ73AzV7R1jDH7tvh72AJJQ2aKsxfIPDjJiR5HH/JwYWB5NjpTwrN
        3ZkO56oGzAg/Ef+J2KZzyE/xErAqJsBwYTMtR+vnnGpwwHRnKZpvI6VzLa9ePBn7
        auVy7ubpmlnvWN5ARgNDgDJLb9TQ6RCYVdJEqdHaujVFwlv11YLep2JanRAbbeAR
        11NyWs7pxBAl6JOjtBVa8VvFnPkNkwaNwhv8/DO++Q==
X-ME-Sender: <xms:y7GGY5-UwwseLUpT0vPpA9efaGHXoQtmgslY4RZZ_i5PqGSaMR6LJA>
    <xme:y7GGY9s9V-Yay_jEmlDd9q6YLL-qYfrzIGOSGcFwYUVSAs_EJbz4_10h5hrlhGmbJ
    IVmEq86rbakl3nXs5E>
X-ME-Received: <xmr:y7GGY3Bw_FuuNYJXrA1HnDc8MeSyy03cCD4RWuIkrkCuF73R5h8XXWpqK236XC8cXOxn7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtddvgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:y7GGY9frowOXW7U99Y7r4wSpkGie6Mu5rf_tPriDGfDSsUF5pEF7VQ>
    <xmx:y7GGY-NYJuvy2LyOMwRjnH6pXJwxk3L9nP8pREDcLBGQlg7HSGiHSA>
    <xmx:y7GGY_lmWt_7Tg29nDaXIUZzCBHnph8KgsJnDqZqOiLMn9Og3MV4JQ>
    <xmx:zLGGY63X34_fvabCJB7CldtJXLPLO-uC6Rz7ZEiQou11zj9g-we4wg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Nov 2022 20:28:43 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 73174103BF4; Wed, 30 Nov 2022 04:28:40 +0300 (+03)
Date:   Wed, 30 Nov 2022 04:28:40 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv7 08/14] x86/mm: Reserve unaccepted memory bitmap
Message-ID: <20221130012840.sf4rvddzc4ev7bj5@box.shutemov.name>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-9-kirill.shutemov@linux.intel.com>
 <Yt+uwhfA57WBrozb@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt+uwhfA57WBrozb@zn.tnic>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 26, 2022 at 11:07:14AM +0200, Borislav Petkov wrote:
> On Tue, Jun 14, 2022 at 03:02:25PM +0300, Kirill A. Shutemov wrote:
> > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > index f267205f2d5a..22d1fe48dcba 100644
> > --- a/arch/x86/kernel/e820.c
> > +++ b/arch/x86/kernel/e820.c
> > @@ -1316,6 +1316,16 @@ void __init e820__memblock_setup(void)
> >  	int i;
> >  	u64 end;
> >  
> > +	/* Mark unaccepted memory bitmap reserved */
> > +	if (boot_params.unaccepted_memory) {
> > +		unsigned long size;
> > +
> > +		/* One bit per 2MB */
> > +		size = DIV_ROUND_UP(e820__end_of_ram_pfn() * PAGE_SIZE,
> > +				    PMD_SIZE * BITS_PER_BYTE);
> > +		memblock_reserve(boot_params.unaccepted_memory, size);
> > +	}
> > +
> 
> Hmm, I don't like how this is dropped right in the middle of a unrelated
> function.
> 
> You're adding arch/x86/mm/unaccepted_memory.c later. Why don't you put
> that chunk in a function there which is called by early_reserve_memory()
> which does exactly what you want - reserve memory early, before memblock
> allocations?

early_reserve_memory() specifically called before e820__memory_setup()
(see comment in setup_arch()), so we don't have e820_table finalized and
we need it to get correct RAM size from e820__end_of_ram_pfn().

I guess we can hide the chunk in a function in unaccepted_memory.c and
call it from here, but it would require #ifdeffery in a header file as the
.c is only compiled for CONFIG_UNACCEPTED_MEMORY=y.

Looks like an overkill to me, no?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
