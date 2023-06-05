Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA2B722DB5
	for <lists+linux-efi@lfdr.de>; Mon,  5 Jun 2023 19:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbjFERdS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Jun 2023 13:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjFERdR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Jun 2023 13:33:17 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFD199;
        Mon,  5 Jun 2023 10:33:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 676725C07C5;
        Mon,  5 Jun 2023 13:33:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 05 Jun 2023 13:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1685986389; x=
        1686072789; bh=lQSZdTgU7X1R4Qu4Ty1C2WHD8IIpt6t48B9pzCnpsEk=; b=b
        ZD4Ex4uAWnIWlU87cl1H2U2ZAqjmipUmeo0iH2/g0OuiCMBqbD2Qqj7zWNE+wWYi
        cbzDleZlwQLjdAwQZLMGb/bRdPDx/fs+xc6mhgW1Jbl96KrPM5gfzjlOQAxUD7xz
        kal93zjaf/xceFhWWzQ6QpBvqgNCWIizUV28IY11P9Lk8XHczxqeZf518nJ2P3JU
        gZu4Vk8/n+DUe7VUcEzU92g4gtepigOLmMPAhJROjkwFHspKf7OtHIFcgfsnAErh
        SRbcIEA2F5kS06NbbMNOCBs/PcOvMpe0UxjGwjPZLJBbJfr/Jfx9wMdClh+LWIeX
        IZv7WJiv8jASair300Rug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685986389; x=1686072789; bh=lQSZdTgU7X1R4
        Qu4Ty1C2WHD8IIpt6t48B9pzCnpsEk=; b=rw6EA8vvsJ+MfPCXHAh4zYG6o0S8N
        2qGHXHE3sll3WkYJwa+/w8xMDp1Ccn5QBHbQRn+DUCmvxFaLU76pFTMtZXjg0uOr
        iLiF8/z0/UEh/goTaoxFDXfVJJ/sUa+TK0hT866HZLOJwFAaPRD3epUbTO9B011R
        gY2XaFfFtK31jpnvn4ba7d0HfvtGg+22ZpEfGkuRUNVdQwTUpCOUyBv2z32C9kUm
        2k8gJfrl+rXc7GchglkPuk18wEJo+2iKGOxWkC5PLcaH+to+itX+8G4DOJfpIHqz
        x6IJCYQS/wCSltE9VbhpIFwrdXtinHPtit7eGJMyV11co582FuMn02ESg==
X-ME-Sender: <xms:VBx-ZNB0w314IbMlaE0t2F57bFarcka3s8N3w2HME2Xkl-ZZVHvJVg>
    <xme:VBx-ZLi44X4xRbq97IgqHN-ouSRJPiQy15WUKoyWCvPp44oDIeRLjRAWMwzom1nK4
    qwLeJfLuUBDpZRMBS0>
X-ME-Received: <xmr:VBx-ZIlOEaN8ynDls-a88iYTI42-DPVU5-G-ngUheK1EqLrU4wH99coLHs7lhgmTpOb6Tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelledgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnheplefghfefteelhfevffelveffgfetffefleef
    udduhfejudetgefgieehfeetheejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhl
    lhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:VBx-ZHzyHHTtMMefYvMNpOnNXCMwuWVr6bnp359eznJC7YOeKbLMZg>
    <xmx:VBx-ZCRrwsD3noh71jL_FCHD5vKqukjOZYWbadQpecmqHdFYHF1HYg>
    <xmx:VBx-ZKaSID2VY0Fd1Di0_tDoZ7hRD7NqRbOxnXFVws_5uud_RofwOQ>
    <xmx:VRx-ZDcEH9CFDT2Irpqg5RsSuW6qkVuieVB6lunoskE38WX9_6jtcQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jun 2023 13:33:07 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A186110A631; Mon,  5 Jun 2023 20:33:03 +0300 (+03)
Date:   Mon, 5 Jun 2023 20:33:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv13 5/9] efi: Add unaccepted memory support
Message-ID: <20230605173303.k5yt535snxyk4ez3@box.shutemov.name>
References: <20230601182543.19036-1-kirill.shutemov@linux.intel.com>
 <20230601182543.19036-6-kirill.shutemov@linux.intel.com>
 <20230605154333.GLZH4CpV3eXCCWCGxi@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605154333.GLZH4CpV3eXCCWCGxi@fat_crate.local>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 05, 2023 at 05:43:33PM +0200, Borislav Petkov wrote:
> On Thu, Jun 01, 2023 at 09:25:39PM +0300, Kirill A. Shutemov wrote:
> > +void accept_memory(phys_addr_t start, phys_addr_t end)
> > +{
> > +	struct efi_unaccepted_memory *unaccepted;
> > +	unsigned long range_start, range_end;
> > +	unsigned long flags;
> > +	u64 unit_size;
> > +
> > +	if (efi.unaccepted == EFI_INVALID_TABLE_ADDR)
> > +		return;
> 
> efi_get_unaccepted_table() already does this test.

Okay.

> > +	unaccepted = efi_get_unaccepted_table();
> > +	if (!unaccepted)
> > +		return;
> 
> So this looks weird: callers can call accept_memory() and that function
> can fail. But they can't know whether it failed or not because it
> returns void.

It is not a failure here. If there's no unaccepted memory in the system
accept_memory() always succeeds.

> > +	unit_size = unaccepted->unit_size;
> > +
> > +	/*
> > +	 * Only care for the part of the range that is represented
> > +	 * in the bitmap.
> > +	 */
> > +	if (start < unaccepted->phys_base)
> > +		start = unaccepted->phys_base;
> 
> So this silently trims start...
> 
> > +	if (end < unaccepted->phys_base)
> > +		return;
> 
> But fails only when end is outside of range.
> 
> I'd warn here at least. And return an error so that the callers know.

There's nothing to warn about. The range (or part of it) is not
represented in the bitmap because it is not unaccepted. We only allocate
bitmap for the range that has unaccepted memory. It can reduce memory
overhead on the bitmap if the unaccepted memory starts very high or ends
early, but there's something else very high in physical addresss space.

> > +	/* Translate to offsets from the beginning of the bitmap */
> > +	start -= unaccepted->phys_base;
> > +	end -= unaccepted->phys_base;
> > +
> > +	/* Make sure not to overrun the bitmap */
> > +	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
> > +		end = unaccepted->size * unit_size * BITS_PER_BYTE;
> 
> How is all that trimming not important to the caller?
> 
> It would assume that its memory got accepted but not really.

See above: not represented in the bitmap means pre-accepted.

...

> > +	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> > +	while (start < end) {
> > +		if (test_bit(start / unit_size, unaccepted->bitmap)) {
> > +			ret = true;
> > +			break;
> 
> I have a faint memory we've had this before but you need to check
> *every* bit in the unaccepted bitmap before returning true. Doh.

Yes, it was discussed before. Here's context:

https://lore.kernel.org/all/Ynt8vDY78/YeXO99@zn.tnic

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
