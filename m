Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A00E11E050
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 10:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfLMJKR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Dec 2019 04:10:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40117 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfLMJKR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Dec 2019 04:10:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so5713947wmi.5
        for <linux-efi@vger.kernel.org>; Fri, 13 Dec 2019 01:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLXDj2tCALFNbZtKdVocDQPJ7xc4HP2wet22NTHx+Ww=;
        b=qNDTfWna4aa7E+3NoI36Qj5lmh3cY5n6y6XU6YD4I+jJqqbYEs2UkPW2OLI3WymCaw
         b3JDttDHmrkWaITnq8po+rwsCUs9ZhuPjWF3ZVTQE3qI++VFJW46sR0BYLM3jNy8/+ZJ
         zWuD9MyfiRwXvoRUHpwr2oQZufVxqp+AzGiNAxvav8NA0/BDDU2zI9pGi0OWh5+D4QR7
         HOSZJ/Aiuq6U1lR5jltUWBSOaN1ay8aYzUaBmR/V3ecK7ydZ46R4p45MikenQnlUduWZ
         oDmnwR+Ij+fOLCZZhlOG/cFpgps0fWhHuIpRDosnJQorFW22tU9C/3hGKeFUZoCrlEGP
         aNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLXDj2tCALFNbZtKdVocDQPJ7xc4HP2wet22NTHx+Ww=;
        b=E6G5iCA7atdu9xFBsXwsYNzRjeJJIcvt3BAHD/CGDaZCt4+paNiY8oqgEMz3hEYR18
         uxPc9AqR+VjDieYQoRO4Q5H2Arb2hJxzFxL7WF+sGxnMTp0NDNrtTlKshbnyw3F1Ld81
         i8k2Ritcyn6+DxQkZOaIqRstB/+moJBOXqQp8z81jNqp09CMJt5pqjkczUk+LqsS8ZZp
         wQdpG/V2PHOhNsL+X+5hY68DnmNW4uVmenUtmwKcxRtaDoYGbFo4iW7ICjMDpp0csJMJ
         9Dg9oe04am08r7lK+nm5fuy3HdN4ZmY3XNwYt6504U0XwE/Nk9uRviGckCEZMto7kx8k
         FkXA==
X-Gm-Message-State: APjAAAX+pcgTz8SB/+KT02OqhbjHolgPHhHVRlLttHJOJh15hYIKmjXx
        VxRL4NrUd2Tb4yXO0IhlZh8Xt72uYx+5uD154utqJg==
X-Google-Smtp-Source: APXvYqxAtkBgMW9OplkwflBepglPjlMIZpEb15nYHCVUw7oWUhcnpHliOfTGGwLYu0CpPC5Rx3J56oc1h57lUcSIidI=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr12443468wmc.9.1576228214657;
 Fri, 13 Dec 2019 01:10:14 -0800 (PST)
MIME-Version: 1.0
References: <20191213090646.12329-1-jlee@suse.com> <20191213090646.12329-3-jlee@suse.com>
In-Reply-To: <20191213090646.12329-3-jlee@suse.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 13 Dec 2019 09:10:12 +0000
Message-ID: <CAKv+Gu_2GTqKJNVpMEg4ic_3ACb5GJKAkgfFWoEdWqMN7pmwiA@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi: show error messages only when loading
 certificates is failed
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
> When loading certificates list from EFI variables, the error
> message and efi status code always be emitted to dmesg. It looks
> ugly:
>
> [    2.335031] Couldn't get size: 0x800000000000000e
> [    2.335032] Couldn't get UEFI MokListRT
> [    2.339985] Couldn't get size: 0x800000000000000e
> [    2.339987] Couldn't get UEFI dbx list
>
> This cosmetic patch moved the messages to the error handling code
> path. And, it also shows the corresponding status string of status
> code.
>

So what output do we get after applying this patch when those
variables don't exist?

> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---
>  security/integrity/platform_certs/load_uefi.c | 40 ++++++++++++++-------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
>
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index 81b19c52832b..b6c60fb3fb6c 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
> @@ -39,7 +40,7 @@ static __init bool uefi_check_ignore_db(void)
>   * Get a certificate list blob from the named EFI variable.
>   */
>  static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
> -                                 unsigned long *size)
> +                                 unsigned long *size, const char *source)
>  {
>         efi_status_t status;
>         unsigned long lsize = 4;
> @@ -48,23 +49,30 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
>
>         status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
>         if (status != EFI_BUFFER_TOO_SMALL) {
> -               pr_err("Couldn't get size: 0x%lx\n", status);
> -               return NULL;
> +               if (status == EFI_NOT_FOUND) {
> +                       pr_debug("%s list was not found\n", source);
> +                       return NULL;
> +               }
> +               goto err;
>         }
>
>         db = kmalloc(lsize, GFP_KERNEL);
> -       if (!db)
> -               return NULL;
> +       if (!db) {
> +               status = EFI_OUT_OF_RESOURCES;
> +               goto err;
> +       }
>
>         status = efi.get_variable(name, guid, NULL, &lsize, db);
>         if (status != EFI_SUCCESS) {
>                 kfree(db);
> -               pr_err("Error reading db var: 0x%lx\n", status);
> -               return NULL;
> +               goto err;
>         }
>
>         *size = lsize;
>         return db;
> +err:
> +       pr_err("Couldn't get %s list: %s\n", source, efi_status_to_str(status));
> +       return NULL;
>  }
>
>  /*
> @@ -153,10 +161,8 @@ static int __init load_uefi_certs(void)
>          * an error if we can't get them.
>          */
>         if (!uefi_check_ignore_db()) {
> -               db = get_cert_list(L"db", &secure_var, &dbsize);
> -               if (!db) {
> -                       pr_err("MODSIGN: Couldn't get UEFI db list\n");
> -               } else {
> +               db = get_cert_list(L"db", &secure_var, &dbsize, "UEFI:db");
> +               if (db) {
>                         rc = parse_efi_signature_list("UEFI:db",
>                                         db, dbsize, get_handler_for_db);
>                         if (rc)
> @@ -166,10 +172,8 @@ static int __init load_uefi_certs(void)
>                 }
>         }
>
> -       mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
> -       if (!mok) {
> -               pr_info("Couldn't get UEFI MokListRT\n");
> -       } else {
> +       mok = get_cert_list(L"MokListRT", &mok_var, &moksize, "UEFI:MokListRT");
> +       if (mok) {
>                 rc = parse_efi_signature_list("UEFI:MokListRT",
>                                               mok, moksize, get_handler_for_db);
>                 if (rc)
> @@ -177,10 +181,8 @@ static int __init load_uefi_certs(void)
>                 kfree(mok);
>         }
>
> -       dbx = get_cert_list(L"dbx", &secure_var, &dbxsize);
> -       if (!dbx) {
> -               pr_info("Couldn't get UEFI dbx list\n");
> -       } else {
> +       dbx = get_cert_list(L"dbx", &secure_var, &dbxsize, "UEFI:dbx");
> +       if (dbx) {
>                 rc = parse_efi_signature_list("UEFI:dbx",
>                                               dbx, dbxsize,
>                                               get_handler_for_dbx);
> --
> 2.16.4
>
