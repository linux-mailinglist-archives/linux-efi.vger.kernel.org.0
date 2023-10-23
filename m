Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1537D3DE1
	for <lists+linux-efi@lfdr.de>; Mon, 23 Oct 2023 19:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjJWRfr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Oct 2023 13:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjJWRfq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Oct 2023 13:35:46 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B89A3;
        Mon, 23 Oct 2023 10:35:43 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id DC6155C0371;
        Mon, 23 Oct 2023 13:35:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 23 Oct 2023 13:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698082539; x=1698168939; bh=ge
        yH5WqMlThfcHZLlfgq+oFzVP2Hwr+FGtkBpCnynnU=; b=i2EEOUodXYKQcARsKD
        7JKLLYx5t4i7TiomDbTxcdq2SqBLW6eQtOpjuHRXAzGKRZgqytbtILamKxt/CctI
        d8J4eQWvmyD8muBNDC9RI120m+jGD/8mGSrwPUXnOKAzjw2rgWMAQ53XV00iXzt3
        D9MAhFh3wCmdi2NfQmi0QgiLf1mfQN0forvMG1JVHuaqlUusKkxqSh+2mDHgfFnb
        YQOKz9lu3ZcL663e6zdUK0+2CXqUDc5KpSt3pVZ2skjrZ+yEhg6b1L10zPkLAxif
        tYhGMtEYg/QB54le5SlKu2FyGF2Q+SIpIPt+lETtvHrsErCwQOtl8+GhoTXGujlh
        9R0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698082539; x=1698168939; bh=geyH5WqMlThfc
        HZLlfgq+oFzVP2Hwr+FGtkBpCnynnU=; b=CtQFK5neqSQQTTlmZ8BnPAPOmuwJ5
        v1UHMG7jGV3tjDPduIJKUFFtDKeKev6AEAxu5D8PG6Dia6w1VGqdgm3VKSBRbC28
        VEBRnv2o4zee1OWV/hBOyt8ciWGVmIdejRsctI8qbj7T3yK23dAAFsHFoPnn1UPS
        McTlV6zc5JGxPHyzmNr3Ei+A6WrYafFDGIatmoNTi9Krl2RA80GDAHwTSA19uy0B
        UKf+4VnThg12lJy9twtaw6eFy1N65gvtu2jcTixemaTOSUHMFVcmTn+ZXMkXL2B7
        msO8MoMtGge/3S4gzyc86E7tvbmmBngdTab7VcdGqxAOkP/HByRpgEk+g==
X-ME-Sender: <xms:6q42ZSyQCf4729eqqf9vwNE6j0zTH-SHXUs9Jn28UhLf2feGvGvEYA>
    <xme:6q42ZeQGIBqSldSZ1F9ZnNGKt5OOn5YhOvs1L366lbkpNs9v7usL_Pw_5cR7jECG4
    aych2Pfg8p224xiLTo>
X-ME-Received: <xmr:6q42ZUUfZO_LwiloXppUq2S1pAd0OqDukNh0YwTekqZMApFT6FkwxXYq-ijKE080023JCFjF3kdY5v-E-wKs7bNGPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrghrrhcuoehkvghrnhgvlhesjh
    hfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpedukeegffdtfeeihfehteevvdeiueet
    teelgfefvdfhleeufeegieduieduhfekieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesjhhfrghrrhdrtggt
X-ME-Proxy: <xmx:6q42ZYi6ONALunCX-EndTyp9EColjBiotEymobq4P8drJUpIf9OUDA>
    <xmx:6q42ZUBgYcHzJIkrQMZDxf13sM-t1ZPH1SrhSL7Tb9bDKgz3vkTSsA>
    <xmx:6q42ZZIX1o7TrZr8NQbHoMV4_XsvEEE8yd9XXaqMDlqEhO8v9V_lYw>
    <xmx:6642ZQ7TNZq-6QSGUxl0ISvZlp23wTvj_1q0TOaKOADqC6CPRQ-H_g>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 13:35:36 -0400 (EDT)
