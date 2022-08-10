Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D414758E948
	for <lists+linux-efi@lfdr.de>; Wed, 10 Aug 2022 11:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiHJJHd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Aug 2022 05:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiHJJHc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 10 Aug 2022 05:07:32 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BBD74DDA;
        Wed, 10 Aug 2022 02:07:30 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id k12so22286939ybk.6;
        Wed, 10 Aug 2022 02:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5bfd0TT16CcJtnkLNNp0P7AOtKZ2EogVES3OM0Yn8To=;
        b=g56aEQSwQ0yhPix+Pfw/Gjs9QwQQcU+/R692fDmZ0Qr/oMzK1AYd6JrciH+HNM3N7j
         HJ+o6MJr4ZF+45z9LUrfSDlBIoLu4hgI14AcQSSmJuVfUtBYCH8pWyZqaSyLXTFYTwnY
         ItKFTnZ6PCJ/lnYuCaGDL1R+TfxiENG5XVHwPsfPH6LniQtUyzpn2+0j/7v/R4/ftQDy
         DFjgBr81oISZMooKkN9CDELzpA4Ychda1+unO12us1eJFiTCaYaaiiXQ0lmLNS+6zH3e
         iPgwxycHT6R6ehAN95p32BFu4mXOC/+tDDqJ9yheq0mAW4Xm2gtoNeOvSq5R1lc/RffE
         /UuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5bfd0TT16CcJtnkLNNp0P7AOtKZ2EogVES3OM0Yn8To=;
        b=S3AhmG4pUoplVRwKkLCfhwWf1Q1MfQOLBSm+KgAP9HRYP3YpvCXqnzxGjkMS+wTItJ
         77SAgzd9KdGnPkDS1pNl+5Grix3s3U3qRtO3ShXH/UIqbXszqxjmUufqWegSK6MHl6is
         7uSNEtwOXwMGRQxDnDAYfq2JT9lIumQekADDlyNST6rWm3wQdNjBC8ZQa0RlxzjB4qYD
         vy0bQr6DBh+RvcpouG6wzmwgTAus9Al4ZffKUVFbQnTmVsg9OJMv68sIGRgG9AewSclQ
         KOgiBr01jzW06PdQz/qLBGYciht+8t2L/tcnFdwNze1B6kcFHYKLGKolN/n6qCCCKtK9
         vqqg==
X-Gm-Message-State: ACgBeo0SKLsCGQitRdlgUVknHmTTkUJJKJrKONY/hArdeRpxaj9Sue3a
        79gl02ILfwxRjGGQCiJUCKHsGaxShPeSWtwksqU=
X-Google-Smtp-Source: AA6agR5ugFjNFRzTbTBrmh9MzqHq4kJaDCZUH5/OnKmpmYadclqc9h+Dw/oyE4ze/Gk99e6O5EjcXAtZl/Zmk+8SnV4=
X-Received: by 2002:a25:d658:0:b0:67b:37ca:dc04 with SMTP id
 n85-20020a25d658000000b0067b37cadc04mr24061093ybg.431.1660122449994; Wed, 10
 Aug 2022 02:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220329174057.GA17778@srcf.ucam.org> <f9622b47-c45f-8c91-cb85-e5db7fd541cf@apertussolutions.com>
 <CAMj1kXEUT8BK_akqjF1Wx0JkLniFyV_h9s1TfQnPqfxCHsKfWw@mail.gmail.com>
 <7aab2990-9c57-2456-b08d-299ae96ac919@apertussolutions.com>
 <CAELHeEfZ-feZnexp7Gx3VAJPerENcoO1Uccbe3xxUX95jvLUdA@mail.gmail.com>
 <b1e7b545-8e66-5dc0-ff5a-9f69d1751a5f@apertussolutions.com>
 <CAELHeEcEN=4YrPJROvzHoOiqqe5Bk0f8pDCZDnQ6aS=2LdwNow@mail.gmail.com>
 <f09fe749-e139-db6a-b2ad-45db76da04ae@apertussolutions.com>
 <CAELHeEe5H8BNf8K22XRm3hXf=_imHBnf-MHcFYvPCXX7GYkt4w@mail.gmail.com> <203110bb-b70b-b4f1-9453-46136659f84c@apertussolutions.com>
