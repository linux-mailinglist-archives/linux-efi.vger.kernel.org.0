Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8323224951
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jul 2020 08:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgGRGmc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Jul 2020 02:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgGRGmc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 18 Jul 2020 02:42:32 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7625F2074B
        for <linux-efi@vger.kernel.org>; Sat, 18 Jul 2020 06:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595054551;
        bh=MR1Wr+6XIRfuCBLczwz8Z1Ao+MHg04hlTgPKHAxJ+3E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f4Jwv4oLBZ6Va8bFVRm+dnJrV4sQDE/ti7UqrSrFlD2u+DJ/u1Xpy3xM3+dohfteK
         3WXXYGJb+MaSbVZyUj3xrNgsnB8QA6MQSQCmfjKOLSTXKiPLNJY9HYoJPAeeQSVWub
         GvtA8WcfbQOa19G5ToOsyoxMtv5MRzT7Y53prXvU=
Received: by mail-ot1-f45.google.com with SMTP id d4so8509900otk.2
        for <linux-efi@vger.kernel.org>; Fri, 17 Jul 2020 23:42:31 -0700 (PDT)
X-Gm-Message-State: AOAM530uL86P9yVl9lpNT46E56CveQQdrXKjaAmTO/TcybIfyAQy2mcw
        /Zn6+t6ynIBhIemZ4I8A1HzPRB3uBj1FqjtOd/Q=
X-Google-Smtp-Source: ABdhPJxVqD/LsInDpRVdANNj7M6Em25IQ0JpJsJOYoU+5AwYmG56RG9P1mC5cm5TTW3Xy9JHj2+154vhlzonuxirPU4=
X-Received: by 2002:a9d:6e85:: with SMTP id a5mr11323407otr.90.1595054550849;
 Fri, 17 Jul 2020 23:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200717194526.3452089-1-nivedita@alum.mit.edu>
In-Reply-To: <20200717194526.3452089-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 18 Jul 2020 09:42:19 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHecvnUPc_JNJQTbvn9p3m1ym0sw6xKiXx77=V28c8TFA@mail.gmail.com>
Message-ID: <CAMj1kXHecvnUPc_JNJQTbvn9p3m1ym0sw6xKiXx77=V28c8TFA@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Mark kernel rodata non-executable
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 17 Jul 2020 at 22:45, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> When remapping the kernel rodata section RO in the EFI pagetables, the
> protection flags that were used for the text section are being reused,
> but the rodata section should not be marked executable.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Thanks Arvind.

As this affects mixed mode only, I will park this for now, and send it
out once I have accumulated some more changes.


> ---
>  arch/x86/platform/efi/efi_64.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index 8e364c4c6768..7caa65837356 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -268,6 +268,8 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
>         npages = (__end_rodata - __start_rodata) >> PAGE_SHIFT;
>         rodata = __pa(__start_rodata);
>         pfn = rodata >> PAGE_SHIFT;
> +
> +       pf = _PAGE_NX | _PAGE_ENC;
>         if (kernel_map_pages_in_pgd(pgd, pfn, rodata, npages, pf)) {
>                 pr_err("Failed to map kernel rodata 1:1\n");
>                 return 1;
> --
> 2.26.2
>
