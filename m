Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 869721613A9
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 14:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgBQNiI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 08:38:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41381 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQNiI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Feb 2020 08:38:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so19796122wrw.8
        for <linux-efi@vger.kernel.org>; Mon, 17 Feb 2020 05:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDiRsEAIhvUGr0lYuEJebsL5PJq7c20YrBjsG0G5asE=;
        b=m9Ib4xAIBqaXvlSAko9uT/dWqaqwCVRkGpAodBbksRx3pH28oU8qRSFzow5t4iDqZq
         9V9bL9GnITj1pRVR8K3xRsdlCcCvPq80SAnT8nt6B9If3bxb6W4H/xKmfy5Tvrerc1In
         YTRPyZI/KB1ZLd3VJvDaQxqLZzZhrTf1le7HuQCP19qI0myl2EJzGGF5mPI+hjB8GD/+
         6nG4OtQ4vdUG/Fe0lRcKlSBGRZEdyqQJArih/bfqU91tPSxgywfrYCLKR8jggkmlIx3j
         xuYmlr3zYjlbPK8p0+EKn/zTRj9yckxcIX5Mmr0VY+8moVN/EL3z7w+It7Ra3dvD1z56
         pCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDiRsEAIhvUGr0lYuEJebsL5PJq7c20YrBjsG0G5asE=;
        b=lbixUR35w78FY3++9e3yfgEAoEHkEsvfZ4IU4gb4+TQyVmZ1o2HvRGzTniKJUea9q6
         aLcMAdfXdFxCRaItcHuD20bAmsXb2zgw7ZHSWXXyqURvbgldQUEhcFsixVdkO8t/WU2F
         MkM9kJTKvDuxyG3p6xVanGMc7BQRRx8DOcKG5+v8etdDbgc3+cFrZD67xG7viMuJdtXx
         M1Em2V5UuUThWUZJ9eqU4K1ERPojvKD9dNwy6EuVwthe7MJh3nssNp8OwmlWcdF8v+s2
         ikXnAR3HGrmIjdmvFy96yofrwwOP1n7l0Ixjum1EfvvZxZEVeKXgo+S+YBegiW+W6Enq
         KY0g==
X-Gm-Message-State: APjAAAWgN8tcTs4oKMlAXWEPy47++byHkwBASF0ToBhcccQ1DxIcRRs9
        jYvT4/D1E6bqUpRXBJatPlLWz7k1CLEN1xB+q7R2Rg==
X-Google-Smtp-Source: APXvYqwOUBucYswqUNyMIHc1aiTamfVBZWGT+dn/rwRaci4zG+s/D1nwmO/6x5V/pkNlnsTqLUeNB8BucEtyklRsh1I=
X-Received: by 2002:adf:8564:: with SMTP id 91mr22934838wrh.252.1581946685893;
 Mon, 17 Feb 2020 05:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20200217113947.2070436-1-javierm@redhat.com>
In-Reply-To: <20200217113947.2070436-1-javierm@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 17 Feb 2020 14:37:54 +0100
Message-ID: <CAKv+Gu-a5Bo9i=K55pa3jEXRq-u5JYVGp1jFEE=UY5B=6eUkRQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] efi: Only print errors about failing to get
 certs if EFI vars are found
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Eric Richter <erichte@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 17 Feb 2020 at 12:40, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> If CONFIG_LOAD_UEFI_KEYS is enabled, the kernel attempts to load the certs
> from the db, dbx and MokListRT EFI variables into the appropriate keyrings.
>
> But it just assumes that the variables will be present and prints an error
> if the certs can't be loaded, even when is possible that the variables may
> not exist. For example the MokListRT variable will only be present if shim
> is used.
>
> So only print an error message about failing to get the certs list from an
> EFI variable if this is found. Otherwise these printed errors just pollute
> the kernel log ring buffer with confusing messages like the following:
>
> [    5.427251] Couldn't get size: 0x800000000000000e
> [    5.427261] MODSIGN: Couldn't get UEFI db list
> [    5.428012] Couldn't get size: 0x800000000000000e
> [    5.428023] Couldn't get UEFI MokListRT
>
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

