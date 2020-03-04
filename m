Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 424811797D3
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 19:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCDS1B (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 13:27:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43672 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgCDS1B (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 13:27:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id h9so3659817wrr.10
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 10:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7rFHkVrJbbcrT2/8m75YP3DRgTjx1oSn+vaHlr9aO2A=;
        b=ptdAr/dl+pyOr1IzJx4MTj1K5lFkgKDuiM6yGPCdQAo/PO/90N5tpsnnvshZOWoT1k
         jQb2LEaUR98kanlk6H/Mgf97fTnxnpPebiFeb4tGyQzbERAzhq3dgosmaQdjmla2cw58
         3s4vqbX8h9XL2bEtk1TSLg5OT9OPO0fljAO8yi1ChmT5xEpXjF3D2uOVn7FrsE4HQdrY
         ObRRtpTfOLptG/r3YsfqOKyl1E6sfEK+IbZkV0ow7Da4LXTHy3HwnrvieaKA5Igja4LM
         E6quEnGamHz3Y3EynoW0haeIN/8/8F70Mc0Gb5hjate4QvKX6/4zNPLe+CE9k0WgG3Wa
         6eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rFHkVrJbbcrT2/8m75YP3DRgTjx1oSn+vaHlr9aO2A=;
        b=TyrpP8aGH76v1XIeW0D6Px8MxWVJauW+Bcah8FhzEXS8IhjNhXXHirXN1N9MvXEY1L
         yPAIQP08camIJCWmxd41rfMOjL38ZWktkCiqKY3TBZIFoqakYtzfC9qmoiLjxkC4EUeT
         x+1PzcDi+rPBpTkhzHE5C6So/GC8AxRCJT36/j39YnmYInFcNFT9irGj70GncehqXZSi
         JQRLO4EhkctNQAcSTHqJDv25IjnxcEYyvVqL2hgbNUV+A7dOxx8cw+noxofa/0rzVn6L
         OCFkWPZLOOFzkZjCbnXY98SVy6qV+stTiQBabqnmmq0+Xh/W3V07bZOuma1bYj3tnE8l
         T7NQ==
X-Gm-Message-State: ANhLgQ3B9qaeJmHAu/1OQNu2rvKG3EEHGXrdUuCAYMw1bee20ok1rbG5
        yxkuk/A/8cpKKvspF8aTXPNaBas5Ck8mhVuulp7XaQ==
X-Google-Smtp-Source: ADFU+vuV+qG6BfaVCFj4nGlwp0QirNSaC9lMg/t2WGiRlH8qXih9loAM5/fIdpLTINIIaipxJrTIKoE1NJ8aDV+89sY=
X-Received: by 2002:a5d:6051:: with SMTP id j17mr5233631wrt.151.1583346417238;
 Wed, 04 Mar 2020 10:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-22-ardb@kernel.org>
 <0a31756e-d554-ff1c-5809-130d516714ae@redhat.com> <CAKv+Gu-bafCk_A27q=hyvbk6KW997D=snHUjOQG+t-NkY4PrKw@mail.gmail.com>
 <2a641bee-5f23-daaf-019a-3636fa6966c5@redhat.com>
In-Reply-To: <2a641bee-5f23-daaf-019a-3636fa6966c5@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 4 Mar 2020 19:26:46 +0100
Message-ID: <CAKv+Gu9RwGhDrUNCa8JqbDv5ckuWiiA_81RehoZMMEFAwfbn+g@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on bridges
 during boot
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Mar 2020 at 11:39, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 2/6/20 3:35 PM, Ard Biesheuvel wrote:
> > On Thu, 6 Feb 2020 at 14:31, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 12/18/19 6:01 PM, Ard Biesheuvel wrote:
> >>> From: Matthew Garrett <matthewgarrett@google.com>
> >>>
> >>> Add an option to disable the busmaster bit in the control register on
> >>> all PCI bridges during the invocation of ExitBootServices() and passing
> >>> control to the runtime kernel. System firmware may configure the IOMMU
> >>> to prevent malicious PCI devices from being able to attack the OS via DMA.
> >>> However, since firmware can't guarantee that the OS is IOMMU-aware, it
> >>> will tear down IOMMU configuration when ExitBootServices() is called.
> >>> This leaves a window between where a hostile device could still cause
> >>> damage before Linux configures the IOMMU again.
> >>>
> >>> If CONFIG_EFI_DISABLE_PCI_DMA is enabled or the "efi=disable_pci_dma"
> >>> command line argument is passed, the EFI stub will clear the busmaster
> >>> bit on all PCI bridges before ExitBootServices() completes. This will
> >>> prevent any malicious PCI devices from being able to perform DMA until
> >>> the kernel reenables busmastering after configuring the IOMMU.
> >>>
> >>> This option is disabled when in EFI mixed mode environments (ie, 64-bit
> >>> kernels with a 32-bit EFI implementation), given that the use of EFI
> >>> events is not supported in this case.
> >>>
> >>> This option may cause failures with some poorly behaved hardware and
> >>> should not be enabled without testing. The kernel commandline options
> >>> "efi=disable_pci_dma" or "efi=no_disable_pci_dma" may be used to
> >>> override the default.
> >>>
> >>> Co-developed-by: Matthew Garrett <mjg59@google.com>
> >>> Signed-off-by: Matthew Garrett <mjg59@google.com>
> >>> [ardb: use EFI events to defer DMA disabling to the end of ExitBootServices()]
> >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>
> >> I guess this might not be the latest version of this patch, but
> >> this does seem to be the thread where most discussion on it
> >> has happened.
> >>
> >> My personal kernel tree atm consists of v5.5 + efi/next + my own patches
> >> and yesterday I noticed that will not boot on a Lenovo X1 7th gen connected
> >> to a Lenovo thunderbolt 3 gen 2 dock.
> >>
> >> My first hunch was that I have CONFIG_EFI_DISABLE_PCI_DMA=y and that that
> >> was causing it and indeed that is the problem.
> >>
> >> So as (somewhat) expected CONFIG_EFI_DISABLE_PCI_DMA=y indeed stops the kernel
> >> from booting on some systems.
> >>
> >> When I hit this problem the efistub prints 2 messages and then the system
> >> just hangs:
> >>
> >> exit_boot() failed!
> >> efi_main() failed!
> >>
> >> When I boot the system without it being connected to the thunderbolt dock
> >> then efi=disable_pci_dma works fine.
> >>
> >> Let me know if I can do anything to help and getting booting while
> >> connected to the dock to work with efi=disable_pci_dma.
> >>
> >
> > Thanks Hans.
> >
> > Can you run the UEFI shell on this system? If so, could you share the
> > output of devtree, both in the docked and the undocked states?
> >
> > That should help us pinpoint which device is throwing an error at
> > ExitBootServices() time due to its driver having been disconnected.
>
> Sorry for being slow to respond. Attached are the outputs of devtree in
> both states. Not sure if the list will accept this, but you should
> get a direct copy.
>

Interesting. The only difference that UEFI seems to know about in
terms of device hierarchy is a XHCI controller with a Realtek USB NIC
attached.

Could you try unloading the driver for that manually, or disconnecting
it? Or disconnect the whole thing from the shell?

If just unloading the realtek driver does not make a difference, but
unload/disconnecting the xhci makes it work, it is likely that it this
feature will break a lot of systems.






--- Downloads/devtree-not-docked 2020-03-04 19:18:14.596315280 +0100
+++ Downloads/devtree-docked 2020-03-04 19:18:08.856257969 +0100
@@ -11,6 +11,7 @@
    Ctrl[] PciRoot(0x0)/Pci(0x0,0x0)
    Ctrl[] Intel(R) Graphics Controller
      Ctrl[] EDP1
+     Ctrl[] DP1
        Ctrl[] Primary Console Output Device
    Ctrl[] PciRoot(0x0)/Pci(0x4,0x0)
    Ctrl[] PciRoot(0x0)/Pci(0x8,0x0)
@@ -44,6 +45,110 @@
    Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x0,0x0)
    Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x0,0x0)/Pci(0x0,0x0)
    Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)
