Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6787B0F9D
	for <lists+linux-efi@lfdr.de>; Thu, 28 Sep 2023 01:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjI0XqR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Sep 2023 19:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI0XqQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Sep 2023 19:46:16 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9D4F4;
        Wed, 27 Sep 2023 16:46:14 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C2A775C25C4;
        Wed, 27 Sep 2023 19:46:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 Sep 2023 19:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695858371; x=1695944771; bh=G6
        UCu/TfSXHA2VOhzGvLxdM7gLocfJLCtB0VrZapTnA=; b=gkrf6LLSJ4W6bIbZAg
        RzRrvqvIMGENAZfJ2MuWXpjgmu3CDKFxyE+BUpA6eI0v3xoVi/7f82fM6Q8L1jyE
        LuyTdQnTd4Z5C9oBPclRNfpOwVe2iuPmeAKumst+04vq4YaUT0Mkoz11P9D4I3BW
        tKv1F8THI8SihsqqM6c8WLXpG32JuEjvxMiE8i2A+DYOuN3mTTpPuRjXOSgHyGp5
        Q/E9/lxRTWLNuvrAVLGvn+XgXLP87DYLhgoBzhXvskZ7HoNFFFPdkN7KjT/NqwjD
        kheq+mSyZZrd9CDjqPVbOlGteB1dFrZcaaaQKSQvTHGJgPOhHteExVIOZFPGBAYH
        guTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695858371; x=1695944771; bh=G6UCu/TfSXHA2
        VOhzGvLxdM7gLocfJLCtB0VrZapTnA=; b=Hmm9fUuXDcXY0zLBnAEMqUgWwdkrA
        rm5nPnXd8wmybWfO5FfyDR7VseP1xVciL1FmdrCIbhJRKZ1npjJKOpySufVgilJ+
        vwAvpA70ByYJ+MYfT0v8uVhF6mL6M9+SVRM85ZKZrEu76LxDSbowR4Hn6+aOoCVF
        FgP4zK5KVpZgNpkyX1+n/pcyCl5QbqC0CKflTmOr9HkiCY6MuMwPqJFoGRSlq3E5
        mZs9v/uKVOCQbsDYjo0SCp7WzTFmB1eeyqkUuYRN1pgPO+5myu6m/Qwjxh9xEw1m
        zdVM0T0joL1gdyL8WLzgufoRRJKU3IU2gICpoo8+gseEP36h7DU67lqjQ==
X-ME-Sender: <xms:w74UZUGHeKWbHFUQ89FiZrSRFLRZgQ-TJf_NlDR79AgyrHqcNN9x-Q>
    <xme:w74UZdUYuBN8owHxwAIabVQK0zonvgI4gL4fnFW2KXKp-mToXsCdEAEB6dU4Y5GdH
    8wXITcsSbXJb7xpDJ8>
X-ME-Received: <xmr:w74UZeJIbl2ZOqSzTq-XWIlwSFZdRHCcggijAa1m8saJbUhACg9mg9qXilOJrJjua3JJT_ZMjqlleeAGlWuW54N_Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdehgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheplfgrnhcujfgvnhgurhhikhcuhfgrrhhruceokhgvrhhnvghlsehjfh
    grrhhrrdgttgeqnecuggftrfgrthhtvghrnhepffefjeffveegjeduieevkedtieevfeeg
    gffhffevueejfefhfeffvddvgfeivdehnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghr
    nhgvlhesjhhfrghrrhdrtggt
X-ME-Proxy: <xmx:w74UZWGAq05zu-YoceKhnkzl4U5tslkxAnBjpJegOjNxpcwLBoMDew>
    <xmx:w74UZaWTDEhuxjVOt4aNPiS2RhoTYoTZeQuk1cd8ksjD09bFkUokRQ>
    <xmx:w74UZZO3A61IEoE9FBL_xddZMINYhIenZVs51JsmrwM0RsMBDthseg>
    <xmx:w74UZRMeebJ4ohThUUrTJUPsvLE1Mj2QR6myIGaKI0MsCML3ZWUvKw>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 19:46:08 -0400 (EDT)