In-Reply-To: <203110bb-b70b-b4f1-9453-46136659f84c@apertussolutions.com>
From:   Brendan Trotter <btrotter@gmail.com>
Date:   Wed, 10 Aug 2022 18:37:18 +0930
Message-ID: <CAELHeEe2CiTXfMf3OYu3bzc_kH=rs4qzC-4XQL12AM=Nq8Csjw@mail.gmail.com>
Subject: Re: Linux DRTM on UEFI platforms
To:     The development of GNU GRUB <grub-devel@gnu.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Alec Brown <alec.r.brown@oracle.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        "piotr.krol@3mdeb.com" <piotr.krol@3mdeb.com>,
        "krystian.hebel@3mdeb.com" <krystian.hebel@3mdeb.com>,
        "persaur@gmail.com" <persaur@gmail.com>,
        "Yoder, Stuart" <stuart.yoder@arm.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "michal.zygowski@3mdeb.com" <michal.zygowski@3mdeb.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "lukasz@hawrylko.pl" <lukasz@hawrylko.pl>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On Tue, Aug 9, 2022 at 8:25 PM Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
> On 7/23/22 01:15, Brendan Trotter wrote:
> > On Sat, Jul 23, 2022 at 2:53 AM Daniel P. Smith
> > <dpsmith@apertussolutions.com> wrote:
> >> On 7/7/22 23:36, Brendan Trotter wrote:
> >>> On Thu, Jul 7, 2022 at 7:18 PM Daniel P. Smith
> >>> <dpsmith@apertussolutions.com> wrote:
> >>>> On 7/5/22 20:03, Brendan Trotter wrote:
> >>>>> On Wed, Jul 6, 2022 at 4:52 AM Daniel P. Smith
> >>>>> <dpsmith@apertussolutions.com> wrote:
> >>>>>> On 6/10/22 12:40, Ard Biesheuvel wrote:> On Thu, 19 May 2022 at 22:59,
> >>>>>> To help provide clarity, consider the following flows for comparison,
> >>>>>>
> >>>>>> Normal/existing efi-stub:
> >>>>>>     EFI -> efi-stub -> head_64.S
> >>>>>>
> >>>>>> Proposed secure launch:
> >>>>>>     EFI -> efi-stub -> dl-handler -> [cpu] -> sl_stub ->head_64.S
> >>>>>
> >>>>> For more clarity; the entire point is to ensure that the kernel only
> >>>>> has to trust itself and the CPU/TPM hardware (and does not have to
> >>>>> trust a potentially malicious boot loader)..Any attempt to avoid a
> >>>>> one-off solution for Linux is an attempt to weaken security.
> >>>>
> >>>> Please elaborate so I might understand how this entrypoint allows for
> >>>> the kernel to only trust itself and the CPU/TPM.
> >>>
> >>> Is this a serious request?
> >>
> >> Yes, it was serious because I found the statements to be terse and open
> >> to interpretation. Specifically, when I read it, it almost seemed that
> >> the position is that dynamic launch is not needed, and that the kernel
> >> could just establish its own RoT.
> >>
> >>> Kernel is started (via. firmware using the kernel's efi-stub, or via.
> >>> "kexec()", or..); and regardless of how the kernel was started the
> >>> kernel establishes its own dynamic root of trust.(e.g. AMD"s SKINIT or
> >>> Intel's TXT, followed by measuring the remainder of itself and
> >>> anything passed from firmware like APCI tables) without relying on a
> >>> call-back provided by "untrusted by kernel" third-parties that don't
> >>> exist in most cases. The dynamic root of trust that kernel creates
> >>> depends on the kernel, CPU, TPM, etc (and excludes untrusted and
> >>> unnecessary third parties)..
> >>
> >> This clarifies the previous statements and I would say, yes, this is one
> >> approach. Considering the challenges we have/are facing in getting a
> >> minimal post-launch handling (sl-stub) into the setup kernel, I would be
> >> hard-pressed to believe adding all the pre-launch handling would be
> >> found to be acceptable. If the intent is to have it completely
> >> self-contained, this would require,
> >>    1) the introduction of a TPM driver into the setup kernel, a hole I
> >>       would rather not go down again
> >
> > ..which is no more work than the introduction of a TPM driver into one
> > boot loader (probably less so, as Linux already has TPM drivers that
> > are used later), and significantly less work than introducing a TPM
> > driver into many boot loaders.
>
> Already been there and no it is not as straight forward as one may
> think. A minimal driver was attempted but rejected by the TPM
> maintainers with the requirement to reuse the existing driver code. So
> we would gladly welcome someone to come rewrite the TPM drive.
> Specifically to de-tangle the core TPM interface code away from all of
> its kernel proper dependencies so that it can be used by both the setup
> kernel and the kernel proper.
>
> > Note that to do this well (with some protection against malicious
> > devices) you'd disable all PCI devices, then set up IOMMU as "allow
> > the least possible", then establish a dynamic root of trust, then
> > enable and allow individual devices only if/when their driver is
> > started by kernel and not sooner. Without doing it like this there's
> > less guarantee that the code/data being measured is the same as the
> > code/data being executed/used (as a malicious device can modify
> > anything before it's measured, restore the original extremely briefly
> > while measurement is done, then modify anything after it's measured
> > and before it's used). Also note that I mean "some protection" and not
> > 100% protection (it's unsolvable unless firmware uses an "allow the
> > least necessary by default" strategy) but "some protection" is better
> > than none.
> >
> > In other words; it isn't necessarily just TPM driver alone that would
> > need to be started "earlier" (ideally it's also IOMMU and PCI
> > enumeration too). However, "earlier" is "earlier than the
> > establishment of dynamic root of trust"; which can be achieved by
> > moving the establishment of dynamic root of trust to a later stage
> > (rather than bringing things like TPM driver to an earlier stage)..
>
> With all due respect, the statement above demonstrates a clear lack of
> understanding how the hardware dynamic launch works. I have written a
> summary[1], with links to details, of how the process works. It is
> highly recommended this is read, as well as the referenced sections in
> Intel's SDM and AMD's APM.
>
> >>    2) potentially the ability to load files from disk if it is not
> >>       acceptable for the bootloader to load the DCE (ACM/SLB)
> >
> > ..which is both unnecessary and ill-advised.
>
> See [1]

Yes? If you're referring to the "authenticated code module" (as part
of senter's internal procedure) it's part of hardware/firmware and
beyond the scope of software/boot loader/kernel.

> >>    3) miscellaneous system evaluations, memory table, machine check, etc.
> >
> > ..which is the same regardless of where it's done.
> >
> >> The only thing that is gained from such an approach is to make dynamic
> >> launch for Linux be self-contained in the kernel.
> >
> > Making it self-contained in the kernel means:
> >
> > a) it actually works, for the most important use case (where UEFI
> > firmware boots Linux's efi-stub directly)
> >
> > b) it actually works, for other use cases (booted via. "kexec()",
> > booted from LILO, booted from ELILO, ...).
> >
> > c) It continues to work; even when you change/update/install/remove a
> > boot manager (which would otherwise change the measurement and break
> > anything that depended on the measurement).
> >
> > d) it's more portable (e.g. easier to port to ARM/Uboot, etc)
> >
> > e) It's more likely to actually be used by end-users (can just install
> > a kernel like normal without extra pages of instructions on how to
> > install and configure unnecessary bootware)
> >
> > f) It'll be peer reviewed by more people
>
> The hook approach does all of this.
>
> >> It does not reduce the
> >> TCB because the whole design of the dynamic launch is to provide a
> >> controlled process that establishes a new trust chain/TCB that is
> >> started from an untrusted state. Specifically, dynamic launch starts
> >> with the CPU being provided all the material for the process by
> >> untrusted code that is currently in control at the time the launch is
> >> initiated.
> >
> > The whole design of dynamic launch is to establish a new trust chain
> > that doesn't depend on an untrusted boot loader (or anything that came
> > before it - firmware, etc). If the "dynamic root of trust" is
> > established by boot loader then it partially suffers the same problems
> > as a static root of trust.
>
> See [1]
>
> >>> The only potential benefit that the callback solution provides is that
> >>> it, in theory, it could reduce duplication of work for other operating
> >>> systems (FreeBSD, Solaris, Haiku, Fuchsia, .. could use the same
> >>> callback instead of doing it themselves); but previous discussions
> >>> (talk of formalising the contract between the boot stub and the Linux
> >>> kernel) suggest that you aren't interested in any other OS.
> >>
> >> With all due respect, but this is where I would have to disagree. There
> >> is substantial benefit,
> >>    1) a single code base that needs to be reviewed vs multiple OS
> >>       specific versions
> >
> > If you wanted to minimize code duplication you'd implement it as an
> > open source library (with a non-restrictive licence like MIT) so that
> > the code can be used by all the different boot loaders instead of
> > duplicated by each different boot loader, in addition to being used by
> > all the different operating systems/kernels.
>
> I completely agree and my intent is to get there eventually.
>
> >>    2) establishes an API that decouples pre- and post-launch
> >
> > ..by providing a call-back that kernel uses post-launch to call an API
> > from pre-launch, that couples pre- and post-launch more than has ever
> > been done before?
>
> That is not what is being proposed.

