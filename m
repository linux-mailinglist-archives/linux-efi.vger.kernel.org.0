Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEFF1A4356
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 10:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgDJIJh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 04:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDJIJg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Apr 2020 04:09:36 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C36920753;
        Fri, 10 Apr 2020 08:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586506176;
        bh=EaVt/rHc26tChpdiQtuvjo6e3de2d0m2F5OOEuyoPDY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UKWDT4wvhQ+8oQnkrQbv/DJKnnOBb3VmGwQBMSC0J2cPj84hbEBGQztzHo6x7mnjY
         e+MO0qG5/IfWcsXQllq1+vHm/gwvd5skOS11T77olS5cLbCodMDq6iZCS7EYOMHybi
         cIt3W77NfeEfNZaWEvzi4SG9PRLvm9iVshQ6hdT4=
Received: by mail-il1-f176.google.com with SMTP id p13so1182248ilp.3;
        Fri, 10 Apr 2020 01:09:36 -0700 (PDT)
X-Gm-Message-State: AGi0PuZxvnTOvXrynsf2oVngsH4whZpSSfg5ikad3p0nQPXcdigMdEes
        WpFMDzoUwiJVJ3we4VDpCz5Ia8/3vgxS+qoDvb0=
X-Google-Smtp-Source: APiQypKt8o2uUAIKvHvnewWjGb3+iaI9Q0QrgDkYCsexDRvS+Com6DRJf3WBaRhmV84z22mJ4az+i4vsxibbb8tCNsA=
X-Received: by 2002:a05:6e02:4c:: with SMTP id i12mr3961102ilr.211.1586506175952;
 Fri, 10 Apr 2020 01:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <1586468669-21456-1-git-send-email-victor.erminpour@oracle.com>
In-Reply-To: <1586468669-21456-1-git-send-email-victor.erminpour@oracle.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Apr 2020 10:09:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGgYYx=9rq-Ficw3vS6FX_0nb-hRStXijh7H4zdD=+Gaw@mail.gmail.com>
Message-ID: <CAMj1kXGgYYx=9rq-Ficw3vS6FX_0nb-hRStXijh7H4zdD=+Gaw@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub/arm64: Enable __efistub_global define in
 .data section
To:     Victor Erminpour <victor.erminpour@oracle.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 9 Apr 2020 at 23:44, Victor Erminpour
<victor.erminpour@oracle.com> wrote:
>
> Enable the __efistub_global define to place variables in the
> .data section for both CONFIG_ARM and CONFIG_ARM64.
>
> This places the EFIstub sys_table variable and other EFIstub
> static variables in the .data section for both CONFIG_ARM and
> CONFIG_ARM64.
>

What does that achieve?

> Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
> ---
>  drivers/firmware/efi/libstub/efistub.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index c244b16..59932d6 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -25,7 +25,7 @@
>  #define EFI_ALLOC_ALIGN                EFI_PAGE_SIZE
>  #endif
>
> -#ifdef CONFIG_ARM
> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
>  #define __efistub_global       __section(.data)
>  #else
>  #define __efistub_global
