Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E24705A74
	for <lists+linux-efi@lfdr.de>; Wed, 17 May 2023 00:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjEPWPs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 18:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEPWPr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 18:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7864231;
        Tue, 16 May 2023 15:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F7C363CF5;
        Tue, 16 May 2023 22:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8E5C433AC;
        Tue, 16 May 2023 22:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684275345;
        bh=1CVkm2h1qch1auKHIlF0XC2larxx6NtF2jvkbfM3xkE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G+BtFuRtmO43VpHUyXzzLrGRiKKiGKFzaJ1G/xmVPtKgURUm2bRbh7ubHUJ8D0d+3
         W/LOKo/w1wOQozubpTzz1KvUk2ZAUhzOHIUxuNavpfJojgyYnMt9AW43CCV4d6vTCp
         a8zC53EjQerVUtIpToCHqUFWSjlhqQ4Yt+H02t5L44VdcOY8eppFQ1zoDZf6XVyyid
         6GNrGrulqtB6stMf+Sz56LomEbpd+NNlUETl308W7lS7/zEwSgNEtbv051wM/eGYK+
         +LJTtsZA3ObVScGmI25LRKPJahNG4iIN70fuQ5Lfd0mgACBkUXqaarrFEqe0XYOjxD
         E+9QCs9rGZNrQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f37b860173so101101e87.2;
        Tue, 16 May 2023 15:15:45 -0700 (PDT)
X-Gm-Message-State: AC+VfDxiIuXE0NRwDsFPc/hKnY7lywcNXYILQfogCAx+X/xj5TpkeFIG
        Co2ar3H7Ds+PYKKmhdsCa25L6oUgjuoUCXSFJN4=
X-Google-Smtp-Source: ACHHUZ5mI+okYrvd0yt5zMehG48RxTQOQz4+Gycufmk9DgSt/lmCXjtU/NESXXGYNMmBUE7Ys4ZVWKH2l+eyPbWHGw8=
X-Received: by 2002:ac2:5285:0:b0:4f2:6857:1d98 with SMTP id
 q5-20020ac25285000000b004f268571d98mr5554640lfm.48.1684275343279; Tue, 16 May
 2023 15:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
 <20230513220418.19357-7-kirill.shutemov@linux.intel.com> <CAMj1kXG488uW=dpvbfvdN1fMZVJ3kCZQoW3UVQJW1F2VEXyxHg@mail.gmail.com>
 <6fe42f66-819c-f2c8-176b-759c1c5a9cf5@intel.com> <CAMj1kXHE7_PrW44Y073=4orY6yVST+CHEA7KCo_0z_uRLew6fQ@mail.gmail.com>
 <a7550521-65bf-f9af-ddb0-118602a6340c@intel.com> <20230516215210.pviqojbr5o4hd6bb@box.shutemov.name>
 <f7b2e758-625a-aafd-d545-bfa6eae513bb@intel.com>
In-Reply-To: <f7b2e758-625a-aafd-d545-bfa6eae513bb@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 May 2023 00:15:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFXh8wAAU2XT9Aifat4myE_+4GBpUcpT5-sTkgWi-Ab6g@mail.gmail.com>
Message-ID: <CAMj1kXFXh8wAAU2XT9Aifat4myE_+4GBpUcpT5-sTkgWi-Ab6g@mail.gmail.com>
Subject: Re: [PATCHv11 6/9] efi/unaccepted: Avoid load_unaligned_zeropad()
 stepping into unaccepted memory
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 17 May 2023 at 00:00, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/16/23 14:52, Kirill A. Shutemov wrote:
> > On Tue, May 16, 2023 at 01:03:32PM -0700, Dave Hansen wrote:
> >> On 5/16/23 11:35, Ard Biesheuvel wrote:
> >>>>> Does this mean that the kernel maps memory before accepting it? As
> >>>>> otherwise, I would assume that such an access would page fault insi=
de
> >>>>> the guest before triggering an exception related to the unaccepted
> >>>>> state.
> >>>> Yes, the kernel maps memory before accepting it (modulo things like
> >>>> DEBUG_PAGEALLOC).
> >>>>
> >>> OK, and so the architecture stipulates that prefetching or other
> >>> speculative accesses must never deliver exceptions to the host
> >>> regarding such ranges?
> >> I don't know of anywhere that this is explicitly written.  It's probab=
ly
> >> implicit _somewhere_ in the reams of VMX/TDX and base SDM docs, but he=
ck
> >> if I know where it is. =F0=9F=98=84
> > It is not specific to TDX: on x86 (and all architectures with precise
> > exceptions) exception handling is delayed until instruction retirement =
and
> > will not happen if speculation turned out to be wrong. And prefetching
> > never generates exceptions.
>
> Not to be Debbie Downer too much here, but it's *totally* possible for
> speculative execution to go read memory that causes you to machine
> check.  We've had such bugs in Linux.
>
> We just happen to be lucky in this case that the unaccepted memory
> exceptions don't generate machine checks *AND* TDX hardware does not
> machine check on speculative accesses that would _just_ violate TDX
> security properties.
>
> You're right for normal, sane exceptions, though.

Same thing on ARM, although I'd have to check their RME stuff in more
detail to see how it behaves in this particular case.

But Kyrill is right that it doesn't really matter for the logic in
this patch - it just accepts some additional pages. The relevant
difference between implementations will likely be whether unaccepted
memory gets mapped beforehand in the first place, but we'll deal with
that once we have to.

As long as we only accept memory that appears in the bitmap as
'unaccepted', this kind of rounding seems safe and reasonable to me.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
