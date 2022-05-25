Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B743953405C
	for <lists+linux-efi@lfdr.de>; Wed, 25 May 2022 17:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiEYP14 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 May 2022 11:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiEYP1z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 May 2022 11:27:55 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08982F03F
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 08:27:54 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 806C13F6F8
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653492473;
        bh=56sEzsfe9fPL+dqkAvgXm6tKeKfT2Xup4I6lOsE7aaY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=idBUkHYWBezSzRIY2iKqoRzUyhsHGSay9uNiMthIW7EHtLFohZ6um/Nu2P/PGNKBU
         Vap75j4cDPui7XJ12m0oIq5UR4euLtaDcH4gIAZw+/0H2/wLPKSnF9i7lvtM0ISE/9
         wNQJgEpEKBH4YK11FjDdpEyru2G1ZtGZA3oLzeZ2XJ9uNbjCoIp/rrKO2sw0jVUeXu
         vlEooRX/9FBRxCMTQoMe0HcAzTxqHsSJrkJjFk5Q8kPZ6AXr6fn36GRwIVa3/Lc9Ax
         bxiAXpVigwBEmudXMdQ+hDwyIKrjMPtOo7ZVIpMnWfCBiFCnqeibTn78AZkhpeTS1g
         4mSIeTDX2mKZQ==
Received: by mail-ej1-f69.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso9710893ejs.12
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 08:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=56sEzsfe9fPL+dqkAvgXm6tKeKfT2Xup4I6lOsE7aaY=;
        b=2FEhQuQcapXLRlFk9xfomVvOGsTyRs/kEWU2q94ZUm2v2yK0fAa6uqHyYQPXfIfhA/
         SoOU2Qt8E73rY9hL8BoaTip4vB09rSAjCcCHwNBYbv6T2aFit7om3wlEPKdxm3Aajm55
         cFFdpTHzNEXZLyT4wVba5q5dIYW6CkcPGgM3s6lCc9yGPP4+WnpcVXWMtEHRXswUKIs7
         XbCzaF2WMpFHAXWiXMKud+kuLMgRLDs0yG18zYW2NCLtBynSgzwaWARgnBPM51wRt3Zg
         NOBk0nRJyO/OjF4q4ck1lti6jnBEZbbqIkoTX/1dVPed5AMgIuXnpdPmFXxW5AXA2XdS
         3Vdw==
X-Gm-Message-State: AOAM530DbdSRJA7oHmbB5N+QIpT/lePPasou2pn0Z/LTz0E+2V0spn8a
        Kx0AHchkdelA6Ry80xIb+/Thd/K4KjhOa7zYmD3d3lNvM8SzEOH9JHnbDjhT97Ujtqjh4Qv5H5K
        4iknkhA7cNNFEIXJWom6P1hC3aPx5MQ64EYlgvQ==
X-Received: by 2002:a05:6402:c1:b0:42a:b8a5:8d5e with SMTP id i1-20020a05640200c100b0042ab8a58d5emr35551080edu.266.1653492472951;
        Wed, 25 May 2022 08:27:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMgUBU4W0WxQRyLzKq/RFbQUPt10kiAPkQG+6E6TfHVPoTMm1PohbGn87/ilCtMwv+r912wA==
X-Received: by 2002:a05:6402:c1:b0:42a:b8a5:8d5e with SMTP id i1-20020a05640200c100b0042ab8a58d5emr35551049edu.266.1653492472640;
        Wed, 25 May 2022 08:27:52 -0700 (PDT)
Received: from [192.168.123.67] (ip-062-143-094-109.um16.pools.vodafone-ip.de. [62.143.94.109])
        by smtp.gmail.com with ESMTPSA id s25-20020a1709066c9900b006fefd1d5c2bsm2246992ejr.148.2022.05.25.08.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 08:27:52 -0700 (PDT)
Message-ID: <a7910ff4-0bce-befa-f961-a82a8a1025a1@canonical.com>
Date:   Wed, 25 May 2022 17:27:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/5] riscv: cpu_ops_spinwait: Support for 64bit hartid
Content-Language: en-US
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Sunil V L <sunil.vl@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atishp@rivosinc.com>
References: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
 <20220525151106.2176147-3-sunilvl@ventanamicro.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20220525151106.2176147-3-sunilvl@ventanamicro.com>
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
> ---
>   arch/riscv/kernel/cpu_ops_spinwait.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/cpu_ops_spinwait.c b/arch/riscv/kernel/cpu_ops_spinwait.c
> index 346847f6c41c..51ac07514a62 100644
> --- a/arch/riscv/kernel/cpu_ops_spinwait.c
> +++ b/arch/riscv/kernel/cpu_ops_spinwait.c
> @@ -18,7 +18,7 @@ void *__cpu_spinwait_task_pointer[NR_CPUS] __section(".data");
>   static void cpu_update_secondary_bootdata(unsigned int cpuid,
>   				   struct task_struct *tidle)
>   {
> -	int hartid = cpuid_to_hartid_map(cpuid);
> +	unsigned long hartid = cpuid_to_hartid_map(cpuid);
>   
>   	/*
>   	 * The hartid must be less than NR_CPUS to avoid out-of-bound access

This line follows:

if (hartid == INVALID_HARTID || hartid >= NR_CPUS)

INVALID_HARTID is defined as ULONG_MAX. Please, mention that you are 
fixing a bug:

Fixes: c78f94f35cf648 ("RISC-V: Use __cpu_up_stack/task_pointer only for 
spinwait method")

NR_CPUS alias CONFIG_NR_CPUS is an int. You should convert it to 
unsigned before comparing it to hartid to avoid build warnings.

Best regards

Heinrich

