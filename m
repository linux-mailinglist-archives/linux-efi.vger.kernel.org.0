Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4664E2661F7
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 17:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgIKPTE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 11:19:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgIKPRj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 11 Sep 2020 11:17:39 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CFB7223BD;
        Fri, 11 Sep 2020 15:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599836562;
        bh=6nL6VORoOL0XE1BB6SwMAH9ldlMzieej9aulUv5ApCU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VxvX7lXdShMpWUUnXfTtcj9IvJa72g4/FGW8OseJYt0DbFmq4GGZDgTBQJkfrmLPz
         GGAV0wbezdq+tR210aKWkXdicHLdFVA9brSAM/CbsGHjjCLuY2UI/VMiGkt98AiLPd
         OftjZDFmAWc1SWtzHwa6NUWqubaF54my5DB2yVBU=
Received: by mail-ot1-f41.google.com with SMTP id o8so892311otl.4;
        Fri, 11 Sep 2020 08:02:42 -0700 (PDT)
X-Gm-Message-State: AOAM531a0dHCcTj/pIDE6fBFPaXvv36nL+7qNSEqp+JUKNLORspKaI8s
        0peRTFsYMa4nAaDXHDQmU+djZtMlxTYPCtwKGcs=
X-Google-Smtp-Source: ABdhPJw07czxiY1a68IYlOpS8V9p84gFMT12gE8YbqAz3XuZxMaBeP7+1oa02tUZjq4T/SCm2P4T+6GhCfFPI6RBSNU=
X-Received: by 2002:a9d:6193:: with SMTP id g19mr1430262otk.108.1599836561839;
 Fri, 11 Sep 2020 08:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200905013107.10457-1-lszubowi@redhat.com> <20200905013107.10457-3-lszubowi@redhat.com>
In-Reply-To: <20200905013107.10457-3-lszubowi@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 11 Sep 2020 18:02:27 +0300
X-Gmail-Original-Message-ID: <CAMj1kXEdkdeE8VSZqEzhd__Kb7_ZmG2af6iBpbY3=nsj1-phYw@mail.gmail.com>
Message-ID: <CAMj1kXEdkdeE8VSZqEzhd__Kb7_ZmG2af6iBpbY3=nsj1-phYw@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] integrity: Move import of MokListRT certs to a
 separate routine
To:     Lenny Szubowicz <lszubowi@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, andy.shevchenko@gmail.com,
        James Morris <jmorris@namei.org>, serge@hallyn.com,
        Kees Cook <keescook@chromium.org>, zohar@linux.ibm.com,
        Borislav Petkov <bp@alien8.de>,
        Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>, prarit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 5 Sep 2020 at 04:31, Lenny Szubowicz <lszubowi@redhat.com> wrote:
>
> Move the loading of certs from the UEFI MokListRT into a separate
> routine to facilitate additional MokList functionality.
>
> There is no visible functional change as a result of this patch.
> Although the UEFI dbx certs are now loaded before the MokList certs,
> they are loaded onto different key rings. So the order of the keys
> on their respective key rings is the same.
>
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>

Why did you drop Mimi's reviewed-by from this patch?

> ---
>  security/integrity/platform_certs/load_uefi.c | 63 +++++++++++++------
>  1 file changed, 44 insertions(+), 19 deletions(-)
>
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index 253fb9a7fc98..c1c622b4dc78 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -66,6 +66,43 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
>  }
>
>  /*
> + * load_moklist_certs() - Load MokList certs
> + *
> + * Load the certs contained in the UEFI MokListRT database into the
> + * platform trusted keyring.
> + *
> + * Return:     Status
> + */
> +static int __init load_moklist_certs(void)
> +{
> +       efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
> +       void *mok;
> +       unsigned long moksize;
> +       efi_status_t status;
> +       int rc;
> +
> +       /* Get MokListRT. It might not exist, so it isn't an error
> +        * if we can't get it.
> +        */
> +       mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
> +       if (mok) {
> +               rc = parse_efi_signature_list("UEFI:MokListRT",
> +                                             mok, moksize, get_handler_for_db);
> +               kfree(mok);
> +               if (rc)
> +                       pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
> +               return rc;
> +       }
> +       if (status == EFI_NOT_FOUND)
> +               pr_debug("MokListRT variable wasn't found\n");
> +       else
> +               pr_info("Couldn't get UEFI MokListRT\n");
> +       return 0;
> +}
> +
> +/*
> + * load_uefi_certs() - Load certs from UEFI sources
> + *
>   * Load the certs contained in the UEFI databases into the platform trusted
>   * keyring and the UEFI blacklisted X.509 cert SHA256 hashes into the blacklist
>   * keyring.
> @@ -73,17 +110,16 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
>  static int __init load_uefi_certs(void)
>  {
>         efi_guid_t secure_var = EFI_IMAGE_SECURITY_DATABASE_GUID;
> -       efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
> -       void *db = NULL, *dbx = NULL, *mok = NULL;
> -       unsigned long dbsize = 0, dbxsize = 0, moksize = 0;
> +       void *db = NULL, *dbx = NULL;
> +       unsigned long dbsize = 0, dbxsize = 0;
>         efi_status_t status;
>         int rc = 0;
>
>         if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
>                 return false;
>
> -       /* Get db, MokListRT, and dbx.  They might not exist, so it isn't
> -        * an error if we can't get them.
> +       /* Get db and dbx.  They might not exist, so it isn't an error
> +        * if we can't get them.
>          */
>         if (!uefi_check_ignore_db()) {
>                 db = get_cert_list(L"db", &secure_var, &dbsize, &status);
> @@ -102,20 +138,6 @@ static int __init load_uefi_certs(void)
>                 }
>         }
>
> -       mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
> -       if (!mok) {
> -               if (status == EFI_NOT_FOUND)
> -                       pr_debug("MokListRT variable wasn't found\n");
> -               else
> -                       pr_info("Couldn't get UEFI MokListRT\n");
> -       } else {
> -               rc = parse_efi_signature_list("UEFI:MokListRT",
> -                                             mok, moksize, get_handler_for_db);
> -               if (rc)
> -                       pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
> -               kfree(mok);
> -       }
> -
>         dbx = get_cert_list(L"dbx", &secure_var, &dbxsize, &status);
>         if (!dbx) {
>                 if (status == EFI_NOT_FOUND)
> @@ -131,6 +153,9 @@ static int __init load_uefi_certs(void)
>                 kfree(dbx);
>         }
>
> +       /* Load the MokListRT certs */
> +       rc = load_moklist_certs();
> +
>         return rc;
>  }
>  late_initcall(load_uefi_certs);
> --
> 2.27.0
>
