Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1245F147EC1
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jan 2020 11:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgAXKag (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jan 2020 05:30:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36069 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAXKag (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jan 2020 05:30:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so1197406wma.1
        for <linux-efi@vger.kernel.org>; Fri, 24 Jan 2020 02:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gskFPzigrKSZnIcxyJHhjUVm5hRE4att7o5Wvs95Y/M=;
        b=IlLYRMdrFRAXWnIXyGKQF6a7h5bMPvnSa1dVUApdPydJjrOLd6qCOCDQ48urILP4Gj
         MmgSP9bYehn96/awga8jN43aG/39L9ayHuoEyKgHU66E7sUWOXNgs7qmHEVE0jvI5dry
         oEtZ1YogEjX0tx0yjd5e9UMTF9TKI8kR0T63KCZrQs4hcqhbHOmnJ7Xhoje4qtPLFCr6
         AYlMIzbdCfnE0iLP+wfPNCWfC73gGiON8uMcFIwZX2A3FZ4DidGxIsRD7Zz2aRoUg7Tb
         ZREcGp/Xt//06KxFHrDDVMOCOF/fLNvd0DdjGjguAmcoH1qxoVY2QOGpYc1hyfS0SdnZ
         XcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gskFPzigrKSZnIcxyJHhjUVm5hRE4att7o5Wvs95Y/M=;
        b=Ue8U2hsWdzR/IM8/DSw/rdIkV+gb1ZAoRtOwxkfZEMi1SOgwKz/bQL9V7dzwcaqh3l
         NkRrDYsqq4Pl43lxt5VvBFvxxad1iAFfQaRGEeYAbuN4/A6kj2sxEkSOwWb7lC7sQ6il
         kJIfTwoQlxScgMLf6iWXqt5yQj+Hc5E3xMuNRLPe4rYzfZrkd0Qaqmt/2EVEGwO+6r+5
         7HD2i97tH6q6WDpMzOku8kxsdB+o3Es5yTlEri0yo5nt8yYWu83RY8C6V/zpybeSYOOb
         mF/sqDusZItV+HOIYtQA9KJq8z/dguXnAsfh4T3pyO7i7OVtTyd22vAj/HS0H7lQKSte
         bDlA==
X-Gm-Message-State: APjAAAUpEJCj2HNVyC6JxOb7ih+wLUcuIkMOD42FOJtz7/mw6Q15o0f8
        m0UhmvI99c8dyfFrZE5HPL90VA==
X-Google-Smtp-Source: APXvYqyT05ki5wukDKmtbXad2iBgVNSnTQPYWDCQxZoP4ubXVrQNRC926NYV4ospzWVA6COJEVBsXg==
X-Received: by 2002:a05:600c:2059:: with SMTP id p25mr2848677wmg.161.1579861833128;
        Fri, 24 Jan 2020 02:30:33 -0800 (PST)
Received: from bivouac.eciton.net (bivouac.eciton.net. [2a00:1098:0:86:1000:23:0:2])
        by smtp.gmail.com with ESMTPSA id z187sm6523868wme.16.2020.01.24.02.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 02:30:32 -0800 (PST)
Date:   Fri, 24 Jan 2020 10:30:31 +0000
From:   Leif Lindholm <leif@nuviainc.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [EXTERNAL] Re: [RFC PATCH] efi/libstub/x86: look for bootparams
 when booting via PE entry point
Message-ID: <20200124103030.GA23297@bivouac.eciton.net>
References: <20200123173047.18409-1-ardb@kernel.org>
 <20200123232736.GS9444@bivouac.eciton.net>
 <CAKv+Gu8m8TzHe7GdCTrdy0atwVw-yQA+2=7CbTO0RpzuR19T0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8m8TzHe7GdCTrdy0atwVw-yQA+2=7CbTO0RpzuR19T0A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 24, 2020 at 08:28:08 +0100, Ard Biesheuvel wrote:
> On Fri, 24 Jan 2020 at 00:27, Leif Lindholm <leif@nuviainc.com> wrote:
> >
> > On Thu, Jan 23, 2020 at 18:30:47 +0100, Ard Biesheuvel wrote:
> > > There are currently a couple of different ways the Linux kernel can be
> > > booted on UEFI x86 systems:
> > > 1) legacy boot - the bootloader jumps straight into the first byte of the
> > >    kernel image after taking down the UEFI boot services and populating a
> > >    bootparams structure with the required information
> > > 2) PE entry point - the kernel is booted as an ordinary PE/COFF executable,
> > >    using the loadimage and startimage boot services, and it is left to the
> > >    boot stub to allocate and populate a bootparams structure
> > > 3) EFI handover protocol - the kernel is copied into memory and the loader
> > >    jumps into it at a fixed offset, providing a bootparams structure but
> > >    with the EFI boot services still active.
> > >
> > > Option #3 is the option preferred by the distros today, since it allows
> > > the bootloader to populate and pass the bootparams structure directly,
> > > which enables things like initrd images loaded from any filesystem (as
> > > opposed to option #2, which requires the kernel's boot stub to load the
> > > initrd but it only supports loading images from the same volume that the
> > > kernel image was loaded from). Option #3 also supports loading 32-bit
> > > kernels on 64-bit firmware and vice versa.
> > >
> > > However, option #2 is a more seamless match, given that it uses the
> > > firmware's standard loading facilities, which is also what EFI secure
> > > boot authentication checks are based on.
> > >
> > > So let's provide a way for option #2 to be used in combination with a
> > > bootloader provided bootparams structure, by specifying a special protocol
> > > GUID for it, and looking for it on the image handle when entering via the
> > > ordinary PE/COFF entry point. This allows a loader to call LoadImage,
> > > install the new protocol on the resulting handle and invoke the kernel via
> > > StartImage, and thus rely on the authentication performed by those boot
> > > services if secure boot is enabled.
> >
> > My impression is that this patch depends on the not-yet-upstream
> > "efi/libstub/x86: Drop __efi_early() export and efi_config struct"?
> >
> 
> Yes, it applies onto efi/next branch
> 
> > (This would be helpful to mention in relation to a future PATCH,
> > unless the requirements have by then already trickled upstream.)
> 
> Sure, although it is not unusual in Linux development for patches on
> $TOPIC to be created against $TOPIC's development branch.

