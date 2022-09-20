Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9A65BE5CB
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 14:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiITMaP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 08:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiITMaN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 08:30:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D97E52FE3
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 05:30:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48D79B80C98
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 12:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CEBC43140
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 12:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663677009;
        bh=ySM1SiKXSFmMheLh/vOPVVXIzghFY7PPauxXoYGEx1A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JXhJuHfRJMzKPW9QS/fYZbAKVSLrqlsrNXyRLU/7m3iVsYLO/nuXrJxfNZ7H22OGh
         IbjsTQY2s4Z5z/cvAhsPra9tUjvd0aaY3sBxrKSHJq6ZHrZ7JPjmKzRuCQozhu4nKq
         yh51+PeC2srtiZzd+1VrREnXMG9Qdb65lxfD6gwNvioLF/ihIBqfkCHNP602NrWsop
         RRVNKH5vT0/ITwxIKvqgSv3EwmjtlUkuKxQ4bBnCcDPCKmk92UvE8yTKBYoXTv2/FH
         i0hz2n35eh2Bii0TXiNX/iicV4ZUrot80G/rtfMhzqqMBTO8gVqhFbSNVrKTtyk87Q
         4z1axQC/4UUSw==
Received: by mail-lf1-f52.google.com with SMTP id f14so3517438lfg.5
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 05:30:08 -0700 (PDT)
X-Gm-Message-State: ACrzQf0c9EtpLIQPxbsQM2613aEw2KwMwLLHkGz8ISQmfLUsnwQB5U+x
        Kgwu9v5UHWaolI7nSQNfYtFTrj9QIXkljhy1GKk=
X-Google-Smtp-Source: AMsMyM7TKRtmORblIOSmvNY25cwkS9v8/nHoewLrF7AIObbJ5CGt5T/9J6YH+NeCzZ1sScGUxB2ut1qslOpXTVELwbg=
X-Received: by 2002:a05:6512:4024:b0:497:4db:6ad0 with SMTP id
 br36-20020a056512402400b0049704db6ad0mr8382518lfb.637.1663677006962; Tue, 20
 Sep 2022 05:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR11MB50644F564BA1A112DF60D44EC54B9@PH0PR11MB5064.namprd11.prod.outlook.com>
 <CAMj1kXEVvOWPdVr6VrsCGR1LnVBZvepLcVOpBXqS6zGj-h23Qw@mail.gmail.com>
 <PH0PR11MB50640586CDB43B707746038BC54D9@PH0PR11MB5064.namprd11.prod.outlook.com>
 <CAMj1kXG7OSn9ypnN4tZGPH-RhqCBZjYNy6xZ2XU2Bvpnq+0X+A@mail.gmail.com> <PH0PR11MB50642815C0F26C5C48FCED25C54C9@PH0PR11MB5064.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB50642815C0F26C5C48FCED25C54C9@PH0PR11MB5064.namprd11.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 20 Sep 2022 14:29:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHK+DWaug7trfEP1u6MHUT8_Mfk_ofk89fVVkDmx5JTBg@mail.gmail.com>
Message-ID: <CAMj1kXHK+DWaug7trfEP1u6MHUT8_Mfk_ofk89fVVkDmx5JTBg@mail.gmail.com>
Subject: Re: [edk2-devel] measurement to command-line/initrd for loading
 kernel via -kernel option
To:     "Xu, Min M" <min.m.xu@intel.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Gonda <pgonda@google.com>
Cc:     "devel@edk2.groups.io" <devel@edk2.groups.io>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Yao, Jiewen" <jiewen.yao@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Lu, Ken" <ken.lu@intel.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(cc Ilias, Matt, Peter[], Daniel[])

