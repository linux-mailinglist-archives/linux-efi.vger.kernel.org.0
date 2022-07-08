Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E924456C0CE
	for <lists+linux-efi@lfdr.de>; Fri,  8 Jul 2022 20:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbiGHQhu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Jul 2022 12:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbiGHQhu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Jul 2022 12:37:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD86167EF;
        Fri,  8 Jul 2022 09:37:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4B00B828B5;
        Fri,  8 Jul 2022 16:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8D3C341C6;
        Fri,  8 Jul 2022 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657298266;
        bh=faBbiFmeCk/XXmJzoX4Ig8MuGcWSSVfGfVZBC0uD89k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JnNXQWwfR5Pobgkk8oUvEGVJBSmO2r9GUMSSXlJVJdnjacOYs4rzXZWR5xmnv4a9V
         EgIw/O7MB3F2AVQe10p3DSyNGUskkhA9GX0KFE45XYEH6U2oqHPwNF2s0PTOM6Tbqb
         +NrTONPkT3X+4Vth/c+oAIggdeCp4m3/wCte3gkq9csT28C2fUd8cgL8vEn2SbmI8z
         FP4DKekY/u9cbEm5oWQS/AAC1NyCHA/KobF2VwgAUerALCK/Z4B7EYl3T1sjPXN/2R
         4GXx4zL0QFw2MDFbeBxRG6I3RHAs7Jz4ihj0wGobXZq+EHQLU3c03k26EXfXlRR2CW
         f+Ip/z3hWi6lA==
Received: by mail-ot1-f45.google.com with SMTP id q18-20020a9d7c92000000b00616b27cda7cso16572452otn.9;
        Fri, 08 Jul 2022 09:37:46 -0700 (PDT)
X-Gm-Message-State: AJIora/ERigHeK+aorDpCkoc6Ighsdjp5BrWUnaNgxSS3bFuDQytH3pt
        t4g6ymRDrjkMWlCtsP3WV9NbK6rj/tSHF/22NVM=
X-Google-Smtp-Source: AGRyM1svHSEUASsl57J1Bv3MiYQY3jBtqML3YrRdG2TT3OOBZQNPUyNOlB3mW51SOJdsvRkRATEvgOuuAgNAADolzfA=
X-Received: by 2002:a9d:7cc7:0:b0:61a:4fe8:95c4 with SMTP id
 r7-20020a9d7cc7000000b0061a4fe895c4mr1924578otn.71.1657298265369; Fri, 08 Jul
 2022 09:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220708131412.81078-1-hdegoede@redhat.com> <20220708131412.81078-3-hdegoede@redhat.com>
In-Reply-To: <20220708131412.81078-3-hdegoede@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 8 Jul 2022 18:37:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH8sck_WMQObNVuT0RkoRFpdZ-V7A4wNW2Mj9CmwdSmZw@mail.gmail.com>
Message-ID: <CAMj1kXH8sck_WMQObNVuT0RkoRFpdZ-V7A4wNW2Mj9CmwdSmZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi: Fix efi_power_off() not being run before
 acpi_power_off() when necessary
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, X86 ML <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 8 Jul 2022 at 15:14, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Commit 98f30d0ecf79 ("ACPI: power: Switch to sys-off handler API")
> switched the ACPI sleep code from directly setting the old global
> pm_power_off handler to using the new register_sys_off_handler()
> mechanism with a priority of SYS_OFF_PRIO_FIRMWARE.
>
> This is a problem when the old global pm_power_off handler would later
> be overwritten, such as done by the late_initcall(efi_shutdown_init):
>
>         if (efi_poweroff_required())
>                 pm_power_off = efi_power_off;
>
> The old global pm_power_off handler gets run with a priority of
> SYS_OFF_PRIO_DEFAULT which is lower then SYS_OFF_PRIO_FIRMWARE, causing
> acpi_power_off() to run first, changing the behavior from before
> the ACPI sleep code switched to the new register_sys_off_handler().
>
> Switch the registering of efi_power_off over to register_sys_off_handler()
> with a priority of SYS_OFF_PRIO_FIRMWARE + 1 so that it will run before
> acpi_power_off() as before.
>
> Note since the new sys-off-handler code will try all handlers in
> priority order, there is no more need for the EFI code to store and
> call the original pm_power_off handler.
>
> Fixes: 98f30d0ecf79 ("ACPI: power: Switch to sys-off handler API")
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

Note that, as far as I know, this should only affect x86 even though
this is generic EFI code, and arm64 also supports ACPI boot, but it
doesn't use ACPI for poweroff/reboot etc

> ---
>  drivers/firmware/efi/reboot.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/firmware/efi/reboot.c b/drivers/firmware/efi/reboot.c
> index 73089a24f04b..ceae84c19d22 100644
> --- a/drivers/firmware/efi/reboot.c
> +++ b/drivers/firmware/efi/reboot.c
> @@ -6,7 +6,7 @@
>  #include <linux/efi.h>
>  #include <linux/reboot.h>
>
> -static void (*orig_pm_power_off)(void);
> +static struct sys_off_handler *efi_sys_off_handler;
>
>  int efi_reboot_quirk_mode = -1;
>
> @@ -51,15 +51,11 @@ bool __weak efi_poweroff_required(void)
>         return false;
>  }
>
> -static void efi_power_off(void)
> +static int efi_power_off(struct sys_off_data *data)
>  {
>         efi.reset_system(EFI_RESET_SHUTDOWN, EFI_SUCCESS, 0, NULL);
> -       /*
> -        * The above call should not return, if it does fall back to
> -        * the original power off method (typically ACPI poweroff).
> -        */
> -       if (orig_pm_power_off)
> -               orig_pm_power_off();
> +
> +       return NOTIFY_DONE;
>  }
>
>  static int __init efi_shutdown_init(void)
> @@ -68,8 +64,13 @@ static int __init efi_shutdown_init(void)
>                 return -ENODEV;
>
>         if (efi_poweroff_required()) {
> -               orig_pm_power_off = pm_power_off;
> -               pm_power_off = efi_power_off;
> +               /* SYS_OFF_PRIO_FIRMWARE + 1 so that it runs before acpi_power_off */
> +               efi_sys_off_handler =
> +                       register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
> +                                                SYS_OFF_PRIO_FIRMWARE + 1,
> +                                                efi_power_off, NULL);
> +               if (IS_ERR(efi_sys_off_handler))
> +                       return PTR_ERR(efi_sys_off_handler);
>         }
>
>         return 0;
> --
> 2.36.0
>
