Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829791C066A
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 21:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgD3Tab (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 15:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgD3Tab (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 30 Apr 2020 15:30:31 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5676120870;
        Thu, 30 Apr 2020 19:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588275030;
        bh=dOMTdvmPpDwoNbmYDtcE5oAQidSzs0ZRLgAH9Rf5ejw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VhNI2r1/2GAHkvWRYR5JqHXcbpNVcsxKQyiva4PeISGbGVxQd97SXzJyLvr+1osLf
         zAxNSFWdvaOHskYTowLxOvyRqmchJ5cAphgUAlS4DIZdQCPNbKkak3BIrIo8sxYRsY
         AqFbyAwV7kPJlx0nPgyIAeLlNaQXjzqVj4aoXN3w=
Received: by mail-io1-f47.google.com with SMTP id c2so2731640iow.7;
        Thu, 30 Apr 2020 12:30:30 -0700 (PDT)
X-Gm-Message-State: AGi0PuaQac+Izl6shhtrKBPOSitx+CFRQB+Ntmo/i7aE3r0dJKY36jb8
        QUi2FAdMmc+YxBWmE/8Xp5BRt6pw0GsT2YMyngM=
X-Google-Smtp-Source: APiQypLe4/dSl8kMISrfU36u5yXX9Io9TAfZnjXWb9LQh9a1rRbj+Sdii0jjsgPJmS1J4uEpFKdqKGFwMrXDnpWIrjI=
X-Received: by 2002:a5d:8045:: with SMTP id b5mr396251ior.16.1588275028780;
 Thu, 30 Apr 2020 12:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <091e3fc3bdbc5f480af7d3b3ac096d174a4480d0.1588273612.git.joe@perches.com>
 <ec53e67b3ac928922807db3cb1585e911971dadc.1588273612.git.joe@perches.com>
In-Reply-To: <ec53e67b3ac928922807db3cb1585e911971dadc.1588273612.git.joe@perches.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 30 Apr 2020 21:30:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHwdy3BTqt-q_qnezyz666BcqKiFxeumfsD+Qjy5qRzZA@mail.gmail.com>
Message-ID: <CAMj1kXHwdy3BTqt-q_qnezyz666BcqKiFxeumfsD+Qjy5qRzZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi/libstub: Correct comment typos
To:     Joe Perches <joe@perches.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 30 Apr 2020 at 21:12, Joe Perches <joe@perches.com> wrote:
>
> Fix a couple typos in comments.
>
> Signed-off-by: Joe Perches <joe@perches.com>

Thanks, I'll queue this one up

> ---
>
> Perhaps these trivialities on top of this series?
>
> drivers/firmware/efi/libstub/pci.c      | 2 +-
>  drivers/firmware/efi/libstub/relocate.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/pci.c b/drivers/firmware/efi/libstub/pci.c
> index 111c44b..17a53d8 100644
> --- a/drivers/firmware/efi/libstub/pci.c
> +++ b/drivers/firmware/efi/libstub/pci.c
> @@ -69,7 +69,7 @@ void efi_pci_disable_bridge_busmaster(void)
>                  * access to the framebuffer. Drivers for true PCIe graphics
>                  * controllers that are behind a PCIe root port do not use
>                  * DMA to implement the GOP framebuffer anyway [although they
> -                * may use it in their implentation of Gop->Blt()], and so
> +                * may use it in their implementation of Gop->Blt()], and so
>                  * disabling DMA in the PCI bridge should not interfere with
>                  * normal operation of the device.
>                  */
> diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
> index 62e2d6..a7ad26 100644
> --- a/drivers/firmware/efi/libstub/relocate.c
> +++ b/drivers/firmware/efi/libstub/relocate.c
> @@ -140,7 +140,7 @@ efi_status_t efi_relocate_kernel(unsigned long *image_addr,
>          * The EFI firmware loader could have placed the kernel image
>          * anywhere in memory, but the kernel has restrictions on the
>          * max physical address it can run at.  Some architectures
> -        * also have a prefered address, so first try to relocate
> +        * also have a preferred address, so first try to relocate
>          * to the preferred address.  If that fails, allocate as low
>          * as possible while respecting the required alignment.
>          */
> --
> 2.26.0
>
