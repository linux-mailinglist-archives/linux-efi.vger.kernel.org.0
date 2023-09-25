Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6C37AD3DE
	for <lists+linux-efi@lfdr.de>; Mon, 25 Sep 2023 10:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjIYI4I (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Sep 2023 04:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjIYI4H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Sep 2023 04:56:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C67C0;
        Mon, 25 Sep 2023 01:56:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A08BC4339A;
        Mon, 25 Sep 2023 08:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695632160;
        bh=OAHGiE3HtiQuwoXQpyli72/6uLnWVVPrSWTK/m76VUg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FAMvLJECwoxaPpqGbYpHmiWyMRIpqfItq9r1MoG95mNmgRk6w+3/ov1yIqVPwWosX
         tn5V20TmbuxyIjpW6J3S8N2uDHjIK05dYR9iXrV5ING/joODy34fmMA9iKjo6nIz0z
         xIPrPld25ZS+PFbGwWuQzNT/3GK/xmcNTPZN71/rmTxntGWj/vG/Mq55AoauETDWo8
         dhpXQyWMw8huYCbBpJvn4+tX5pi+Uc+YbTRnfV1jdpUgURb+dibAi6G5ZBzIVfFJIN
         9cFJ7+324FybQFWIpvnSQwyY7YwXN6sktVP3Qzw9eEoj2hb/RTf2dDGcBvmKxbaBdz
         8BlBGAJgTGFJA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5043120ffbcso8447763e87.2;
        Mon, 25 Sep 2023 01:56:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YxQg320B1LuzYMq7T92vl9prUrSC0BjndBlhvqyYQ6o99ws/2le
        FADkW5uK8emOqqw2o2tObYFeXo5+COl4uons7vs=
X-Google-Smtp-Source: AGHT+IHdWMl/7v2aSkpx8fA68Ctqs2uUqJy0Qw1DszW5NlpXS1U3dVeLT7Sy6ikU1FB/vTB2nfITSm8TKbj97xSlKT8=
X-Received: by 2002:a05:6512:318d:b0:4fd:f84f:83c1 with SMTP id
 i13-20020a056512318d00b004fdf84f83c1mr5950519lfe.64.1695632158118; Mon, 25
 Sep 2023 01:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230921133703.39042-1-kernelfans@gmail.com> <ZQ0j6Es88aR8cjRv@desktop>
 <CAF+s44R0ty0-aV+Amw2pL58YGa4JHt_y0WpiDMzehULPiC_aJw@mail.gmail.com>
In-Reply-To: <CAF+s44R0ty0-aV+Amw2pL58YGa4JHt_y0WpiDMzehULPiC_aJw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 25 Sep 2023 08:55:46 +0000
X-Gmail-Original-Message-ID: <CAMj1kXF0rZ0Ej-+x__E9=Ca8Mesb+N+35etqiUzEMzhRR6trCg@mail.gmail.com>
Message-ID: <CAMj1kXF0rZ0Ej-+x__E9=Ca8Mesb+N+35etqiUzEMzhRR6trCg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Sign the Image which is zboot's payload
To:     Pingfan Liu <piliu@redhat.com>
Cc:     Jan Hendrik Farr <kernel@jfarr.cc>,
        Pingfan Liu <kernelfans@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 25 Sept 2023 at 03:01, Pingfan Liu <piliu@redhat.com> wrote:
>
> On Fri, Sep 22, 2023 at 1:19=E2=80=AFPM Jan Hendrik Farr <kernel@jfarr.cc=
> wrote:
> >
...
> > I missed some of the earlier discussion about this zboot kexec support.
> > So just let me know if I'm missing something here. You were exploring
> > these two options in getting this supported:
> >
> > 1. Making kexec_file_load do all the work.
> >
> > This option makes the signature verification easy. kexec_file_load
> > checks the signature on the pe file and then extracts it and does the
> > kexec.
> >
> > This is similar to how I'm approaching UKI support in [1].
> >
>
> Yes, that is my original try.
>
> > 2. Extract in userspace and pass decompressed kernel to kexec_file_load
> >
> > This option requires the decompressed kernel to have a valid signature =
on
> > it. That's why this patch adds the ability to add that signature to the
> > kernel contained inside the zboot image.
> >
>
> You got it.
>
> > This option would not make sense for UKI support as it would not
> > validate the signature with respect to the initrd and cmdline that it
> > contains. Am I correct in thinking that there is no similar issue with
> > zboot images? They don't contain any more information besides the kerne=
l
> > that is intended to be securely signed, right? Do you have a reference
>
> If using my second method, it means to unpack the UKI image in user
> space, and pass the kernel image, initrd and cmdline through
> kexec_file_load interface. If the UKI can have signature on the initrd
> and cmdline, we extend the capability of that interface to check those
> verification.
>
> > for the zboot image layout somewhere?
> >
>
> Sorry that maybe there is no document. I understand them through the code=
.
> The zboot image, aka, vmlinuz.efi looks like:
> PE header, which is formed manually in arch/arm64/kernel/head.S
> EFI decompressor, which consists of
> drivers/firmware/efi/libstub/zboot.c and libstub
> Image.gz, which is formed by compressing Image as instructed in Makefile.=
zboot
>
>

Indeed, this is currently only documented in code. zboot is a PE
executable that decompresses the kernel and boots it, but it also
carries the base and size of the compressed payload in its header,
along with the compression type so non-EFI loaders can run it as well
(QEMU implements this for gzip on arm64)

> > > I hesitate to post this series,
> >
> > I appreciate you sending it, it's helping the discussion along.
> >

Absolutely. RFCs are important because nobody knows how exactly the
code will look until someone takes the time to implement it. So your
work on this is much appreciated, even if we may decide to take
another approach down the road.

> > > [...] since Ard has recommended using an
> > > emulated UEFI boot service to resolve the UKI kexec load problem [1].
> > > since on aarch64, vmlinuz.efi has faced the similar issue at present.
> > > But anyway, I have a crude outline of it and am sending it out for
> > > discussion.
> >
> > The more I'm thinking about it, the more I like Ard's idea. There's now
> > already two different formats trying to be added to kexec that are
> > pretty different from each other, yet they both have the UEFI interface
> > in common. I think if the kernel supported kexec'ing EFI applications
> > that would be a more flexible and forward-looking approach. It's a
>
> Yes, I agree. That method is attractive, originally I had a try when
> Ard suggested it but there was no clear boundary on which boot service
> should be implemented for zboot, so I did not move on along that
> direction.
>
> Now, UKI poses another challenge to kexec_file_load, and seems to
> require more than zboot. And it appears that Ard's approach is a
> silver bullet for that issue.
>

Yes, it looks appealing but it will take some time to iterate on ideas
and converge on an implementation.

> > standard that both zboot and UKI as well as all future formats for UEFI
> > platforms will support anyways. So while it's more work right now to
> > implement, I think it'll likely pay off.
> >
> > It is significantly more work than the other options though. So I think
> > before work is started on it, it would be nice to get some type of
> > consensus on these things (not an exhaustive list, please feel free to
> > add to it):
> >
>
> I try to answer part of the questions.
>
> > 1. Is it the right approach? It adds a significant amount of userspace
> > API.
>
> My crude assumption: this new stub will replace the purgatory, and I
> am not sure whether kexec-tools source tree will accommodate it. It
> can be signed and checked during the kexec_file_load.
>
> > 2. What subset of the UEFI spec needs/should to be supported?
> > 3. Can we let runtime services still be handled by the firmware after
> > exiting boot services?
>
> I think the runtime services survive through the kexec process. It is
> derived from the real firmware, not related with this stub
>

Yes, this should be possible.

> > 4. How can we debug the stubs that are being invoked?
> > 5. Can we let the EFI binary know that this is a kexec and not a normal
> > bootup. Potentially systemd-stub would want to change how/if it does TP=
M
> > PCR measurements.
> > ...
> >
>

Not sure whether this matters. The TPM logic is exposed via EFI
protocols, and the kernel could either expose them or not. If it does,
and we execute the EFI stub (sytemd-stub) code all the way through to
ExitBootServices() while executing in the old kernel, we could even
take PCR measurements and display them, giving us secure and measured
boot for kexec.

> Besides these questions, I wonder whether a highly configured EDK2 can
> be used as the stub (ArmVirtQemuKernel.dsc can be the start point).
> But there should be efforts to exclude the drivers which have the MMIO
> access. I saw Ard is active in EDK2, maybe that is the reason why he
> did not pick up EDK2 to serve the stub.
>

I don't think EDK2 is suitable for this - the code style is different,
the license is different and it is simply a lot of code.

What I would prefer is to define a subset of the EFI boot services
that we actually rely on, and perhaps even introduce some other
constraints on the EFI code, e.g., allow it to run unprivileged.

That way, kexec could execute the EFI stub as an ordinary user process
(to some extent), including allocations for the decompressed kernel,
initrd, etc. Finally, the only thing purgatory would need to do is
linearize the populated regions in the VA space and copy them to
physical memory.

This all sounds very high-level, and there may be some difficulties
down the road, but I think this deserves a proper look because it is
an appealing way to make EFI execution idempotent in the context of
kexec, and also reduces the arch-specific logic substantially.