Date:   Mon, 23 Oct 2023 19:35:34 +0200
From:   Jan Hendrik Farr <kernel@jfarr.cc>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ard Biesheuvel <ardb@google.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 00/15] x86/boot: Rework PE header generation
Message-ID: <ZTau5kbdB-9iRfcm@desktop>
References: <20230912090051.4014114-17-ardb@google.com>
 <ZRt2ToOHm2XT8MlU@desktop>
 <CAMj1kXH--86-pqHp6W0gsRDAMw-iuYKrgHEpmZzaJnpsVTkkxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH--86-pqHp6W0gsRDAMw-iuYKrgHEpmZzaJnpsVTkkxw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 23 13:22:53, Ard Biesheuvel wrote:
> On Tue, 3 Oct 2023 at 04:03, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
> >
> > On 12 09:00:51, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Now that the EFI stub boot flow no longer relies on memory that is
> > > executable and writable at the same time, we can reorganize the PE/COFF
> > > view of the kernel image and expose the decompressor binary's code and
> > > r/o data as a .text section and data/bss as a .data section, using 4k
> > > alignment and limited permissions.
> > >
> > > Doing so is necessary for compatibility with hardening measures that are
> > > being rolled out on x86 PCs built to run Windows (i.e., the majority of
> > > them). The EFI boot environment that the Linux EFI stub executes in is
> > > especially sensitive to safety issues, given that a vulnerability in the
> > > loader of one OS can be abused to attack another.
> >
> > This split is also useful for the work of kexecing the next kernel as an
> > EFI application. With the current EFI stub I have to set the memory both
> > writable and executable which results in W^X warnings with a default
> > config.
> >
> > What made this more confusing was that the flags of the .text section in
> > current EFI stub bzImages are set to
> > IMAGE_SCN_MEM_EXECUTE | IMAGE_SCN_MEM_READ. So if you load that section
> > according to those flags the EFI stub will quickly run into issues.
> >
> > I assume current firmware on x86 machines does not set any restricted
> > permissions on the memory. Can someone enlighten me on their behavior?
> >
> 
> No current x86 firmware does not use restricted permissions at all.
> All memory is mapped with both writable and executable permissions,
> except maybe the stack.
> 
> The x86 Linux kernel has been depending on this behavior too, up until
> recently (fixes are in -rc now for the v6.6 release). Before this, it
> would copy its own executable image around in memory.
> 
> So EFI based kexec will need to support this behavior if it targets
> older x86 kernels, although I am skeptical that this is a useful
> design goal.

I don't see this as an important goal either.

> I have been experimenting with running the EFI stub code in user space
> all the way until ExitBootServices(). The same might work for UKI if
> it is layered cleanly on top of the EFI APIs (rather than poking into
> system registers or page tables under the hood).
> 
> How this would work with signed images etc is TBD but I quite like the
> idea of running everything in user space and having a minimal
> purgatory (or none at all) if we can simply populate the entire
> address space while running unprivileged, and just branch to it in the
> kexec() syscall. I imagine this being something like a userspace
> helper that is signed/trusted itself, and gets invoked by the kernel
> to run EFI images that are trusted and tagged as being executable
> unprivileged.

I've been experimenting with running EFI apps inside kernel space instead.
This is the more natural approach for signed images. Sure, a malicious EFI
app could do arbitrary stuff in kernel mode, but they're signed. On the other
hand running this entirely in user space would at least guarantee that the
system can not crash due to a misbehaving EFI app (at least until
ExitBootServices()).

The question of whether or not to make this the job of a userspace helper that
is signed must have come up when kexec_file_load syscall was added. It would
have also been an option at the time to extend trust to a signed version of
the userspace kexec tool.

Why was kexec_file_load created instead of restricting kexec_load to a signed
version of the kexec userspace tool?

