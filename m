Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1397E534033
	for <lists+linux-efi@lfdr.de>; Wed, 25 May 2022 17:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245077AbiEYPRb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 May 2022 11:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245093AbiEYPRZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 May 2022 11:17:25 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86A8B0A4A
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 08:17:23 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ADB353F85D
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653491840;
        bh=fsgCZw/xRNXiy6OJN4APf5lDTp10s7xR3Y+a1NWVZTo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=kRnCD55jy5NJzFKeRVfL+FfRSeSSXdxYm4YPa6AYW4/WX2/br6cSKn91qFQvzwz8g
         +28ccWjj5YPhiEkqlSOD1SzXzO4w9gIihwUc30RDUxiCI4lE3cfgfT/5kZabKZe9mn
         vN8H3UGnFQVbpk/QW9QeVlzbyduRCqlnw4tYmUukR+s30RxGqX7rjXKUQ6KEzPDi1a
         dJvPjab9OivHvIfTveWyWfpM5gL3d0MC2gecoRQgbhMiB5KUesYgPShNu74Y9OLh+Z
         +dmXxN+IcFK94pvv/ZKmMV17ZRrYpBHmF6rJ4ey6xqkHpom2PzOiHEeD8Z4cxI/YUJ
         j1qDN90a2h9JQ==
Received: by mail-ed1-f70.google.com with SMTP id r14-20020aa7cfce000000b0042bcefd6109so840237edy.13
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 08:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fsgCZw/xRNXiy6OJN4APf5lDTp10s7xR3Y+a1NWVZTo=;
        b=Pxlu6sWzc+RTVelbIboXttnuMinNULp/DkPy0z3UyQ4OLKuMdN+9s0Jm5Ku8KhWOtf
         N7gkKxqOn7Ijxn8kS1tjH8Weade0iemsuyRkdoup9wSV2AWar/bg2ALhO241sA0cb2SI
         SOuOwi1W0gCTlOndyrzYRhofqePAouDMn5+eVyiuwXh7u4lXQwDRpLhXdyf0uQzgklEh
         AasUADUqt5YGBCG/beSDgMZZmLOoQHOz8BDJS2WirzuEXj8jLCHI6zCsHmB4e5cJvgkG
         wSzDIkvDdhUxnuqcwStLA7rwPSVqM2sB7yo1CTF2DVe06h053vJAsmMKvLnW7Ik+5kZS
         /5QA==
X-Gm-Message-State: AOAM533805bo0KeIl5ROGFyWXnNIGo1Qk09ACCueEw1uvjSIxBYFY9Y7
        7Dvlp02Fzkt88SF9ojx5cYd5LDWoeaBF7nC8DMOe6U4N7gMuIA90XXGIxoIwxdrK4VCPMK5tovM
        NqEzZgs3KJIEkr4DuFMod8HP2OjurXc40fDqSvw==
X-Received: by 2002:a17:906:5d10:b0:6f4:e263:b574 with SMTP id g16-20020a1709065d1000b006f4e263b574mr30507999ejt.435.1653491839757;
        Wed, 25 May 2022 08:17:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGEBbYA4ZthguX/6ezk6GsjZqOLHUOp5YalEv0cGTth685wa7GG2o5INcUqyTuzNjzdCdFVA==
X-Received: by 2002:a17:906:5d10:b0:6f4:e263:b574 with SMTP id g16-20020a1709065d1000b006f4e263b574mr30507981ejt.435.1653491839485;
        Wed, 25 May 2022 08:17:19 -0700 (PDT)
Received: from [192.168.123.67] (ip-062-143-094-109.um16.pools.vodafone-ip.de. [62.143.94.109])
        by smtp.gmail.com with ESMTPSA id y16-20020a056402271000b0042b6a84b230sm4559765edd.90.2022.05.25.08.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 08:17:18 -0700 (PDT)
Message-ID: <09b050e3-b8e2-fc58-c4cf-e1c81c5eac84@canonical.com>
Date:   Wed, 25 May 2022 17:17:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/5] riscv: cpu_ops_sbi: Support for 64bit hartid
Content-Language: en-US
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Sunil V L <sunil.vl@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
 <20220525151106.2176147-2-sunilvl@ventanamicro.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20220525151106.2176147-2-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/25/22 17:11, Sunil V L wrote:
> The hartid can be a 64bit value on RV64 platforms. This patch modifies
> the hartid variable type to unsigned long so that it can hold 64bit
> value on RV64 platforms.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   arch/riscv/kernel/cpu_ops_sbi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
> index 4f5a6f84e2a4..efa0f0816634 100644
> --- a/arch/riscv/kernel/cpu_ops_sbi.c
> +++ b/arch/riscv/kernel/cpu_ops_sbi.c
> @@ -65,7 +65,7 @@ static int sbi_hsm_hart_get_status(unsigned long hartid)
>   static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
>   {
>   	unsigned long boot_addr = __pa_symbol(secondary_start_sbi);
> -	int hartid = cpuid_to_hartid_map(cpuid);
> +	unsigned long hartid = cpuid_to_hartid_map(cpuid);
>   	unsigned long hsm_data;
>   	struct sbi_hart_boot_data *bdata = &per_cpu(boot_data, cpuid);
>   
> @@ -107,7 +107,7 @@ static void sbi_cpu_stop(void)
>   static int sbi_cpu_is_stopped(unsigned int cpuid)
>   {
>   	int rc;
> -	int hartid = cpuid_to_hartid_map(cpuid);
> +	unsigned long hartid = cpuid_to_hartid_map(cpuid);
>   
>   	rc = sbi_hsm_hart_get_status(hartid);
>   

