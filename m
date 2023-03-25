Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD996C89BD
	for <lists+linux-efi@lfdr.de>; Sat, 25 Mar 2023 01:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCYAwG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Mar 2023 20:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCYAwF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Mar 2023 20:52:05 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B21B15C8C;
        Fri, 24 Mar 2023 17:52:04 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id AA04D5C00AB;
        Fri, 24 Mar 2023 20:52:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Mar 2023 20:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679705521; x=
        1679791921; bh=263d8X9NDnlXPj9Gft3I5NwFp7vjifRWFXPErnNXYcg=; b=S
        Vyu3+WT1SQ/rpL2qc2AVcRZtC1GHV0VANuJwsnb7O6eD3ujY53Zq2C3RNp2VhjD9
        kSJ1EJ+Zw8yt4dt4g3tdsF1epmgk+Y6dQqQgcvUGi2Qm+ja16GcM4FbDwObo6gtI
        pi04vLMwFg2BUmjNBkoYk22EYsqJa2AQac4Lu5WU+AHgsM+9gV29MBa4Zfq11uKe
        Cy80Bewh3fXKQ8hOB5sa9akOYIKgrGYGEpYbUpQDYkJfyKigqbDZuGUUy4PRV3H7
        g9yEbctH5adS87bZ9xOH2G4HXbXRGkaPvNmwBaRyqIDV/UFqqbPhQNcpOq9xBlCi
        foSWP7R2Wwlzk7OJDskSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679705521; x=1679791921; bh=263d8X9NDnlXP
        j9Gft3I5NwFp7vjifRWFXPErnNXYcg=; b=Kwa9zywoQPN5tt82AYZ+Wg9Z9klHk
        7RvusbiekcY51nEhKGK2jcIRMl+Rozu+uM2p5mQEVNXqvrqtsb7ApH7sJyLF7233
        ZwYOmAPZS0IKtWacHr4094ha8LJn4jQOAu5avofXNR9tl0ewf7J/aZzYgGIXaj1R
        9UXuVNSMj3xQxAGEAj8lBhd5dYv4CDUFe8xJ+uYDYqZzGUYpnmDz1r5AV26g7BYF
        IkQozErZ0/l8GfKLgFN/xYXIXSFqiFQO2xAKLcu8EmUpuHK1ssxJ2jiIy2X+eQrR
        pV1qTU4O1HdJBgP7IwY/9mSxS/LZc8mhtVU/btMEdix83nf6OgAJFqmjw==
X-ME-Sender: <xms:sEUeZGvItccVD1Qq2oLUDYoR6gIcVER-qXwkLHPowAW8TSWn6XWAUA>
    <xme:sEUeZLeTEC8HccwXT42QqAny5pR7oxlbFKm8pL72GitCU6GTPbSR1jcnr9y49n2Xy
    EReWcS6podMPNNwLa0>
X-ME-Received: <xmr:sEUeZByn2cSPGV14wq43GHsuqardoj3r93lVhd8GpO0CELe6FXgNY0nT5YCgrGlKZ2eG_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegjedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeelgffhfeetlefhveffleevfffgtefffeelfedu
    udfhjeduteeggfeiheefteehjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:sEUeZBO7gvcY9fDy9xCIf_SlQrpdKoZ1F6E45UV-KQ5zGrIT6P4r5Q>
    <xmx:sEUeZG99hAKAavKAOXXgIoXHpqYDgAk_iSFV0ZjsMSRReZSAMpzFKA>
    <xmx:sEUeZJW-VYDBbwny3b_XzXVpsLcsBwrMpbXhuTbBKJTkM4W52Doo-g>
    <xmx:sUUeZLKphPcSWDVtDKrrobSajDCpcz6BVOo8ebcIaUsh46zDTtFpmQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 20:52:00 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0EE5310A607; Sat, 25 Mar 2023 03:51:57 +0300 (+03)
Date:   Sat, 25 Mar 2023 03:51:57 +0300
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
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 06/14] efi/x86: Implement support for unaccepted memory
Message-ID: <20230325005157.37b4alnuf6p6mh66@box.shutemov.name>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
 <20221207014933.8435-7-kirill.shutemov@linux.intel.com>
 <Y7Q5x7qV/Cmc/p8s@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7Q5x7qV/Cmc/p8s@zn.tnic>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 03, 2023 at 03:20:55PM +0100, Borislav Petkov wrote:
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index 6787ed8dfacf..8aa8adf0bcb5 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -314,6 +314,20 @@ config EFI_COCO_SECRET
> >  	  virt/coco/efi_secret module to access the secrets, which in turn
> >  	  allows userspace programs to access the injected secrets.
> >  
> > +config UNACCEPTED_MEMORY
> > +	bool
> > +	depends on EFI_STUB
> 
> This still doesn't make a whole lotta sense. If I do "make menuconfig" I don't
> see the help text because that bool doesn't have a string prompt. So who is that
> help text for?

It is a form of documentation for a developer. The same happens for other
options. For instance, BOOT_VESA_SUPPORT or ARCH_HAS_CURRENT_STACK_POINTER.

Yes, it is not visible user, but I still think it is helpful for a
developer to understand what the option does.

> Then, in the last patch you have
> 
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -888,6 +888,8 @@ config INTEL_TDX_GUEST
>         select ARCH_HAS_CC_PLATFORM
>         select X86_MEM_ENCRYPT
>         select X86_MCE
> +       select UNACCEPTED_MEMORY
> +       select EFI_STUB
> 
> I guess you want to select UNACCEPTED_MEMORY only.

I had to rework it as

config INTEL_TDX_GUEST
	...
	depends on EFI_STUB
	select UNACCEPTED_MEMORY

Naked select UNACCEPTED_MEMORY doesn't work if EFI and EFI_STUB is
disabled:

WARNING: unmet direct dependencies detected for UNACCEPTED_MEMORY
  Depends on [n]: EFI [=n] && EFI_STUB [=n]
  Selected by [y]:
  - INTEL_TDX_GUEST [=y] && HYPERVISOR_GUEST [=y] && X86_64 [=y] && CPU_SUP_INTEL [=y] && X86_X2APIC [=y]

IIUC, the alternative is to have selects all the way down the option tree.

> 
> And I've already mentioned this whole mess:
> 
> https://lore.kernel.org/r/Yt%2BnOeLMqRxjObbx@zn.tnic
> 
> Please incorporate all review comments before sending a new version of
> your patch.
> 
> Ignoring review feedback is a very unfriendly thing to do:
> 
> - if you agree with the feedback, you work it in in the next revision
> 
> - if you don't agree, you *say* *why* you don't

Sorry, it was not my intention. I misread your comment and focused on
build issues around the option.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
