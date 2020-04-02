Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A5A19C113
	for <lists+linux-efi@lfdr.de>; Thu,  2 Apr 2020 14:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbgDBMbt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Apr 2020 08:31:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732957AbgDBMbs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 2 Apr 2020 08:31:48 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E278420784;
        Thu,  2 Apr 2020 12:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585830708;
        bh=DNMiejYwj2j0Q5rLQZF5oFRZlYEgWeu3M1bkmf7hNEc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k/apptIJHcrqHktp4ToqJxrtyMHceAbQ598Eg3lDXvMcf8qQLBmBq9Avwh4QCIXhf
         xEdPcA+wfR3dbIc2FEKx2apDHYG2eSMvJ3hWCpOKL4KPWzAKUGuGTMYhoU5pB2KMaX
         dqK/l/ksji1WsoiFipAjKyd9k14HypJd9c7ynSCo=
Received: by mail-io1-f46.google.com with SMTP id y17so1259898iow.9;
        Thu, 02 Apr 2020 05:31:47 -0700 (PDT)
X-Gm-Message-State: AGi0PubbHIFtlWLhTPDbPRy/5aeVYdDgeSl6Mjt21DoLHilONJSuw+5m
        /mOEmjT59BuB7e5z7A1+aH0RyC01ZnQ0vKPjYAE=
X-Google-Smtp-Source: APiQypL+SH2GW1pV8qQ+8TpfGGBEg/QFKeyESpRUrLNNnjZ3QYYp2FRde6CIsOAENBP0K5dSS6xs7XOfzgQAjR/9PLQ=
X-Received: by 2002:a05:6638:a22:: with SMTP id 2mr3218066jao.74.1585830707279;
 Thu, 02 Apr 2020 05:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200402102537.503103-1-colin.king@canonical.com>
In-Reply-To: <20200402102537.503103-1-colin.king@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 2 Apr 2020 14:31:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF=v5QNEPdzFuwuE6-FTysGV1qTfsHLRFkbgG8sjMcAMQ@mail.gmail.com>
Message-ID: <CAMj1kXF=v5QNEPdzFuwuE6-FTysGV1qTfsHLRFkbgG8sjMcAMQ@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub/x86: remove redundant assignment to pointer hdr
To:     Colin King <colin.king@canonical.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2 Apr 2020 at 12:25, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer hdr is being assigned a value that is never read and
> it is being updated later with a new value. The assignment is
> redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks Colin. I'll queue this up.

> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 8d3a707789de..e02ea51273ff 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -392,8 +392,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>         image_base = efi_table_attr(image, image_base);
>         image_offset = (void *)startup_32 - image_base;
>
> -       hdr = &((struct boot_params *)image_base)->hdr;
> -
>         status = efi_allocate_pages(0x4000, (unsigned long *)&boot_params, ULONG_MAX);
>         if (status != EFI_SUCCESS) {
>                 efi_printk("Failed to allocate lowmem for boot params\n");
> --
> 2.25.1
>
