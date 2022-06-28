Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EF955EAA1
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 19:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiF1RGa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 13:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiF1RGa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 13:06:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB852B252;
        Tue, 28 Jun 2022 10:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37BC3B81F25;
        Tue, 28 Jun 2022 17:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAB7C341CA;
        Tue, 28 Jun 2022 17:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656435987;
        bh=HDnSgvwKqNVpa/SQSMf/jTDknkPfhYQod00aVF8quIY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JNWnbq5krlwWVg4lKCsGPWb0Ih5hGvXxbLHveVWRe0+lLdFIDL7qmfxr2XG66Jz3J
         SS/SoXl0KIco0AV+tWidiOnL1zGiuVFPqvTzvZJyQAWihKJlpGWgyLY4SE3FLW9ooc
         an5aHl+cdWlM13eQMaNltPSP0680s6Zekbljfc0qMhTbYaPihqsen137lKNd1qIbom
         CzTq6rfnXb4ZzOhLul1QIL0ImUIgvmws/7OcUpL48SeMR/y6I6dTquey8q4v8qfrba
         0YofunL4WwwJ7ZbvEqLQkncUrUVLF0aTPTOZIHf747Fzl7nSgm9ezo2HoOBIoYwL1s
         m+6vfbRzqvGeg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-101b4f9e825so17879859fac.5;
        Tue, 28 Jun 2022 10:06:26 -0700 (PDT)
X-Gm-Message-State: AJIora+IZK6+gWRG3Buj1yq8GDA1X/aBpN24tLRoJcSng9dxh0Qajtk8
        KaNrrh3diMwx/zBRH3koCgGE8dNjeTUEnacLei4=
X-Google-Smtp-Source: AGRyM1uHDp/3ecOok/jjhHh+TO5Zv2awjGIoFm7C2SIVNVcllIpBoyfRHYN06rcu6DZ41ZR7q2pAbNSlg1DMc46ZAzg=
X-Received: by 2002:a05:6870:5b91:b0:108:374a:96b0 with SMTP id
 em17-20020a0568705b9100b00108374a96b0mr371999oab.126.1656435986032; Tue, 28
 Jun 2022 10:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220628125346.693304-1-sudeep.holla@arm.com> <20220628125346.693304-2-sudeep.holla@arm.com>
In-Reply-To: <20220628125346.693304-2-sudeep.holla@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Jun 2022 19:06:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGn5PdM70B_HTUjJRiDvpnaj7FXYwYYLOSNxSHN6XXRiQ@mail.gmail.com>
Message-ID: <CAMj1kXGn5PdM70B_HTUjJRiDvpnaj7FXYwYYLOSNxSHN6XXRiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ACPI: PRM: Change handler_addr type to void pointer
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 28 Jun 2022 at 14:53, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> handler_addr is a virtial address passed to efi_call_virt_pointer.
> While x86 currently type cast it into the pointer in it's arch specific
> arch_efi_call_virt() implementation, ARM64 is restrictive for right
> reasons.
>
> Convert the handler_addr type from u64 to void pointer.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/acpi/prmt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 4d3a219c67f8..998101cf16e4 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -53,7 +53,7 @@ static LIST_HEAD(prm_module_list);
>
>  struct prm_handler_info {
>         guid_t guid;
> -       u64 handler_addr;
> +       void *handler_addr;
>         u64 static_data_buffer_addr;
>         u64 acpi_param_buffer_addr;
>
> @@ -148,7 +148,7 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
>                 th = &tm->handlers[cur_handler];
>
>                 guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
> -               th->handler_addr = efi_pa_va_lookup(handler_info->handler_address);
> +               th->handler_addr = (void *)efi_pa_va_lookup(handler_info->handler_address);
>                 th->static_data_buffer_addr = efi_pa_va_lookup(handler_info->static_data_buffer_address);
>                 th->acpi_param_buffer_addr = efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
>         } while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
> --
> 2.37.0
>
