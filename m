Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797BF1F965F
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jun 2020 14:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbgFOMQE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jun 2020 08:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729863AbgFOMQD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Jun 2020 08:16:03 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E8A8206B7
        for <linux-efi@vger.kernel.org>; Mon, 15 Jun 2020 12:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592223363;
        bh=x/0rQFJaTGc84XvnrPEz+bPp43IhgBzF584SNjzZl+0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LZU+B18syuAdQQu3B8IfIx8CdI2XpsJzoEu4VVArbhNRHxc4UViDUDDGdPQcakBYX
         xUIOru2DJHlJgYOq9TGLBhSJ/mPsbpviCAwFJhb2i8QLuZZ0Lev4au3/mW5qLpxByp
         VrBVElSllDu+pxzAx+mHG1Dg0JZjF9Q5fRyF39DE=
Received: by mail-ot1-f45.google.com with SMTP id t6so12890066otk.9
        for <linux-efi@vger.kernel.org>; Mon, 15 Jun 2020 05:16:03 -0700 (PDT)
X-Gm-Message-State: AOAM530WT73SxghasHFrWIxkrb6TVTh0GPMcKO7zKvf4j4ZMit6iwt9a
        ml/jUfzNFx/A8RkNMlg1j4FtAw2ko+LZk+I+0uI=
X-Google-Smtp-Source: ABdhPJxL2A/6SoFQsjmuiEFJyltSB1BrjbOWB5nkcOT1TTx/PLuUrbjK3HETrkls4TBxICM5F/8efuuiZGitEesIqZo=
X-Received: by 2002:a9d:42e:: with SMTP id 43mr21145184otc.108.1592223362691;
 Mon, 15 Jun 2020 05:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200615115109.7823-1-fent@in.tum.de>
In-Reply-To: <20200615115109.7823-1-fent@in.tum.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 15 Jun 2020 14:15:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGiG1opT8OyO-fN30YnrwAwSN6VttfhN5Hz1fMHd5EbVA@mail.gmail.com>
Message-ID: <CAMj1kXGiG1opT8OyO-fN30YnrwAwSN6VttfhN5Hz1fMHd5EbVA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Fix path separator regression
To:     Philipp Fent <fent@in.tum.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 15 Jun 2020 at 13:58, Philipp Fent <fent@in.tum.de> wrote:
>
> Commit 9302c1bb8e47 ("efi/libstub: Rewrite file I/O routine") introduced a
> regression that made a couple of (badly configured) systems fail to
> boot [1]: Until 5.6, we silently accepted Unix-style file separators in
> EFI paths, which might violate the EFI standard, but are an easy to make
> mistake. This fix restores the pre-5.7 behaviour.
>
> [1] https://bbs.archlinux.org/viewtopic.php?id=256273
>
> Signed-off-by: Philipp Fent <fent@in.tum.de>

Apologies for the breakage. I will queue this as a fix.


> ---
>  drivers/firmware/efi/libstub/file.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
> index 2005e33b33d5..f8a28a6e0bde 100644
> --- a/drivers/firmware/efi/libstub/file.c
> +++ b/drivers/firmware/efi/libstub/file.c
> @@ -102,11 +102,21 @@ static int find_file_option(const efi_char16_t *cmdline, int cmdline_len,
>         if (!found)
>                 return 0;
>
> +       /* Skip any leading slashes */
> +       while (cmdline[i] == L'/' || cmdline[i] == L'\\')
> +               i++;
> +
>         while (--result_len > 0 && i < cmdline_len) {
>                 if (cmdline[i] == L'\0' ||
>                     cmdline[i] == L'\n' ||
>                     cmdline[i] == L' ')
>                         break;
> +               /* Replace UNIX dir separators with EFI standard separators */
> +               if (cmdline[i] == L'/') {
> +                       *result++ = L'\\';
> +                       i++;
> +                       continue;
> +               }

Any objections if I change this to


---%<---
efi_char16_t c = cmdline[i++];

if (c == L'\0' || c == L'\n' || c == L' ')
  break;
else if (c == L'/')
  /* Replace UNIX dir separators with EFI standard ones */
  *result++ = L'\\';
else
  *result++ = c;
---%<---


(no need to resend)


>                 *result++ = cmdline[i++];
>         }
>         *result = L'\0';
> --
> 2.27.0
>
