Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB2A7C7F27
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 09:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjJMH7s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 03:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjJMH7r (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 03:59:47 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36F383
        for <linux-efi@vger.kernel.org>; Fri, 13 Oct 2023 00:59:45 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7b5fe8ab5f9so791174241.3
        for <linux-efi@vger.kernel.org>; Fri, 13 Oct 2023 00:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697183985; x=1697788785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=REWI9aVVUrDk67MWEBoCKN3t/aYt3f7m0oP9Ii5DchY=;
        b=YHrBAUglzHn79P+UoSQc3Fg2KMkJqHy29ILAgTS3pyXjdAPKfsTXQv+dO2EIqdlpaz
         YNcrOlKHcdRLquqTqblelIoy7Oo0kyx2VxiB78jIV4qS8Ej4UPGabk+fnCzwCxJ1/UTS
         BY486mfnwiXS1+b/jt7vi1vTNsoARFfqZqIHm37z619ik/htdzudPHhxiU2vjk0oXjFG
         CHGIjLY0kVYyaicVyCUIX7goI5wiv8pz6E37tC/sof0yBz23iUaTqoEfqI8utpDD2oK/
         TaWCIBjTUFc1lFSHjzjVFCoqwawSZ4slLCDzp7gNVgD5xcCBGilvA3OxUPsSfbH+EXw0
         fOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697183985; x=1697788785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REWI9aVVUrDk67MWEBoCKN3t/aYt3f7m0oP9Ii5DchY=;
        b=Q9CMXEJXpYQNFFHrBRSE9AKnLcu6Wp9VngS1ZruWPDHl0tQXwqyKusEag/i8QFInU8
         AJ2eUrYpSbPoup8MEZFD8FbDh9F/A8LESfhdvSjd2kernvGMirKHlNIt35RzT/RfADKs
         bzrl2XNBIvzx88utkcjuSXKauWurK34lndKJ8LKuYNpfUCsJHEqeyAcl5/M36rCYnaV7
         /wj9HsWuTy0njqXpeB52mLgSMzhRrPsMuPgvEvQ8jsIVsGwmPwAEeeKugM4YEqZWMHps
         e26vKQzSf9Lo5xigLqBITjDZaRbw1cXsKuwHbNjDLide/Hswarih9dRGMeqgfgs3qyTn
         stjg==
X-Gm-Message-State: AOJu0YzYIh7DCb/afE+LvFTXmFjeIpgugqMU7Tbx9ypB9hwqdJvanRd6
        BMLnL4lcgNRRM1+tkRESNzr92+HMVILPuase/5DPqg==
X-Google-Smtp-Source: AGHT+IHhTeTi3Gj505Mx41j5LL+4dFLAR7SjmoTwKizwc56WY8GM2CHR/4kcLzIx9ca66aTrVt4/PRvpPsiimuxIb6M=
X-Received: by 2002:a05:6102:f09:b0:457:79e5:50df with SMTP id
 v9-20020a0561020f0900b0045779e550dfmr16193319vss.33.1697183985048; Fri, 13
 Oct 2023 00:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231013074540.8980-1-masahisa.kojima@linaro.org> <20231013074540.8980-7-masahisa.kojima@linaro.org>
In-Reply-To: <20231013074540.8980-7-masahisa.kojima@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 13 Oct 2023 13:29:34 +0530
Message-ID: <CAFA6WYMoWn6MgoRp8hD89PwmLeHaO+X1sGB0QOMQDLJtuseP3g@mail.gmail.com>
Subject: Re: [PATCH v9 6/6] tee: optee: restore efivars ops when
 tee-supplicant stops
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Kojima-san,

On Fri, 13 Oct 2023 at 13:18, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> When tee-supplicant stops, tee-based EFI variable service
> is no longer available. Restore the efivars generic ops at the
> moment when tee-supplicant stops.

This is a layering violation as evident from below linking error. The
tee-supplicant is internal to how OP-TEE is implemented. I have
already shared a unified way to handle shutdown of supplicant
dependent devices here [1].

[1] https://lore.kernel.org/all/20230728134832.326467-1-sumit.garg@linaro.org/

-Sumit

>
> Linking error occurs if we set CONFIG_OPTEE=y and
> CONFIG_TEE_STMM_EFI=m. Use IS_REACHABLE() guard to call
> tee_stmm_restore_efivars_generic_ops() function.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 8 +++++++-
>  drivers/tee/optee/supp.c                 | 4 ++++
>  include/linux/efi.h                      | 1 +
>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> index edc165bc1bb0..e804b260edaa 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -572,10 +572,16 @@ static int tee_stmm_efi_probe(struct device *dev)
>         return 0;
>  }
>
> -static int tee_stmm_efi_remove(struct device *dev)
> +void tee_stmm_restore_efivars_generic_ops(void)
>  {
>         efivars_unregister(&tee_efivars);
>         efivars_generic_ops_register();
> +}
> +EXPORT_SYMBOL_GPL(tee_stmm_restore_efivars_generic_ops);
> +
> +static int tee_stmm_efi_remove(struct device *dev)
> +{
> +       tee_stmm_restore_efivars_generic_ops();
>
>         return 0;
>  }
> diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> index 322a543b8c27..d07d4fc4e72e 100644
> --- a/drivers/tee/optee/supp.c
> +++ b/drivers/tee/optee/supp.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2015, Linaro Limited
>   */
>  #include <linux/device.h>
> +#include <linux/efi.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include "optee_private.h"
> @@ -58,6 +59,9 @@ void optee_supp_release(struct optee_supp *supp)
>                 complete(&req->c);
>         }
>
> +       if (IS_REACHABLE(CONFIG_TEE_STMM_EFI))
> +               tee_stmm_restore_efivars_generic_ops();
> +
>         supp->ctx = NULL;
>         supp->req_id = -1;
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 489707b9b0b0..9b60893d6299 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1365,5 +1365,6 @@ extern struct blocking_notifier_head efivar_ops_nh;
>
>  void efivars_generic_ops_register(void);
>  void efivars_generic_ops_unregister(void);
> +void tee_stmm_restore_efivars_generic_ops(void);
>
>  #endif /* _LINUX_EFI_H */
> --
> 2.30.2
>
