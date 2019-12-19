Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBFC21259AB
	for <lists+linux-efi@lfdr.de>; Thu, 19 Dec 2019 03:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSCuP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Dec 2019 21:50:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfLSCuO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 18 Dec 2019 21:50:14 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F6B924676
        for <linux-efi@vger.kernel.org>; Thu, 19 Dec 2019 02:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576723814;
        bh=9KgypPwrlr826WwVMVeS/rAzvy61qi9K77kyHV+Sd10=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y5bulYPV1wPEQMe1dQniT11r4jM0sBsVCKU2ZHOoXrn8/JJqB4XEnW5mtQUHpYt/F
         Ecr1gQWsDD5tkeVlCWyzrxJ60PT2r8Qw/VlwA1Kd+YB+eU9ei00uVK/gpQk83UgpTG
         oX7INyKuD03IX8JHScEG0e9mV+DmtYL3UtlQ+AVc=
Received: by mail-wm1-f45.google.com with SMTP id f129so4048655wmf.2
        for <linux-efi@vger.kernel.org>; Wed, 18 Dec 2019 18:50:14 -0800 (PST)
X-Gm-Message-State: APjAAAVKXkvSUdLwJ/ethqo95rwfAIkJRK8TA3oLCn5CXZKmkqBweD2O
        Uj4Z1+muL3fVTvNxzDUqC3ABpx0jPNVp76jOpcn3zQ==
X-Google-Smtp-Source: APXvYqyrbSC6DH7uj8M+ymwdB+SprcqhKpaQk4ihsppywpWHtP7cnKBB+zs0A9EJe+5VRi3TxECaFshXfbuhfdbADhg=
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr7119263wmi.89.1576723812679;
 Wed, 18 Dec 2019 18:50:12 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-22-ardb@kernel.org>
In-Reply-To: <20191218170139.9468-22-ardb@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 18 Dec 2019 18:50:00 -0800
X-Gmail-Original-Message-ID: <CALCETrWLMeSbmL_ff=AOmuswxWgvRu75cpNPz9SZgeNwex+ygg@mail.gmail.com>
Message-ID: <CALCETrWLMeSbmL_ff=AOmuswxWgvRu75cpNPz9SZgeNwex+ygg@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on bridges
 during boot
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
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

On Wed, Dec 18, 2019 at 9:03 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> From: Matthew Garrett <matthewgarrett@google.com>
>
> Add an option to disable the busmaster bit in the control register on
> all PCI bridges during the invocation of ExitBootServices() and passing
> control to the runtime kernel. System firmware may configure the IOMMU
> to prevent malicious PCI devices from being able to attack the OS via DMA.
> However, since firmware can't guarantee that the OS is IOMMU-aware, it
> will tear down IOMMU configuration when ExitBootServices() is called.
> This leaves a window between where a hostile device could still cause
> damage before Linux configures the IOMMU again.
>
> If CONFIG_EFI_DISABLE_PCI_DMA is enabled or the "efi=disable_pci_dma"
> command line argument is passed, the EFI stub will clear the busmaster
> bit on all PCI bridges before ExitBootServices() completes. This will
> prevent any malicious PCI devices from being able to perform DMA until
> the kernel reenables busmastering after configuring the IOMMU.
>
> This option is disabled when in EFI mixed mode environments (ie, 64-bit
> kernels with a 32-bit EFI implementation), given that the use of EFI
> events is not supported in this case.
>
> This option may cause failures with some poorly behaved hardware and
> should not be enabled without testing. The kernel commandline options
> "efi=disable_pci_dma" or "efi=no_disable_pci_dma" may be used to
> override the default.

Could this maybe be efi=disable_early_pci_dma?

As it stands, it reads like busmastering is turned off and stays off,
which is not the case.  I'm dreading the silly forum posts saying
"your system is slow, and busmastering is leet, so use
efi=no_disable_pci_dma to allow busmastering and make it OMG fast".

--Andy