+   Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)
+   Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)
+   Ctrl[] eXtensible Host Controller (USB 3.0)
+     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)
+     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x3,0x0)
+     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)
+     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x4,0x0)
+     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x3,0x0)/USB(0x0,0x0)
+     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x0,0x0)
+     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x2,0x0)
+     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x3,0x0)
+     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x3,0x0)/USB(0x0,0x0)/USB(0x1,0x0)
+       Ctrl[] Realtek USB Ethernet Controller
<lots of network stuff>
+     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x0,0x0)/USB(0x3,0x0)
+     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x0,0x0)/USB(0x3,0x1)
+     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x0,0x0)/USB(0x3,0x2)
+     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x0,0x0)/USB(0x3,0x3)
+     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x2,0x0)/USB(0x3,0x0)
+     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x3,0x0)/USB(0x0,0x0)
+     Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x2,0x0)/Pci(0x0,0x0)/USB(0x1,0x0)/USB(0x0,0x0)/USB(0x3,0x0)/USB(0x1,0x0)
+     Ctrl[] Generic Usb Keyboard
+       Ctrl[] Primary Console Input Device
+     Ctrl[] Generic Usb Mouse
+       Ctrl[] Primary Console Input Device
+     Ctrl[] Generic Usb Mouse
+       Ctrl[] Primary Console Input Device
+   Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x4,0x0)
    Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x2,0x0)
    Ctrl[] eXtensible Host Controller (USB 3.0)
    Ctrl[] PciRoot(0x0)/Pci(0x1D,0x4)/Pci(0x0,0x0)/Pci(0x4,0x0)
@@ -69,5 +174,3 @@
  Ctrl[] VenHw(2C0EEABD-4107-44A8-A787-2E38FFC52B2B)
  Ctrl[] VenHw(48B9FB42-B3B9-4A0E-BF66-36AE1C302369)
  Ctrl[] VenHw(A7F26116-CFDC-4296-8224-ED7D140170C7)
- Ctrl[] MemoryMapped(0xB,0xFF2E0000,0xFF37FFFF)
- Ctrl[] Fv(B92CF322-8AFA-4AA4-B946-005DF1D69778)
