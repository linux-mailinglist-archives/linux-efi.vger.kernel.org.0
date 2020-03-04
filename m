Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C53F179B5E
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 22:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388389AbgCDV7o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 16:59:44 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51433 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388281AbgCDV7o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 16:59:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id a132so3968803wme.1
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 13:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E+9MYSdRR2EKU8qoABHmwd4RgS6ohBSTigAP5NRs/yE=;
        b=R7N29paXY9UhvHcVMI5l9y5ICGVSDTF6vidfhn/aYdet2gbdq/z15eyAZ4me1eQ3xf
         X8QzX3XQOasfizrAD23oixyVud1jQQvt02GrFaprw4mBoNbQxEO34OgPqu4J59bERINu
         d42OMsAVKwhz4hbaNmQ6aJbE0nAqBQ0/LaDYBDVthtfezOtb+431+j1hlk4OvBXgL0uI
         h512dQOPdtf5Z7xpElAwRohQQUGEl9fg4eWZ+imrc3SamctqONgiW+MdGrwEizjMy9ay
         ZPGuaXy5/TZnz8j0bddHtcF3dYiUf4VaeDDN98o+S2lDe+cKW/LnUhmZ2VOEqeswnZBE
         OuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E+9MYSdRR2EKU8qoABHmwd4RgS6ohBSTigAP5NRs/yE=;
        b=i67P556sLyqcCK3K5t6FYnuGIBkzMfH5ErSAPKl+RD5pfbMYwVblmWY66mvBfLMmqd
         ljGEjgAHG2WQgovHgUoAlw7TzL/8gGyrb3glU1Hphf9Gq4XVpGpD8cG3rYQW98siGiyB
         XXSONMNWJy/nP6c8PDUJFizunbmrE7o4KkcVxfnOSLvQzzYmCT1zY+11Itexi3Gjuu9V
         3d+Q180Crl0MA42YZ+g0MBDgyYhDxn8edBVMO3Gl4YkBxUpm86FpczvcvunzoSDB1R7n
         iMZzBSkSw+qeHxQsHn5SBLiiY3dnG+hmqT/vZ+zG4HFRHNn8IQmQsGGIwGa4kXpw5Q4Z
         Dl2w==
X-Gm-Message-State: ANhLgQ2eXELHQpdnClMyJkiiGkLgBwPDy3nZDQqRzlvon5YVQtbTbiBg
        u2fJz0MNmRkbOD86I7g22ou58OBKK8KPKB2Af/xbPQ==
X-Google-Smtp-Source: ADFU+vtrTBWF5f74nuNQ/KGqE7wVMlUGVrCO1PJS8sP26N3AheotqeRBp4h7qCkZ4oUxxTN8BY8Ea0WnjGGuKpal5Mc=
X-Received: by 2002:a1c:9d43:: with SMTP id g64mr5298642wme.62.1583359180897;
 Wed, 04 Mar 2020 13:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-22-ardb@kernel.org>
 <0a31756e-d554-ff1c-5809-130d516714ae@redhat.com> <CAKv+Gu-bafCk_A27q=hyvbk6KW997D=snHUjOQG+t-NkY4PrKw@mail.gmail.com>
 <2a641bee-5f23-daaf-019a-3636fa6966c5@redhat.com> <CAKv+Gu9RwGhDrUNCa8JqbDv5ckuWiiA_81RehoZMMEFAwfbn+g@mail.gmail.com>
 <de8c1023-c637-263b-b5d0-2a71ddb24d6e@redhat.com>
In-Reply-To: <de8c1023-c637-263b-b5d0-2a71ddb24d6e@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 4 Mar 2020 22:59:30 +0100
Message-ID: <CAKv+Gu-JLm_W-Zdtg=Bea5mmyyCkhMtz9Py=ybwGmP8W9Ck1pA@mail.gmail.com>
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

