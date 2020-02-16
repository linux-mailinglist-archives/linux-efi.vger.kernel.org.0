Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9B3160510
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 18:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgBPRdQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 12:33:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgBPRdQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 12:33:16 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 779952086A
        for <linux-efi@vger.kernel.org>; Sun, 16 Feb 2020 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581874395;
        bh=iPN4GRSxftClYdW2bpJCs06VBDIRWUdhu33LTOPvy1Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZGp3vKGqx04ZGJrBDPDq0J03AaC5AmXX6vckOQmSKI6OnFXxFQ4zDkj0x/lcMxTd5
         d3LAu/7ooPAGLOZA5ObrWmaArrgKv37HkzZcM2Kyn84Ej6A3TlI6Ux+2ERb1RWP05O
         OuvQ+x3hyfKs/fHCHNuElz4dGKWZGSFeNwFdQRIo=
Received: by mail-wr1-f43.google.com with SMTP id z3so16911928wru.3
        for <linux-efi@vger.kernel.org>; Sun, 16 Feb 2020 09:33:15 -0800 (PST)
X-Gm-Message-State: APjAAAUtbrlqrXGyDP0DnCeTVJyrWieH9YrUL3vOAIn9opomowgBJx3r
        7wo8EI+50U8vqA7FM2NFHNrnVa5E6kAOAS5ORerzIg==
X-Google-Smtp-Source: APXvYqzC09ky72ZcgkuwLRBsvoAJlw1G1Sf2p3pvdKBd8s4iPftZIwbDcMky5AWdTt8T8hmXVaRSSfXvtc3SLleoicA=
X-Received: by 2002:a5d:6a4b:: with SMTP id t11mr16532123wrw.262.1581874393852;
 Sun, 16 Feb 2020 09:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20200216171340.6070-1-xypron.glpk@gmx.de>
In-Reply-To: <20200216171340.6070-1-xypron.glpk@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 16 Feb 2020 18:33:03 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8JEkFPN3V1mAJtCBAM2=gDhqMMaVxX7Zep-73s6CeARw@mail.gmail.com>
Message-ID: <CAKv+Gu8JEkFPN3V1mAJtCBAM2=gDhqMMaVxX7Zep-73s6CeARw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: function description efi_allocate_pages()
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 16 Feb 2020 at 18:13, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Provide a Sphinx style function description for efi_allocate_pages().
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Thanks Heinrich. I will put this on the pile.

> ---
>  drivers/firmware/efi/libstub/mem.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
> index 5808c8764e64..c6a784ed640f 100644
> --- a/drivers/firmware/efi/libstub/mem.c
> +++ b/drivers/firmware/efi/libstub/mem.c
> @@ -65,8 +65,20 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
>         return status;
>  }
>
> -/*
> - * Allocate at the highest possible address that is not above 'max'.
> +/**
> + * efi_allocate_pages() - Allocate memory pages
> + * @size:      minimum number of bytes to allocate
> + * @addr:      On return the address of the first allocated page. The first
> + *             allocated page has alignment EFI_ALLOC_ALIGN which is an
> + *             architecture dependent multiple of the page size.
> + * @max:       the address that the last allocated memory page shall not
> + *             exceed
> + *
> + * Allocate pages as EFI_LOADER_DATA. The allocated pages are aligned according
> + * to EFI_ALLOC_ALIGN. The last allocated page will not exceed the address
> + * given by 'max'.
> + *
> + * Return:     status code
>   */
>  efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
>                                 unsigned long max)
> --
> 2.25.0
>
