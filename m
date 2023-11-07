Return-Path: <linux-efi+bounces-2-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C24727E3491
	for <lists+linux-efi@lfdr.de>; Tue,  7 Nov 2023 05:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE36CB20B6F
	for <lists+linux-efi@lfdr.de>; Tue,  7 Nov 2023 04:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC11917C7;
	Tue,  7 Nov 2023 04:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dbf0Ltzk"
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C7F8C19
	for <linux-efi@vger.kernel.org>; Tue,  7 Nov 2023 04:37:07 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F6B134
	for <linux-efi@vger.kernel.org>; Mon,  6 Nov 2023 20:37:05 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2800f7c8125so4952167a91.1
        for <linux-efi@vger.kernel.org>; Mon, 06 Nov 2023 20:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699331825; x=1699936625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WGCkBY5WRLeayy3l30tNZQ/lx6Qo6qQvQDwDMwFQ+1I=;
        b=Dbf0Ltzk2CeiJ74RbAUUzF2RpYI6I79vUk/ID8eyXIz2G70zjULTDwSvIzz1/6L+ru
         w20ACWkhXGWT6nfRRrDMVkPRDu0ZKlteIHalOzwuA8EXZLC37xFyiPeZPm7wwaLelrBe
         0gzUxEkF9hscYy5eevENCGEN+PdPZ7y4ncq8QSYdL0XzN5HmQ58xKgvN34c1b07xBtDz
         bzjDGzIFuoZt6ynJMPVCYrGjMQDVVig+Eivc/UzFDF6/so+zILinH9+w7zv0Xp4MLOkp
         IYcd0tPxBgxqYE3AE42X6wyfLhO+H4pozqqNfNb38AmZGnLUrjU/j/5xwY6keDidzMps
         5WKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699331825; x=1699936625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGCkBY5WRLeayy3l30tNZQ/lx6Qo6qQvQDwDMwFQ+1I=;
        b=TyD66y3OUIo9TnjGO8OdEYCifsl0KpdUXb+FrY1rQ2+SXwEpSfkJFmyKrOLroTo8uh
         uWBMHMmZ28AIC2z4pXwkSr9lgWk1GR0+Z84UXwQMQ0wqsy9BuPvu2qmzYwgx2ARf5p6C
         n4NzLUydf3DSOo6H9EH/Hz4gDclJwpYCw4f/uJ1CU5C98evAPjMTOVJEic1UG9UbDS0D
         TkDC4FphNUC1+31J/PE5zm35k4t4H0GvcMVxGg8FlscVrukQsk79RmUGUq4SfaNe7msA
         amCCmvK7odNkKSqQ+QIPzgvphEYx47ERj6ME4Rp2hhOogrWxUOc9PpLRyzrC5ah5D31w
         6O7g==
X-Gm-Message-State: AOJu0YxJzeN1O5fR694kFwKq1G309Gg64WfBZSokR1DaRDRThFbL54B2
	PfsgMB4N/60IgiE9OTqkMoiSBbDbTChP7y3zfvAp7g==
X-Google-Smtp-Source: AGHT+IGg4IOO6iwAswJi2mx9of/jHYKlPfVVgAfZJKHgBHD1eD+l0sMvC0aW2GnKG+Lb8F2pQhN8cJmgPngMWzUV98w=
X-Received: by 2002:a17:90b:1d06:b0:268:808:8e82 with SMTP id
 on6-20020a17090b1d0600b0026808088e82mr2056098pjb.1.1699331824947; Mon, 06 Nov
 2023 20:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013074540.8980-1-masahisa.kojima@linaro.org>
 <20231013074540.8980-7-masahisa.kojima@linaro.org> <CAFA6WYMoWn6MgoRp8hD89PwmLeHaO+X1sGB0QOMQDLJtuseP3g@mail.gmail.com>
