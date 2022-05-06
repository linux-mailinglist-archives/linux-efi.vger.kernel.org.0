Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741AE51DD4F
	for <lists+linux-efi@lfdr.de>; Fri,  6 May 2022 18:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443798AbiEFQRR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 May 2022 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443669AbiEFQRK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 May 2022 12:17:10 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6971A6E8E7
        for <linux-efi@vger.kernel.org>; Fri,  6 May 2022 09:12:15 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id t25so9827779ljd.6
        for <linux-efi@vger.kernel.org>; Fri, 06 May 2022 09:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3LVCF+EC61p3SRHqy5+HBfYg8g8sBVA6E2RSjLMm3ic=;
        b=71gELqa8e3JZdAR40f88qYRAendRWwJy32RDkq6jbbgAR1oFpqUnUAh7JDtx9eVM4b
         hXnwylvyfzfwO1l5pR5a8tj6McjLg1BgMlPCXYajEuS9KSDUdhDD4IEadqjiXDqkc5MN
         jgRnaEFuE4vFyEl8fmIM9iQXW9RSsk/YvT+UGEyx56ucVrRD6B9KQ/k3MQeUHryYIjuD
         6HSmA9SD2cmqfM/Rtv+U/n0Ew972cSEgHdE7tNtlrRWpD4u3DVdtKECy53If23SgbnzR
         xej7+9vB9kXXhnte6xgRsD1WPNIKMmy+MI5P0vF2w3FABpNop43zQpwmMAvrts8IUo6u
         Ay6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3LVCF+EC61p3SRHqy5+HBfYg8g8sBVA6E2RSjLMm3ic=;
        b=DCcKbroLrTLB++KVNUj6r/V+EGpLPrHIxVwPSLKDhfcUtWvQcObaiZYwZEZ7lJYt9E
         PoMu6r6Syw1xisef7MHFjT8T35ce66TBg0hygcA6n6p1xjYNCqTH2KT7e9SpCeopjUL+
         k4EuJrQ63dtoIiGaprQRTF/XpyIm7aVfDcfsgh0BdxhW1W2TJ1lemBfZ56FFlsYiRPuE
         EYTOWZ6Wi2XxRE8w0IIjjfu+5O6rLxUlR5U1ICUAeQqqlyxMxQJuYX7EfcbRLQtuigl8
         DMjDJKIepsfjKRrFcueoMGUYHfU85mJJtIxYZ40JuMIpJHZeLchWj5YssBb6nJO+BRi8
         gkVA==
X-Gm-Message-State: AOAM532zs4xiirhYNvwjhd7/N6woLUp3JWaOqH7RfnMuTFgbXlwOEPP1
        s2TK8hct/WnY99lWe91QhWKmoA==
X-Google-Smtp-Source: ABdhPJxcoFt3N3AtHGRW62qNedg2H/hvHQ56BxLep0ct05gnPOlLMPFLw3EGV7t5IJpESnjqgxaHQQ==
X-Received: by 2002:a2e:b6c6:0:b0:24f:3919:5923 with SMTP id m6-20020a2eb6c6000000b0024f39195923mr2365023ljo.398.1651853533664;
        Fri, 06 May 2022 09:12:13 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v17-20020a2e9611000000b0024f3d1daed9sm680999ljh.97.2022.05.06.09.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 09:12:13 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 27825104AFD; Fri,  6 May 2022 19:13:59 +0300 (+03)
Date:   Fri, 6 May 2022 19:13:59 +0300
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 08/12] x86/mm: Provide helpers for unaccepted memory
Message-ID: <20220506161359.4j5j5fxrw53fdbyr@box.shutemov.name>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-9-kirill.shutemov@linux.intel.com>
 <YnJfhiiHn+48H2vb@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnJfhiiHn+48H2vb@zn.tnic>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 04, 2022 at 01:12:06PM +0200, Borislav Petkov wrote:
> On Mon, Apr 25, 2022 at 06:39:30AM +0300, Kirill A. Shutemov wrote:
> > +	unaccepted_memory = __va(boot_params.unaccepted_memory);
> > +	range_start = start / PMD_SIZE;
> > +
> > +	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> > +	for_each_set_bitrange_from(range_start, range_end, unaccepted_memory,
> > +				   DIV_ROUND_UP(end, PMD_SIZE)) {
> > +		unsigned long len = range_end - range_start;
> > +
> > +		/* Platform-specific memory-acceptance call goes here */
> > +		panic("Cannot accept memory");
> 
> Yeah, no, WARN_ON_ONCE() pls.

Failure to accept the memory is fatal. Why pretend it is not?

For TDX it will result in a crash on the first access. Prolonging the
suffering just make it harder to understand what happened.

> > +	unsigned long flags;
> > +	bool ret = false;
> > +
> > +	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> > +	while (start < end) {
> > +		if (test_bit(start / PMD_SIZE, unaccepted_memory)) {
> > +			ret = true;
> 
> Wait, what?
> 
> That thing is lying: it'll return true for *some* PMD which is accepted
> but not the whole range of [start, end].

That's true. Note also that the check is inherently racy. Other CPU can
get the range or subrange accepted just after spin_unlock().

The check indicates that accept_memory() has to be called on the range
before first access.

Do you have problem with a name? Maybe has_unaccepted_memory()?

-- 
 Kirill A. Shutemov
