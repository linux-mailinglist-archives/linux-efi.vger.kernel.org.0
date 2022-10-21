Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49350607286
	for <lists+linux-efi@lfdr.de>; Fri, 21 Oct 2022 10:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJUIia (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Oct 2022 04:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiJUIi1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Oct 2022 04:38:27 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D822315B
        for <linux-efi@vger.kernel.org>; Fri, 21 Oct 2022 01:38:16 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b2so3893964lfp.6
        for <linux-efi@vger.kernel.org>; Fri, 21 Oct 2022 01:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qYZYbXbI2mcjAn9NVDsmb+aO90EEBxaGk4Wi/Rwt0M0=;
        b=DSE0su34rNBYYaUYKb1G/ttcMOyOBa5xDFgJr91gRnrX63jo/p2tJCUGhJ01bqTwyo
         cjqEKC73T3hmEVJC0XRNllMQajZEEIdBOVn/pFyM3YzGUqs7SV7GkLLmTRpgUJGK6Mr1
         rCjDA+jwKsXYdHXeBLT/mT84N9k/0dKdnfZoQZbTU15lI0BUlEORMxTUK90gJqumqfHQ
         lZsCEeeBEPOYcWiC1xEUL7xdFbbpeY+TlcT94jJaQ9HfJBzYjS6MvRVvD7NyvOZZhBgT
         8AcWY3DqR4yCoy7HLxhIY4qdLLPIjTKSszLiqJRJDMxRZAzBgeO26L4H49gBFBrs1G5w
         oFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYZYbXbI2mcjAn9NVDsmb+aO90EEBxaGk4Wi/Rwt0M0=;
        b=M5vOAGysiD5BrfmKMZWVEyMJLkXQqMsDWsQU/q3bsWdtgQGn+Fn9vpw47PjR7VwVYG
         PK/+N1t2vejuZPq8OEhleGKZXtPlRieyQszHb2hMhjwd8PJSrLR44RgU0zyTU1WMoBi6
         qTpiwVH4UMbz19P1AJcikFd32X52piBbCY6lEpVlojxENzsYmFcwlkA7mGXfXZhCqvQN
         udowh3p5fS5rrjtGqhuvmywIliH+jnNhRxwz0o8mux7ChwFiYwMAhEmfjJzSGYho++Le
         cHEkpaekMNUT0vnAjJhjnzx5JS/Du81BoY+f/ouL3lZZKR2/y72B760LPX5D1Oon4Dth
         Qr6w==
X-Gm-Message-State: ACrzQf3mviheoaLw10RGixc6tmapY9JtxBMvHZWXbjJ6stWgXru1eTO0
        MRxFIVMQmixmgRdUAPQR9lRqkpptuuyvyKMUxMzwBw==
X-Google-Smtp-Source: AMsMyM7tCNG8t9SEw4e3xdKCodUmbdY1kJ+5xBZP/drdzfWEoWiyYZyqIpM7AJGnTSbMJqGboIQriznKMC3QfL/EGzU=
X-Received: by 2002:ac2:5a5d:0:b0:4a2:3d64:8ad3 with SMTP id
 r29-20020ac25a5d000000b004a23d648ad3mr6538667lfn.530.1666341494934; Fri, 21
 Oct 2022 01:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221020083910.1902009-1-ardb@kernel.org> <20221020083910.1902009-3-ardb@kernel.org>
In-Reply-To: <20221020083910.1902009-3-ardb@kernel.org>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Fri, 21 Oct 2022 11:37:38 +0300
Message-ID: <CAC_iWjLcP_DpxcY5q7w=_Am-Ky4h_7A199a-HjPbuGfyfN-L3w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] efi: random: Use 'ACPI reclaim' memory for random seed
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Lennart Poettering <lennart@poettering.net>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Thu, 20 Oct 2022 at 11:40, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> EFI runtime services data is guaranteed to be preserved by the OS,
> making it a suitable candidate for the EFI random seed table, which may
> be passed to kexec kernels as well (after refreshing the seed), and so
> we need to ensure that the memory is preserved without support from the
> OS itself.
>
> However, runtime services data is intended for allocations that are
> relevant to the implementations of the runtime services themselves, and
> so they are unmapped from the kernel linear map, and mapped into the EFI
> page tables that are active while runtime service invocations are in
> progress. None of this is needed for the RNG seed.
>
> So let's switch to EFI 'ACPI reclaim' memory: in spite of the name,
> there is nothing exclusively ACPI about it, it is simply a type of
> allocation that carries firmware provided data which may or may not be
> relevant to the OS, and it is left up to the OS to decide whether to
> reclaim it after having consumed its contents.
>
> Given that in Linux, we never reclaim these allocations, it is a good
> choice for the EFI RNG seed, as the allocation is guaranteed to survive
> kexec reboots.

Can we add this as a comment right above the efi_bs_call()

>
> One additional reason for changing this now is to align it with the
> upcoming recommendation for EFI bootloader provided RNG seeds, which
> must not use EFI runtime services code/data allocations.
>
> Cc: <stable@vger.kernel.org> # v4.14+
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/random.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
> index 24aa37535372..183dc5cdb8ed 100644
> --- a/drivers/firmware/efi/libstub/random.c
> +++ b/drivers/firmware/efi/libstub/random.c
> @@ -75,7 +75,7 @@ efi_status_t efi_random_get_seed(void)
>         if (status != EFI_SUCCESS)
>                 return status;
>
> -       status = efi_bs_call(allocate_pool, EFI_RUNTIME_SERVICES_DATA,
> +       status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
>                              sizeof(*seed) + EFI_RANDOM_SEED_SIZE,
>                              (void **)&seed);
>         if (status != EFI_SUCCESS)
> --
> 2.35.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
