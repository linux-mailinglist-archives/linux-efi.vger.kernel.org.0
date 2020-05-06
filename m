Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439AF1C6A06
	for <lists+linux-efi@lfdr.de>; Wed,  6 May 2020 09:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgEFHYH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 May 2020 03:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbgEFHYH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 6 May 2020 03:24:07 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1542E2075A;
        Wed,  6 May 2020 07:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588749847;
        bh=x7OyI4ujQqJw0j0GzC4hS3Aq2xvKqYQlLnWoJNviDjI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2dF/3JTTgUTXkPe00eAGP+i/UrEb6At13z6L8h0yfrl/xzNk2Y5LE5dG3bFPy3gsV
         PanOXrzYPZqsVHdv4gTC1p54m9U/IrzFxdW0PPJ6mB4mrKWoHAmCzVMzr1tCUx8MbD
         mgM6oToSjO1sRXefqDLWUFwvnbNkWAeT0wdLMaio=
Received: by mail-io1-f43.google.com with SMTP id k18so1201848ion.0;
        Wed, 06 May 2020 00:24:07 -0700 (PDT)
X-Gm-Message-State: AGi0PuYoT4ZZstg3sPL6oQwiLuTiKNjIDIeCqxshoR6lAX/ZSnl3ww0A
        /Pdf8tA7K/oPGQ8sXyaiAIwRFquy7Pnog8qw7fg=
X-Google-Smtp-Source: APiQypIDZYGhT0LIyzlWMf02JIHTT0d22XLa8P8k+ofCUy3V1mbu/iTR9hb+bBCzJxHhbqT4z3ia2IzftQLl9LWc4FA=
X-Received: by 2002:a02:8247:: with SMTP id q7mr6901558jag.68.1588749846416;
 Wed, 06 May 2020 00:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200505190016.4350-1-lszubowi@redhat.com>
In-Reply-To: <20200505190016.4350-1-lszubowi@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 6 May 2020 09:23:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHsvy09V0rK2Qh0eiR4Vi5ZDn=5ordNvEBH4c-Xk00QgQ@mail.gmail.com>
Message-ID: <CAMj1kXHsvy09V0rK2Qh0eiR4Vi5ZDn=5ordNvEBH4c-Xk00QgQ@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub/x86: Free EFI map buffer in allocate_e820()
To:     Lenny Szubowicz <lszubowi@redhat.com>
Cc:     eric.snowberg@oracle.com, Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 5 May 2020 at 21:00, Lenny Szubowicz <lszubowi@redhat.com> wrote:
>
> In allocate_e820(), free the EFI map buffer that has been returned
> by efi_get_memory_map(). The returned size of the EFI map buffer
> is used to allocate an adequately sized e820ext buffer, if it's
> needed. But the contents of that EFI map buffer is not used at all
> and the local pointer to it is gone on return from allocate_e820().
>
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 05ccb229fb45..4efe3e7a218d 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -623,6 +623,9 @@ static efi_status_t allocate_e820(struct boot_params *params,
>         if (status != EFI_SUCCESS)
>                 return status;
>
> +       /* Allocated EFI map buf is not used here. Just need its size. */
> +       efi_bs_call(free_pool, map);
> +

Wouldn't it be better to call BS->GetMemoryMap() directly here, with a
zero size for the input buffer?

>         nr_desc = buff_size / desc_size;
>
>         if (nr_desc > ARRAY_SIZE(params->e820_table)) {
> --
> 2.18.4
>
