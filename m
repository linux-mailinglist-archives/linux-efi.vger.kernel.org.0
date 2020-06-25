Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A3B20A29A
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jun 2020 18:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403920AbgFYQGl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Jun 2020 12:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403870AbgFYQGl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 25 Jun 2020 12:06:41 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4EF22082F
        for <linux-efi@vger.kernel.org>; Thu, 25 Jun 2020 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593101200;
        bh=9CieM3ydCzhnTQatdofQJHy/UqSGeOnX+gL71Y17B/Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rR5HMubhtz9Wjiix+rwxuhN3ahVlbHuwjBGOxXEVBTlP7wwa1APP9hjdWXbjrJUVS
         18bsNceJWnl5t2T/89n6B0FuxrPj0QZG2SpJ+qW8fAOG8FdWJh3GWNyaigYh3uQUDn
         wlr9sTxSje1sX47XbX6BdnLRJeJxh4drcVS35xnc=
Received: by mail-ot1-f44.google.com with SMTP id u23so5731582otq.10
        for <linux-efi@vger.kernel.org>; Thu, 25 Jun 2020 09:06:40 -0700 (PDT)
X-Gm-Message-State: AOAM531csUQbR9a450eJPqFf5MYmgkMIfFuB/EpulZlYgTyvttfNYl79
        hj6IqfNGvr/Rin/gpnv1f1Nm70l3Y7zcdMx5lNw=
X-Google-Smtp-Source: ABdhPJwms3ao4qK2VqfvH2d8UYzXUloh/BEtpmhQLdmdecJoZI2ZGx9+RLHp/fgfx3Jnnuu36ijd2XBn6UwWLhgYZfc=
X-Received: by 2002:a9d:5a12:: with SMTP id v18mr26472534oth.90.1593101199987;
 Thu, 25 Jun 2020 09:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200618191059.3809491-1-nivedita@alum.mit.edu>
In-Reply-To: <20200618191059.3809491-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 25 Jun 2020 18:06:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEXchmP4aEXrT+UQMtec2pWuGrs2V+_xNKy-XG5sW4uVQ@mail.gmail.com>
Message-ID: <CAMj1kXEXchmP4aEXrT+UQMtec2pWuGrs2V+_xNKy-XG5sW4uVQ@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Remove unused variables
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 18 Jun 2020 at 21:11, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Commit
>   987053a30016 ("efi/x86: Move command-line initrd loading to efi_main")
> made the ramdisk_addr/ramdisk_size variables in efi_pe_entry unused, but
> neglected to delete them.
>
> Delete these unused variables.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Queued as a fix, thanks.

> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 5a48d996ed71..37e82bf397aa 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -361,8 +361,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>         int options_size = 0;
>         efi_status_t status;
>         char *cmdline_ptr;
> -       unsigned long ramdisk_addr;
> -       unsigned long ramdisk_size;
>
>         efi_system_table = sys_table_arg;
>
> --
> 2.26.2
>
