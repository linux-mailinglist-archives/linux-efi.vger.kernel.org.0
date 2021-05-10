Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A193792E5
	for <lists+linux-efi@lfdr.de>; Mon, 10 May 2021 17:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhEJPkY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 May 2021 11:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234490AbhEJPju (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 May 2021 11:39:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4A7D60FE4;
        Mon, 10 May 2021 15:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620661121;
        bh=1Zsl9SztvxaW6X5yybQdHiTY0J0WjKFNG3noiaEUXQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OF5j/FVpcPcGwdaOBA/s3TbLmd8a7l+K09QjFCyscBSuOGMFXXhv/feNa4mF+8ryo
         n0KzaCREFZN/zqNC0xENKxBaC4z7ZswREiNIH4NulcS7j1w1F/OCltsZY0oHDvX8Tj
         TLO1g1Ex2WMEFst6LKOZd2AaRFigXknWTGTR9kLhgIMUEQL1nEUBC2iddPhWI1oi8w
         LIdUX9kzzCDQP87ejxW0D8OOZ5SDsYp84QTmJOGtyReIOen0hC0E8UMWEQy3KLzokM
         NQWiIg9UcH+aedKbchBNJZEnIsh0JETNrqhEVC47yfEi/ptsvpguH7Qkxp91ph49pz
         TsmuJEa9ZFscg==
Received: by mail-oi1-f179.google.com with SMTP id b25so10923321oic.0;
        Mon, 10 May 2021 08:38:41 -0700 (PDT)
X-Gm-Message-State: AOAM531QBFCbxRDhHrhlOZIkAWNXUWQVJh2mcdDhlPffZvSzMsMRm46c
        XzyBMK3Kj1R1ipbruSX57zPPJGZRWLVBPTnYUbY=
X-Google-Smtp-Source: ABdhPJyzL1Eyc5r70XnrgnFSkdgDVnk8oWZUFRX1A3dchBwdZpihODX/nbKKUaWX6vR16z6SR9rq6Mli+P1KA7DzDH8=
X-Received: by 2002:aca:4056:: with SMTP id n83mr26631363oia.47.1620661121088;
 Mon, 10 May 2021 08:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <YIK0D1JyV6ZeDMSS@mwanda>
In-Reply-To: <YIK0D1JyV6ZeDMSS@mwanda>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 10 May 2021 17:38:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHELn=t9H4z2SK7u5kkTuqh-TnW9YtY6PJs8Q=j-PLVTg@mail.gmail.com>
Message-ID: <CAMj1kXHELn=t9H4z2SK7u5kkTuqh-TnW9YtY6PJs8Q=j-PLVTg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: prevent read overflow in find_file_option()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Philipp Fent <fent@in.tum.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 23 Apr 2021 at 13:48, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> If the buffer has slashes up to the end then this will read past the end
> of the array.  I don't anticipate that this is an issue for many people
> in real life, but it's the right thing to do and it makes static
> checkers happy.
>
> Fixes: 7a88a6227dc7 ("efi/libstub: Fix path separator regression")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/firmware/efi/libstub/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
> index 4e81c6077188..dd95f330fe6e 100644
> --- a/drivers/firmware/efi/libstub/file.c
> +++ b/drivers/firmware/efi/libstub/file.c
> @@ -103,7 +103,7 @@ static int find_file_option(const efi_char16_t *cmdline, int cmdline_len,
>                 return 0;
>
>         /* Skip any leading slashes */
> -       while (cmdline[i] == L'/' || cmdline[i] == L'\\')
> +       while (i < cmdline_len && (cmdline[i] == L'/' || cmdline[i] == L'\\'))
>                 i++;
>
>         while (--result_len > 0 && i < cmdline_len) {
> --
> 2.30.2
>

Thanks Dan, I will queue this up.
