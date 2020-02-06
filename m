Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F0A15464F
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2020 15:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgBFOfj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Feb 2020 09:35:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54746 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgBFOfi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Feb 2020 09:35:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id g1so214846wmh.4
        for <linux-efi@vger.kernel.org>; Thu, 06 Feb 2020 06:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOkE5SpJlKdmIP466Mh2GJy4ITuOAMe9aLwkANI2pA4=;
        b=FZQt9hT2aPgrW3an+zS+HezW3R1SXB8DYcRgAi0AIL8yiTlJRGxRkdQp8b2PKH2E0N
         5cpUG8EM/20IYaAncWnlvioQtb5zsJg1l5fCRGJkzGi2OFIS0TCd1+7t7//rm0otQc8l
         x4EBenJm5XarVdGNHOJFLfgrbh2TCx06reKC8T9LmZ11dKRE3kip7na8yeMPMSvRx4XJ
         AJOFBwYHs2cuyqo4SMvcCCOEPYYsyP75kWZERHJzVK+klTWOWVKVdh5+rCOXhv58+3tu
         3s9BOX65x5mbby9KixcFllWZZf1hHq5k8SWFjN2fzAP9DFO8G06c6zWoKX2NE5hBWnhd
         uLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOkE5SpJlKdmIP466Mh2GJy4ITuOAMe9aLwkANI2pA4=;
        b=dOH4IUMad3d59tUGXXwfvLvLat1xl6z/NmWewkMNKMHCHU8RUA7xxtjBUe56lKuXX+
         fC9+GiI0NcwGnjzcO8cp2/PGsg2Abg7HEaOczDgyEg9cZB3LyB3YEbM+AMsJZEXuN+Nj
         3tupvuW0gwVlbiYbACbdn+i7ES3EjFEMZU/IKhE++M9GJ+iH8sPGoydZzkbO1nORmVpU
         unluA7+NmSZQxNn2cTWwoenmnfNH02crGEVtW/KsruwUQvp+rNLldmgL75f7OI6e0lSW
         QuQF2kIVxsDdKkV1e6QUmr4GAzKRqcFhRe1w1fLBtp91mMJXKpUNtSB37IQGoZMyMU35
         DLKQ==
X-Gm-Message-State: APjAAAXRMFZ74L/zatxsfi/bEznXRJa3zPmWZPyeqBbyBt7DTZBJ7Qyn
        wEyjhirav5eIlNXW61ArkEqMs+j+ftj5C6MqU2D1Ag==
X-Google-Smtp-Source: APXvYqyNmMjSpyBfQkJTnAdCK3LaBzNoE0Jh5PNiy8sfQlx2iHSF68dLgPZgB6yLdlKyy1KfPmvP195jZxJk6xdstwk=
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr4844609wmf.40.1580999736222;
 Thu, 06 Feb 2020 06:35:36 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-22-ardb@kernel.org>
 <0a31756e-d554-ff1c-5809-130d516714ae@redhat.com>
In-Reply-To: <0a31756e-d554-ff1c-5809-130d516714ae@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Feb 2020 14:35:25 +0000
Message-ID: <CAKv+Gu-bafCk_A27q=hyvbk6KW997D=snHUjOQG+t-NkY4PrKw@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on bridges
 during boot
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
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

On Thu, 6 Feb 2020 at 14:31, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 12/18/19 6:01 PM, Ard Biesheuvel wrote:
> > From: Matthew Garrett <matthewgarrett@google.com>
> >
> > Add an option to disable the busmaster bit in the control register on
> > all PCI bridges during the invocation of ExitBootServices() and passing
> > control to the runtime kernel. System firmware may configure the IOMMU
> > to prevent malicious PCI devices from being able to attack the OS via DMA.
> > However, since firmware can't guarantee that the OS is IOMMU-aware, it
> > will tear down IOMMU configuration when ExitBootServices() is called.
> > This leaves a window between where a hostile device could still cause
> > damage before Linux configures the IOMMU again.
> >
> > If CONFIG_EFI_DISABLE_PCI_DMA is enabled or the "efi=disable_pci_dma"
> > command line argument is passed, the EFI stub will clear the busmaster
> > bit on all PCI bridges before ExitBootServices() completes. This will
> > prevent any malicious PCI devices from being able to perform DMA until
> > the kernel reenables busmastering after configuring the IOMMU.
> >
> > This option is disabled when in EFI mixed mode environments (ie, 64-bit
> > kernels with a 32-bit EFI implementation), given that the use of EFI
> > events is not supported in this case.
> >
> > This option may cause failures with some poorly behaved hardware and
> > should not be enabled without testing. The kernel commandline options
> > "efi=disable_pci_dma" or "efi=no_disable_pci_dma" may be used to
> > override the default.
> >
> > Co-developed-by: Matthew Garrett <mjg59@google.com>
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > [ardb: use EFI events to defer DMA disabling to the end of ExitBootServices()]
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> I guess this might not be the latest version of this patch, but
> this does seem to be the thread where most discussion on it
> has happened.
>
> My personal kernel tree atm consists of v5.5 + efi/next + my own patches
> and yesterday I noticed that will not boot on a Lenovo X1 7th gen connected
> to a Lenovo thunderbolt 3 gen 2 dock.
>
> My first hunch was that I have CONFIG_EFI_DISABLE_PCI_DMA=y and that that
> was causing it and indeed that is the problem.
>
> So as (somewhat) expected CONFIG_EFI_DISABLE_PCI_DMA=y indeed stops the kernel
> from booting on some systems.
>
> When I hit this problem the efistub prints 2 messages and then the system
> just hangs:
>
> exit_boot() failed!
> efi_main() failed!
>
> When I boot the system without it being connected to the thunderbolt dock
> then efi=disable_pci_dma works fine.
>
> Let me know if I can do anything to help and getting booting while
> connected to the dock to work with efi=disable_pci_dma.
>

Thanks Hans.

Can you run the UEFI shell on this system? If so, could you share the
output of devtree, both in the docked and the undocked states?

That should help us pinpoint which device is throwing an error at
ExitBootServices() time due to its driver having been disconnected.
