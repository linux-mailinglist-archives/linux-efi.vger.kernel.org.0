Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D104F5A50E7
	for <lists+linux-efi@lfdr.de>; Mon, 29 Aug 2022 18:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiH2QC7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Aug 2022 12:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiH2QC5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Aug 2022 12:02:57 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AB68FD57
        for <linux-efi@vger.kernel.org>; Mon, 29 Aug 2022 09:02:55 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-33dc345ad78so207249487b3.3
        for <linux-efi@vger.kernel.org>; Mon, 29 Aug 2022 09:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8Usi9Hh1KvrJmXEusctcdOFszMM7+qvg9UBwUxClRh0=;
        b=P63R/tJ1/yc2xe/SYPTrGdLCylhF8Yq/+kzrso3A2VDilTv0adUYIPWvD/PV8NImJF
         rvP+8ZABp8nUF1fbgcAf4+5O5JPVD7egARXdeRN7M8thmFgzEEcGdam2RaoZaz7SHCPi
         Ws92dnROdr+EUTrMzw6dPkZFbmHzFWZP6l+r1gQDVO3qkwLPGfevPjuOb+We6iXKTDYl
         tNpS+apxMlkRoa1XuSVaEByTnXLeRgx4OwVpM1JcBEi/X1wA0qYpX2cVMjcn39Q+NLDe
         OQeCLFZ+h7GW6hFG2icL9huyDGj4Dzmm6aqgWJYXAz1DCtPWiMwXFxvyVjtCuC4p+lge
         NjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8Usi9Hh1KvrJmXEusctcdOFszMM7+qvg9UBwUxClRh0=;
        b=egsHpsTWZDmgIzrTMmB/znJR9D8QGehs38V6bRiRLLk6opBdfoFQg3odujFrTdym1S
         13TrbjbhW4qJCG8cskZ0Xd4dT5k0Pw2m7c9k91haR4hJKiaMgm7n8xwBo71nmJ9zgdw5
         X8WPtKffVoThQ9JtZR8TMNSP9/a77yogip2XuM7qNCKf4rPxkM/So59byzhW36Pcfd/D
         9ATH9AzZ6voRddDzVzS1VfKESDo4y8SwoPuBE63YQW1vnei+kGoZOf87SyzQp5OI+Mqx
         BnxsC1IcBZDHD9oF+aMa43Ipe8bpZyoWbnCTFQyfAJCoc9tu9/HX0VDeK6hXj/oDpXlP
         IkcA==
X-Gm-Message-State: ACgBeo35wplYQNak0BZjV+bmlkZaBSK3PsEJGFWsjV2AbqbCw7dV3tXU
        UF6A8jQloWetTXiYCLVAPoY/C1go7Fcq3leKaHgekQ==
X-Google-Smtp-Source: AA6agR7/KN4/eHAqKBzu8Y1ODKrUf87PVyGKXZruOIOILGQ04PmnXodL6U9rRi2s20C9/A8QbHpYKGVUuhl+ceHb/GM=
X-Received: by 2002:a0d:da41:0:b0:329:91e7:fd06 with SMTP id
 c62-20020a0dda41000000b0032991e7fd06mr10477748ywe.436.1661788974863; Mon, 29
 Aug 2022 09:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com> <8cf143e7-2b62-1a1e-de84-e3dcc6c027a4@suse.cz>
 <20220810141959.ictqchz7josyd7pt@techsingularity.net> <CAAH4kHa6s3sBRySNu-TZG_6vOaN4KheVy4kvxG5s=wOTDGy2=Q@mail.gmail.com>
 <2981e25e-9cda-518a-9750-b8694f2356b5@amd.com>
In-Reply-To: <2981e25e-9cda-518a-9750-b8694f2356b5@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Mon, 29 Aug 2022 09:02:43 -0700
Message-ID: <CAAH4kHbcfnVWNQHf6Mrg__bSFT6196Sx4kno6o0Zo7hsgOgnNw@mail.gmail.com>
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> > The stack track is in mm/page_alloc.c. I've done a little
> > investigation, but I can't account for why there's a hard cutoff of
> > correctness at 256GB
> >
> > [    0.065563] RIP: 0010:memmap_init_range+0x108/0x173
> > [    0.066309] Code: 77 16 f6 42 10 02 74 10 48 03 42 08 48 c1 e8 0c
> > 48 89 c3 e9 3a ff ff ff 48 89 df 48 c1 e7 06 48 03 3d d9 a2 66 ff 48
> > 8d 47 08 <c7> 47 34 01 00 00 00 48 c7 47 38 00 00 00 00 c7 47 30 ff ff
> > ff ff
> > [    0.069108] RSP: 0000:ffffffffad603dc8 EFLAGS: 00010082 ORIG_RAX:
> > 0000000000000404
> > [    0.070193] RAX: ffffdba740000048 RBX: 0000000000000001 RCX: 0000000000000000
> > [    0.071170] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffdba740000040
> > [    0.072224] RBP: 0000000000000000 R08: 0000000000001000 R09: 0000000000000000
> > [    0.073283] R10: 0000000000000001 R11: ffffffffad645c60 R12: 0000000000000000
> > [    0.074304] R13: 00000000000000a0 R14: 0000000000000000 R15: 0000000000000000
> > [    0.075285] FS:  0000000000000000(0000) GS:ffffffffadd6c000(0000)
> > knlGS:0000000000000000
> > [    0.076365] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.077194] CR2: ffffdba740000074 CR3: 0008001ee3a0c000 CR4: 00000000000606b0
> > [    0.078209] Call Trace:
> > [    0.078524]  <TASK>
> > [    0.078887]  ? free_area_init+0x5c1/0x66c
> > [    0.079417]  ? zone_sizes_init+0x52/0x6c
> > [    0.079934]  ? setup_arch+0xa55/0xb6d
> > [    0.080417]  ? start_kernel+0x64/0x65a
> > [    0.080897]  ? secondary_startup_64_no_verify+0xd6/0xdb
> > [    0.081620]  </TASK>
>
> Note that there is a bug in Brijesh's version of the patch and it will
> almost exclusively use the MSR protocol. Please try the version of the
> patch that I recently sent up based on the current unaccepted memory tree
> from Kirill.
>

I've now tested this patch set with Tom's new patch set, and it
appears to be that the problem with 256GB is more likely to be due to
this unaccepted memory patch set rather than something AMD-specific.

Kirill, do you see any problems with 256GB on TDX? It seems there is
some unaccepted memory getting touched in memmap_init_range when the
VM's memory size is at least 256GB

-- 
-Dionna Glaze, PhD (she/her)