In-Reply-To: <CAFA6WYMoWn6MgoRp8hD89PwmLeHaO+X1sGB0QOMQDLJtuseP3g@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Tue, 7 Nov 2023 13:36:53 +0900
Message-ID: <CADQ0-X99y_q+3L+dRWr39uV63YX6_9HrNQzFpZW5_SvmDn1vqQ@mail.gmail.com>
Subject: Re: [PATCH v9 6/6] tee: optee: restore efivars ops when
 tee-supplicant stops
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jens Wiklander <jens.wiklander@linaro.org>, 
	Jan Kiszka <jan.kiszka@siemens.com>, linux-kernel@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-efi@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Sumit,

On Fri, 13 Oct 2023 at 16:59, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Kojima-san,
>
> On Fri, 13 Oct 2023 at 13:18, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > When tee-supplicant stops, tee-based EFI variable service
> > is no longer available. Restore the efivars generic ops at the
> > moment when tee-supplicant stops.
>
> This is a layering violation as evident from below linking error. The
> tee-supplicant is internal to how OP-TEE is implemented. I have
> already shared a unified way to handle shutdown of supplicant
> dependent devices here [1].

I will drop this patch, and send the next version.

Thanks,
Masahisa Kojima

>
> [1] https://lore.kernel.org/all/20230728134832.326467-1-sumit.garg@linaro.org/
>
> -Sumit
>
> >
> > Linking error occurs if we set CONFIG_OPTEE=y and
> > CONFIG_TEE_STMM_EFI=m. Use IS_REACHABLE() guard to call
> > tee_stmm_restore_efivars_generic_ops() function.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >  drivers/firmware/efi/stmm/tee_stmm_efi.c | 8 +++++++-
> >  drivers/tee/optee/supp.c                 | 4 ++++
> >  include/linux/efi.h                      | 1 +
> >  3 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> > index edc165bc1bb0..e804b260edaa 100644
> > --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> > +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> > @@ -572,10 +572,16 @@ static int tee_stmm_efi_probe(struct device *dev)
> >         return 0;
> >  }
> >
> > -static int tee_stmm_efi_remove(struct device *dev)
> > +void tee_stmm_restore_efivars_generic_ops(void)
> >  {
> >         efivars_unregister(&tee_efivars);
> >         efivars_generic_ops_register();
> > +}
> > +EXPORT_SYMBOL_GPL(tee_stmm_restore_efivars_generic_ops);
> > +
> > +static int tee_stmm_efi_remove(struct device *dev)
> > +{
> > +       tee_stmm_restore_efivars_generic_ops();
> >
> >         return 0;
> >  }
> > diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> > index 322a543b8c27..d07d4fc4e72e 100644
> > --- a/drivers/tee/optee/supp.c
> > +++ b/drivers/tee/optee/supp.c
> > @@ -3,6 +3,7 @@
> >   * Copyright (c) 2015, Linaro Limited
> >   */
> >  #include <linux/device.h>
> > +#include <linux/efi.h>
> >  #include <linux/slab.h>
> >  #include <linux/uaccess.h>
> >  #include "optee_private.h"
> > @@ -58,6 +59,9 @@ void optee_supp_release(struct optee_supp *supp)
> >                 complete(&req->c);
> >         }
> >
> > +       if (IS_REACHABLE(CONFIG_TEE_STMM_EFI))
> > +               tee_stmm_restore_efivars_generic_ops();
> > +
> >         supp->ctx = NULL;
> >         supp->req_id = -1;
> >
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index 489707b9b0b0..9b60893d6299 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -1365,5 +1365,6 @@ extern struct blocking_notifier_head efivar_ops_nh;
> >
> >  void efivars_generic_ops_register(void);
> >  void efivars_generic_ops_unregister(void);
> > +void tee_stmm_restore_efivars_generic_ops(void);
> >
> >  #endif /* _LINUX_EFI_H */
> > --
> > 2.30.2
> >

