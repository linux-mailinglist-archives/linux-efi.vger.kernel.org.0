Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CA0148B30
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jan 2020 16:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgAXPUs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jan 2020 10:20:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36376 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgAXPUs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jan 2020 10:20:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so2067575wma.1
        for <linux-efi@vger.kernel.org>; Fri, 24 Jan 2020 07:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ysBwEu09FTfzBAjNkf0+xOmCwdqnhglCwE+GFK+CdT4=;
        b=asBG0Fdamgf1eHesfFnL7dIPIOUW2fdmauXnMM9kP/kOW3hs4SzcRlSCFf1rH+TWnX
         2g1Ore2t0vfqnIclx4NjA1lEK93kNCczg3zLFKTD5kbpZNnAOQVzCyiWq+LjXY1X37lp
         o41EJOWaittizGKx/yG9UKpoZoNfjlqByNHfK5G7rZn4UncEGDd7M7unBUqzq5MCPinK
         JfT5xP7ot6+puQ4+SfxKyE8v2MiqVYXHDPgIGNTJaexwehhqnWEc/g5986eaAKUdvnnR
         0Q9FsffjMuqnw2d7clJLJepvJVFwOVDwGABEbI4oq84hkGvSjxwZ9qV/fF+S8oNzfLQw
         P4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ysBwEu09FTfzBAjNkf0+xOmCwdqnhglCwE+GFK+CdT4=;
        b=QPu8nBZta2FRTEd6EjFjg596Ge5JpB6/TiJyOtCMen7QwhCv4KurWPzeM2n/cDB/mK
         f57GLJ4x+OVMFBp+fJDAgKKWaVBr1609iRtW+hPJDL09Y+Wa6WqPi8561EIby/Id0soG
         WnB9gBzpYAtRrOyqR6A0E97+NSeJEC4DhSLWuFGtJsuqmn7z85j02zevrlciYgfd/mDZ
         Wtr3A4T0ecjVSArsko9+mTuYJxHI6ZFwhhf5tEWzL6fSJRXFDYEsmk+ehqX52nRfHBOl
         Go2Fu1RL1q2F87JEhSixTKpPutxgZ48Yylq5beHB1Z+eejf5VDYRR2g5gvK6eqiGcKeJ
         0NWA==
X-Gm-Message-State: APjAAAXJqVA33CjXCOWeRM2rTvySqwoW+ukIewkrs9siLiVEI8J83+OQ
        QD3x/ChcVeLG0cTwmx1Kp79uaGpSUd/am5fho8x+Cw==
X-Google-Smtp-Source: APXvYqy7Z2ePb3BmMa6CrK1emWvDEUIAQvCv/Wv/slcJofyskpSyFY1dCaf4GatSelKXtfJKgo6PQcrjiIjNs7hhCo0=
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr3744146wmj.1.1579879244984;
 Fri, 24 Jan 2020 07:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20200123173047.18409-1-ardb@kernel.org> <20200123232736.GS9444@bivouac.eciton.net>
 <CAKv+Gu8m8TzHe7GdCTrdy0atwVw-yQA+2=7CbTO0RpzuR19T0A@mail.gmail.com> <20200124103030.GA23297@bivouac.eciton.net>
In-Reply-To: <20200124103030.GA23297@bivouac.eciton.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 24 Jan 2020 16:20:31 +0100
Message-ID: <CAKv+Gu85h=x9Lsn960dMo_Pu==rdnVdhw4H3i3VYD5v4sKt4dQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [RFC PATCH] efi/libstub/x86: look for bootparams
 when booting via PE entry point
To:     Leif Lindholm <leif@nuviainc.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 24 Jan 2020 at 11:30, Leif Lindholm <leif@nuviainc.com> wrote:
>
> On Fri, Jan 24, 2020 at 08:28:08 +0100, Ard Biesheuvel wrote:
> > On Fri, 24 Jan 2020 at 00:27, Leif Lindholm <leif@nuviainc.com> wrote:
> > >
> > > On Thu, Jan 23, 2020 at 18:30:47 +0100, Ard Biesheuvel wrote:
> > > > There are currently a couple of different ways the Linux kernel can be
> > > > booted on UEFI x86 systems:
> > > > 1) legacy boot - the bootloader jumps straight into the first byte of the
> > > >    kernel image after taking down the UEFI boot services and populating a
> > > >    bootparams structure with the required information
> > > > 2) PE entry point - the kernel is booted as an ordinary PE/COFF executable,
> > > >    using the loadimage and startimage boot services, and it is left to the
> > > >    boot stub to allocate and populate a bootparams structure
> > > > 3) EFI handover protocol - the kernel is copied into memory and the loader
> > > >    jumps into it at a fixed offset, providing a bootparams structure but
> > > >    with the EFI boot services still active.
> > > >
> > > > Option #3 is the option preferred by the distros today, since it allows
> > > > the bootloader to populate and pass the bootparams structure directly,
> > > > which enables things like initrd images loaded from any filesystem (as
> > > > opposed to option #2, which requires the kernel's boot stub to load the
> > > > initrd but it only supports loading images from the same volume that the
> > > > kernel image was loaded from). Option #3 also supports loading 32-bit
> > > > kernels on 64-bit firmware and vice versa.
> > > >
> > > > However, option #2 is a more seamless match, given that it uses the
> > > > firmware's standard loading facilities, which is also what EFI secure
> > > > boot authentication checks are based on.
> > > >
> > > > So let's provide a way for option #2 to be used in combination with a
> > > > bootloader provided bootparams structure, by specifying a special protocol
> > > > GUID for it, and looking for it on the image handle when entering via the
> > > > ordinary PE/COFF entry point. This allows a loader to call LoadImage,
> > > > install the new protocol on the resulting handle and invoke the kernel via
> > > > StartImage, and thus rely on the authentication performed by those boot
> > > > services if secure boot is enabled.
> > >
> > > My impression is that this patch depends on the not-yet-upstream
> > > "efi/libstub/x86: Drop __efi_early() export and efi_config struct"?
> > >
> >
> > Yes, it applies onto efi/next branch
> >
> > > (This would be helpful to mention in relation to a future PATCH,
> > > unless the requirements have by then already trickled upstream.)
> >
> > Sure, although it is not unusual in Linux development for patches on
> > $TOPIC to be created against $TOPIC's development branch.
>
> No, it just would have saved me a few minutes of digging since I've
> not been actively tracking linux-efi for quite some time (quite
> possibly since the repo url included 'mfleming').
>

