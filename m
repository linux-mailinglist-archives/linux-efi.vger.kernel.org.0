Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBBB5340EB
	for <lists+linux-efi@lfdr.de>; Wed, 25 May 2022 18:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245429AbiEYP7S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 May 2022 11:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245386AbiEYP7G (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 May 2022 11:59:06 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC71B36FE
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 08:59:03 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9E0543F804
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653494341;
        bh=ceTyIPuj0mdwf7qJM6JGPSBEklD8LtuaTMx0pA8AGQY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=XfoJSqIZdov5QHGY/D4uU2Lwk8ZpZOGG3NWWi3JxYb2mlR8qMtQ8mrNEtRtVgHYD/
         KPk+7DYI6tMKAnbWIBDQBq2I7vBX16isGsdA1AX8ry1IwNaVuivVEyyhpZNOb47iib
         J0mPWe0apCmzGuEjWTMurNk/pDIMgPSlRRT+a5fef/UiLR0ZnXDtbPE6hMm4GIJLg4
         YuCWVvn4vGTjjprBElh3ZKwAtKvKJ6ydkebwuMaakGYOqWGmCkUgQ7eDxlJUvX7tYh
         VKOGzBTE6mnswQDBIar9NSnpdlcKTbJ/hiib4l9teRH2ptco56bjWiE96ZwSb8uJsM
         /1Fcppbl0zVKg==
Received: by mail-ed1-f71.google.com with SMTP id u1-20020aa7d981000000b0042acd1f2253so15136352eds.4
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 08:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ceTyIPuj0mdwf7qJM6JGPSBEklD8LtuaTMx0pA8AGQY=;
        b=Fm/x64pUN7i10jixOFbx503J+3DZAQixPD78O07NYvZeqagdjfo29Z8p/nvnKdXvVM
         49a9BHGzjaj1v3DH/9JTblSGQGvlPaNV2DqToUOvh5lFQjF9R3eC0vIPpqTAoAiLSDJ8
         I2Xhr+qnZR8NHiVd+7uMjnSypcDNZXIbuUQphYfjAKCKfEj4Vf4MUo1P+PorTyqkD08z
         laoZJxlxShUZabUlqnOlkLZiAikM9GvdOa/DpAoAnP7vlhxyvvtVBdBaIsEzsMwJbQI1
         xgsGOZXOlLb5jWQJEe62t1mdfQVk6h84ab1g++UPAuyDtbKHv5H04C3nZu4+WM5fXAoD
         vzXQ==
X-Gm-Message-State: AOAM53312jChiFkhUE3CTdMC6zccNsooXDX7vMHj8uhlxIeH2S7LL3+M
        dbQO77PdHLmPlCo1FaIysqCK1udDhZtVTDgKJgJM90XxYNT72OQj7/pWX7hJPCZEWPFkDtOh3Bq
        yqp8fr3PS+n8/4pHyAZA/Me0PYTRKF7FuTWOUYw==
X-Received: by 2002:aa7:c615:0:b0:42b:cdcc:5844 with SMTP id h21-20020aa7c615000000b0042bcdcc5844mr2769931edq.312.1653494339816;
        Wed, 25 May 2022 08:58:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx94oaHZAUQqbKeS616bkQPP3+D2aG2FQiBBhy3mgd3CzCggc7oTgSKb95EHir2Xerc0gQJxg==
X-Received: by 2002:aa7:c615:0:b0:42b:cdcc:5844 with SMTP id h21-20020aa7c615000000b0042bcdcc5844mr2769909edq.312.1653494339621;
        Wed, 25 May 2022 08:58:59 -0700 (PDT)
Received: from [192.168.123.67] (ip-062-143-094-109.um16.pools.vodafone-ip.de. [62.143.94.109])
        by smtp.gmail.com with ESMTPSA id my44-20020a1709065a6c00b006f3ef214de4sm7747900ejc.74.2022.05.25.08.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 08:58:59 -0700 (PDT)
Message-ID: <fff02688-e272-3462-d950-427ebe4ad862@canonical.com>
Date:   Wed, 25 May 2022 17:58:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/5] riscv: smp: Support for 64bit hartid
Content-Language: en-US
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Sunil V L <sunil.vl@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Marc Zyngier <maz@kernel.org>
References: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
 <20220525151106.2176147-4-sunilvl@ventanamicro.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20220525151106.2176147-4-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/25/22 17:11, Sunil V L wrote:
> The hartid can be a 64bit value on RV64 platforms. This patch
> modifies the hartid parameter in riscv_hartid_to_cpuid() as
> unsigned long so that it can hold 64bit value on RV64 platforms.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   arch/riscv/include/asm/smp.h | 4 ++--
>   arch/riscv/kernel/smp.c      | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 23170c933d73..d3443be7eedc 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -42,7 +42,7 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask);
>   /* Hook for the generic smp_call_function_single() routine. */
>   void arch_send_call_function_single_ipi(int cpu);
>   
> -int riscv_hartid_to_cpuid(int hartid);
> +int riscv_hartid_to_cpuid(unsigned long hartid);
>   
>   /* Set custom IPI operations */
>   void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops);
> @@ -70,7 +70,7 @@ static inline void show_ipi_stats(struct seq_file *p, int prec)
>   {
>   }
>   
> -static inline int riscv_hartid_to_cpuid(int hartid)
> +static inline int riscv_hartid_to_cpuid(unsigned long hartid)
>   {
>   	if (hartid == boot_cpu_hartid)
>   		return 0;
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index b5d30ea92292..018e7dc45df6 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -47,7 +47,7 @@ static struct {
>   	unsigned long bits ____cacheline_aligned;
>   } ipi_data[NR_CPUS] __cacheline_aligned;
>   
> -int riscv_hartid_to_cpuid(int hartid)
> +int riscv_hartid_to_cpuid(unsigned long hartid)
>   {
>   	int i;
>   
> @@ -55,7 +55,7 @@ int riscv_hartid_to_cpuid(int hartid)
>   		if (cpuid_to_hartid_map(i) == hartid)
>   			return i;
>   
> -	pr_err("Couldn't find cpu id for hartid [%d]\n", hartid);
> +	pr_err("Couldn't find cpu id for hartid [%lu]\n", hartid);
>   	return -ENOENT;
>   }
>   

