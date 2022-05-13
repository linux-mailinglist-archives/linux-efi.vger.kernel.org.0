Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0995525E34
	for <lists+linux-efi@lfdr.de>; Fri, 13 May 2022 11:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378821AbiEMJBx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 May 2022 05:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378805AbiEMJBt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 May 2022 05:01:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73E961291;
        Fri, 13 May 2022 02:01:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4AF0C21AA0;
        Fri, 13 May 2022 09:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652432504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SyY4mEpMFa5F68efRI76ShsKbkWuRwJfr+pFEe31UIc=;
        b=tOrn1fTmPgR4XYhGMsWqyR1oqiwuDphjD/lBoBUskrL+KquiEeR7Gyk2PNNw5rpCPQ1T+7
        3lK0nh6Ub+5akOBWp830oyQloyYS4qe3+OJ+xwPVeUnw+AG+huWSERBaaZVPXclDxxhsdF
        xaupQwxeGjAZ1nbIlW47kana45LJebc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652432504;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SyY4mEpMFa5F68efRI76ShsKbkWuRwJfr+pFEe31UIc=;
        b=A7l/iE3h5zsH0F85RE9NINwnO2+9WlnsMl1oxm2z3ZDD2GPRHJC9hoz+HtRwnKf00vYuIs
        PE2vKhJNXw/z9yAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C00213446;
        Fri, 13 May 2022 09:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AfOdDngefmJ6bwAAMHmgww
        (envelope-from <bp@suse.de>); Fri, 13 May 2022 09:01:44 +0000
Date:   Fri, 13 May 2022 11:01:43 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Michael Roth <michael.roth@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
Message-ID: <Yn4ed1gupKmNz2jn@zn.tnic>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-7-kirill.shutemov@linux.intel.com>
 <YnE4ZzzVrxUnr3Uv@zn.tnic>
 <20220506153013.e6v4q2qhuhqumfiu@box.shutemov.name>
 <YnpGnMoviGoK4Ucq@zn.tnic>
 <CAAH4kHYRxgUNnGRUO473q02q3akLzgiTvbA2qKEP5jq6jFV-uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAH4kHYRxgUNnGRUO473q02q3akLzgiTvbA2qKEP5jq6jFV-uA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

+ mroth
- brijesh

On Thu, May 12, 2022 at 10:34:02PM -0700, Dionna Amalie Glaze wrote:
> Kirill, I've been tracking these changes to see if we can handle the
> unaccepted memory type for SEV-SNP, but testing has been an issue. The
> proposed patch in Ovmf to introduce unaccepted memory seems to have
> stalled out last September
> (https://www.mail-archive.com/devel@edk2.groups.io/msg35842.html) and
> is particularly difficult to adapt to SEV-SNP since it doesn't follow
> the TDVF way of initializing all memory. Is there a different
> development I might have missed so that we might test these cases?
> Without the UEFI introducing EFI_UNACCEPTED_MEMORY type, any kernel
> uses are essentially dead code.
> 
> Thanks,
> -Dionna
> 
> (apologies for repost in text mode)
> 
> On Tue, May 10, 2022 at 4:04 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, May 06, 2022 at 06:30:13PM +0300, Kirill A. Shutemov wrote:
> > > I find it harder to follow.
> >
> > If in doubt, always consider using a helper function:
> >
> > ---
> >
> > diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
> > index 7db2f41b54cd..cf475243b6d5 100644
> > --- a/arch/x86/boot/compressed/efi.h
> > +++ b/arch/x86/boot/compressed/efi.h
> > @@ -32,6 +32,7 @@ typedef       struct {
> >  } efi_table_hdr_t;
> >
> >  #define EFI_CONVENTIONAL_MEMORY                 7
> > +#define EFI_UNACCEPTED_MEMORY          15
> >
> >  #define EFI_MEMORY_MORE_RELIABLE \
> >                                 ((u64)0x0000000000010000ULL)    /* higher reliability */
> > diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> > index 28b91df9d31e..39bb4c319dfc 100644
> > --- a/arch/x86/boot/compressed/kaslr.c
> > +++ b/arch/x86/boot/compressed/kaslr.c
> > @@ -671,6 +671,23 @@ static bool process_mem_region(struct mem_vector *region,
> >  }
> >
> >  #ifdef CONFIG_EFI
> > +
> > +/*
> > + * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if supported) are guaranteed
> > + * to be free.
> > + */
> > +static inline bool memory_type_is_free(efi_memory_desc_t *md)
> > +{
> > +       if (md->type == EFI_CONVENTIONAL_MEMORY)
> > +               return true;
> > +
> > +       if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
> > +               if (md->type == EFI_UNACCEPTED_MEMORY)
> > +                       return true;
> > +
> > +       return false;
> > +}
> > +
> >  /*
> >   * Returns true if we processed the EFI memmap, which we prefer over the E820
> >   * table if it is available.
> > @@ -723,21 +740,9 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
> >                  * free memory and thus available to place the kernel image into,
> >                  * but in practice there's firmware where using that memory leads
> >                  * to crashes.
> > -                *
> > -                * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if
> > -                * supported) are guaranteed to be free.
> >                  */
> > -
> > -               switch (md->type) {
> > -               case EFI_CONVENTIONAL_MEMORY:
> > -                       break;
> > -               case EFI_UNACCEPTED_MEMORY:
> > -                       if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
> > -                               break;
> > +               if (!memory_type_is_free(md))
> >                         continue;
> > -               default:
> > -                       continue;
> > -               }
> >
> >                 if (efi_soft_reserve_enabled() &&
> >                     (md->attribute & EFI_MEMORY_SP))
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > https://people.kernel.org/tglx/notes-about-netiquette
> 
> 
> 
> -- 
> -Dionna Glaze, PhD (she/her)
> 

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