Maybe I'm confused. I thought the proposal was that unnecessary and
untrusted code (Trenchboot) is inserted into "pre kernel launch"
(between UEFI firmware and Linux's efi-stub), and then (during "post
kernel launch") kernel calls a callback provided by "pre kernel
launch" (Trenchboot); thereby coupling pre-launch (Trenchboot) and
post-launch (Linux kernel) more than has ever be done before.

I also assumed that if the 1st kernel runs for 6 months and then
starts a 2nd kernel via. "kexec()" ; then the 2nd kernel would call
the callback provided by "pre 1st kernel launch from 6 months ago".

> >>    3) reduces the complexity required to enable adoption by an OS
> >
> > There's only one OS that uses the Linux Boot Protocol. Any other OS
> > (FreeBSD, Fuschia, Haiku, ...) has to radically change everything
> > about how it boots before it can think about adopting your Linux
> > specific solution. Is there even a proposal to add support to GRUB
> > developers' own multi-boot specification (to "enable easy adoption" by
> > Solaris and its forks)?
> >
> > Building it directly into the Linux kernel would make adoption by
> > other operating systems easier, as they wouldn't need to change their
> > boot code and most of them are used to porting code from Linux anway.
>
> Nothing in this proposal binds it to the Linux Boot Protocol.
>
> >>    4) zero reduction in the security properties of the architecture
> >
> > It's a huge reduction in the security properties. It allows a "just
> > lie and measure nothing" boot loader to be (pre)installed,, tricking
> > the kernel into thinking there's security when there is none.
>
> See [1].

