Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A9F591BD9
	for <lists+linux-efi@lfdr.de>; Sat, 13 Aug 2022 18:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbiHMQDl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 Aug 2022 12:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbiHMQDl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 13 Aug 2022 12:03:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A56BE20
        for <linux-efi@vger.kernel.org>; Sat, 13 Aug 2022 09:03:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEB81B80688
        for <linux-efi@vger.kernel.org>; Sat, 13 Aug 2022 16:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965EBC433D6;
        Sat, 13 Aug 2022 16:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660406617;
        bh=8AKntuXc65i1saqB877W3R6RYDsPiOzfHdOG82gubqU=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=PhTckigvrk6wORM1yefMuhw4OzzCT5g0MqPXfKBkB8Ikh82SWyxGormHL2RVr4qaa
         5RaurmRXRFFSNRxF4WZl0vecbOzuu815Ii4L3Bvj5VRZN4Padu85IFiJaSZXzV/uTj
         bkAC3PraOdUJ3Rn3lWl+DmWbtt/fAEPmj9x3xH7d31AtXJtDZVyoZ4C0UWM/ti7blF
         TQ+CDO8qaPlwRFWZqW7TEIkNT01056UTuWfVNyCayV1STzUhrHZQLNS71p3Bjx7s8E
         9q/siV67O39uPnKXtapHZ4pyNVn6akegu/zvDkxPnOshvvzsDsIMA0bws64+k+llO5
         jijaAWyfZbLmw==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6EC2127C0054;
        Sat, 13 Aug 2022 12:03:35 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Sat, 13 Aug 2022 12:03:35 -0400
X-ME-Sender: <xms:Vcv3YsmErhiITZcZb1ewvRfGp8WKYVpcCSXPLaOoZqAoZDRI6hMUnw>
    <xme:Vcv3Yr073Ux4YxlVXeReMUjlfVHbyjJTg9gzfkEI1_SSyoaJvzwU0N9J0zq5_ZmVj
    MW4wzlFK57Q5lD522Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegkedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduveffvdegvdefhfegjeejlefgtdffueekudfgkeduvdetvddu
    ieeluefgjeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:Vcv3YqqVem25JP1OVJnbkzhneXfFS9Q6S16Buho6LI7VhRipN9G56Q>
    <xmx:Vcv3YonhQ2lB9dIGV-tpxJr6DPp91xlTAaOrQF7DCczlz-fILodArA>
    <xmx:Vcv3Yq3hF8NrHj1hB7NM97Hzs6hqRPFCqxfri8C8NapB8tV7HSaWqg>
    <xmx:V8v3YuKfQi2x3medjAB6zQWBJAqajbP7rJJnRCJw1sUHKgQR5oCasw>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BB8CF31A0062; Sat, 13 Aug 2022 12:03:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <453fb432-ac13-4819-8395-95561bca948b@www.fastmail.com>
In-Reply-To: <20220809113827.fchtnyzy44z5fuis@box.shutemov.name>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-11-kirill.shutemov@linux.intel.com>
 <7cec93c5-3db4-409b-8c1e-bc1f10dd68fc@www.fastmail.com>
 <20220809113827.fchtnyzy44z5fuis@box.shutemov.name>
Date:   Sat, 13 Aug 2022 09:03:13 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Borislav Petkov" <bp@alien8.de>,
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
        "Dave Hansen" <dave.hansen@intel.com>,
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



On Tue, Aug 9, 2022, at 4:38 AM, Kirill A. Shutemov wrote:
> On Tue, Jul 26, 2022 at 01:17:13PM -0700, Andy Lutomirski wrote:
>>=20
>>=20
>> On Tue, Jun 14, 2022, at 5:02 AM, Kirill A. Shutemov wrote:
>> > load_unaligned_zeropad() can lead to unwanted loads across page bou=
ndaries.
>> > The unwanted loads are typically harmless. But, they might be made =
to
>> > totally unrelated or even unmapped memory. load_unaligned_zeropad()
>> > relies on exception fixup (#PF, #GP and now #VE) to recover from th=
ese
>> > unwanted loads.
>> >
>> > But, this approach does not work for unaccepted memory. For TDX, a =
load
>> > from unaccepted memory will not lead to a recoverable exception wit=
hin
>> > the guest. The guest will exit to the VMM where the only recourse i=
s to
>> > terminate the guest.
>>=20
>> Why is unaccepted memory marked present in the direct map in the firs=
t place?
>>=20
>> Having kernel code assume that every valid address is followed by
>> several bytes of memory that may be read without side effects other t=
han
>> #PF also seems like a mistake, but I probably won=E2=80=99t win that =
fight. But
>> sticking guard pages in front of definitely-not-logically present pag=
es
>> seems silly to me.  Let=E2=80=99s just not map it.
>
> It would mean no 1G pages in direct mapping for TDX as we accept 2M a
> time.
>
>> (What if MMIO memory is mapped next to regular memory?  Doing random
>> unaligned reads that cross into MMIO seems unwise.)
>
> MMIO is shared, not unaccpted private. We already handle the situation.
> See 1e7769653b06 ("x86/tdx: Handle load_unaligned_zeropad() page-cross=
 to
> a shared page").
>

I don=E2=80=99t mean in a confidential guest =E2=80=94 I mean generally.=
 This whole model of =E2=80=9Coverrun the buffer =E2=80=94 no big deal=E2=
=80=9D is just fragile.

> --=20
>   Kiryl Shutsemau / Kirill A. Shutemov
