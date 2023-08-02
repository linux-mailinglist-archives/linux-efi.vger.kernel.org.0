Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C9C76C614
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 09:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjHBHEt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 03:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjHBHEs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 03:04:48 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A021FFA
        for <linux-efi@vger.kernel.org>; Wed,  2 Aug 2023 00:04:46 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe0e201f87so752505e87.0
        for <linux-efi@vger.kernel.org>; Wed, 02 Aug 2023 00:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690959885; x=1691564685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l2sfaru8OmVAEwVJ+R5RxlQAJhktlVz8IstV6follvw=;
        b=t0vr7GihQGBrwc1YJ3g1AAGYXD1jGvcpgN6iJPKD5xMRd3D2qdP95+65hD6xjI47pn
         kIWOuYLdSGmHKai2A5knurHHQEORLXj75JtpwB1ZU7vS0VgUmxbknWAUZzsgFblUWzKS
         aT3HYRNov0I3Xr8f/zcWSnH16/BsAG/VDPYFRoR32RQ3fnySxvEHSNKU+QtkRn/zH/fX
         rPieoZuPJ/0ljTNhj5e+j/+RkSTyoU3yUcSDFPpsQZ/DeflKsTO+UNjJq1RcLE1by5FN
         AOIfoco74tbL3wVNC8VSOvlFVPcpWoj3KViiZNjNaHsDEryuy7dEmJ2awpyYFK0tXAJf
         Xj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690959885; x=1691564685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2sfaru8OmVAEwVJ+R5RxlQAJhktlVz8IstV6follvw=;
        b=WoOz9MAXrXv5lripULRL12AKZkj6zP9HjTWGAWToQrHLB59xfvCsC0tYRl8zrGVipJ
         iZsiAtK9FGeiKJ76n0+sK1njOPSyoHA7PE/dP/y2Fv/tKYBSrAD3J2kba2StP8FSSEBi
         q0bLnETjp9o616M1U3arian0iXWAhQiEn+XfrCUG9dcP1giM5UKM6crgJSD7u0C3WcL6
         4sLhhmydfJ+MXIfBhwgOQrdfe32QAbs+cQiNYy3oueOlUnliV/J4E3aRY1dc3PfjGDal
         A0DRrEX4PapsNze5BRDGCfQYLp8BVuRCvsUZ94Z4nTeFf4udiKwBi6/JT+lQtqEdmMVR
         APtg==
X-Gm-Message-State: ABy/qLZ9HBzWKggRad/f10POggGc4jndq0rUPeMnQ/gvVjwoRCh11wHM
        wydtNQ6TANWFIPpt48yJVA49GKIjr9YAMqgYYOGkCQ==
X-Google-Smtp-Source: APBJJlEFs33+TYBvFeAhLwS/9cMe6ZvbN5xrDHcMO8IGg8h5hW0KncTIehYj+kKXFczrThbpIoNGezoyA4hMlAxDpQA=
X-Received: by 2002:a19:2d5b:0:b0:4f9:dac6:2f3d with SMTP id
 t27-20020a192d5b000000b004f9dac62f3dmr1638816lft.13.1690959885075; Wed, 02
 Aug 2023 00:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230731065041.1447-1-masahisa.kojima@linaro.org>
 <20230731065041.1447-4-masahisa.kojima@linaro.org> <e1e9a9c1-db6f-c2f6-1ac0-fd368f79aec6@canonical.com>
In-Reply-To: <e1e9a9c1-db6f-c2f6-1ac0-fd368f79aec6@canonical.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 2 Aug 2023 10:04:08 +0300
Message-ID: <CAC_iWjLo=RbFCs5i1jdMXRbx0r-ximrSb5fWFad+98R5r_gpXQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] efi: Add tee-based EFI variable driver
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
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

Hi Heinrich

[...]

> > +static struct tee_client_driver tee_stmm_efi_driver = {
> > +     .id_table       = tee_stmm_efi_id_table,
> > +     .driver         = {
> > +             .name           = "tee-stmm-efi",
> > +             .bus            = &tee_bus_type,
> > +             .probe          = tee_stmm_efi_probe,
> > +             .remove         = tee_stmm_efi_remove,
> > +     },
> > +};
> > +
> > +static int __init tee_stmm_efi_mod_init(void)
> > +{
> > +     return driver_register(&tee_stmm_efi_driver.driver);
>
> Assuming that multiple drivers supplying EFI runtime services may be
> available in future, e.g.
>
> * generic, using EFI runtime function supplied by UEFI firmware
> * TEE-STMM
> * Qualcomm driver as needed for Lenovo X13s
> * ubootefi.var file in ESP
>
> further assuming that multiple driver probe functions succeed:
>
> How do you identify which driver to activate?

This is really a firmware issue.  Whoever assembles that needs to make
sure there's a single entity that should manage the EFI variables.

As far as the current situation
- Qualcomm doesn't run OP-TEE and IIRC uses a DT-entry to enable that code
- OP-TEE will swap the runtime variables calls if StMM is compiled
along and the userspace supplicant is running
- We got no support for ubootefi.var.  If we ever add that the only
clash I can see is u-boot compiled with StMM support and someone
touches the ubootefi.var on ESP.

I'd really prefer to have the feature be autodetected, but if we can't
do that, perhaps we could agree on an EFI config table that the kernel
could read and interpret on what to activate on priority, or
alternatively re-purpose Qualcomms DT entry?

Regards
/Ilias

>
> Best regards
>
> Heinrich
>
> > +}
> > +
> > +static void __exit tee_stmm_efi_mod_exit(void)
> > +{
> > +     driver_unregister(&tee_stmm_efi_driver.driver);
> > +}
> > +
> > +module_init(tee_stmm_efi_mod_init);
> > +module_exit(tee_stmm_efi_mod_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Ilias Apalodimas <ilias.apalodimas@linaro.org>");
> > +MODULE_AUTHOR("Masahisa Kojima <masahisa.kojima@linaro.org>");
> > +MODULE_DESCRIPTION("TEE based EFI runtime variable service driver");
>