Fair enough

> > > I like how clean this change is (once prereqs are in).
> > > But for the sake of having the conversation - doing this requires a
> > > corresponding change in any bootloader, to register the bootparams
> > > structure as a protocol on the image handle.
> >
> > Yes. I have looked into implementing this for OVMF, which implements
> > the kernel's boot protocol directly (to support the
> > -kernel/-append/-initrd QEMU arguments), but it is a bit involved,
> > given how QEMU cuts up the PE image into two separate parts. I'll have
> > another stab at it today, but it may be better to look at GRUB
> > instead.
> >

I completed my OVMF implementation, and it basically does

if (Bp->hdr.version >= 0x210) {
  Status = gBS->LoadImage (FALSE, gImageHandle,
                  (EFI_DEVICE_PATH *)&mKernelDevicePath,
                  NULL, 0, &KernelImageHandle);
  if (EFI_ERROR (Status)) {
    DEBUG ((DEBUG_WARN, "%a: failed to load kernel image - %r\n",
      __FUNCTION__, Status));
    return Status;
  }

  Status = gBS->InstallMultipleProtocolInterfaces (&KernelImageHandle,
                  &gLinuxX86BootParamsProtocolGuid, KernelSetup,
                  NULL);
  if (EFI_ERROR (Status)) {
    DEBUG ((DEBUG_WARN,
      "%a: failed to install bootparams protocol onto kernel image
handle - %r\n",
      __FUNCTION__, Status));
    return Status;
  }

  Status = gBS->StartImage (KernelImageHandle, NULL, NULL);
  DEBUG ((DEBUG_WARN, "%a: StartImage() returned - %r\n",
      __FUNCTION__, Status));
}


> > > But the bootparams structure carries an awful lot of baggage.
> > > Would it be worth considering substituting it for something else when
> > > taking this path?
> >
> > There are two approaches imaginable here:
> > - use bootparams as is, and have it carry cmdline+initrd when booting
> > in EFI mode, as it does today,
> > - align with other EFI arches, and make GRUB pass the command line via
> > the EFI loaded image options, and only pass initrd information.
>
> Since we have options #1-3 above, I will refer to these two options
> as a) and b).
>
> > Given how trivial [and potentially backportable] the approach below
> > is, and the fact that it will enable the use of any kind of existing
> > bootparams related quirk, I'm leaning towards keeping this approach,
> > given that option #2 above requires the introduction of something that
> > we will not be able to share with other arches anyway (unless we use a
> > device tree for this purpose, which doesn't seem like a great idea
> > either)
>
> Or we could (for example) migrate to a common format that uses config
> tables, or a custom protocol like you do here,on all architectures.
>

Actually, that is a good point. That would permit the grub-efi side to
be 100% generic, which would be nice given the complexity of the
proposed secure boot changes.

> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > ---
> > > >  arch/x86/boot/compressed/eboot.c | 8 ++++++++
> > > >  arch/x86/boot/header.S           | 2 +-
> > > >  include/linux/efi.h              | 1 +
> > > >  3 files changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> > > > index 82e26d0ff075..b74c4b18dc20 100644
> > > > --- a/arch/x86/boot/compressed/eboot.c
> > > > +++ b/arch/x86/boot/compressed/eboot.c
> > > > @@ -362,6 +362,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
> > > >       struct setup_header *hdr;
> > > >       efi_loaded_image_t *image;
> > > >       efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
> > > > +     efi_guid_t bp_proto = LINUX_EFI_X86_BOOTPARAMS_PROTOCOL_GUID;
> > > >       int options_size = 0;
> > > >       efi_status_t status;
> > > >       char *cmdline_ptr;
> > > > @@ -374,6 +375,13 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
> > > >       if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
> > > >               return EFI_INVALID_PARAMETER;
> > > >
> > > > +     status = efi_bs_call(handle_protocol, handle, &bp_proto,
> > > > +                          (void **)&boot_params);
> > > > +     if (status == EFI_SUCCESS) {
> > > > +             efi_stub_entry(handle, sys_table, boot_params);
> > > > +             /* not reached */
> > > > +     }
> > > > +
> > >
> > > Would this make sense to move below LOADED_IMAGE_PROTOCOL lookup
> > > below?
> > >
> >
> > For what purpose? If we enter the image with a bootparams structure
> > already provided, why should we care about the loaded image protocol?
>
> I was thinking as a sanity check for a b) approach above. But I guess
> then we'd need to either extend the API of efi_stub_entry even
> further, or repeat the LOADED_IMAGE_PROTOCOL lookup there anyway.
>

Right.

In any case, it would make sense to discuss these options in a wider audience.
