Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB636F5D5B
	for <lists+linux-efi@lfdr.de>; Wed,  3 May 2023 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjECRzt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 May 2023 13:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjECRzs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 May 2023 13:55:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC595272
        for <linux-efi@vger.kernel.org>; Wed,  3 May 2023 10:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E53E862F1F
        for <linux-efi@vger.kernel.org>; Wed,  3 May 2023 17:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12C3C433D2;
        Wed,  3 May 2023 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683136542;
        bh=pr6VXchOekW4kaZuQqcL3QQRks0YchslFlKuv1MLJSY=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=YeX3d3ZRDN6tkgOoTIHOLpRhgIFe0uKWJ4SnN3qTzWNHVUg+kjpokKDUNhIDhlOIH
         xajJryWPn4Kp7favZeZmdV1fBZpO6/f6kjttxV4jcFVYoVI6BcwfKjRQW/kvBI4ztc
         aiu4pQDvmWznMFjBPcS4OzTRDYSYMVnJZIBT8L/1at2pXXwWv+jUy5SBZjNGBQYsw3
         ikmRJvVD2a8sn2GqatKWc1Q+cNUbKJJ4rOezdVAZqcI0MlcX2VVDX5uGGqQHXPjuQ7
         TDlvsMuFTF839FWhw32JFz96kORWJMjUBOAuQlcwvaSq3AfqsHv7ZWfUCFndDcDK6o
         GP/F0uTwkFBGQ==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id A905127C0054;
        Wed,  3 May 2023 13:55:40 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Wed, 03 May 2023 13:55:40 -0400
X-ME-Sender: <xms:G6BSZMuZ8Gk-SeJDWXruSJ1jJ1Ljomv5dWrno6lbI04NHkoTOrs-jw>
    <xme:G6BSZJf5t15-h2TjEF7-x5DwqvY5gQjjq1wGGHGnNu1xsvXNPRybfK-EigvLPznmB
    uayzDSUIAY3LsZV0HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehnugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhepudevffdvgedvfefhgeejjeelgfdtffeukedugfekuddvtedv
    udeileeugfejgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudei
    udekheeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlih
    hnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:G6BSZHxHJ5_f6Owi-vNFvoBOGMfRhNmMkO4X7LsZbRLAGC6e-2ZGaQ>
    <xmx:G6BSZPNDJsHyX6S1JgOHVOHXlazS5wDv17xzIBjbgsGRVLuFsohRVg>
    <xmx:G6BSZM8EnzgQWAROsOCgp3Vsz2h6UAS_cSZMuqYXmpBjwrUMEB3SQA>
    <xmx:HKBSZPdiI8QqTCA9eAeStE3kmfhemB4lo2OjL3w430XqLvNp4ABpgw>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 99CAB31A0063; Wed,  3 May 2023 13:55:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-386-g2404815117-fm-20230425.001-g24048151
Mime-Version: 1.0
Message-Id: <44b21bb3-a65d-4560-9fe5-c7ddc260ddc0@app.fastmail.com>
In-Reply-To: <CAMj1kXH5+scbFuaOP+VC7EHEZcn-tmp3nk=9uYGYGfJyb0S92Q@mail.gmail.com>
References: <20230416120729.2470762-1-ardb@kernel.org>
 <5694ea5d-da9a-413e-9499-02a54588a953@app.fastmail.com>
 <CAMj1kXH5+scbFuaOP+VC7EHEZcn-tmp3nk=9uYGYGfJyb0S92Q@mail.gmail.com>
Date:   Wed, 03 May 2023 10:55:19 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Ard Biesheuvel" <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Evgeniy Baskov" <baskov@ispras.ru>,
        "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Alexey Khoroshilov" <khoroshilov@ispras.ru>,
        "Peter Jones" <pjones@redhat.com>,
        "Gerd Hoffmann" <kraxel@redhat.com>,
        "Dave Young" <dyoung@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 0/3] efi: Implement generic zboot support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Apr 21, 2023, at 6:41 AM, Ard Biesheuvel wrote:
> On Fri, 21 Apr 2023 at 15:30, Andy Lutomirski <luto@kernel.org> wrote:
>>
>>
>>
>> On Sun, Apr 16, 2023, at 5:07 AM, Ard Biesheuvel wrote:
>> > This series is a proof-of-concept that implements support for the E=
FI
>> > zboot decompressor for x86. It replaces the ordinary decompressor, =
and
>> > instead, performs the decompression, KASLR randomization and the 4/5
>> > level paging switch while running in the execution context of EFI.
>>
>> I like the concept.  A couple high-level questions, since I haven=E2=80=
=99t dug into the code:
>>
>> Could zboot and bzImage be built into the same kernel image?  That wo=
uld get this into distros, and eventually someone could modify the legac=
y path to switch to long mode and invoke zboot (because zboot surely doe=
sn=E2=80=99t need actual UEFI =E2=80=94 just a sensible environment like=
 what UEFI provides.)
>>
>
> That's an interesting question, and to some extent, that is actually
> what Evgeny's patch does: execute more of what the decompressor does
> from inside the EFI runtime context.
>
> The main win with zboot imho is that we get rid of all the funky
> heuristics that look for usable memory for trampolines and
> decompression buffers in funky ways, and instead, just use the EFI
> APIs for allocating pages and remapping them executable as needed
> (which is the important piece here) I'd have to think about whether
> there is any middle ground between this approach and Evgeny's - I'll
> have to get back to you on that.
>

Hmm.  I dug the tiniest bit into the history.  The x86/boot/compressed s=
tuff has an allocator!  It's this:

        free_mem_ptr     =3D heap;        /* Heap */
        free_mem_end_ptr =3D heap + BOOT_HEAP_SIZE;

plus a trivial and horrible malloc() implementation in include/linux/dec=
ompress/mm.h.  There's one caller in x86/boot/compressed.

And, once upon a time, the idea of allocating enough memory to store the=
 kernel from the decompressor would have been a problem.  I'm willing to=
 claim that we should not even try to support x86 systems that have that=
 little memory (at least not once they've gotten long mode or at least f=
lat 32-bit protected mode working).  We should not try to allocate below=
 1MB (my laptop will cry), but there's no need for that.

So maybe the middle ground is to build a modern, simple malloc(), and ba=
ck it by EFI when EFI is there and by just finding some free memory when=
 EFI is not there?

This would be risky -- someone might have a horrible machine that has tr=
ouble with a simple allocator.