>
> ---
>
> Changes in v2:
> - Fix flaws in the logic, that caused the signature list was parsed if
>   the return code was EFI_NOT_FOUND that pointed out Hans de Goede.
> - Print debug messages if the variables are not found.
>
>  security/integrity/platform_certs/load_uefi.c | 40 ++++++++++++-------
>  1 file changed, 26 insertions(+), 14 deletions(-)
>
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index 111898aad56..f0c90824196 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -35,16 +35,18 @@ static __init bool uefi_check_ignore_db(void)
>   * Get a certificate list blob from the named EFI variable.
>   */
>  static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
> -                                 unsigned long *size)
> +                                 unsigned long *size, efi_status_t *status)
>  {
> -       efi_status_t status;
>         unsigned long lsize = 4;
>         unsigned long tmpdb[4];
>         void *db;
>
> -       status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
> -       if (status != EFI_BUFFER_TOO_SMALL) {
> -               pr_err("Couldn't get size: 0x%lx\n", status);
> +       *status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
> +       if (*status == EFI_NOT_FOUND)
> +               return NULL;
> +
> +       if (*status != EFI_BUFFER_TOO_SMALL) {
> +               pr_err("Couldn't get size: 0x%lx\n", *status);
>                 return NULL;
>         }
>
> @@ -52,10 +54,10 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
>         if (!db)
>                 return NULL;
>
> -       status = efi.get_variable(name, guid, NULL, &lsize, db);
> -       if (status != EFI_SUCCESS) {
> +       *status = efi.get_variable(name, guid, NULL, &lsize, db);
> +       if (*status != EFI_SUCCESS) {
>                 kfree(db);
> -               pr_err("Error reading db var: 0x%lx\n", status);
> +               pr_err("Error reading db var: 0x%lx\n", *status);
>                 return NULL;
>         }
>
> @@ -74,6 +76,7 @@ static int __init load_uefi_certs(void)
>         efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
>         void *db = NULL, *dbx = NULL, *mok = NULL;
>         unsigned long dbsize = 0, dbxsize = 0, moksize = 0;
> +       efi_status_t status;
>         int rc = 0;
>
>         if (!efi.get_variable)
> @@ -83,9 +86,12 @@ static int __init load_uefi_certs(void)
>          * an error if we can't get them.
>          */
>         if (!uefi_check_ignore_db()) {
> -               db = get_cert_list(L"db", &secure_var, &dbsize);
> +               db = get_cert_list(L"db", &secure_var, &dbsize, &status);
>                 if (!db) {
> -                       pr_err("MODSIGN: Couldn't get UEFI db list\n");
> +                       if (status == EFI_NOT_FOUND)
> +                               pr_debug("MODSIGN: db variable wasn't found\n");
> +                       else
> +                               pr_err("MODSIGN: Couldn't get UEFI db list\n");
>                 } else {
>                         rc = parse_efi_signature_list("UEFI:db",
>                                         db, dbsize, get_handler_for_db);
> @@ -96,9 +102,12 @@ static int __init load_uefi_certs(void)
>                 }
>         }
>
> -       mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
> +       mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
>         if (!mok) {
> -               pr_info("Couldn't get UEFI MokListRT\n");
> +               if (status == EFI_NOT_FOUND)
> +                       pr_debug("MokListRT variable wasn't found\n");
> +               else
> +                       pr_info("Couldn't get UEFI MokListRT\n");
>         } else {
>                 rc = parse_efi_signature_list("UEFI:MokListRT",
>                                               mok, moksize, get_handler_for_db);
> @@ -107,9 +116,12 @@ static int __init load_uefi_certs(void)
>                 kfree(mok);
>         }
>
> -       dbx = get_cert_list(L"dbx", &secure_var, &dbxsize);
> +       dbx = get_cert_list(L"dbx", &secure_var, &dbxsize, &status);
>         if (!dbx) {
> -               pr_info("Couldn't get UEFI dbx list\n");
> +               if (status == EFI_NOT_FOUND)
> +                       pr_debug("dbx variable wasn't found\n");
> +               else
> +                       pr_info("Couldn't get UEFI dbx list\n");
>         } else {
>                 rc = parse_efi_signature_list("UEFI:dbx",
>                                               dbx, dbxsize,
> --
> 2.24.1
>
