Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62DC93731A
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2019 13:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfFFLj5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jun 2019 07:39:57 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50642 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfFFLj4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jun 2019 07:39:56 -0400
Received: by mail-it1-f196.google.com with SMTP id a186so2624514itg.0
        for <linux-efi@vger.kernel.org>; Thu, 06 Jun 2019 04:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATDRXGLW3SKA+8BA2BRhqoFgRHFlcKJPGLmDOgbTpLM=;
        b=qc3xzSNVRN2ZHqA4Qq9sWKCinZ+aPa2DZYWThtV6g6/Uz7PDYFtgR6Q/uvTwYjvJOb
         lJth1g+Zr2l66cmPLixbsDsPqk2C+lJD+phVR6U3W8sprgD2QYkomWyg0Drd1GQZSPxs
         iMbUP0D0nO/TZebwQznViSUKI2i9OieD/ERrZt5Z5kzLhEYN+JsvPW42tji4/WSxw6Ob
         fWNwTZeiJtEkrjZN+Myd/6lf9Z/tLyLaOAEmFrE+2nnaCwt4vJzaoUhhI/0sSF6PVTPX
         eoNnlkzZZ/0+o1Q5LShZiSFfje3jcYgu9XVwq04oOw/hel3VKkhiARqPSDou290tFVwS
         ZKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATDRXGLW3SKA+8BA2BRhqoFgRHFlcKJPGLmDOgbTpLM=;
        b=ok29IX9AFG4oZOu9Xn8wEZgLM86qkpieHhgzw51TBI6mIMMsdN93lLV9nrWee7T8kF
         +aoKc8137Upvc+pbD7Ji/Sz99Rz6g/mRUbhU6uoQWYp3DFpsKaMrSedE33M8kBFhEXwO
         6NehkyXHtBmN19TTTfheyITIQUR9Wvdu/bh14431sl0Q71qNSdDKAJGqH7+6Da0dxGPG
         YLjZfPZETdUW8uqum/i1T5EVyG6NZGKMY7Gna+zfq91fVYgbG5QWaQ4azdre7+fkRkbI
         lxta24LX0QhboFx7q6NAHryXC6mUXlM9T2YUBZBCNrdpOr5MrlUQeZ9FLUUWh2lfE9ow
         ZKlA==
X-Gm-Message-State: APjAAAVg6nDcgaE5cIbFawW7SUNYSlO6zA/E3ZgovFsXBLLDYx+XXQBU
        ZsGqVe83VDhhfIYYhu1uXmCWUTKaRv5A/RX1WANqQwYR/pFkyQ==
X-Google-Smtp-Source: APXvYqy6IXwtsRT+VSEpdO9w13CdBrJZ0n4wxgUAAHnpaBNtBcCAocBB2FoIBSv0vcIsKI8349N7F/zgspYe071lqco=
X-Received: by 2002:a24:740f:: with SMTP id o15mr15249956itc.76.1559821196007;
 Thu, 06 Jun 2019 04:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190605181140.35559-1-matthewgarrett@google.com>
In-Reply-To: <20190605181140.35559-1-matthewgarrett@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Jun 2019 13:39:42 +0200
Message-ID: <CAKv+Gu_GxV1GySRz-xju6RsB0Qdra=nN=CL+M=jvQ1e2V6p_ig@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix TPM code build failure on ARM
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 5 Jun 2019 at 20:11, Matthew Garrett <matthewgarrett@google.com> wrote:
>
> asm/early_ioremap.h needs to be #included before tpm_eventlog.h in order
> to ensure that early_memremap is available.
>

Doesn't that make it tpm_eventlog.h's job to #include it?


> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  drivers/firmware/efi/tpm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 0bdceb5913aa..1d3f5ca3eaaf 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -7,13 +7,12 @@
>  #define TPM_MEMREMAP(start, size) early_memremap(start, size)
>  #define TPM_MEMUNMAP(start, size) early_memunmap(start, size)
>
> +#include <asm/early_ioremap.h>
>  #include <linux/efi.h>
>  #include <linux/init.h>
>  #include <linux/memblock.h>
>  #include <linux/tpm_eventlog.h>
>
> -#include <asm/early_ioremap.h>
> -
>  int efi_tpm_final_log_size;
>  EXPORT_SYMBOL(efi_tpm_final_log_size);
>
> --
> 2.22.0.rc1.311.g5d7573a151-goog
>