On Wed, 4 Mar 2020 at 19:49, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 3/4/20 7:26 PM, Ard Biesheuvel wrote:
> > On Wed, 4 Mar 2020 at 11:39, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 2/6/20 3:35 PM, Ard Biesheuvel wrote:
> >>> On Thu, 6 Feb 2020 at 14:31, Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 12/18/19 6:01 PM, Ard Biesheuvel wrote:
> >>>>> From: Matthew Garrett <matthewgarrett@google.com>
> >>>>>
> >>>>> Add an option to disable the busmaster bit in the control register on
> >>>>> all PCI bridges during the invocation of ExitBootServices() and passing
> >>>>> control to the runtime kernel. System firmware may configure the IOMMU
> >>>>> to prevent malicious PCI devices from being able to attack the OS via DMA.
> >>>>> However, since firmware can't guarantee that the OS is IOMMU-aware, it
> >>>>> will tear down IOMMU configuration when ExitBootServices() is called.
> >>>>> This leaves a window between where a hostile device could still cause
> >>>>> damage before Linux configures the IOMMU again.
> >>>>>
> >>>>> If CONFIG_EFI_DISABLE_PCI_DMA is enabled or the "efi=disable_pci_dma"
> >>>>> command line argument is passed, the EFI stub will clear the busmaster
> >>>>> bit on all PCI bridges before ExitBootServices() completes. This will
> >>>>> prevent any malicious PCI devices from being able to perform DMA until
> >>>>> the kernel reenables busmastering after configuring the IOMMU.
> >>>>>
> >>>>> This option is disabled when in EFI mixed mode environments (ie, 64-bit
> >>>>> kernels with a 32-bit EFI implementation), given that the use of EFI
> >>>>> events is not supported in this case.
> >>>>>
> >>>>> This option may cause failures with some poorly behaved hardware and
> >>>>> should not be enabled without testing. The kernel commandline options
> >>>>> "efi=disable_pci_dma" or "efi=no_disable_pci_dma" may be used to
> >>>>> override the default.
> >>>>>
> >>>>> Co-developed-by: Matthew Garrett <mjg59@google.com>
> >>>>> Signed-off-by: Matthew Garrett <mjg59@google.com>
> >>>>> [ardb: use EFI events to defer DMA disabling to the end of ExitBootServices()]
> >>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>>>
> >>>> I guess this might not be the latest version of this patch, but
> >>>> this does seem to be the thread where most discussion on it
> >>>> has happened.
> >>>>
> >>>> My personal kernel tree atm consists of v5.5 + efi/next + my own patches
> >>>> and yesterday I noticed that will not boot on a Lenovo X1 7th gen connected
> >>>> to a Lenovo thunderbolt 3 gen 2 dock.
> >>>>
> >>>> My first hunch was that I have CONFIG_EFI_DISABLE_PCI_DMA=y and that that
> >>>> was causing it and indeed that is the problem.
> >>>>
> >>>> So as (somewhat) expected CONFIG_EFI_DISABLE_PCI_DMA=y indeed stops the kernel
> >>>> from booting on some systems.
> >>>>
> >>>> When I hit this problem the efistub prints 2 messages and then the system
> >>>> just hangs:
> >>>>
> >>>> exit_boot() failed!
> >>>> efi_main() failed!
> >>>>
> >>>> When I boot the system without it being connected to the thunderbolt dock
> >>>> then efi=disable_pci_dma works fine.
> >>>>
> >>>> Let me know if I can do anything to help and getting booting while
> >>>> connected to the dock to work with efi=disable_pci_dma.
> >>>>
> >>>
> >>> Thanks Hans.
> >>>
> >>> Can you run the UEFI shell on this system? If so, could you share the
> >>> output of devtree, both in the docked and the undocked states?
> >>>
> >>> That should help us pinpoint which device is throwing an error at
> >>> ExitBootServices() time due to its driver having been disconnected.
> >>
> >> Sorry for being slow to respond. Attached are the outputs of devtree in
> >> both states. Not sure if the list will accept this, but you should
> >> get a direct copy.
> >>
> >
> > Interesting. The only difference that UEFI seems to know about in
> > terms of device hierarchy is a XHCI controller with a Realtek USB NIC
> > attached.
> >
> > Could you try unloading the driver for that manually, or disconnecting
> > it? Or disconnect the whole thing from the shell?
>
> How would I go about that / do that ?
>
> > If just unloading the realtek driver does not make a difference, but
> > unload/disconnecting the xhci makes it work, it is likely that it this
> > feature will break a lot of systems.
>
> Notice that it is not just the XHCI controller which gets added though,
> there also is an extra PCI-e switch added to the route to the XHCI controller,
> I've attached both docked and undocked lspci output under Linux. I guess
> this might be transparent from a UEFI pov though.
>

Yeah, what matters is drivers that are actually called when the EFI
stub calls ExitBootServices(), and looking at the dump, the XHCI
driver and the Realtek driver are the only ones that stand out to me
(and the Realtek one is probably the only 3rd party driver, so that
one looks the most suspect to me)
