Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6CC111E16C
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 11:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfLMKDc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Dec 2019 05:03:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44225 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLMKDc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Dec 2019 05:03:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so5938836wrm.11
        for <linux-efi@vger.kernel.org>; Fri, 13 Dec 2019 02:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBwjg8KYKl96mggL33baldfDiIMn3TQvg81waFm29R8=;
        b=JykxmuTSac6P2wO4GXkGPNQbDUE55BBEP7c50jnvheyrIuu3lWGD6GCp44IcvxKn8B
         S/CVdePKbtsCHh4N6FFLXn1yUPBp23AEpQNyM1sPTX3EkgSXCl4Sokt82rCrbDJVHXaD
         NkgCv6OQPk80QtppE8DNTdx7lBldxB/mLorjsto7Ud3yCbCs7S2tf4d2gb4BfG47sHBU
         UroOxPh2v8SS1Eoh+rF8O0lcSRntWkqf9KRaKOj61rBslxKk5esR2TPQwt3iKuHua/WY
         EOpU+YQ3T/a9uk20vmcFOlxxTSyTGZyggmBruWsKjrNtLlYrcZAQ95tS81RE4KGQD3gB
         ulTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBwjg8KYKl96mggL33baldfDiIMn3TQvg81waFm29R8=;
        b=hog7yzEJIseauGCkcJDntFhXch2rFLA+AmyZ5kp7TLMdocKoEMXU9Kw+2LvoxHbQqr
         QwIdxPI26dCK4gCVe52ktnEznDjuompsb1Yn7gNXlVPs0bnVjzy7Bj4UVyBVuNJxaH0a
         jR68KB5H6AWuVBk6t/ahKRjLXnziAA6OSSssCejNS29o5+/5hWclmI0UW2mcYC3ySZBq
         PgQeJshtYjM8a25OdBW9UerZvSxxcwHBcJz5fwfwoUO8lKNbkgLAlIKpRotcgKGYZkOs
         zD/5OfNeFiA9m/uRfjCz/pyGxRoDxnR3IzYvz7tMsrWvW2prciNWw6KMErCLSD8ae8WQ
         xzog==
X-Gm-Message-State: APjAAAWbHuomH0hRkp4WGtfCGwpKAzKki2BGuvvCslvIxD7fVDxjuc9+
        n9J4wpImXmoX+Fg1xg+BABJnAqgfQBL4sUFN37ABoQ==
X-Google-Smtp-Source: APXvYqw+nd3Vhgsl1yc4y1cF3SkuvyXwLF9EsVoYDFKi4jhRyQjzp899ocHgHzIk5ZAgkqFb6bhFwbkq0tIaVnWig2w=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr11220760wrj.325.1576231409604;
 Fri, 13 Dec 2019 02:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20191213090646.12329-1-jlee@suse.com> <20191213090646.12329-2-jlee@suse.com>
In-Reply-To: <20191213090646.12329-2-jlee@suse.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 13 Dec 2019 10:03:27 +0000
Message-ID: <CAKv+Gu8sGku8e1q9ku_wXfcXTGQ5W8Lt_q5KEK9WycgHw15TgA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] efi: add a function to convert the status code to
 a string
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 13 Dec 2019 at 10:07, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
>
> This function can be used to convert EFI status code to a string
> to improve the readability of log.
>
> v2:
> Moved the convert function to efi.c
>

Please put the patch series revision log below the ---

> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/firmware/efi/efi.c | 32 ++++++++++++++++++++++++++++++++
>  include/linux/efi.h        |  1 +
>  2 files changed, 33 insertions(+)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index e98bbf8e56d9..8bdc1c17eb5d 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -954,6 +954,38 @@ int efi_status_to_err(efi_status_t status)
>         return err;
>  }
>
> +#define EFI_STATUS_STR(_status) \
> +       EFI_##_status : return "EFI_" __stringify(_status)
> +
> +const char *efi_status_to_str(efi_status_t status)
> +{
> +       switch (status) {
> +       case EFI_STATUS_STR(SUCCESS);
> +       case EFI_STATUS_STR(LOAD_ERROR);
> +       case EFI_STATUS_STR(INVALID_PARAMETER);
> +       case EFI_STATUS_STR(UNSUPPORTED);
> +       case EFI_STATUS_STR(BAD_BUFFER_SIZE);
> +       case EFI_STATUS_STR(BUFFER_TOO_SMALL);
> +       case EFI_STATUS_STR(NOT_READY);
> +       case EFI_STATUS_STR(DEVICE_ERROR);
> +       case EFI_STATUS_STR(WRITE_PROTECTED);
> +       case EFI_STATUS_STR(OUT_OF_RESOURCES);
> +       case EFI_STATUS_STR(NOT_FOUND);
> +       case EFI_STATUS_STR(ABORTED);
> +       case EFI_STATUS_STR(SECURITY_VIOLATION);
> +       }
> +       /*
> +        * There are two possibilities for this message to be exposed:
> +        * - Caller feeds a unknown status code from firmware.
> +        * - A new status code be defined in efi.h but we forgot to update
> +        *   this function.
> +        */
> +       pr_warn("Unknown efi status: 0x%lx\n", status);
> +
> +       return "Unknown efi status";
> +}
> +EXPORT_SYMBOL(efi_status_to_str);
> +
>  static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
>  static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index d87acf62958e..2c6848d2b112 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1228,6 +1228,7 @@ efi_capsule_pending(int *reset_type)
>  #endif
>
>  extern int efi_status_to_err(efi_status_t status);
> +extern const char *efi_status_to_str(efi_status_t status);
>
>  /*
>   * Variable Attributes
> --
> 2.16.4
>
