Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75756BA166
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 22:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCNVYX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 17:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCNVYU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 17:24:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8EE55519;
        Tue, 14 Mar 2023 14:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AF9A619E4;
        Tue, 14 Mar 2023 21:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A530C4339B;
        Tue, 14 Mar 2023 21:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678829042;
        bh=YqViZD41gexkA1fXl8jJ1gtu6PrOo8wk/cq3HkC/8tA=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=RKLEvu4ThAfJ0unmpd/t1SefIVvTTYbe8Cs2R5GKuErwrCJo7hQmtgoV6Zmp46CdI
         z6a3imXZeAt9lUefOL8vdsqFZIewsneMK516YvlfutIbEcsR3T+ivjr88OzGyj71VR
         DqtFmQTNXXf666PbZdE86cCGPjHwbDbl4OnDiA66PSFYLIki8c+wu9UECuUit0IpKa
         Lff0b5EWMOsDE5KZuVMa1hKwCF+Z/fmRWCAv+zK9ICvEb4GXnuqcK2BNx3LF9Tjaj1
         0d9XbStBvb8MunU7dIKb4Ho1VHq9lH+EdoT2GpSIJ3RrTIVlbxBrUT5DlIQaKOexp9
         AlPoonaAxs/9w==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 05C1D27C0054;
        Tue, 14 Mar 2023 17:24:00 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Tue, 14 Mar 2023 17:24:01 -0400
X-ME-Sender: <xms:8OUQZKn6AMpqGGnCFFr_ESQ3UsDJc2WEV-8QnY0aNAR9r7GQ0dAypQ>
    <xme:8OUQZB2sYM3ClM7ZFcJBS5O6AItJ1IPkuSI8dhMxUzqK7Qg6-v8TcGdXD36Dp1rKP
    _v0AV9xvpRExnf1t3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddviedgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefhhffhjefgteeiudfgledvveejvdeugfehkeevudejgffhffdt
    veffffelhedtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtg
    homhdpmhhitghrohhsohhfthdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrg
    hlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgv
    lhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:8OUQZIqu5xQuQvVQPudIQnU0ZRnxDtEpF217ioYbfb2sx0tl3_HMjA>
    <xmx:8OUQZOm4kOUpymH0f8YFQMKJ1Vn7-mTUOg68yZo4g7gXdrAQ7Hpf-w>
    <xmx:8OUQZI3Vz4VoXpO2jGBTxOaLo2kKziVeAQfaGZ0puJa1Bc87vlyUNg>
    <xmx:8OUQZCPfRMyO6dFwPhYMmr1hgEZIAjO5Q36IwH4XHHzu-DVsjC2Kig>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2054F31A0063; Tue, 14 Mar 2023 17:24:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <d575db7f-bad3-477e-a501-19d2d84527cd@app.fastmail.com>
In-Reply-To: <cover.1678785672.git.baskov@ispras.ru>
References: <cover.1678785672.git.baskov@ispras.ru>
Date:   Tue, 14 Mar 2023 14:23:39 -0700
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Mar 14, 2023, at 3:13 AM, Evgeniy Baskov wrote:
> This patchset is aimed
> * to improve UEFI compatibility of compressed kernel code for x86_64
> * to setup proper memory access attributes for code and rodata sections
> * to implement W^X protection policy throughout the whole execution 
>   of compressed kernel for EFISTUB code path. 

The overall code quality seems okay, but I have some questions as to what this is for.  The early boot environment is not exposed to most sorts of attacks -- there's no userspace, there's no network, and there is not a whole lot of input that isn't implicitly completely trusted.

What parts of this series are actually needed to get these fancy new bootloaders to boot Linux?  And why?

>
> Kernel is made to be more compatible with PE image specification [3],
> allowing it to be successfully loaded by stricter PE loader
> implementations like the one from [2]. There is at least one
> known implementation that uses that loader in production [4].
> There are also ongoing efforts to upstream these changes.

Can you clarify 

>
> Also the patchset adds EFI_MEMORY_ATTTRIBUTE_PROTOCOL, included into
> EFI specification since version 2.10, as a better alternative to
> using DXE services for memory protection attributes manipulation,
> since it is defined by the UEFI specification itself and not UEFI PI
> specification. This protocol is not widely available so the code
> using DXE services is kept in place as a fallback in case specific
> implementation does not support the new protocol.
> One of EFI implementations that already support
> EFI_MEMORY_ATTTRIBUTE_PROTOCOL is Microsoft Project Mu [5].

Maybe make this a separate series?

> 
> Kernel image generation tool (tools/build.c) is refactored as a part
> of changes that makes PE image more compatible.
>   
> The patchset implements memory protection for compressed kernel
> code while executing both inside EFI boot services and outside of
> them. For EFISTUB code path W^X protection policy is maintained
> throughout the whole execution of compressed kernel. The latter
> is achieved by extracting the kernel directly from EFI environment
> and jumping to it's head immediately after exiting EFI boot services.
> As a side effect of this change one page table rebuild and a copy of
> the kernel image is removed.

I have no problem with this, but what's it needed for?

>
> Memory protection inside EFI environment is controlled by the
> CONFIG_DXE_MEM_ATTRIBUTES option, although with these patches this
> option also control the use EFI_MEMORY_ATTTRIBUTE_PROTOCOL and memory
> protection attributes of PE sections and not only DXE services as the
> name might suggest.
>

> [1] 
> https://lore.kernel.org/lkml/893da11995f93a7ea8f7485d17bf356a@ispras.ru/
> [2] https://github.com/acidanthera/audk/tree/secure_pe

Link is broken

> [3] 
> https://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/pecoff_v83.docx

I skimmed this very briefly, and I have no idea what I'm supposed to look at.  This is the entire PE spec!
