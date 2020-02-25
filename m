Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB10016ECF1
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2020 18:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgBYRpU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 12:45:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729939AbgBYRpU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Feb 2020 12:45:20 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADAF82176D
        for <linux-efi@vger.kernel.org>; Tue, 25 Feb 2020 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582652720;
        bh=3Poz7jxq/qrWijhX+h0LsAxU+LowS2xjr5QXZRUEM/M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qVWyRsciCPkSKXc5vXMsH44IvYNi1Ru2klseSGmoInTcEJ7iupPoCumWQvacsEgDP
         Dkaf799PKHDMNJ1k54tRReZpvSlxbq4izq3YNkqHGvYWL6Y4K6QLk+RrMMCe+Pzhuc
         ZWsKGd7NaoAkvLu39t+5FdorfzPSqo69GLF0dSgQ=
Received: by mail-wm1-f53.google.com with SMTP id p9so73160wmc.2
        for <linux-efi@vger.kernel.org>; Tue, 25 Feb 2020 09:45:19 -0800 (PST)
X-Gm-Message-State: APjAAAW8L8yXBQ/uM1bYBomB8zaIQt0lqrStg6ql9YhbfmTJ/HvN1Llx
        1VdcHF1DtToA+htnu0wcn8n0R30PTWAGolFrUYE/4w==
X-Google-Smtp-Source: APXvYqyZRwLTc1nkXaComsaLWbhJtUqWzzkDg2dRKUkmo7/fXBOi/XyjC/Y/6v14bvpDRDK/fkAw2IXpcmtzTQP/G/k=
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr363473wmj.1.1582652718055;
 Tue, 25 Feb 2020 09:45:18 -0800 (PST)
MIME-Version: 1.0
References: <261ea8108c6290e95962be2638bd204f90787c1c.1582652466.git.thomas.lendacky@amd.com>
In-Reply-To: <261ea8108c6290e95962be2638bd204f90787c1c.1582652466.git.thomas.lendacky@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Feb 2020 18:45:06 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_FJeiaY5yw9=ER4XyBZrDFZ5L4igrqxP6hhJ7Z8easpw@mail.gmail.com>
Message-ID: <CAKv+Gu_FJeiaY5yw9=ER4XyBZrDFZ5L4igrqxP6hhJ7Z8easpw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/efi: Add additional efi tables for unencrypted
 mapping checks
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 25 Feb 2020 at 18:41, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> When booting with SME active, EFI tables must be mapped unencrypted since
> they were built by UEFI in unencrypted memory. Update the list of tables
> to be checked during early_memremap() processing to account for new EFI
> tables.
>
> This fixes a bug where an EFI TPM log table has been created by UEFI, but
> it lives in memory that has been marked as usable rather than reserved.
>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>
> ---
> Changes since v1:
> - Re-spun against EFI tree

Which one? Surely not the one in the link I included?

> ---
>  arch/x86/platform/efi/efi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 43b24e149312..c6ca959e2366 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -88,6 +88,9 @@ static const unsigned long * const efi_tables[] = {
>  #ifdef CONFIG_EFI_RCI2_TABLE
>         &rci2_table_phys,
>  #endif
> +       &efi.rng_seed,
> +       &efi.tpm_log,
> +       &efi.tpm_final_log,
>  };
>
>  u64 efi_setup;         /* efi setup_data physical address */
> --
> 2.17.1
>
