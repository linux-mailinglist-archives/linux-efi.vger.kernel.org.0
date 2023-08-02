Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65FB76C314
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 04:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjHBCug (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Aug 2023 22:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHBCuf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Aug 2023 22:50:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188ED1FF3
        for <linux-efi@vger.kernel.org>; Tue,  1 Aug 2023 19:50:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-267fcd6985cso4387455a91.2
        for <linux-efi@vger.kernel.org>; Tue, 01 Aug 2023 19:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690944633; x=1691549433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mEciU1Z6QKvhxwGm0gWIaghrQDHodEupjalaHi7C4ek=;
        b=sw00dMomp4qoKUJKvQWZ8U7BwpH8nuA1hdHmpgpt9RwYi4sKYaf0YyJFCKdkljd+aI
         RdPmRAthF/D/TZQ3L5BRlkqzFpACa4cTugXbIWait5MP+MUqkIDU7qRcCxAAL49KOYgd
         l0zajU2VVCuxEX/6z7FJeMclkxAv5VkLGoZFoWxzPOR4z6LF7ohCRJiQBbrwFNJ8HWfj
         tD2muoJGdEun1lmGp3D3PJt9DrtWVpQ9+6nmaUqv5zkfxYp4JZg8veCTjwspXGah7GXg
         qI3JEcVDTX4erseoCaBxYfj3e/EWM22pKJ6F7EIox+VlsKdSn5/Y13I65vgk0Sx6Bv3A
         KRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690944633; x=1691549433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEciU1Z6QKvhxwGm0gWIaghrQDHodEupjalaHi7C4ek=;
        b=Sbt7lUSck7kXSatItE7/4FHyfxGTq0+pyfVKlTsoKODkUc/pkc1jXyyo0dOEZOxKTj
         83lGEIxyZYW8BRkAMBq06HCE8ZapGHdf1LzzgYsV2i5KSzPimG5uS/h1FBOj5sBBLC5G
         gP3uJKsbdMcsBvWkH4R6L1835ys12AbzM77QaPeyxLSH+YS72TVUKnVNN2c1ssgeDhjJ
         rZ8wwgYvw8Og2l9caq+8jUN8byxXxV0HIlWedONAm7EYlGBQKwRQ56UPqxExXxHfXdVv
         5P9E/lxCqW00TsjoKMPc6oyoZSFaT6HigPM5tVPhSDujV+6/r/xNmBSJoVE0DB7cDXs8
         CbOg==
X-Gm-Message-State: ABy/qLbnyyG5KmymECR0Gmju3dMtxLv9icIhsk8DqXYS+HI/fdVJTlry
        JQcP6jvGm19ZWJrCiZ3SNZldQsXz8S1L+wVi+o/zlA==
X-Google-Smtp-Source: APBJJlFE7aed1xYMU4PfC57Dmdh/QB/JAqb36jqJoBarsI5/0tnpl7QlbRPHXlGgVLBoc+KXTKRNlsXgpM9WzYpK66A=
X-Received: by 2002:a17:90a:1b6c:b0:268:3d4:24bb with SMTP id
 q99-20020a17090a1b6c00b0026803d424bbmr14844027pjq.1.1690944633503; Tue, 01
 Aug 2023 19:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230731065041.1447-1-masahisa.kojima@linaro.org>
 <20230731065041.1447-4-masahisa.kojima@linaro.org> <a6d9857c-fcbd-74d0-bc97-fc86a8c1b820@infradead.org>
In-Reply-To: <a6d9857c-fcbd-74d0-bc97-fc86a8c1b820@infradead.org>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Wed, 2 Aug 2023 11:50:22 +0900
Message-ID: <CADQ0-X91QS8F1UA4Yzj8skk-q+F_5XaU=jQiew_TBpxV7=X5PA@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] efi: Add tee-based EFI variable driver
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 1 Aug 2023 at 00:05, Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 7/30/23 23:50, Masahisa Kojima wrote:
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index 043ca31c114e..aa38089d1e4a 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -287,3 +287,18 @@ config UEFI_CPER_X86
> >       bool
> >       depends on UEFI_CPER && X86
> >       default y
> > +
> > +config TEE_STMM_EFI
> > +     tristate "TEE based EFI runtime variable service driver"
>
>                   TEE-based
OK.

>
> > +     depends on EFI && OPTEE && !EFI_VARS_PSTORE
> > +     help
> > +       Select this config option if TEE is compiled to include StandAloneMM
> > +       as a separate secure partition it has the ability to check and store
>
>                                partition. It has the ability
OK.

Thank you for your review.

Regards,
Masahisa Kojima

>
> > +       EFI variables on an RPMB or any other non-volatile medium used by
> > +       StandAloneMM.
> > +
> > +       Enabling this will change the EFI runtime services from the firmware
> > +       provided functions to TEE calls.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called tee_stmm_efi.
>
> --
> ~Randy
