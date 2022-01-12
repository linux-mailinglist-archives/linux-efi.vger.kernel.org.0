Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A76848CC38
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 20:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350184AbiALToa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jan 2022 14:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344788AbiALTmv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Jan 2022 14:42:51 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2D5C034004
        for <linux-efi@vger.kernel.org>; Wed, 12 Jan 2022 11:42:41 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u13so11746200lff.12
        for <linux-efi@vger.kernel.org>; Wed, 12 Jan 2022 11:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cOQ/xWPl3tvthX8wOW9afvSYF1hlxSg5dmQKz7cg1rA=;
        b=EknpayJrAOCN1/MkEc37OWKDriaMtq0JwDs0lNvkfqcB7uPcXUaSrno1DUCY9OQCJj
         JeBtJgxRTF/jm9kwWgcun5p1maV/PEb/wz5Awq2uCeJZK63eBeszBuPCsS3NMGCIMOQ5
         0UfBseExvdfhvW7o52YW5I5LI1D+lUI0kClR9eu3xdjjdfDkrUYi3EI9ZQRCXGpgdxLG
         FJgY+bVhKg5nntLrbcy+o2p4gLba5TtUVb08puKdTBNXTH9HcjLpLA7Yk1AnMRiyOLE1
         RCZfkJ/ZZtuUGDAwd74tJrw53H8VOQOlaMLuFTMRd9Xfi9f3xpfgQxYQTNxCp/2sxGRs
         KPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cOQ/xWPl3tvthX8wOW9afvSYF1hlxSg5dmQKz7cg1rA=;
        b=6CIIf8ceU2gyVaokM8Otk0wg9Lt6tCPzzIMk8htvCW/oM1JIyD4wMp1uleRj8BrcLk
         yMyeaztE8maR14c0i+2hwDx0WpOr9aE/Wvroih77qPmRB+gd2FXD4BIPRlFUbJl3lH8Y
         74BZ+wRcmeyP5PT2zUVLF87BC+75uNtRnB8ACoMrCosfFUs+pd+3W3SjRf96/Zv79dZs
         5qNySMRn7UKvz7I7Zy7DCkI0TIU94UqKyZhqHGlHmjsjB7ok5FXrOfcKqNDYFpnEkcKJ
         YpdzUZXGH7B0IB+1kPiTNNca8zwiGTgOWF+NemE2rJUWDadK9MrFSHcXSVmoeUHAYA+I
         9Xag==
X-Gm-Message-State: AOAM531QhqxuUvzVeLr4xOOMnB0P3om2CKSOUtumGDBGM7wfXQse0BfE
        bBKFFflddJa2pcuxVjSNwnQwTA==
X-Google-Smtp-Source: ABdhPJwTHrcLUKfFze3EfLRUMqmC0B1PnsBiDjZJKmSvB3k+WBc7vCS4TK6ASfyh26UvG0jZ0nk5QQ==
X-Received: by 2002:a05:6512:b9e:: with SMTP id b30mr864164lfv.23.1642016559895;
        Wed, 12 Jan 2022 11:42:39 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x39sm75833lfa.14.2022.01.12.11.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 11:42:39 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id C858B103A6D; Wed, 12 Jan 2022 22:43:02 +0300 (+03)
Date:   Wed, 12 Jan 2022 22:43:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
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
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 5/7] x86/mm: Reserve unaccepted memory bitmap
Message-ID: <20220112194302.cyxhjypsptr4mtix@box.shutemov.name>
References: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
 <20220111113314.27173-6-kirill.shutemov@linux.intel.com>
 <3a361a1d-0e14-8884-c5bb-90aeb87e38ef@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a361a1d-0e14-8884-c5bb-90aeb87e38ef@intel.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 11, 2022 at 11:10:40AM -0800, Dave Hansen wrote:
> On 1/11/22 03:33, Kirill A. Shutemov wrote:
> > Unaccepted memory bitmap is allocated during decompression stage and
> > handed over to main kernel image via boot_params. The bitmap is used to
> > track if memory has been accepted.
> > 
> > Reserve unaccepted memory bitmap has to prevent reallocating memory for
> > other means.
> 
> I'm having a hard time parsing that changelog, especially the second
> paragraph.  Could you give it another shot?

What about this:

	Unaccepted memory bitmap is allocated during decompression stage and
	handed over to main kernel image via boot_params.

	Kernel tracks what memory has been accepted in the bitmap.

	Reserve memory where the bitmap is placed to prevent memblock from
	re-allocating the memory for other needs.

?

> > +	/* Mark unaccepted memory bitmap reserved */
> > +	if (boot_params.unaccepted_memory) {
> > +		unsigned long size;
> > +
> > +		/* One bit per 2MB */
> > +		size = DIV_ROUND_UP(e820__end_of_ram_pfn() * PAGE_SIZE,
> > +				    PMD_SIZE * BITS_PER_BYTE);
> > +		memblock_reserve(boot_params.unaccepted_memory, size);
> > +	}
> 
> Is it OK that the size of the bitmap is inferred from
> e820__end_of_ram_pfn()?  Is this OK in the presence of mem= and other things
> that muck with the e820?

Good question. I think we are fine. If kernel is not able to allocate
memory from a part of physical address space we don't need the bitmap for
it either.

-- 
 Kirill A. Shutemov
