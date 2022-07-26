Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB883581AE5
	for <lists+linux-efi@lfdr.de>; Tue, 26 Jul 2022 22:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiGZUS0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Jul 2022 16:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbiGZUSM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Jul 2022 16:18:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D2F371B6;
        Tue, 26 Jul 2022 13:17:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 114566160D;
        Tue, 26 Jul 2022 20:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277ACC433B5;
        Tue, 26 Jul 2022 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658866659;
        bh=GIbzRLMc9lrNfJDLat0Hlv7hVWiWNwlnlBD/YoWm7qk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=HUgoqY2e9W43NpWGppKfLxqPT6/YHFWqQPaWTnFvfuupCtEEEighHCoWgZkclwHVw
         8AqhJMfX+te8UwJm4gMUuKSx8n+GXYBzLffSEANnsXLwSol0V+QNQXyx/g6t5kzThs
         onAwtDCafnKiMzQqr23be8U8Wc+OZApDBGF5KWcE5XWncQTJ8seJxWH7Nx4iFwVPIU
         OA4kZ/A/sDYa3cr9SrTD06uJ5l1tgypf9VGGppBUF7fiwzgnug8UK9Gt4fuZZvNx3j
         gT1UYbxAndS/v6xebtRaMF0OHeIYE3sb/dG/el95rgE8BHFreVM4ORt5eQoi5i+hbL
         dwVDq+WOW3mkA==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id E625C27C0054;
        Tue, 26 Jul 2022 16:17:36 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Tue, 26 Jul 2022 16:17:36 -0400
X-ME-Sender: <xms:3kvgYpARSMhj5VmUmkVurT4f9xIAbHMjszDAsk4s7T_ZDEAnZEkIIw>
    <xme:3kvgYnj2LF_o1PLtJkx6eKicevIJ0clraa1BkE-gW0pLj_FIhm4YY3MSBzxUOKhNc
    qZdmQ6EZUjiY0lqW_4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddutddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehnugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhepudevffdvgedvfefhgeejjeelgfdtffeukedugfekuddvtedv
    udeileeugfejgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudei
    udekheeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlih
    hnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:3kvgYkkZlSnTU32WZ_55gKqv5cIe7D964TqhbVuzL27aabuDTxKoFw>
    <xmx:3kvgYjzGYouhLPqDLXVDOuV8KE_sgB1ywcMsUliOZTPqL2TCFgGRLw>
    <xmx:3kvgYuQTvBqwlKuScxo52TwDLjHx0G3L6F5Uc0misveIhuFHKWG6LA>
    <xmx:4EvgYpk51w0Q1qFeRijHIUCHVuwPtaZDWCkAVAH3NfYUJT4uI259qA>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C5B1A31A0062; Tue, 26 Jul 2022 16:17:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-757-gc3ad9c75d3-fm-20220722.001-gc3ad9c75
Mime-Version: 1.0
Message-Id: <7cec93c5-3db4-409b-8c1e-bc1f10dd68fc@www.fastmail.com>
In-Reply-To: <20220614120231.48165-11-kirill.shutemov@linux.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-11-kirill.shutemov@linux.intel.com>
Date:   Tue, 26 Jul 2022 13:17:13 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Sean Christopherson" <seanjc@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Joerg Roedel" <jroedel@suse.de>,
        "Ard Biesheuvel" <ardb@kernel.org>
Cc:     "Andi Kleen" <ak@linux.intel.com>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On Tue, Jun 14, 2022, at 5:02 AM, Kirill A. Shutemov wrote:
> load_unaligned_zeropad() can lead to unwanted loads across page bounda=
ries.
> The unwanted loads are typically harmless. But, they might be made to
> totally unrelated or even unmapped memory. load_unaligned_zeropad()
> relies on exception fixup (#PF, #GP and now #VE) to recover from these
> unwanted loads.
>
> But, this approach does not work for unaccepted memory. For TDX, a load
> from unaccepted memory will not lead to a recoverable exception within
> the guest. The guest will exit to the VMM where the only recourse is to
> terminate the guest.

Why is unaccepted memory marked present in the direct map in the first p=
lace?

Having kernel code assume that every valid address is followed by severa=
l bytes of memory that may be read without side effects other than #PF a=
lso seems like a mistake, but I probably won=E2=80=99t win that fight. B=
ut sticking guard pages in front of definitely-not-logically present pag=
es seems silly to me.  Let=E2=80=99s just not map it.

(What if MMIO memory is mapped next to regular memory?  Doing random una=
ligned reads that cross into MMIO seems unwise.)
