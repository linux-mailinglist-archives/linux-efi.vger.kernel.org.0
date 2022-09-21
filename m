Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657C65C0368
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiIUQE2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 12:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiIUQDC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 12:03:02 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADA2A2855
        for <linux-efi@vger.kernel.org>; Wed, 21 Sep 2022 08:54:10 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b6so7523699ljr.10
        for <linux-efi@vger.kernel.org>; Wed, 21 Sep 2022 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mo7g3q35sz+tLdvVanOmusY3mR003QbxOLTriaZF9+A=;
        b=TDE0uP5sf06L4/oDeGPL6WuTfFA5L2J6FF7hwM9LZlIDf0C+jBULzwhSxGZbWPiBLQ
         7345nKFhKmaS2UIsUmQNYjoGG08KXeDRNPc7MZBNOEiwmED2LnN/IzbZpR6FgFhI3E1q
         VDCmNfLJe4a9s6R8PkNjqPVC1iW4bOVnAa7LMQL9TxE/iax1TTwmhKKCSPHJOpQOf0c2
         WEmL2vtMhyjAhIQMySCoJ2UK10Bl4j31QXMurMElSBJFgOnoFdgZoznjxw2KBhUTPiaB
         hO0gtWH2KmFae0YDnitvbVNAkDflW2R2AcHYAa9drph6g6gM9hphBo8JyXNujIXxlZyb
         pRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mo7g3q35sz+tLdvVanOmusY3mR003QbxOLTriaZF9+A=;
        b=x8YrvI0HCKvaGbyx8/40QmIPytZmTEjYc3vbqgpbrAAARPS3hJaKUj+A51u3YB8XA0
         JHBo6PWTyso+AJiGFdOdPymev8jtqW1/EdDRki0MzIwrOpNX+7jDNkPxmJFerKIr9ChR
         XVM+UOCXy635z0jNR5zZ+ytSmEyXkTHJxo8ozAWDZeHTHQ2KwLeTmyGWwbmAq66f+z9h
         ziy5l+GKqRucEsAOKlXxo9w5X9SobOSavwmPgaP0gjoPAJRysXtIqVjyjFxTXSjoi7Qy
         rEU57szHSE06J1r067okampYeQ/TYzlePiStRWAd9l1QDfKChMYJQoZX7+hC02Smc7dY
         KOCQ==
X-Gm-Message-State: ACrzQf3kjRxMfUg95HKBfYAt0zxmrwwhYJEUTiIDd7JjD9TUsL6Dq0hG
        VMVzxXRsirBNnMNyQNnmxgUGJr4S2pDLQ6sv9ltBww==
X-Google-Smtp-Source: AMsMyM4Nj2VlV5cdo5+cIlujgeQm/ji66WqIoBEZ5EcbMg7jDrMzBrKmgyuW5av9hLlb3PeXohUeSf83ZzyxASf2Rz0=
X-Received: by 2002:a2e:7817:0:b0:26c:3e9c:3465 with SMTP id
 t23-20020a2e7817000000b0026c3e9c3465mr7400077ljc.145.1663775587844; Wed, 21
 Sep 2022 08:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220920153743.3598053-1-ardb@kernel.org>
In-Reply-To: <20220920153743.3598053-1-ardb@kernel.org>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 21 Sep 2022 17:52:31 +0200
Message-ID: <CAC_iWjLjnPZQ2Fbo7kieH5C1NCTNaL3rnBdcW8L1q1FZ9td4aQ@mail.gmail.com>
Subject: Re: [PATCH] efi: libstub: check Shim mode using MokSBStateRT
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, pjones@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard

On Tue, 20 Sept 2022 at 17:37, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> We currently check the MokSBState variable to decide whether we should
> treat UEFI secure boot as being disabled, even if the firmware thinks
> otherwise. This is used by shim to indicate that it is not checking
> signatures on boot images. In the kernel, we use this to relax lockdown
> policies.
>
> However, in cases where shim is not even being used, we don't want this
> variable to interfere with lockdown, given that the variable is
> non-volatile variable and therefore persists across a reboot. This means
> setting it once will persistently disable lockdown checks on a given
> system.
>
> So switch to the mirrored version of this variable, called MokSBStateRT,
> which is supposed to be volatile, and this is something we can check.
>

Just out of curiosity was the mirroring implemented at the same time
in SHIM? IOW does MokSBState guarantee the presence of the -RT?
Regardless of the answer this fixes an actual problem, so fwiw

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/xen/efi.c                        | 5 +++--
>  drivers/firmware/efi/libstub/secureboot.c | 8 ++++----
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
> index 7d7ffb9c826a..8bd65f2900b9 100644
> --- a/arch/x86/xen/efi.c
> +++ b/arch/x86/xen/efi.c
> @@ -100,6 +100,7 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
>         enum efi_secureboot_mode mode;
>         efi_status_t status;
>         u8 moksbstate;
> +       u32 attr;
>         unsigned long size;
>
>         mode = efi_get_secureboot_mode(efi.get_variable);
> @@ -113,13 +114,13 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
>         /* See if a user has put the shim into insecure mode. */
>         size = sizeof(moksbstate);
>         status = efi.get_variable(L"MokSBStateRT", &shim_guid,
> -                                 NULL, &size, &moksbstate);
> +                                 &attr, &size, &moksbstate);
>
>         /* If it fails, we don't care why. Default to secure. */
>         if (status != EFI_SUCCESS)
>                 goto secure_boot_enabled;
>
> -       if (moksbstate == 1)
> +       if (!(attr & EFI_VARIABLE_NON_VOLATILE) && moksbstate == 1)
>                 return efi_secureboot_mode_disabled;
>
>   secure_boot_enabled:
> diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
> index 8a18930f3eb6..516f4f0069bd 100644
> --- a/drivers/firmware/efi/libstub/secureboot.c
> +++ b/drivers/firmware/efi/libstub/secureboot.c
> @@ -14,7 +14,7 @@
>
>  /* SHIM variables */
>  static const efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
> -static const efi_char16_t shim_MokSBState_name[] = L"MokSBState";
> +static const efi_char16_t shim_MokSBState_name[] = L"MokSBStateRT";
>
>  static efi_status_t get_var(efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
>                             unsigned long *data_size, void *data)
> @@ -43,8 +43,8 @@ enum efi_secureboot_mode efi_get_secureboot(void)
>
>         /*
>          * See if a user has put the shim into insecure mode. If so, and if the
> -        * variable doesn't have the runtime attribute set, we might as well
> -        * honor that.
> +        * variable doesn't have the non-volatile attribute set, we might as
> +        * well honor that.
>          */
>         size = sizeof(moksbstate);
>         status = get_efi_var(shim_MokSBState_name, &shim_guid,
> @@ -53,7 +53,7 @@ enum efi_secureboot_mode efi_get_secureboot(void)
>         /* If it fails, we don't care why. Default to secure */
>         if (status != EFI_SUCCESS)
>                 goto secure_boot_enabled;
> -       if (!(attr & EFI_VARIABLE_RUNTIME_ACCESS) && moksbstate == 1)
> +       if (!(attr & EFI_VARIABLE_NON_VOLATILE) && moksbstate == 1)
>                 return efi_secureboot_mode_disabled;
>
>  secure_boot_enabled:
> --
> 2.35.1
>
