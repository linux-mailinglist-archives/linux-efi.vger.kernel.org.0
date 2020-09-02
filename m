Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5C225A717
	for <lists+linux-efi@lfdr.de>; Wed,  2 Sep 2020 09:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgIBHzn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Sep 2020 03:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgIBHzi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Sep 2020 03:55:38 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802EAC061244;
        Wed,  2 Sep 2020 00:55:38 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q3so1906061pls.11;
        Wed, 02 Sep 2020 00:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vv9wafYlcRndezilwjOVw+Uvg14avW3QcJVd3Hrp9X0=;
        b=dUhRbwVRhGDqCmPDJulA9D1NH7C7y9XHVxD2cCdGOWci+8hb5IympO9z/mRng67H8/
         EdOTtIbOUtlS0mzLi//6vD4CigO1owTjoWyCjHgRxEoqhFi1zxwgFApN05D3L06ODh+s
         AVvnjlPrW+HYJTAL/8YojwCSWZA0hmWlOyI4Z0ujWxLb7QaZJHPkmOvkknBkjULMUk8O
         vZCA+YksoU5lSSMLMuTxe0RWE+SopR/Bz0y9IzEH472wSI8+jrXlqe5BwxCUUpZ/v2qU
         95IpUaWjKi1whSEN6uAGZZ96PnIq+fl78D9OB6zeF8Yss0rzX0NdmyXMSAg8XGrUO6+9
         /VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vv9wafYlcRndezilwjOVw+Uvg14avW3QcJVd3Hrp9X0=;
        b=IRLT6+5EpSjhCNN2Y+fuqxvT2I7RU50cwxBbtEOS8deSGrJwEGlRdPApKzPES+ZLyO
         SFnp5iWtdGg8iIFlyjQXPH++EoPKxfbxZv5RGcYNc0oEYbru4GZwC/1QqaogidogrYgh
         gABgTyJvETFXBA65OhtSvaPW08EmiHELT5adZqNP267l2b6+KAkFfUNQ7bj3YP0JJoVN
         pXQh0FaX2pI/zblAIl+lz24ALGt6c38x1X9kL7nNmYpanp8pZDEM2bG9dEvD8i0VQtZ6
         CpZBvw1AObVOEwFuoUxmH7dGSMQo51ZXaFY2WMeSept7X+IBO3t+sg1IftDnDOoziV0T
         O/ZQ==
X-Gm-Message-State: AOAM532Gw5cmG/vr2kwCptWuwxHS4t3hqvTTpVUb3dnMSu6fyjGqjIxc
        RAVGU/Z2oW5Fzh/AIiF60mnxwt+NnnH5bZuPAWkmNH2bPx8=
X-Google-Smtp-Source: ABdhPJxNZ9O3Sj7OvHiGloTdmPJ7LxTz4zR2Er8HbAv/pmqjuckAEtpUdzJasMFcDiKbP+NTn6IiUaUkABxel3cBWdE=
X-Received: by 2002:a17:902:b715:: with SMTP id d21mr1104159pls.92.1599033338028;
 Wed, 02 Sep 2020 00:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200826034455.28707-1-lszubowi@redhat.com> <20200826034455.28707-3-lszubowi@redhat.com>
In-Reply-To: <20200826034455.28707-3-lszubowi@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Sep 2020 10:55:21 +0300
Message-ID: <CAHp75Vec0a3LC7dGY6wacQu0brc+Zjfowt6kGdcZ9sfMzoDR9g@mail.gmail.com>
Subject: Re: [PATCH 2/3] integrity: Move import of MokListRT certs to a
 separate routine
To:     Lenny Szubowicz <lszubowi@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 26, 2020 at 6:45 AM Lenny Szubowicz <lszubowi@redhat.com> wrote:
>
> Move the loading of certs from the UEFI MokListRT into a separate
> routine to facilitate additional MokList functionality.
>
> There is no visible functional change as a result of this patch.
> Although the UEFI dbx certs are now loaded before the MokList certs,
> they are loaded onto different key rings. So the order of the keys
> on their respective key rings is the same.

...

>  /*
> + * load_moklist_certs() - Load MokList certs
> + *
> + * Returns:    Summary error status
> + *
> + * Load the certs contained in the UEFI MokListRT database into the
> + * platform trusted keyring.
> + */

Hmm... Is it intentionally kept out of kernel doc format?

> +static int __init load_moklist_certs(void)
> +{
> +       efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
> +       void *mok = NULL;
> +       unsigned long moksize = 0;
> +       efi_status_t status;
> +       int rc = 0;

Redundant assignment (see below).

> +       /* Get MokListRT. It might not exist, so it isn't an error
> +        * if we can't get it.
> +        */
> +       mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);

> +       if (!mok) {

Why not positive conditional? Sometimes ! is hard to notice.

> +               if (status == EFI_NOT_FOUND)
> +                       pr_debug("MokListRT variable wasn't found\n");
> +               else
> +                       pr_info("Couldn't get UEFI MokListRT\n");
> +       } else {
> +               rc = parse_efi_signature_list("UEFI:MokListRT",
> +                                             mok, moksize, get_handler_for_db);
> +               if (rc)
> +                       pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
> +               kfree(mok);

 kfree(...)
 if (rc)
  ...
 return rc;

And with positive conditional there will be no need to have redundant
'else' followed by additional level of indentation.

> +       }

> +       return rc;

return 0;

> +}

P.S. Yes, I see that the above was in the original code, so, consider
my comments as suggestions to improve the code.

-- 
With Best Regards,
Andy Shevchenko
