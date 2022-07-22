Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E57757E365
	for <lists+linux-efi@lfdr.de>; Fri, 22 Jul 2022 17:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiGVPHZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 Jul 2022 11:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbiGVPHY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 22 Jul 2022 11:07:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DF48810B;
        Fri, 22 Jul 2022 08:07:23 -0700 (PDT)
Received: from zn.tnic (p200300ea97297665329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:7665:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DCB0B1EC04E4;
        Fri, 22 Jul 2022 17:07:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658502438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3Hc0Vuv3k27qn5hRTK62cKaY/chLQcEx0JaH2giHRug=;
        b=fFn7fCbE9fzF8IoOrgQ/x1EoTFvBSRPNJLjiw+qpNnOmbOf65mkhNsyc0cETIHlUak1sm/
        qOkO8NF/s4BDSD8YxmO71pol1top4QIOpBgu/2bqpyTZC67PPk7hajToBOT++7Gm1GT4fO
        nwOhQ/PnGxR+T4CmEfYCAQnMLgFMbSM=
Date:   Fri, 22 Jul 2022 17:07:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Marc Orr <marcorr@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Gonda <pgonda@google.com>,
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
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Yao, Jiewen" <jiewen.yao@intel.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted
 memory
Message-ID: <Ytq9IWopJS4EGqEq@zn.tnic>
References: <CAAH4kHaB2tL+sAn0NAciu5DQeX5hpNkDees=n=f83S=Ph9Y6tw@mail.gmail.com>
 <YtcCWfCQuEsVhH6W@zn.tnic>
 <CAMj1kXEKtcieycyyFMyuLKJK61FgaDwtLieC0N47W1Sa5LaBsA@mail.gmail.com>
 <YtcgxxMyFTReuuRw@zn.tnic>
 <bb7479df-7871-9861-600d-c2fed783b659@intel.com>
 <YtcnQbiRgZPtR+rQ@zn.tnic>
 <22d54786-bc12-ecc5-2b37-cbaa56090aa8@intel.com>
 <CAA03e5FMEyswDhoXRJ5U_n9RG4QM524aQYpF4473ydnAVJr1PA@mail.gmail.com>
 <YteWPj7HytPrcplB@zn.tnic>
 <CAA03e5H8-n23eZ5sMWLQADpJ+AQCrhMoDng_aiw3-C5cPHEwnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAA03e5H8-n23eZ5sMWLQADpJ+AQCrhMoDng_aiw3-C5cPHEwnA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 20, 2022 at 10:03:40AM -0700, Marc Orr wrote:
> Generally, no. But the problem with tags is that distros tag their
> images wrong sometimes. And that leads to problems. For example, I
> just got a bug assigned to me yesterday about some ARM image tagged as
> SEV_CAPABLE. Oops. Lol :-). (Though, I'm pretty sure we won't try to
> boot an ARM image on a non-ARM host anyway; but it's still wrong...)

Yeah, even if, let it crash'n'burn - people will notice pretty quickly.

> That being said, this lazy accept problem is sort of a special case,
> since it requires deploying code to the guest FW and the guest kernel.
> I'm still relatively new at all of this, but other than the
> SNP/TDX-enlightenment patches themselves,  I haven't really seen any
> other examples of this. So that goes back to my previous question. Is
> this going to happen a lot more?

Good question.

Unfortunately, not even the architects of coco could give you an answer
because, as you see yourself, those additional features like memory
acceptance, live migration, etc keep changing - the whole coco thing is
pretty much a moving target.

For example, if someone comes along and says, err, see, I have this live
migration helper and that thing runs as an EFI executable and it is so
much better...

Not saying it'll happen but it could. I hope you're catching my drift.

> If not, I can definitely see value in the argument to skip the
> complexity of the FW/kernel feature negotiation.
>
> Another thing I thought of since my last reply, that's mostly an
> internal solution to this problem on our side: Going back to Dave's
> 10k-foot view of the different angles of how to solve this. For "1.
> Deal with that at the host level configuration", I'm thinking we could
> tag the images with their internal guest kernel version. For example,
> if an image has a 5.15 kernel, then we could have a `KERNEL_5_15` tag.
> This would then allow us to have logic in the guest FW like:
> 
> if (guest_kernel_is_at_least(/*major=*/5, /*minor=*/15)
>      enable_lazy_accept = true;

Well, I don't want to spoil your idea but imagine distros like SLE or
others backport features into old kernels. All of a sudden 5.14 or older
can do memory acceptance too. And then that version-based scheme falls
apart.

So I'm guessing it would probably be better to explicitly tag distro
images. Thing is, once all needed support gets in, you can drop the tags
and simply say, you don't support those old images anymore and assume
all required support is there and implicit...

> Also, tagging images with their underlying kernel versions still seems
> susceptible to mis-labeling. But this seems like it can be mostly
> "fixed" via automation (e.g., write a tool to boot the guest and ask
> it what it's kernel version is and use the result to attach the tag).

I'll do you one better: boot the image and check for all required
features and produce tags. Or do not accept the image as a possible coco
image. And so on.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
