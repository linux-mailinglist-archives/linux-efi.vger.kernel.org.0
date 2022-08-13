Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283C3591BF0
	for <lists+linux-efi@lfdr.de>; Sat, 13 Aug 2022 18:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239684AbiHMQMW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 Aug 2022 12:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiHMQMW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 13 Aug 2022 12:12:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA54CE0FD;
        Sat, 13 Aug 2022 09:12:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50282B8069F;
        Sat, 13 Aug 2022 16:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0E8C433B5;
        Sat, 13 Aug 2022 16:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660407137;
        bh=AyAGH0PcMtFcg49U7U4FZXoOq5ScRaVgEYBLreXB280=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=C3DO/cdGuqKWCfuMHu5t/g+mL7ExtT5COBjzp8ik3KD3XW89sZ9v7usUWfktdkG+W
         PYCGPVujPe3RYQIvQiwABCvqA87KPi2vVJvULFlIRcQltxAyHP16J8Umzyj9sOAGDz
         rwRea+hTT2B7ZfR3F7U7MbSjxIekEX74zgelB32A3Dc+IAZ7QcHvt9G+seoP6KnNJc
         CD+WQZ+LhSvHEbiIwCryqQzE78My/f0uQwxuHwxKw0rEB/kacZOz0HcduvWItqSj+n
         WPjXe08MEpEn1ho3s+2RNkOp2/3Vh8xlEnyvx0fP0jlvih5Ke0PHTASXzlRtTg+CrC
         6Y+QBoFP9/hSA==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 825C627C005A;
        Sat, 13 Aug 2022 12:12:15 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Sat, 13 Aug 2022 12:12:15 -0400
X-ME-Sender: <xms:Xc33YpmtMfZUbZQdNB3zbOjIp_WGElDfb5HJWHie6xAxT8ravZngDg>
    <xme:Xc33Yk18IHTcTpjchSV36cXf9NENZ1ytFNTWMRALqYoCVPKGDjkpSCkDC6YLMpbK4
    rE3okoIj6fhmHHfLsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegkedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehnugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhepieetjeelgeejkeelgeevueejjedvheejkeevgeduudduffeu
    keejffefueejkefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqd
    hluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:Xc33Yvpy3vWICYgEiCvlHdsVcwY6iDnb1goKjw8nXUeokbOI8Wkfpg>
    <xmx:Xc33Ypn8XprHNMCB6eXqZO8blECaSCWd7crGk3UxN2kX4Rk4T5sMUw>
    <xmx:Xc33Yn3HstirShLFDbG2l82H2U9Cd5L3oVjArpiIEVZf6nZmnUurRQ>
    <xmx:X833YrKt1AsOjrqWOxsBLBy96vEI9pcVyPRIvGsAc4fbeaWRElO8Ew>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DFF4D31A0062; Sat, 13 Aug 2022 12:12:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <f9e3aacf-d90e-42a1-ac0e-39ba61389305@www.fastmail.com>
In-Reply-To: <YvTncOa6KSr8EIuE@zn.tnic>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-11-kirill.shutemov@linux.intel.com>
 <Yt/ANO5usdV+JSSW@zn.tnic> <80cc204b-a24f-684f-ec66-1361b69cae39@intel.com>
 <073c5a97-272c-c5a0-19f2-c3f14f916c72@intel.com> <YvTncOa6KSr8EIuE@zn.tnic>
