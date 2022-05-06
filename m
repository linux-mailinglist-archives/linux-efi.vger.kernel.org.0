Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBB851CE77
	for <lists+linux-efi@lfdr.de>; Fri,  6 May 2022 04:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387714AbiEFA45 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 May 2022 20:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387709AbiEFA44 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 May 2022 20:56:56 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C6C5DE7E
        for <linux-efi@vger.kernel.org>; Thu,  5 May 2022 17:53:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bu29so10198149lfb.0
        for <linux-efi@vger.kernel.org>; Thu, 05 May 2022 17:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C5GPnJUVP3BtQbsY0hrSBcmaxNZOUF97hX/9OQsx+nA=;
        b=nLZPkQ5PVl8ydEQfOubz8On/1Fq63lQN6lh/vZ5Aegg+xPA34KIVO26IrV87jX5wPe
         8M10ylUu9YV8TQM8HP2/8undJLvbVcL1/dVTkVcECHb9CzEEqKq07m14/HgnXxA7Njia
         YFD9HYkWHYF6sWGhtvKCPmH/IStLKZu+wd185XNNJDESn6HYZEa+2g+/xT6nMw6+t8/g
         39BKxahY18nOyAdMZrhMfCYQLCIMFGLV4qB/FupV+3jv+iDHAqrfEb52qkY/VpnQPsI8
         KTvsIBhr+lDuXx6BCqyiYijMMAKSx6DWRCL3X9YV0fdlAgTdw+PmU7XeCeBdqNxsFuvW
         hzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C5GPnJUVP3BtQbsY0hrSBcmaxNZOUF97hX/9OQsx+nA=;
        b=maqVeyZON3wj+K9KzT28p5QTlppEhQmT5dWy2DgOMwVCq6jzVZJsCLrCCu3Vs3Cfol
         yURkkvdkArq1Kw8sTfDahh1mjgxZs0VtoGUbrdWM8lQ/fUTOrVMPwWdzxrl2HvCOQYgv
         gNXeo/uUhSDvoPqvAyoJ5FfVlYD9jLz/8VGD9Qs62u0TgjEmq7mxoLDOB3XmQZMItgTY
         K1FL4fVKdZ+nrGlRCRlvvoaxy3ZaMWm9yFUtowFFsMGCzZjHgVs+45QtdFTYBCdzEmsZ
         JF3yJyskKMArb8Nkv4Yr9lZjFR1Nxe2SlHIuHr2wCXwIrElkYDdeqF0td8rNkdC/Q/jF
         MogA==
X-Gm-Message-State: AOAM531ITe+8rljzb1+RC4RVhGV/QIhllVjwt4Uz4ANfaK5Cu8AhM+pi
        iTJCx1ZItxKyq4fZX1/utTwFdA==
X-Google-Smtp-Source: ABdhPJxBGAyRzcf0ZNYdABhMRx6y2moZzNV7QFboqJg1pD4XhwD22Dkio7DKSmS7KcErp6zO6RaPpQ==
X-Received: by 2002:a05:6512:3b87:b0:473:9e36:5f0d with SMTP id g7-20020a0565123b8700b004739e365f0dmr715960lfv.424.1651798393878;
        Thu, 05 May 2022 17:53:13 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c33-20020a05651223a100b0047255d21113sm443339lfv.66.2022.05.05.17.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 17:53:13 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A1C92104AF0; Fri,  6 May 2022 03:54:58 +0300 (+03)
Date:   Fri, 6 May 2022 03:54:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv5 02/12] mm: Add support for unaccepted memory
Message-ID: <20220506005458.jrebaho2w55ojwyb@box.shutemov.name>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-3-kirill.shutemov@linux.intel.com>
 <2bb92a84-18f4-d007-9465-fdc19f6f1c86@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bb92a84-18f4-d007-9465-fdc19f6f1c86@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, May 03, 2022 at 10:21:03PM +0200, David Hildenbrand wrote:
> 
> >  
> > +/*
> > + * Page acceptance can be very slow. Do not call under critical locks.
> > + */
> > +static void accept_page(struct page *page, unsigned int order)
> > +{
> > +	phys_addr_t start = page_to_phys(page);
> > +	int i;
> > +
> > +	accept_memory(start, start + (PAGE_SIZE << order));
> > +
> > +	for (i = 0; i < (1 << order); i++) {
> > +		if (PageUnaccepted(page + i))
> > +			__ClearPageUnaccepted(page + i);
> > +	}
> > +}
> 
> What was the rationale of leaving PageUnaccepted() set on sub-pages when
> merging pages?
> 
> I'd just clear the flag when merging and avoid the loop here. You could
> even assert here that we don't have any PageUnaccepted() on tail pages.

Okay, fair enough. I will change the code.

-- 
 Kirill A. Shutemov