On Tue, 20 Sept 2022 at 02:20, Xu, Min M <min.m.xu@intel.com> wrote:
>
> On September 19, 2022 2:59 PM, Ard Biesheuvel wrote:
> > On Mon, 19 Sept 2022 at 04:13, Xu, Min M <min.m.xu@intel.com> wrote:
> > >
> > > On September 18, 2022 8:52 PM, Ard Biesheuvel wrote:
> > > > Hello Min Xu,
> > > >
> > > > On Sat, 17 Sept 2022 at 04:53, Xu, Min M <min.m.xu@intel.com> wrote=
:
> > > > >
> > > > > Hi, Ard
> > > > >
> > > > > I am checking the measurement behavior when loading the kernel vi=
a
> > > > > the
> > > > QEMU -kernel option. I find it is implemented by below 2 driver/lib=
:
> > > > >
> > > > > - OvmfPkg/QemuKernelLoaderFsDxe
> > > > >
> > > > >  This is a separate DXE driver that exposes the virtual
> > > > > SimpleFileSystem
> > > > implementation that carries the kernel and initrd passed via the
> > > > QEMU command line.
> > > > >
> > > > > - OvmfPkg/Library/X86QemuLoadImageLib
> > > > >
> > > > >   This is the library that consumes above driver and call
> > > > LoadImage/StartImage so that the kernel image gets authenticated
> > > > and/or measured.
> > > > >
> > > > > See https://edk2.groups.io/g/devel/message/55381
> > > > >
> > > > >
> > > > >
> > > > > I have some questions about the implementation need your help.
> > > > >
> > > > > 2. Kernel image is authenticated and/or measured in LoadImage. I
> > > > > am
> > > > wondering if =E2=80=9Ccommand line=E2=80=9D is measured as well? =
=E2=80=9CCommand line=E2=80=9D can
> > > > be treated as an external input and in my opinion it should be meas=
ured
> > too.
> > > > >
> > > > > 3. The same question to initrd. Is it measured?
> > > > >
> > > >
> > > > The initrd is measured by the EFI stub in Linux, and we are
> > > > currently adding measurement of the load options to that as well:
> > > > https://lore.kernel.org/all/20220916081441.1993492-2-
> > > > ilias.apalodimas@linaro.org/
> > > >
> > > > The initrd is Linux specific in any case, so there, the Linux OS
> > > > loader is a natural place to take care of this. The load options ar=
e
> > > > being added because of the oversight in the TCG spec, which only
> > > > covers load options if they are part of a Boot#### option, but
> > > > between
> > > > LoadImage() and StartImage, you can pass any load options you want
> > > > via the loaded image protocol, so it needs to be measured as well.
> > > >
> > > Thanks Ard for the explanation.
> > > I was told that in grub boot cmd-line/initrd will be measured as well=
. So my
> > question is that will they be measured twice? One in grub.efi, the othe=
r in efi-
> > stub?
> > >
> >
> > The EFI stub may be the only OS loader, so the EFI stub should measure =
the
> > command line and the initrd.
> >
> > Whether or not a previous loader stage exists that may or may not measu=
re
> > the same pieces is not for the EFI stub to reason about. And in any cas=
e,
> > measuring the same thing twice is much less of an issue than not measur=
ing it
> > at all.
> >
> > > My understanding is that the loader should take the responsibility to=
 do the
> > measurement.
> > > For grub boot, grub.efi is the loader so it measures kernel-image/cmd=
-
> > line/initrd.
> >
> > If the EFI stub is invoked, the EFI stub is the OS loader. We should no=
t be
> > relying on the presence of absence of GRUB (or shim) in the boot chain.
> >
> > > For direct boot, TryRunningQemuKernel() now measures kernel image (in
> > CoreLoadImage). Shall it also measure cmd-line/initrd in the same time?
> > >
> >
> > No, I don't think it should. This is why we are adding this to the EFI =
stub
> > instead.
> >
> > If we measure the initrd and command line in the EFI stub, we don't hav=
e to
> > measure it anywhere else, and we can use any generic EFI loader on a
> > measured boot system.
> >
> Ard, thanks for the explanation.
> The reason why I am checking the measurement of cmd-line and initrd is th=
at I am thinking how to measure cmd-line and initrd in TDVF with the EFI_CC=
_MEASUREMENT_PROTOCOL which is defined in MdePkg/Include/Protocol/CcMeasure=
ment.h. Actually EFI_CC_MEASUREMENT_PROTOCOL is designed for the Confidenti=
al Computing guest to support measurement.
>
> I check the patch in https://lore.kernel.org/all/20220916081441.1993492-1=
-ilias.apalodimas@linaro.org/. It supports the EFI_TCG2_PROTOCOL. I think i=
t can also support EFI_CC_MEASUREMENT_PROTOCOL like below:
>   efi_tcg2_protocol_t *tcg2 =3D NULL;
>   efi_cc_protocol_t *cc =3D NULL;
>   efi_bs_call(locate_protocol, &tcg2_guild, NULL, (void**)&tcg2);
>   efi_bs_call(locate_protocol, &cc_guild, NULL, (void**)&cc);
>   if (tcg2) {
>       do_tcg2_measurement ();
>   } else if (cc) {
>       cc-> MapPcrToMrIndex ();  // because there is a map between TPM-PCR=
 index to CC-MeasureRegister Index.
>       do_cc_measurement ();
>   }
>

Thanks for the example, this is helpful.

I am anticipating this if () to grow more branches pretty soon, so it
is high time we have a discussion about how to abstract this properly.

We will need to measure various assets for:
- TCG measured boot
- TDX measure boot
- SEV/SNP measured boot?
- DICE attestation
- ARM RME
- Trenchboot DRTM

The latter is the odd one out here, but it will also need to capture
system state at different times throughout the execution of the EFI
stub, so it makes sense to mention it here.

Ilias's patches add the following function to the Linux EFI stub

struct efi_measured_event {
   efi_tcg2_event_t event_data;
   efi_tcg2_tagged_event_t tagged_event;
   u8 tagged_event_data[];
};

void efi_measure_tagged_event(unsigned long load_addr, unsigned long load_s=
ize,
         const struct efi_measured_event *event);

which is geared towards the TCG2 types. I imagine this will need to
evolve into something more generic over time, making the use of the
TCG2 types specific to that particular measurement path.

As the Linux/EFI and OVMF maintainer, I am somewhat involved in all of
these efforts, but I am by no means an expert on any of them. So this
is really a call for collaboration to ensure that we converge on
something that is usable for everyone and not a constant source of
churn.

> I am wondering when your 2 patches would be accepted and merged so that I=
 can submit my patch based on yours.
>

I just sent a v2 of Ilias's patches with some preliminary changes to
make these abstractions easier in the future. If there are no
objections, I will queue those patches tomorrow, so they should be in
linux-next by friday

https://lore.kernel.org/r/20220920122746.3553306-1-ardb@kernel.org