Date:   Thu, 28 Sep 2023 01:46:06 +0200
From:   Jan Hendrik Farr <kernel@jfarr.cc>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Pingfan Liu <piliu@redhat.com>, Pingfan Liu <kernelfans@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Philipp Rudo <prudo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, keyrings@vger.kernel.org,
        Luca Boccassi <bluca@debian.org>, lennart@poettering.net,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, mjg59@google.com,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH 0/2] Sign the Image which is zboot's payload
Message-ID: <ZRS-vnMyjZRKRLhT@desktop>
References: <20230921133703.39042-1-kernelfans@gmail.com>
 <ZQ0j6Es88aR8cjRv@desktop>
 <CAF+s44R0ty0-aV+Amw2pL58YGa4JHt_y0WpiDMzehULPiC_aJw@mail.gmail.com>
 <CAMj1kXF0rZ0Ej-+x__E9=Ca8Mesb+N+35etqiUzEMzhRR6trCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF0rZ0Ej-+x__E9=Ca8Mesb+N+35etqiUzEMzhRR6trCg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 25 08:55:46, Ard Biesheuvel wrote:
> On Mon, 25 Sept 2023 at 03:01, Pingfan Liu <piliu@redhat.com> wrote:
>
> [...]
>
> > > 4. How can we debug the stubs that are being invoked?
> > > 5. Can we let the EFI binary know that this is a kexec and not a normal
> > > bootup. Potentially systemd-stub would want to change how/if it does TPM
> > > PCR measurements.
> > > ...
> > >
> >
> 
> Not sure whether this matters. The TPM logic is exposed via EFI
> protocols, and the kernel could either expose them or not. If it does,
> and we execute the EFI stub (sytemd-stub) code all the way through to
> ExitBootServices() while executing in the old kernel, we could even
> take PCR measurements and display them, giving us secure and measured
> boot for kexec.
> 

I think we should definitely delay any of the measurements until
ExitBootServices(). We don't wan't measurements of a kernel that is not
running and might even get unloaded before being kexec'ed to make their
way into the TPM.

> > Besides these questions, I wonder whether a highly configured EDK2 can
> > be used as the stub (ArmVirtQemuKernel.dsc can be the start point).
> > But there should be efforts to exclude the drivers which have the MMIO
> > access. I saw Ard is active in EDK2, maybe that is the reason why he
> > did not pick up EDK2 to serve the stub.
> >
> 
> I don't think EDK2 is suitable for this - the code style is different,
> the license is different and it is simply a lot of code.
> 
> What I would prefer is to define a subset of the EFI boot services
> that we actually rely on, and perhaps even introduce some other
> constraints on the EFI code, e.g., allow it to run unprivileged.
> 
> That way, kexec could execute the EFI stub as an ordinary user process
> (to some extent), including allocations for the decompressed kernel,
> initrd, etc. Finally, the only thing purgatory would need to do is
> linearize the populated regions in the VA space and copy them to
> physical memory.
> 
> This all sounds very high-level, and there may be some difficulties
> down the road, but I think this deserves a proper look because it is
> an appealing way to make EFI execution idempotent in the context of
> kexec, and also reduces the arch-specific logic substantially.

I just started work on a proof-of-concept implementation of this [1]. It's
kinda unorganized and early right now though. Currently just testing with
executing a bzimage with the normal EFI stub on x86. At this point it starts
executing the EFI stub which checks efi_system_table->hdr.signature for the
correct signature (which I have not set yet). That causes the EFI stub to
exit. It does correctly call the exit function from my provided boot services
table and the correct ExitStatus gets logged in dmesg. So it's able to call
into my boot services correctly.

This is definitly the most low level code I've ever written though, so
I'm just learning this stuff.

Next I'll work on setting up a proper memory mapping for the EFI
application.

After that I'll work on implementing the needed boot services and
protocols.

[1] https://github.com/Cydox/linux/commits/kexec-uefi

--

Jan
