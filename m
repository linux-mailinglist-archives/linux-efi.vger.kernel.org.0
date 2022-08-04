Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9EC589A6B
	for <lists+linux-efi@lfdr.de>; Thu,  4 Aug 2022 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiHDK0W (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Aug 2022 06:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbiHDK0R (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Aug 2022 06:26:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C36ABF6F
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 03:26:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89E9DB8250A
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 10:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399C0C433C1
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 10:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659608773;
        bh=FuTFLreq1GkIUSGdxowaFSFCV9B2znUXes5ZDEdwmIc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dOsg53LX1lkm+VW3ieCx9JI41YvIoJS9bqQgozfGe3GAwpPg6qsJx885wf3KaL6oD
         TByt+KCV8bJ7QwXJDN10dm9I7BU3gnm5bMguIjq17zjFnxBoj1jUrObpriSKSVTFny
         os00PGfECseRDTVEm6BoWkeFLOayyxcDFn8Tv6plF3EWT2l8dSkIWSx5aGajXMvsj6
         uQQWGq4u0HSYhNPhniGZlXXlxUw57elm9bwo8Elp9XGt9BOhCyCCwEKWB2AAUWdfIr
         jEoKHqsH9XYhvwo3xsxrXW8yc9OpZbWxMJb8YKeC+lhASCWmxjckW5+3dgv6Fhcv9a
         RBGUWeeD/j25Q==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-10bd4812c29so23790957fac.11
        for <linux-efi@vger.kernel.org>; Thu, 04 Aug 2022 03:26:13 -0700 (PDT)
X-Gm-Message-State: ACgBeo0Z7GvnXbT51KJ1F2uBHA7gGVFcJwWJiLgAQW2XZzqRhuR2UOYU
        S2WmkKH/FnsoFD8Ojx3m6shQrsCFI1CJqv30HxI=
X-Google-Smtp-Source: AA6agR4z2a4tnNrCOGesRhreXsybs77J5W4l8hO46Om9/7V3KjnkVGT4S/UsUTSnNKqnwBOS3VzW9Ioh27atLMmjhRY=
X-Received: by 2002:a05:6870:a90a:b0:10d:9e83:98a6 with SMTP id
 eq10-20020a056870a90a00b0010d9e8398a6mr3748307oab.228.1659608772378; Thu, 04
 Aug 2022 03:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <YusVVLNbLgsk49PK@zx2c4.com> <20220804004411.1343158-1-Jason@zx2c4.com>
 <20220804030012-mutt-send-email-mst@kernel.org> <bfa5704d-755c-5a52-e7cc-bd9b34e5bb03@redhat.com>
 <YuuQb3D/YY1SiUqY@redhat.com>
In-Reply-To: <YuuQb3D/YY1SiUqY@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Aug 2022 12:26:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFr6Bv4_G0-wCTu4fp_iCrG060NHJx_j2dbnyiFJKYYeQ@mail.gmail.com>
Message-ID: <CAMj1kXFr6Bv4_G0-wCTu4fp_iCrG060NHJx_j2dbnyiFJKYYeQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/i386: place setup_data at fixed place in memory
To:     =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc:     Laszlo Ersek <lersek@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 4 Aug 2022 at 11:25, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Thu, Aug 04, 2022 at 10:58:36AM +0200, Laszlo Ersek wrote:
> > On 08/04/22 09:03, Michael S. Tsirkin wrote:
> > > On Thu, Aug 04, 2022 at 02:44:11AM +0200, Jason A. Donenfeld wrote:
> > >> The boot parameter header refers to setup_data at an absolute addres=
s,
> > >> and each setup_data refers to the next setup_data at an absolute add=
ress
> > >> too. Currently QEMU simply puts the setup_datas right after the kern=
el
> > >> image, and since the kernel_image is loaded at prot_addr -- a fixed
> > >> address knowable to QEMU apriori -- the setup_data absolute address
> > >> winds up being just `prot_addr + a_fixed_offset_into_kernel_image`.
> > >>
> > >> This mostly works fine, so long as the kernel image really is loaded=
 at
> > >> prot_addr. However, OVMF doesn't load the kernel at prot_addr, and
> > >> generally EFI doesn't give a good way of predicting where it's going=
 to
> > >> load the kernel. So when it loads it at some address !=3D prot_addr,=
 the
> > >> absolute addresses in setup_data now point somewhere bogus, causing
> > >> crashes when EFI stub tries to follow the next link.
> > >>
> > >> Fix this by placing setup_data at some fixed place in memory, relati=
ve
> > >> to real_addr, not as part of the kernel image, and then pointing the
> > >> setup_data absolute address to that fixed place in memory. This way,
> > >> even if OVMF or other chains relocate the kernel image, the boot
> > >> parameter still points to the correct absolute address.
> > >>
> > >> Fixes: 3cbeb52467 ("hw/i386: add device tree support")
> > >> Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> > >> Cc: Richard Henderson <richard.henderson@linaro.org>
> > >> Cc: Peter Maydell <peter.maydell@linaro.org>
> > >> Cc: Michael S. Tsirkin <mst@redhat.com>
> > >> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > >> Cc: Gerd Hoffmann <kraxel@redhat.com>
> > >> Cc: Ard Biesheuvel <ardb@kernel.org>
> > >> Cc: linux-efi@vger.kernel.org
> > >> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > >
> > > Didn't read the patch yet.
> > > Adding Laszlo.
> >
> > As I said in
> > <http://mid.mail-archive.com/8bcc7826-91ab-855e-7151-2e9add88025a@redha=
t.com>,
> > I don't believe that the setup_data chaining described in
> > <https://www.kernel.org/doc/Documentation/x86/boot.rst> can be made wor=
k
> > for UEFI guests at all, with QEMU pre-populating the links with GPAs.
> >
> > However, rather than introducing a new info channel, or reusing an
> > existent one (ACPI linker/loader, GUID-ed structure chaining in pflash)=
,
> > for the sake of this feature, I suggest simply disabling this feature
> > for UEFI guests. setup_data chaining has not been necessary for UEFI
> > guests for years (this is the first time I've heard about it in more
> > than a decade), and the particular use case (provide guests with good
> > random seed) is solved for UEFI guests via virtio-rng / EFI_RNG_PROTOCO=
L.
> >
> > ... Now, here's my problem: microvm, and Xen.
> >
> > As far as I can tell, QEMU can determine (it already does determine)
> > whether the guest uses UEFI or not, for the "pc" and "q35" machine
> > types. But not for microvm or Xen!
> >
> > Namely, from pc_system_firmware_init() [hw/i386/pc_sysfw.c], we can
> > derive that
> >
> >   pflash_cfi01_get_blk(pcms->flash[0])
> >
> > returning NULL vs. non-NULL stands for "BIOS vs. UEFI". Note that this
> > is only valid after the inital part of pc_system_firmware_init() has ru=
n
> > ("Map legacy -drive if=3Dpflash to machine properties"), but that is no=
t a
> > problem, given the following call tree:
>
> I don't beleve that's a valid check anymore since Gerd introduced the
> ability to load UEFI via -bios, for UEFI builds without persistent
> variables. ( a8152c4e4613c70c2f0573a82babbc8acc00cf90 )
>

I think there is a fundamental flaw in the QEMU logic where it adds
setup_data nodes to the *file* representation of the kernel image.

IOW, loading the kernei image at address x, creating setup_data nodes
in memory relative to x and then invoking the kernel image directly
(as kexec does as well, AIUI) is perfectly fine.

Managing a file system abstraction and a generic interface to load its
contents, and using it to load the kernel image anywhere in memory is
also fine, and OVMF -kernel relies on this.

It is the combination of the two that explodes, unsurprisingly. Making
inferences about which kind of firmware is invoking the file loading
interface, and gating this behavior accordingly just papers over the
problem.

Jason and I have been discussing this over IRC, and there are
essentially 3 places we could address this:
1) in the Linux/x86 EFI stub, which has a 'pure EFI' entrypoint and a
'EFI handover protocol' entrypoint, and we could simply wipe the
setup_data pointer in the former;
2) in OVMF's kernel loader, where we could 'fix up' the setup_data field
3) in QEMU, which [as I laid out above] does something it shouldn't be doin=
g.

I strongly object to 2), as it would involve teaching OVMF's 'pure
EFI' boot path about the intricacies of struct boot_params etc, which
defeats the purpose of having a generic EFI boot path (Note that much
of my work on the Linux/EFI subsystem over the past years has been
focused on getting rid of all the arch-specific hacks and layering
violations and making as much of the EFI code in Linux arch-agnostic
and adhere to EFI principles and APIs)

Given that neither SETUP_DTB nor SETUP_RNG_SEED are particularly
relevant for pure EFI boot, clearing setup_data in the pure EFI
entrypoint in the EFI stub is not unreasonable, but not very future
proof, given that it limits how we might use setup_data for other
purposes in the future (although one might argue we could just drop
code again from the stub when new uses of setup_data are introduced
into the kernel)

However, our conclusion was that it is really QEMU that is doing
something strange here, so IMHO, fixing QEMU is really the most
suitable approach.

--=20
Ard.
