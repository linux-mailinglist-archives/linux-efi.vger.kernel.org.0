Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5EE12634A
	for <lists+linux-efi@lfdr.de>; Thu, 19 Dec 2019 14:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfLSNRv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Dec 2019 08:17:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54060 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfLSNRv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Dec 2019 08:17:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id m24so5386296wmc.3
        for <linux-efi@vger.kernel.org>; Thu, 19 Dec 2019 05:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SaU+qXQ1t2qsNuSusxMAcfgyz0QkGRejIK6OwmfEOA8=;
        b=hQAENzXgiRiPWd918FmEAA95YnzTsflaNqQ4vVNJEnsIvcKXTATRxMVwqGBkUxGKPK
         tRx9aquyrxUfo+bRJ9itv4qYHt8VGlJuH617w7Rmsu32qYjjSa7/XVPAnBKgeF8S5K+F
         /BrYFBwJm1BzZNPZzw7eRSLjNaq8EtcOGSC7fzBMiwlxJKYVY5AfexyshUGqlVAcjayy
         rKrwgBImXqfjrIMyUnwJvNkzgH6qcvKvWXW8n3Nq1/78doZB3Xa1DkLXm8MujGiqAdUN
         mDLV9a0wkkX/JB/zorlur27xQtognKWkGHQ4NMFrANpa5hD38hhFi7EOEZneFQTMOfSC
         66tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SaU+qXQ1t2qsNuSusxMAcfgyz0QkGRejIK6OwmfEOA8=;
        b=tlqkrExAPqIuOeaHBsDwDU+L+ISIN7sxuP3+pmMCp7pQJ7CjnfG0FDwDHpyliTt4eQ
         Dx6mePrjbaCpOMbh0bmiaqcuwLi+0fbOBSSnp5jE8jGFjHwsnQv4lMx27hU7bN6KpQFN
         DRwDqBl70hubVt2LuyoLiksE/ijQ9xa5tL/G4AgWIIOmPIbiHiT20K6Iv5fbkX00auWz
         pCoLJungabk8c2cyaWx7BeTWNdAGVooLeHUPn+QAKVD3os1Ht/eqZGpWAVDUc2MON+2B
         bI5kvQFYNWp/gCB3eqpNzsvMVtL2N9AATY6HI7lG5DxPgpU/gRe2YuziMfs0hNFBwFnU
         Qnug==
X-Gm-Message-State: APjAAAUHm/R+REiIL4xZ3ppr2gVMoHOHnT5vEVOtaDjmVZOt0UoL8dIQ
        3h27kYGMJlUyzzWeaoEUIlMmvVmh5iBjjREQGbO5sg==
X-Google-Smtp-Source: APXvYqx4klGO0GVEA3hzmRWU2J6BD7RzjcDibCeVmBV4qX0G1SX+EBDdxUeG5xfzDF5PYu60tvTbE2almU4YsPQp4+0=
X-Received: by 2002:a1c:a795:: with SMTP id q143mr9583693wme.52.1576761469282;
 Thu, 19 Dec 2019 05:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-22-ardb@kernel.org>
 <CALCETrWLMeSbmL_ff=AOmuswxWgvRu75cpNPz9SZgeNwex+ygg@mail.gmail.com>
In-Reply-To: <CALCETrWLMeSbmL_ff=AOmuswxWgvRu75cpNPz9SZgeNwex+ygg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 19 Dec 2019 13:17:44 +0000
Message-ID: <CAKv+Gu-BNNmix9vcR6y1UQZSH5BDOcqeWj=2XM75OvxDwQ8DoQ@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on bridges
 during boot
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 19 Dec 2019 at 04:50, Andy Lutomirski <luto@kernel.org> wrote:
>
> On Wed, Dec 18, 2019 at 9:03 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
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
>
> Could this maybe be efi=disable_early_pci_dma?
>
> As it stands, it reads like busmastering is turned off and stays off,
> which is not the case.  I'm dreading the silly forum posts saying
> "your system is slow, and busmastering is leet, so use
> efi=no_disable_pci_dma to allow busmastering and make it OMG fast".
>

Fair enough. I'll change this to [no_]disable_early_pci_dma (assuming
Matthew doesn't object to the exact shade of this bikeshed)
