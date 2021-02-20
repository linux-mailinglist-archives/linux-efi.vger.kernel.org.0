Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134443205CE
	for <lists+linux-efi@lfdr.de>; Sat, 20 Feb 2021 15:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhBTOvD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 20 Feb 2021 09:51:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhBTOvD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 20 Feb 2021 09:51:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90FC0614A7;
        Sat, 20 Feb 2021 14:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613832620;
        bh=sEgZZeFlsjMhvx4/IaxNjgfQb/5lJnlNMe12FkxtARM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R0w8ZN9az4icRd0HwdeQcPC/o35/bV+Qu+guCJzFztERSQPhD3cj2JlyPuCHBZ8Yl
         wfAq3KajtuJO2/yraiADg5jwOoJvwVS9iztHSG4Xn/YakTBXUJEkxjNVM089QXf+U8
         QnK7ELLMfGn9lRH17qic4G1cAoS+0/vttoDG9Z9zrLApKt4XiX4bBqEGuujKEh7zTP
         HlQ1K9r/I5oq5QTeIJ5vHi7JQTatYWBUq+/Kjg+OlfK2Xomajg5QB6cA7fFzMAYAff
         54JckfnnYw2kQ31hCB2SqjkoP8mH53fkZ449IxEv4cOi4rhGq3gdO+F4bhQPrRXQcK
         ktA+mddF8Sy1Q==
Received: by mail-ot1-f52.google.com with SMTP id g6so3746081otk.11;
        Sat, 20 Feb 2021 06:50:20 -0800 (PST)
X-Gm-Message-State: AOAM532nj2JcWVPqltaAM57xWzRJFhw9QJ7bwSXvVYHk7jIU4VFckPxr
        ioka+46FQa0Sj6nMqScXcs53ygfn3amIjhU91/Q=
X-Google-Smtp-Source: ABdhPJykDLP2b0F0XbtrV+D+jbkui7LQuGNc9eItQ90SqbZrnyfZxfJsU2R7aCiPco1EGnFIZrLf6iCSOOt29ymcOPg=
X-Received: by 2002:a05:6830:11:: with SMTP id c17mr10535926otp.77.1613832619962;
 Sat, 20 Feb 2021 06:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20210218201849.2805-1-xypron.glpk@gmx.de>
In-Reply-To: <20210218201849.2805-1-xypron.glpk@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 20 Feb 2021 15:50:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEaqUdKeWSgAeJsnk7HNt2478PzhjC6+Ehv2qg8uVpzSg@mail.gmail.com>
Message-ID: <CAMj1kXEaqUdKeWSgAeJsnk7HNt2478PzhjC6+Ehv2qg8uVpzSg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/efivars: ConInDev, ConOutDev, ConErrDev are volatile
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Peter Jones <pjones@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(cc Peter)

On Thu, 18 Feb 2021 at 21:18, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> UEFI variables ConInDev, ConOutDev, ConErrDev are volatile variables that
> are set by the firmware on every reset. It does not make sense to set these
> variables via the efivarfs filesystem.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/firmware/efi/vars.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index 41c1d00bf933..561e0a01093b 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -180,11 +180,8 @@ static const struct variable_validate variable_validate[] = {
>         { EFI_GLOBAL_VARIABLE_GUID, "DriverOrder", validate_boot_order },
>         { EFI_GLOBAL_VARIABLE_GUID, "Driver*", validate_load_option },
>         { EFI_GLOBAL_VARIABLE_GUID, "ConIn", validate_device_path },
> -       { EFI_GLOBAL_VARIABLE_GUID, "ConInDev", validate_device_path },
>         { EFI_GLOBAL_VARIABLE_GUID, "ConOut", validate_device_path },
> -       { EFI_GLOBAL_VARIABLE_GUID, "ConOutDev", validate_device_path },
>         { EFI_GLOBAL_VARIABLE_GUID, "ErrOut", validate_device_path },
> -       { EFI_GLOBAL_VARIABLE_GUID, "ErrOutDev", validate_device_path },
>         { EFI_GLOBAL_VARIABLE_GUID, "Lang", validate_ascii_string },
>         { EFI_GLOBAL_VARIABLE_GUID, "OsIndications", NULL },
>         { EFI_GLOBAL_VARIABLE_GUID, "PlatformLang", validate_ascii_string },
> --
> 2.30.0
>
