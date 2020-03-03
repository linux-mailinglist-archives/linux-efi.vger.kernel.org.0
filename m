Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86DE61782EA
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 20:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgCCTLs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 14:11:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729586AbgCCTLr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Mar 2020 14:11:47 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9610F208C3
        for <linux-efi@vger.kernel.org>; Tue,  3 Mar 2020 19:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583262706;
        bh=Gm97G7ePTvTA/2qImrmMfXs4ah+ywyggwz9iheWgI34=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zFNEdwSvQ65AQQj+EjXhFKyKnE4i/lJyYwLSS+ADHBpVaPtUkoLFAiyvHSC1cKiJh
         EYfrrxQmOXeBXtbvN9MopG2vxijGaxFQ4mmfFvLPzqxTudAwxoAj2HOPArIUTQ/Xaf
         L5pahdot351ChS+RD22FpHcjnYJhEpnrtZ3tQ/J0=
Received: by mail-wr1-f41.google.com with SMTP id v4so5833528wrs.8
        for <linux-efi@vger.kernel.org>; Tue, 03 Mar 2020 11:11:46 -0800 (PST)
X-Gm-Message-State: ANhLgQ18+daACKm1LWd+5zcdDGyHP8j6blVzYXUfCs53JivEi3TfQvlG
        +5VnIXIwVtoiZ5LL8mNVznob9uW1Sh8BGJVRZrY3EA==
X-Google-Smtp-Source: ADFU+vvZpcv2G95Un+H8kNu0mF7hau3OQ+mlltuZfwIGzpAzdyWYqEdm4ZULNNH/bCnKgBNOLgwTiI9R4qt0HDehXj4=
X-Received: by 2002:adf:a411:: with SMTP id d17mr6691415wra.126.1583262705029;
 Tue, 03 Mar 2020 11:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20200301230537.2247550-1-nivedita@alum.mit.edu> <20200301230537.2247550-4-nivedita@alum.mit.edu>
In-Reply-To: <20200301230537.2247550-4-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 Mar 2020 20:11:34 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_Xbw7SjdCvHMrDXW4o-XtM8FH4LAXPtro9cXSecVuFSA@mail.gmail.com>
Message-ID: <CAKv+Gu_Xbw7SjdCvHMrDXW4o-XtM8FH4LAXPtro9cXSecVuFSA@mail.gmail.com>
Subject: Re: [PATCH 3/5] efi/x86: Add kernel preferred address to PE header
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2 Mar 2020 at 00:05, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Store the kernel's link address as ImageBase in the PE header. Note that
> the PE specification requires the ImageBase to be 64k aligned. The
> preferred address should almost always satisfy that, except for 32-bit
> kernel if the configuration has been customized.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/header.S | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 4ee25e28996f..0d8d2cb28fd9 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -138,10 +138,12 @@ optional_header:
>  #endif
>
>  extra_header_fields:
> +       # PE specification requires ImageBase to be 64k-aligned
> +       .set    ImageBase, (LOAD_PHYSICAL_ADDR+0xffff) & ~0xffff

Could you call this image_base please, and put some spaces around the +

>  #ifdef CONFIG_X86_32
> -       .long   0                               # ImageBase
> +       .long   ImageBase                       # ImageBase
>  #else
> -       .quad   0                               # ImageBase
> +       .quad   ImageBase                       # ImageBase
>  #endif
>         .long   0x20                            # SectionAlignment
>         .long   0x20                            # FileAlignment
> --
> 2.24.1
>
