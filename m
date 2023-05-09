Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76B16FBC33
	for <lists+linux-efi@lfdr.de>; Tue,  9 May 2023 02:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjEIA4p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 May 2023 20:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEIA4o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 May 2023 20:56:44 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032673A84;
        Mon,  8 May 2023 17:56:42 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B99285C01AA;
        Mon,  8 May 2023 20:56:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 08 May 2023 20:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1683593799; x=
        1683680199; bh=R0MvdCJrAGQ3Lx601BQioOuJmlf2hwwfSdhcLcNWO5Q=; b=s
        EeEvU6yL9KcddveYTaG4jW49jAptZTFLlcgGM7rB5S79PZlLO/WT5o7kriEpPZzd
        jNxN9wQGt4jmdJV68b/Q05Oo2SOo3FR7UPK1aDOvrKntXqbxZK0lDqMESF3/usWx
        jOUFx5Po71d1NncnScZ4Ej9IICFrbIHIS1kDZfGs3NfC+fBLjFMr7MTyZJfaUzUg
        rnoA0HdA4znpZ+OCutRFCblzmWw+mMAWUe48qpFsypD4RpJiMUork6hZCnipfdiY
        3Ekv9ZBusPtuovilI2BjnmY/Baer0aA815jHxR6WMaKoK/dYNOmUk1L0phbivXQF
        rxxhh+qu3aEvvQrEPRt2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683593799; x=1683680199; bh=R0MvdCJrAGQ3L
        x601BQioOuJmlf2hwwfSdhcLcNWO5Q=; b=g/w0UhmNd2dweHlXYwAIHgEQlefGr
        Cxa7kh+pkPfbpoHlavNypmWkCIYcGm84Zvr97hAOp/QvhNf4TS1h9I20ljSYthI2
        9kzfxxrukjzZ3KbI31uDt4vsKyx7mI54LJP8ckq8DdyMNOMWMU56J11oBW4pjngs
        jgMvtWW1XVu4UE3u0WjzcLV/28ZVopNibtVTcJLzHdrCw3EZ1A0eczDyuKK9ooAK
        AJ1WxInDWqZKq0fV9vjzdmUWsRGoQK9L2wtTjxzDxJT+stcLSGx//Vj+r86znjZW
        hox7ObZSqiMDnSoiRD2//yLDTKf9gDvbRS0+WasRF/ol3RbI6vPaSpn/A==
X-ME-Sender: <xms:RppZZLIZvHZLxfeASGA3I9g966R4yZqV3JWcmJZQ88RWwM0r5gDx-w>
    <xme:RppZZPL4OuE677_Tk6XD-IVdtLMdQtYfr5dMPcR9UI1q8MTGTa3XdOuE4Tk6daRRZ
    sXIleKZrRy4UgG6hyg>
X-ME-Received: <xmr:RppZZDvDPTSVzc86XrescHVIxi9Ji0lQGQnN3fLtt86DQZJvgTX4IsS8yapsX_gw593hJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefledgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeeulefgteeukeeihfffveeukefhudehvdegvdeh
    lefhvdduffegheegffeifeelveenucffohhmrghinhepthhhihhnghhsrdhhmhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhes
    shhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:RppZZEaO-iTHcU7AIuouj19ki9bDuGEgpnHP5Dme13T8UKFv6mu64g>
    <xmx:RppZZCY8TfNS_5ME1lpq92RblPOT7IhR4uNfy9KA1e9e0k9M3M02Bw>
    <xmx:RppZZIBc2-NXle5d_v3l__XehFTzyuLP-9wZssKk-8vv4hm0IAZ7YQ>
    <xmx:R5pZZFnc9reDSxZgxioSzcXFjrY-QLvPVEPHVmegnMKplIGQegloEg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 May 2023 20:56:37 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5E0AE10C40B; Tue,  9 May 2023 03:56:34 +0300 (+03)
Date:   Tue, 9 May 2023 03:56:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
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
Subject: Re: [PATCHv10 04/11] efi/x86: Implement support for unaccepted memory
Message-ID: <20230509005634.qtuiodpirexbxu2k@box.shutemov.name>
References: <20230507234618.18067-1-kirill.shutemov@linux.intel.com>
 <20230507234618.18067-5-kirill.shutemov@linux.intel.com>
 <CAMj1kXE26G=HgqBHoJOWF+FyXs7Ryj7VFFY9A+xG7HmUXnb5bg@mail.gmail.com>
 <20230508190043.ouauzbghn27khdy4@box.shutemov.name>
 <CAMj1kXFxw4+opJuq=g2unocitRyKYz_hfrZb-grsZtPwBOyKgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFxw4+opJuq=g2unocitRyKYz_hfrZb-grsZtPwBOyKgw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, May 09, 2023 at 12:11:41AM +0200, Ard Biesheuvel wrote:
> > @@ -1324,13 +1325,15 @@ void __init e820__memblock_setup(void)
> >          * e820_table is not finalized and e820__end_of_ram_pfn() cannot be
> >          * used to get correct RAM size.
> >          */
> > -       if (boot_params.unaccepted_memory) {
> > +       if (efi.unaccepted != EFI_INVALID_TABLE_ADDR) {
> > +               struct efi_unaccepted_memory *unaccepted;
> >                 unsigned long size;
> >
> > -               /* One bit per 2MB */
> > -               size = DIV_ROUND_UP(e820__end_of_ram_pfn() * PAGE_SIZE,
> > -                                   PMD_SIZE * BITS_PER_BYTE);
> > -               memblock_reserve(boot_params.unaccepted_memory, size);
> > +               unaccepted = __va(efi.unaccepted);
> > +
> > +               size = sizeof(struct efi_unaccepted_memory);
> > +               size += unaccepted->size;
> > +               memblock_reserve(efi.unaccepted, size);
> >         }
> >
> 
> This could be moved to generic code (but we'll need to use early_memremap())

I don't understand why early_memremap() is needed. EFI_LOADER_DATA already
mapped into direct mapping. We only need to reserve the memory so it
could not be reallocated for other things. Hm?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