[1] doesn't provide any useful information. How does a kernel know
that the callback provided by boot loader actually measures what it's
supposed to measure, or even does anything at all?

> >>> This leaves me wondering what your true motivation is. Are you trying
> >>> to benefit GRUB/Trenchboot (at the expense of security, end-user
> >>> convenience, distro installer hassle, etc); or trying to manufacture
> >>> scope for future man-in-the middle attacks (by promoting a solution
> >>> that requires something between firmware and kernel)?
> >>
> >> As a loyal member of the tinfoil hat brigade, I will always advocate for
> >> accept nothing and question everything. All I can ask is to evaluate the
> >> technical merit of the presentations [1][2][3] and the patch series [4].
> >> If there is anything concerning with the theory or the implementation,
> >> then it should be raised so that it may be addressed. A means to do so
> >> is the "what if" game, as it is great to formulate a hypothesis. In this
> >> case, the "what if" postulated is the assumption that the approach is to
> >> allow a future MitM attack.
> >
> > How quickly could a disgruntled system administrator (or someone
> > selling computers with a Linux distro pre-installed, or anyone trying
> > to circumvent a company's digital rights management scheme that
> > happens to rely on DRTM for remote attestation, or...) break your
> > security in a way that survives kernel updates?
> >
> > My estimate is that it'd take about 5 minutes to download the boot
> > loader's open source code then 10 minutes to modify it.
> >
> > The only real safeguard against this is UEFI's Secure Boot, which
> > doesn't work on old computers or most "non-8086" computers, doesn't
> > work if an attacker can install their own secure boot keys, and
> > doesn't work in most virtual machines.
>
> See [1].

[1] doesn't provide any useful information. Dynamic root of trust is
only useful for detecting if a measurement changed; so if the
measurement was always nonsense from the beginning and never changes
it becomes worse than nothing.

> >> Then the challenge is to examine the
> >> process, their underlying mechanism, and the security properties of
> >> those mechanisms to see if a MitM can be discerned. I will gladly engage
> >> with anyone that presents an analysis demonstrating an assumption I
> >> made/missed that opens the possibility for subversion of the launch
> >> integrity attempting to be built.
> >
> > Surely it'd be easier for kernel to ignore the bootloader's
> > "untrustworthy dynamic root of trust" (and establish its own
> > "trustworthy dynamic root of trust") than it would be for kernel to
> > detect a MiTM boot loader.
>
> See [1].

[1] doesn't provide any useful information. Senter and skinit don't
provide a method for kernel to detect that (e.g.) a MiTM boot loader
has always measured a forgery and has changed unmeasured code in a
different way every time you boot.

- Brendan