No, it just would have saved me a few minutes of digging since I've
not been actively tracking linux-efi for quite some time (quite
possibly since the repo url included 'mfleming').

> > I like how clean this change is (once prereqs are in).
> > But for the sake of having the conversation - doing this requires a
> > corresponding change in any bootloader, to register the bootparams
> > structure as a protocol on the image handle.
> 
> Yes. I have looked into implementing this for OVMF, which implements
> the kernel's boot protocol directly (to support the
> -kernel/-append/-initrd QEMU arguments), but it is a bit involved,
> given how QEMU cuts up the PE image into two separate parts. I'll have
> another stab at it today, but it may be better to look at GRUB
> instead.
> 
> > But the bootparams structure carries an awful lot of baggage.
> > Would it be worth considering substituting it for something else when
> > taking this path?
> 
> There are two approaches imaginable here:
> - use bootparams as is, and have it carry cmdline+initrd when booting
> in EFI mode, as it does today,
> - align with other EFI arches, and make GRUB pass the command line via
> the EFI loaded image options, and only pass initrd information.

Since we have options #1-3 above, I will refer to these two options
as a) and b).

> Given how trivial [and potentially backportable] the approach below
> is, and the fact that it will enable the use of any kind of existing
> bootparams related quirk, I'm leaning towards keeping this approach,
> given that option #2 above requires the introduction of something that
> we will not be able to share with other arches anyway (unless we use a
> device tree for this purpose, which doesn't seem like a great idea
> either)

Or we could (for example) migrate to a common format that uses config
tables, or a custom protocol like you do here,on all architectures.

> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/boot/compressed/eboot.c | 8 ++++++++
> > >  arch/x86/boot/header.S           | 2 +-
> > >  include/linux/efi.h              | 1 +
> > >  3 files changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> > > index 82e26d0ff075..b74c4b18dc20 100644
> > > --- a/arch/x86/boot/compressed/eboot.c
> > > +++ b/arch/x86/boot/compressed/eboot.c
> > > @@ -362,6 +362,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
> > >       struct setup_header *hdr;
> > >       efi_loaded_image_t *image;
> > >       efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
> > > +     efi_guid_t bp_proto = LINUX_EFI_X86_BOOTPARAMS_PROTOCOL_GUID;
> > >       int options_size = 0;
> > >       efi_status_t status;
> > >       char *cmdline_ptr;
> > > @@ -374,6 +375,13 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
> > >       if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
> > >               return EFI_INVALID_PARAMETER;
> > >
> > > +     status = efi_bs_call(handle_protocol, handle, &bp_proto,
> > > +                          (void **)&boot_params);
> > > +     if (status == EFI_SUCCESS) {
> > > +             efi_stub_entry(handle, sys_table, boot_params);
> > > +             /* not reached */
> > > +     }
> > > +
> >
> > Would this make sense to move below LOADED_IMAGE_PROTOCOL lookup
> > below?
> >
> 
> For what purpose? If we enter the image with a bootparams structure
> already provided, why should we care about the loaded image protocol?

I was thinking as a sanity check for a b) approach above. But I guess
then we'd need to either extend the API of efi_stub_entry even
further, or repeat the LOADED_IMAGE_PROTOCOL lookup there anyway.

/
    Leif

> > >       status = efi_bs_call(handle_protocol, handle, &proto, (void *)&image);
> > >       if (status != EFI_SUCCESS) {
> > >               efi_printk("Failed to get handle for LOADED_IMAGE_PROTOCOL\n");
> > > diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> > > index 97d9b6d6c1af..2b5d4d181df1 100644
> > > --- a/arch/x86/boot/header.S
> > > +++ b/arch/x86/boot/header.S
> > > @@ -300,7 +300,7 @@ _start:
> > >       # Part 2 of the header, from the old setup.S
> > >
> > >               .ascii  "HdrS"          # header signature
> > > -             .word   0x020f          # header version number (>= 0x0105)
> > > +             .word   0x0210          # header version number (>= 0x0105)
> > >                                       # or else old loadlin-1.5 will fail)
> > >               .globl realmode_swtch
> > >  realmode_swtch:      .word   0, 0            # default_switch, SETUPSEG
> > > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > > index 4169e9d0d699..fd381ebce127 100644
> > > --- a/include/linux/efi.h
> > > +++ b/include/linux/efi.h
> > > @@ -666,6 +666,7 @@ void efi_native_runtime_setup(void);
> > >  #define LINUX_EFI_TPM_EVENT_LOG_GUID         EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
> > >  #define LINUX_EFI_TPM_FINAL_LOG_GUID         EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
> > >  #define LINUX_EFI_MEMRESERVE_TABLE_GUID              EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
> > > +#define LINUX_EFI_X86_BOOTPARAMS_PROTOCOL_GUID       EFI_GUID(0xa50da594, 0x048d, 0x4296,  0xb2, 0xe1, 0xce, 0xc7, 0xb4, 0xf5, 0x79, 0x13)
> > >
> > >  /* OEM GUIDs */
> > >  #define DELLEMC_EFI_RCI2_TABLE_GUID          EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
> > > --
> > > 2.17.1
> > >
