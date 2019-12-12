Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB96A11CB11
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 11:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfLLKiB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 05:38:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36584 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfLLKiB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 05:38:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so1922437wma.1
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 02:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LEkUr58WGziT8fxYk1Ew3kC9fjqbADWx2DYTMjRwGQ=;
        b=W0uTSigXUFE2xdm3NywrWLAehtiY1nqq3KXNKgVWsPsHs4FYM7q82PekauW43zhU+y
         NbZNb/8+kXW7sH0tuPsGgM7Z/mdI1Txr44glAgZlrLb9ELa+Zqyujf83VLh9NAdvk5B4
         tf1F7jjHyPYEZMeCJyGT7iiHVvZtajUKDYKWtpbJrvwcrJMDgbrXgG3WPSdQdQlOR/mg
         eeeQequvLO1FvKN3dDyiWpbOsCqi2VlEt0ZkYZxAJ2q2xOj0TnU8WGJwwL8aQ6xZGhQ8
         SUTF4f8yUUwsE5FeB1fXYHmU/DtsjoLrhV7OB90gbZKWyvbt2Uqa/W2v0Els2KLIdHXV
         sP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LEkUr58WGziT8fxYk1Ew3kC9fjqbADWx2DYTMjRwGQ=;
        b=KgnrKyYdJ25lGhKfjSw12IxoLgrC3pctadE3B/5qjdYmORO0GO1kYl2GkHAeK8S2Rk
         g98u4NngMtKIpFkp4GRTnH/qedPtxnHJbMZ/N4xN1gozTUS/3xPF1YS6paOo08F89c3N
         OYwaeYqyRCqpMXd9LZ1TZTwb3j7emiH0152qkqq+OhOY4DryyDvcPoAoygfRIq+MXtO8
         xx7DYTA1f/U1E5bmY+7VNJHsph+8Wy+jO2WPKUHWcnZ2I1OoYjydNDzjeDvXacZBMdzd
         GgnWDSgC7Dkctqs4bN5Nbbvf4VGqkklTXtikm9tCN3XzEAzkDsbZ8wx7u45/zdmi5t7p
         Lkbw==
X-Gm-Message-State: APjAAAULui6rwYdHbZmx4NzGARtFGJmTUe5sBUO+ayb0Du7SUQ03JoGQ
        kPPA3VsnKr7vW0eYM+RlST+mOkeRgza9h0rbp6zHsA==
X-Google-Smtp-Source: APXvYqxr3fWC//jtQ4389G0t+wE4iStFTkxw+AcnJfeuE7/RxMxYE2FNqp3gvUBnlv+YKbpTnsdFT2YVgd4NFGhuVAs=
X-Received: by 2002:a1c:a795:: with SMTP id q143mr5503441wme.52.1576147080146;
 Thu, 12 Dec 2019 02:38:00 -0800 (PST)
MIME-Version: 1.0
References: <20191212103158.4958-1-hdegoede@redhat.com> <20191212103158.4958-2-hdegoede@redhat.com>
In-Reply-To: <20191212103158.4958-2-hdegoede@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 12 Dec 2019 10:37:58 +0000
Message-ID: <CAKv+Gu9Fa=ccEyGW=hyZya0y-ujL27twKVX5JwcqWRMQ=yfQzg@mail.gmail.com>
Subject: Re: [PATCH 5.5 regression fix 1/2] efi/libstub/random: Initialize
 pointer variables to zero for mixed mode
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 12 Dec 2019 at 11:32, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Commit 0d95981438c3 ("x86: efi/random: Invoke EFI_RNG_PROTOCOL to seed the
> UEFI RNG table"), causes the drivers/efi/libstub/random.c code to get used
> on x86 for the first time.
>
> But this code was not written with EFI mixed mode in mind (running a 64
> bit kernel on 32 bit EFI firmware), this causes the kernel to crash during
> early boot when running in mixed mode.
>
> The problem is that in mixed mode pointers are 64 bit, but when running on
> a 32 bit firmware, EFI calls which return a pointer value by reference only
> fill the lower 32 bits of the passed pointer, leaving the upper 32 bits
> uninitialized which leads to crashes.
>
> This commit fixes this by initializing pointers which are passed by
> reference to EFI calls to NULL before passing them, so that the upper 32
> bits are initialized to 0.
>
> Fixes: 0d95981438c3 ("x86: efi/random: Invoke EFI_RNG_PROTOCOL to seed the UEFI RNG table")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks Hans.

I'm a bit annoyed with myself since I should have been able to catch
this in my QEMU tests and I didn't

I'll queue this (and the next patch) as a fix



> ---
>  drivers/firmware/efi/libstub/random.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
> index 35edd7cfb6a1..97378cf96a2e 100644
> --- a/drivers/firmware/efi/libstub/random.c
> +++ b/drivers/firmware/efi/libstub/random.c
> @@ -33,7 +33,7 @@ efi_status_t efi_get_random_bytes(efi_system_table_t *sys_table_arg,
>  {
>         efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
>         efi_status_t status;
> -       struct efi_rng_protocol *rng;
> +       struct efi_rng_protocol *rng = NULL;
>
>         status = efi_call_early(locate_protocol, &rng_proto, NULL,
>                                 (void **)&rng);
> @@ -162,8 +162,8 @@ efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg)
>         efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
>         efi_guid_t rng_algo_raw = EFI_RNG_ALGORITHM_RAW;
>         efi_guid_t rng_table_guid = LINUX_EFI_RANDOM_SEED_TABLE_GUID;
> -       struct efi_rng_protocol *rng;
> -       struct linux_efi_random_seed *seed;
> +       struct efi_rng_protocol *rng = NULL;
> +       struct linux_efi_random_seed *seed = NULL;
>         efi_status_t status;
>
>         status = efi_call_early(locate_protocol, &rng_proto, NULL,
> --
> 2.23.0
>
