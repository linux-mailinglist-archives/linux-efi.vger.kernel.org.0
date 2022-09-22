Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722455E5CA2
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 09:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiIVHrl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 03:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiIVHrl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 03:47:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3C9A00D6
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 00:47:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA3A9B82A2C
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 07:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F176C4347C
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 07:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663832857;
        bh=tVCsXer08RrzpO20KEpZPRTL3qVEbRpDgiMuGiAIx+A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j0dZFZ+GalQIt/i2g3qwAwcsu3E/Yyj2j1eY+mQnqsj58hSyI0EQHQTDLyGB9U1JA
         Z3jf/QEWnq3z74dDTlzjEq+SfSK9XXi+1/QDGKRe9nvt9Xu39YNZNn3vC8c5eg0qNk
         7V3Owvtqg71K3SGbsk0FY6+DXwnZXXU6E/4lZUpcrlT21zTaM8g+PylstQxEXSbI9v
         lUeymXMcefTq11qeqFHuj3Rraix1P7BdlEwRg5DeUCFVspadcIRD//1fjz0Fbl/tm8
         ja1dnvtMrGIFDfDt0Y+nEhFsQSFTiDz6fVo/w8P1KTPUiOgzfqa3HWz1kB9swP/1IQ
         qQs1+bqJ2LEDA==
Received: by mail-lf1-f47.google.com with SMTP id f14so13308194lfg.5
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 00:47:37 -0700 (PDT)
X-Gm-Message-State: ACrzQf2VDfs4ywIedaXR96r9k6sL557n5pzfgXOo7yBDCY7o6QNDMZly
        Sen+mQ0Eld2szPGrVyMKLwsmckxOqqdndsqXnf0=
X-Google-Smtp-Source: AMsMyM7cqjZ+Zx5XFAayOnDx4uI3sbnueiuXtuMOmSd85CfGhW7UX1nm+1onXjVObQqjzxSfePSs4CZQ7RZJLAPJIsY=
X-Received: by 2002:a05:6512:4024:b0:497:4db:6ad0 with SMTP id
 br36-20020a056512402400b0049704db6ad0mr781958lfb.637.1663832855333; Thu, 22
 Sep 2022 00:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220920153743.3598053-1-ardb@kernel.org> <CAC_iWjLjnPZQ2Fbo7kieH5C1NCTNaL3rnBdcW8L1q1FZ9td4aQ@mail.gmail.com>
 <20220921191023.dztlybd5t5dwdjay@redhat.com>
In-Reply-To: <20220921191023.dztlybd5t5dwdjay@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 22 Sep 2022 09:47:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEayKNN8T_DzmDV917mGH5rh_ANs6ZOa9Oa2QA7hbR-dA@mail.gmail.com>
Message-ID: <CAMj1kXEayKNN8T_DzmDV917mGH5rh_ANs6ZOa9Oa2QA7hbR-dA@mail.gmail.com>
Subject: Re: [PATCH] efi: libstub: check Shim mode using MokSBStateRT
To:     Peter Jones <pjones@redhat.com>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 21 Sept 2022 at 21:10, Peter Jones <pjones@redhat.com> wrote:
>
> On Wed, Sep 21, 2022 at 05:52:31PM +0200, Ilias Apalodimas wrote:
> > Hi Ard
> >
> > On Tue, 20 Sept 2022 at 17:37, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > We currently check the MokSBState variable to decide whether we should
> > > treat UEFI secure boot as being disabled, even if the firmware thinks
> > > otherwise. This is used by shim to indicate that it is not checking
> > > signatures on boot images. In the kernel, we use this to relax lockdown
> > > policies.
> > >
> > > However, in cases where shim is not even being used, we don't want this
> > > variable to interfere with lockdown, given that the variable is
> > > non-volatile variable and therefore persists across a reboot. This means
> > > setting it once will persistently disable lockdown checks on a given
> > > system.
> > >
> > > So switch to the mirrored version of this variable, called MokSBStateRT,
> > > which is supposed to be volatile, and this is something we can check.
> > >
> >
> > Just out of curiosity was the mirroring implemented at the same time
> > in SHIM? IOW does MokSBState guarantee the presence of the -RT?
> > Regardless of the answer this fixes an actual problem, so fwiw
>
> Yes, since 2016.
>
> Reviewed-by: Peter Jones <pjones@redhat.com>
>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >

Thanks, I've queued this as a fix.


> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/xen/efi.c                        | 5 +++--
> > >  drivers/firmware/efi/libstub/secureboot.c | 8 ++++----
> > >  2 files changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
> > > index 7d7ffb9c826a..8bd65f2900b9 100644
> > > --- a/arch/x86/xen/efi.c
> > > +++ b/arch/x86/xen/efi.c
> > > @@ -100,6 +100,7 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
> > >         enum efi_secureboot_mode mode;
> > >         efi_status_t status;
> > >         u8 moksbstate;
> > > +       u32 attr;
> > >         unsigned long size;
> > >
> > >         mode = efi_get_secureboot_mode(efi.get_variable);
> > > @@ -113,13 +114,13 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
> > >         /* See if a user has put the shim into insecure mode. */
> > >         size = sizeof(moksbstate);
> > >         status = efi.get_variable(L"MokSBStateRT", &shim_guid,
> > > -                                 NULL, &size, &moksbstate);
> > > +                                 &attr, &size, &moksbstate);
> > >
> > >         /* If it fails, we don't care why. Default to secure. */
> > >         if (status != EFI_SUCCESS)
> > >                 goto secure_boot_enabled;
> > >
> > > -       if (moksbstate == 1)
> > > +       if (!(attr & EFI_VARIABLE_NON_VOLATILE) && moksbstate == 1)
> > >                 return efi_secureboot_mode_disabled;
> > >
> > >   secure_boot_enabled:
> > > diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
> > > index 8a18930f3eb6..516f4f0069bd 100644
> > > --- a/drivers/firmware/efi/libstub/secureboot.c
> > > +++ b/drivers/firmware/efi/libstub/secureboot.c
> > > @@ -14,7 +14,7 @@
> > >
> > >  /* SHIM variables */
> > >  static const efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
> > > -static const efi_char16_t shim_MokSBState_name[] = L"MokSBState";
> > > +static const efi_char16_t shim_MokSBState_name[] = L"MokSBStateRT";
> > >
> > >  static efi_status_t get_var(efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
> > >                             unsigned long *data_size, void *data)
> > > @@ -43,8 +43,8 @@ enum efi_secureboot_mode efi_get_secureboot(void)
> > >
> > >         /*
> > >          * See if a user has put the shim into insecure mode. If so, and if the
> > > -        * variable doesn't have the runtime attribute set, we might as well
> > > -        * honor that.
> > > +        * variable doesn't have the non-volatile attribute set, we might as
> > > +        * well honor that.
> > >          */
> > >         size = sizeof(moksbstate);
> > >         status = get_efi_var(shim_MokSBState_name, &shim_guid,
> > > @@ -53,7 +53,7 @@ enum efi_secureboot_mode efi_get_secureboot(void)
> > >         /* If it fails, we don't care why. Default to secure */
> > >         if (status != EFI_SUCCESS)
> > >                 goto secure_boot_enabled;
> > > -       if (!(attr & EFI_VARIABLE_RUNTIME_ACCESS) && moksbstate == 1)
> > > +       if (!(attr & EFI_VARIABLE_NON_VOLATILE) && moksbstate == 1)
> > >                 return efi_secureboot_mode_disabled;
> > >
> > >  secure_boot_enabled:
> > > --
> > > 2.35.1
> > >
> >
>
> --
>         Peter
>
