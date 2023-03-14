Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AA16BA37D
	for <lists+linux-efi@lfdr.de>; Wed, 15 Mar 2023 00:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCNXV2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 19:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCNXVY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 19:21:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056ED30E84;
        Tue, 14 Mar 2023 16:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F6F261A43;
        Tue, 14 Mar 2023 23:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B18C433D2;
        Tue, 14 Mar 2023 23:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678836081;
        bh=1LpG8Owr5h1Nv/yVkTjkl6nlXkxG8Oan2DRA4buy3zE=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=TlmqXPQ6PCSyTMy7FM1O2V+iWNqVaBb7Iy3h36aSy8QcjtFubzEIPmPYMRvRoX2N5
         VF7+9EUU7kesqX4EUfyFUKQNcTrnGfCXeAKuE5NKKaqJVBT845IBUpXYN9VoWJrdj5
         qagmLbTfH4BQ+YD5VPK8IGVlZ/JN/pQyi7QiMkhl7lDxktwTO1WCUOUCsRxGEnWkVV
         BBvM1o8rTitEkXvsQVf0e4iTN8kJ5IFk689Sf1cu2/ybM2YsOCufAp8HrdXO7SRjuS
         rhWFiYRg3ct6h3OFgft0C2G7BT2cGjGEMHZgQKmCUIzJe5mxbtjK3FrgVgOpUUudug
         NjjkyAWthKyJg==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id CE3D827C0054;
        Tue, 14 Mar 2023 19:21:19 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Tue, 14 Mar 2023 19:21:19 -0400
X-ME-Sender: <xms:bgERZF-R6V2BvHK54N93fzcPxKyYc04MEA6T3NLYUK8L6QQ49J3r3w>
    <xme:bgERZJtbmILXoH6H7gR_0JSDSFcLwvjYyMgsh2AiO2UDXAHk5U_xnC9E2LI_uUICX
    tKUHNQv5KRKFB24DQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvjedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgedugedtledtieduteffveevhfefheeuhfegfeduvdeltdeugeet
    veeliedvfeehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluh
    htoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:bgERZDCbcFEkx3oeJCN44ysiNNUUI0Fqa289qbZyDAjvNp2swyYjzg>
    <xmx:bgERZJefgs1xsuybL_QtwGHtzoqyCJtwPMw957We9aZawtPxMqYmgA>
    <xmx:bgERZKNhdykp_OA2tlYxeiYIR2IuPQbDA-pniq8zlxMl4tvBV3fidw>
    <xmx:bwERZBkgrohfTVb_w_Y35cX-J-LaoJ_JiG8IBv0Fy0YsgTh6EV7LuQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C2D3731A0063; Tue, 14 Mar 2023 19:21:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <ea1b6e36-c434-49e9-bede-b4bd2b41868d@app.fastmail.com>
In-Reply-To: <d575db7f-bad3-477e-a501-19d2d84527cd@app.fastmail.com>
References: <cover.1678785672.git.baskov@ispras.ru>
 <d575db7f-bad3-477e-a501-19d2d84527cd@app.fastmail.com>
Date:   Tue, 14 Mar 2023 16:20:43 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Evgeniy Baskov" <baskov@ispras.ru>,
        "Ard Biesheuvel" <ardb@kernel.org>
Cc:     "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Alexey Khoroshilov" <khoroshilov@ispras.ru>,
        "Peter Jones" <pjones@redhat.com>,
        "Gerd Hoffmann" <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 00/27] x86_64: Improvements at compressed kernel stage
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On Tue, Mar 14, 2023, at 2:23 PM, Andy Lutomirski wrote:
> On Tue, Mar 14, 2023, at 3:13 AM, Evgeniy Baskov wrote:
>>
>> Kernel is made to be more compatible with PE image specification [3],
>> allowing it to be successfully loaded by stricter PE loader
>> implementations like the one from [2]. There is at least one
>> known implementation that uses that loader in production [4].
>> There are also ongoing efforts to upstream these changes.
>
> Can you clarify 

Sorry, lost part of a sentence.  Can you clarify in what respect the loader is stricter?


Anyway, I did some research.  I found:

https://github.com/rhboot/shim/pull/459/commits/99a8d19326f69665e0b86bcfa6a59d554f662fba

which gives a somewhat incoherent-sounding description in which setting EFI_IMAGE_DLLCHARACTERISTICS_NX_COMPAT apparently enables allocating memory that isn't RWX.  But this seems odd EFI_IMAGE_DLLCHARACTERISTICS_NX_COMPAT is a property of the EFI *program*, not the boot services implementation.  And I'd be surprised if a flag on the application changes the behavior of boot services, but, OTOH, this is Microsoft.

And the PE 89 spec does say that EFI_IMAGE_DLLCHARACTERISTICS_NX_COMPAT means "Image is NX compatible" and that is the sole mention of NX in the document.

And *this* seems to be the actual issue:

https://github.com/rhboot/shim/pull/459/commits/825d99361b4aaa16144392dc6cea43e24c8472ae

I assume that MS required this change as a condition for signing, but what do I know?  Anyway, the rules appear to be that the PE sections must not be both W and X at the same size.  (For those who are familiar with the abomination known as ELF but not with the abomination known as PE, a "section" is a range in the file that gets mapped into memory.  Like a PT_LOAD segment in ELF.)

Now I don't know whether anything prevents us from doing something awful like mapping the EFI stuf RX and then immediately *re*mapping everything RWX.  (Not that I'm seriously suggesting that.)  And it's not immediately clear to me how the rest of this series fits in, what this has to do with the identity map, etc.

Anyway, I think the series needs to document what's going on, in the changelog and relevant comments.  And if the demand-population of the identity map is a problem, then there should be a comment like (made up -- don't say this unless it's correct):

A sufficiently paranoid EFI implementation may enforce W^X when mapping memory through the boot services protocols.  And creating identity mappings in the page fault handler needs to use the boot services protocols to do so because [fill this in] [or it would be a bit of an abomination to do an end run around them by modifying the page tables ourselves] [or whatever is actually happening].  While we *could* look at the actual fault type and create an R or RW or RX mapping as appropriate, it's better to figure out what needs to be mapped for real and to map it with the correct permissions before faulting.

But I still think we should keep the demand-faulting code as a fallback, even if it's hardcoded as RW, and just log the fault mode and address.  We certainly shouldn't be *executing* code that wasn't identity mapped.  Unless that code is boot services and we're creating the boot services mappings!

For that matter, how confident are we that there aren't crappy boot services implementations out there that require that we fix up page faults? After all, it's not like EFI implementations, especially early ones, are any good.

--Andy
