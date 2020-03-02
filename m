Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A058175692
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 10:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCBJGE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Mar 2020 04:06:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgCBJGC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Mar 2020 04:06:02 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF558246B6
        for <linux-efi@vger.kernel.org>; Mon,  2 Mar 2020 09:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583139960;
        bh=9VyCf4dwGTnrVyn18Hp/Ohy02tvvPdNQE/X3kfntlnY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cZ5plMEanXjcxTSiK8Z5s9eTiSyLDidnZC3a0qAVHwC8AeMFxMK8Jkb2kftPUI/RL
         /fNSSTunTS4R0bcIAlW3ojaWkTFr7tTC0xQ0gUVGeR2K94QHn0PuxhyKaIXBqjmTk1
         SkYOKsLteQ6IVqUpEIscDzVzgY4ilkYmmHnHQook=
Received: by mail-wr1-f46.google.com with SMTP id n7so3577802wrt.11
        for <linux-efi@vger.kernel.org>; Mon, 02 Mar 2020 01:05:59 -0800 (PST)
X-Gm-Message-State: ANhLgQ0vY6AieTY2ac+fE8kWTev8dY34MDaSzqFqXqx7EL8wxx2H4u0o
        UPJtJUSLSxeEqwqQHUdopSnWvLKja2R3DyWLuBtOJw==
X-Google-Smtp-Source: ADFU+vsJ1MsogAG7JWBk0KsbC6ingwVKpcNrmJm/CtOg8fMZzkADZRUnDDKZ9pMMuCZbkETade0v13pKbGcH+k5atmE=
X-Received: by 2002:a5d:6051:: with SMTP id j17mr1272058wrt.151.1583139958096;
 Mon, 02 Mar 2020 01:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20200301155748.4788-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200301155748.4788-1-lukas.bulwahn@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 2 Mar 2020 10:05:47 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_gCqMO89wQ8RTwveBMDu-vdwhS5anPiZzQHdViygEouQ@mail.gmail.com>
Message-ID: <CAKv+Gu_gCqMO89wQ8RTwveBMDu-vdwhS5anPiZzQHdViygEouQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust EFI entry to removing eboot.c
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 1 Mar 2020 at 16:58, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit c2d0b470154c ("efi/libstub/x86: Incorporate eboot.c into libstub")
> removed arch/x86/boot/compressed/eboot.[ch], but missed to adjust the
> MAINTAINERS entry.
>
> Since then, ./scripts/get_maintainer.pl --self-test complains:
>
>   warning: no file matches F: arch/x86/boot/compressed/eboot.[ch]
>
> Rectify EXTENSIBLE FIRMWARE INTERFACE (EFI) entry in MAINTAINERS.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Ard, please pick this patch for your linux-next branch.
> applies cleanly on next-20200228, do not apply on current master
>
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>

Thanks Lukas, I'll queue this up.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 09b04505e7c3..4ce510b8467a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6383,7 +6383,6 @@ T:        git git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
>  S:     Maintained
>  F:     Documentation/admin-guide/efi-stub.rst
>  F:     arch/*/kernel/efi.c
> -F:     arch/x86/boot/compressed/eboot.[ch]
>  F:     arch/*/include/asm/efi.h
>  F:     arch/x86/platform/efi/
>  F:     drivers/firmware/efi/
> --
> 2.17.1
>
