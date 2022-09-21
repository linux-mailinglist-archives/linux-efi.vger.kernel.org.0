Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7945E5399
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 21:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiIUTKd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 15:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIUTKd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 15:10:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B034C580AA
        for <linux-efi@vger.kernel.org>; Wed, 21 Sep 2022 12:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663787430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VJoInkloU32C9AR3RPsVMPeMbfju4OFWPjPWO0xr8xg=;
        b=ZtZQJiJfcrq+5MEXCsvpvS9aNci86edo9n9QZyUXDuCtqFdEYMI4Pi0D3IsAN+B3wGnBf3
        cyEhibzhyHkxxxrcETH8o0jrisQVplJ7U/afWkCdnNHAVyZokQVjIf58rFs7/PwkGdTpCq
        ZsPZq7qTj4tiIqfmFoYFdS2DnGzxqnY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-DWFGm2XkN5CZffQV61xUdA-1; Wed, 21 Sep 2022 15:10:27 -0400
X-MC-Unique: DWFGm2XkN5CZffQV61xUdA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD10C85A5B6;
        Wed, 21 Sep 2022 19:10:26 +0000 (UTC)
Received: from redhat.com (unknown [10.2.17.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9160449BB65;
        Wed, 21 Sep 2022 19:10:26 +0000 (UTC)
Date:   Wed, 21 Sep 2022 15:10:24 -0400
From:   Peter Jones <pjones@redhat.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH] efi: libstub: check Shim mode using MokSBStateRT
Message-ID: <20220921191023.dztlybd5t5dwdjay@redhat.com>
References: <20220920153743.3598053-1-ardb@kernel.org>
 <CAC_iWjLjnPZQ2Fbo7kieH5C1NCTNaL3rnBdcW8L1q1FZ9td4aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC_iWjLjnPZQ2Fbo7kieH5C1NCTNaL3rnBdcW8L1q1FZ9td4aQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 21, 2022 at 05:52:31PM +0200, Ilias Apalodimas wrote:
> Hi Ard
> 
> On Tue, 20 Sept 2022 at 17:37, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > We currently check the MokSBState variable to decide whether we should
> > treat UEFI secure boot as being disabled, even if the firmware thinks
> > otherwise. This is used by shim to indicate that it is not checking
> > signatures on boot images. In the kernel, we use this to relax lockdown
> > policies.
> >
> > However, in cases where shim is not even being used, we don't want this
> > variable to interfere with lockdown, given that the variable is
> > non-volatile variable and therefore persists across a reboot. This means
> > setting it once will persistently disable lockdown checks on a given
> > system.
> >
> > So switch to the mirrored version of this variable, called MokSBStateRT,
> > which is supposed to be volatile, and this is something we can check.
> >
> 
> Just out of curiosity was the mirroring implemented at the same time
> in SHIM? IOW does MokSBState guarantee the presence of the -RT?
> Regardless of the answer this fixes an actual problem, so fwiw

Yes, since 2016.

Reviewed-by: Peter Jones <pjones@redhat.com>

> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/xen/efi.c                        | 5 +++--
> >  drivers/firmware/efi/libstub/secureboot.c | 8 ++++----
> >  2 files changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
> > index 7d7ffb9c826a..8bd65f2900b9 100644
> > --- a/arch/x86/xen/efi.c
> > +++ b/arch/x86/xen/efi.c
> > @@ -100,6 +100,7 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
> >         enum efi_secureboot_mode mode;
> >         efi_status_t status;
> >         u8 moksbstate;
> > +       u32 attr;
> >         unsigned long size;
> >
> >         mode = efi_get_secureboot_mode(efi.get_variable);
> > @@ -113,13 +114,13 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
> >         /* See if a user has put the shim into insecure mode. */
> >         size = sizeof(moksbstate);
> >         status = efi.get_variable(L"MokSBStateRT", &shim_guid,
> > -                                 NULL, &size, &moksbstate);
> > +                                 &attr, &size, &moksbstate);
> >
> >         /* If it fails, we don't care why. Default to secure. */
> >         if (status != EFI_SUCCESS)
> >                 goto secure_boot_enabled;
> >
> > -       if (moksbstate == 1)
> > +       if (!(attr & EFI_VARIABLE_NON_VOLATILE) && moksbstate == 1)
> >                 return efi_secureboot_mode_disabled;
> >
> >   secure_boot_enabled:
> > diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
> > index 8a18930f3eb6..516f4f0069bd 100644
> > --- a/drivers/firmware/efi/libstub/secureboot.c
> > +++ b/drivers/firmware/efi/libstub/secureboot.c
> > @@ -14,7 +14,7 @@
> >
> >  /* SHIM variables */
> >  static const efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
> > -static const efi_char16_t shim_MokSBState_name[] = L"MokSBState";
> > +static const efi_char16_t shim_MokSBState_name[] = L"MokSBStateRT";
> >
> >  static efi_status_t get_var(efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
> >                             unsigned long *data_size, void *data)
> > @@ -43,8 +43,8 @@ enum efi_secureboot_mode efi_get_secureboot(void)
> >
> >         /*
> >          * See if a user has put the shim into insecure mode. If so, and if the
> > -        * variable doesn't have the runtime attribute set, we might as well
> > -        * honor that.
> > +        * variable doesn't have the non-volatile attribute set, we might as
> > +        * well honor that.
> >          */
> >         size = sizeof(moksbstate);
> >         status = get_efi_var(shim_MokSBState_name, &shim_guid,
> > @@ -53,7 +53,7 @@ enum efi_secureboot_mode efi_get_secureboot(void)
> >         /* If it fails, we don't care why. Default to secure */
> >         if (status != EFI_SUCCESS)
> >                 goto secure_boot_enabled;
> > -       if (!(attr & EFI_VARIABLE_RUNTIME_ACCESS) && moksbstate == 1)
> > +       if (!(attr & EFI_VARIABLE_NON_VOLATILE) && moksbstate == 1)
> >                 return efi_secureboot_mode_disabled;
> >
> >  secure_boot_enabled:
> > --
> > 2.35.1
> >
> 

-- 
        Peter