Date:   Sat, 13 Aug 2022 09:11:52 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Sean Christopherson" <seanjc@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Joerg Roedel" <jroedel@suse.de>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Sathyanarayanan Kuppuswamy" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "David Rientjes" <rientjes@google.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Varad Gautam" <varad.gautam@suse.com>,
        "Dario Faggioli" <dfaggioli@suse.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "David Hildenbrand" <david@redhat.com>,
        "Marcelo Henrique Cerri" <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com,
        "the arch/x86 maintainers" <x86@kernel.org>, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv7 10/14] x86/mm: Avoid load_unaligned_zeropad() stepping into
 unaccepted memory
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On Thu, Aug 11, 2022, at 4:26 AM, Borislav Petkov wrote:
> On Wed, Aug 03, 2022 at 07:02:31AM -0700, Dave Hansen wrote:
>> One other thing I remembered as I re-read my write up on this.
>>=20
>> In the "new" mode, guests never get #VE's for unaccepted memory.  They
>> just exit to the host and can never be reentered.  They must be kille=
d.
>
> Yeah, this is the part which I think is really silly.
>
> OSes, in their execution lifetime, can - erroneously or not - but it
> happens pretty often in real life, touch some unrelated memory. And th=
is
> has never been a big deal - #PF, that's it.
>
> But now they don't even get a chance to correct their mistake - VMEXIT,
> die.
>
> load_unaligned_zeropad() is just one case.
>
> Imagine the user loads some buggy driver in the guest and that driver
> starts doing stray memory accesses through a wild pointer into the
> fields. Guest dies immediately.
>
> Dunno bit it all feels a bit too harsh and unfriendly to me.
>
> Sure, if that user is really unlucky, those stray accesses can kill
> his OS on baremetal too. So maybe you could argue here that such stray
> accesses are actually a good thing. :)
>
> All I know is, there should be a more resilient way to handle those.
>
>> In the "old" mode, I _believe_ that the guest always gets a #VE for
>> non-EPT-present memory.  The #VE is basically the same no matter if t=
he
>> page is unaccepted or if the host goes out and makes a
>> previously-accepted page non-present.
>>=20
>> One really nasty implication of this "old" mode is that the host can
>> remove *accepted* pages that are used in the syscall gap.  That means
>> that the #VE handler would need to be of the paranoid variety which
>> opens up all kinds of other fun.
>
> Yeah, I believe this needs to be dealt with anyway, for SNP at least.
> But on AMD it would simply cause an exception and it'll be handled in
> the #VC thing. And there's some ugly code to deal with the gap too.

I do not believe for a second that the =E2=80=9Cugly=E2=80=9D code in qu=
estion is correct. Let=E2=80=99s please not go there for TDX.  The whole=
 point of this thing is security =E2=80=94 I would rather see a somewhat=
 fragile situation than an exploit.

Now if the TD module could deliver an unrecoverable #MC instead of an im=
possible-to-handle #VE, maybe we could at least get a nice debug trace o=
ut?  Of course it=E2=80=99s not so easy to do anything with a debug trac=
e that doesn=E2=80=99t break confidentiality.

So, Dave (and other Intel folks), here=E2=80=99s a different feature I t=
hink we will want: a secure way to get debug logs out of a TDX guest. Ma=
ybe the guest could have a way to send syslog lines to the TD module (vi=
a hypercall or a ring buffer) and the TD module could encrypt them again=
st a secret that is only accessible to future boots of the same guest or=
 to an attested outside key.  TDX already has an exceedingly flexible at=
testation mechanism =E2=80=94 there is surely room for the guest config =
to include a public key that is used for encryption of exported logs.

(Yes, this is sort of doable in software, but the part where any kind of=
 buffer actually gets saved anywhere if the guest goes kaboom requires e=
ither help from the TD module or a defined protocol with key negotiation=
 involving the untrusted host.)

The model where the guest leaves a panic on the screen or serial console=
 won=E2=80=99t work in TDX=E2=80=A6

>
>>  * "Old" - #VE's can happen in the syscall gap
>>  * "New" - #VE's happen at better-defined times.  Unexpected ones are
>>    fatal.
>>=20
>> There's a third option which I proposed but doesn't yet exist.  The T=
DX
>> module _could_ separate the behavior of unaccepted memory #VE's and
>> host-induced #VEs.  This way, we could use load_unaligned_zeropad() w=
ith
>> impunity and handle it in the #VE handler.  At the same time, the host
>> would not be allowed to remove accepted memory and cause problems in =
the
>> syscall gap.  Kinda the best of both worlds.
>
> I like that. This should've been the default from the get-go. Oh well,
> what's it called in English, hindsight is 20 20...?
>
>> But, I'm not sure how valuable that would be now that we have the
>> (admittedly squirrelly) code to avoid load_unaligned_zeropad() #VE's.
>
> I think you should push for the bestest solution and one day we can ki=
ll
> those ugly workarounds.
>
> Thx.
>
> --=20
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
