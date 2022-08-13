Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3148591BE1
	for <lists+linux-efi@lfdr.de>; Sat, 13 Aug 2022 18:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbiHMQF2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 Aug 2022 12:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbiHMQF1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 13 Aug 2022 12:05:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84361BE35
        for <linux-efi@vger.kernel.org>; Sat, 13 Aug 2022 09:05:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42835B806A0
        for <linux-efi@vger.kernel.org>; Sat, 13 Aug 2022 16:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF93BC433D6;
        Sat, 13 Aug 2022 16:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660406723;
        bh=3g9RQwus4TjJnSLEmDO7GO8w4lhwGY5MWBNfeGUrI14=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=bR3utfteio3+HXiiA5b9ZVNOesXk99inIzLdtSS3Fbr4O2vhnqjAKFXnIUNKErZU1
         AXlqTpnV+qv86BuGxlLt8Uswr1e9UsMcDl/tWW7lYBmIEThfMUqBYA/vB9H0GEoZlF
         /gKQdhBaqegWs78Sn/gdnhx1jwE+1BhLHOQhhRpfpE3L52xy6RRYPfC2Cv8tp7XBo0
         e+5Eugq7TqDz4Z68+k6mXXnc8WDhTS7WOAWrP2Rm43CtwGTrNLZPQEwR1DcChwNm65
         JXptI7Xq2yutap0/sMdFhWOD4woGK/ikcOLQmk3yZi2hqSFKwUGc8ZSJWj3Lv/zBTu
         PdllclRHsw4nQ==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id CB83A27C005A;
        Sat, 13 Aug 2022 12:05:20 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Sat, 13 Aug 2022 12:05:20 -0400
X-ME-Sender: <xms:wMv3Yh1znTFOlpPKRQXsFsX0gbQh_RkV1b-kLRRUvVbQr6AlAq5IZg>
    <xme:wMv3YoEtKCJ70L7KpOgNKT50af-yNGCo_PVCuFAj12suYKJQAwAkBuljC7VTuIEzF
    kQmiuOZeIU9t3CL7eI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegkedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduveffvdegvdefhfegjeejlefgtdffueekudfgkeduvdetvddu
    ieeluefgjeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:wMv3Yh6eSWyZepVnU6ZzOhKtIyjlm-JuAUVTDDVDEu_7tABQEHiFSw>
    <xmx:wMv3Yu2y8kvttoCDlkJouXGwn-w1WnxG7XgU-_L1RcKirCbjUpMlEg>
    <xmx:wMv3YkHh1hdCZdkLL1eKipSaJXM7F4eDCgJN2rSatQqYJbtbpw2cZQ>
    <xmx:wMv3Ynb5fDEj8dsYNQuRpGtjpogyHyKlFlRkH267crqDACrgSGeToQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1B36831A0063; Sat, 13 Aug 2022 12:05:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <f2cf11d3-c2f8-4add-ab58-19a4844be361@www.fastmail.com>
In-Reply-To: <073c5a97-272c-c5a0-19f2-c3f14f916c72@intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-11-kirill.shutemov@linux.intel.com>
 <Yt/ANO5usdV+JSSW@zn.tnic> <80cc204b-a24f-684f-ec66-1361b69cae39@intel.com>
 <073c5a97-272c-c5a0-19f2-c3f14f916c72@intel.com>
Date:   Sat, 13 Aug 2022 09:04:58 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Dave Hansen" <dave.hansen@intel.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Sean Christopherson" <seanjc@google.com>,
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



On Wed, Aug 3, 2022, at 7:02 AM, Dave Hansen wrote:
> On 8/2/22 16:46, Dave Hansen wrote:
>> To sum it all up, I'm not happy with the complexity of the page
>> acceptance code either but I'm not sure that it's bad tradeoff compar=
ed
>> to greater #VE complexity or fragility.
>>=20
>> Does anyone think we should go back and really reconsider this?
>
> One other thing I remembered as I re-read my write up on this.
>
> In the "new" mode, guests never get #VE's for unaccepted memory.  They
> just exit to the host and can never be reentered.  They must be killed.
>
> In the "old" mode, I _believe_ that the guest always gets a #VE for
> non-EPT-present memory.  The #VE is basically the same no matter if the
> page is unaccepted or if the host goes out and makes a
> previously-accepted page non-present.
>
> One really nasty implication of this "old" mode is that the host can
> remove *accepted* pages that are used in the syscall gap.  That means
> that the #VE handler would need to be of the paranoid variety which
> opens up all kinds of other fun.
>
>  * "Old" - #VE's can happen in the syscall gap
>  * "New" - #VE's happen at better-defined times.  Unexpected ones are
>    fatal.
>
> There's a third option which I proposed but doesn't yet exist.  The TDX
> module _could_ separate the behavior of unaccepted memory #VE's and
> host-induced #VEs.  This way, we could use load_unaligned_zeropad() wi=
th
> impunity and handle it in the #VE handler.  At the same time, the host
> would not be allowed to remove accepted memory and cause problems in t=
he
> syscall gap.  Kinda the best of both worlds.
>
> But, I'm not sure how valuable that would be now that we have the
> (admittedly squirrelly) code to avoid load_unaligned_zeropad() #VE's.

How would that be implemented?  It would need to track which GPAs *were*=
 accepted across a host-induced unmap/remap cycle. This would involve pr=
eventing the host from ever completely removing a secure EPT table witho=
ut the guest=E2=80=99s help, right?

Admittedly this would IMO be better behavior. Is it practical to impleme=
nt?
