Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA2957B01B
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jul 2022 06:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiGTErB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jul 2022 00:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiGTErA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Jul 2022 00:47:00 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676415B784
        for <linux-efi@vger.kernel.org>; Tue, 19 Jul 2022 21:46:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g126so15528850pfb.3
        for <linux-efi@vger.kernel.org>; Tue, 19 Jul 2022 21:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=VtF9+07gASHhrIu6wD3FN1xOsSjHByW20JZ9pcO8ds0=;
        b=fjQHDQLqh1A1CvsX2jafefzTGE36QKfdh3Qilgur+BwmX5uXp/iLBU4QybnFkKJVmG
         pNABvDJrsAlwuXpzvTuIT5usg1eR++fZZZDamrFa8h3thcwUlBZnsOBf1ZmrICn3YSTj
         T0Kcbxh3rIDHWJhYw3iXXLT9ja0KNaFgSGnuvEtGxH4R/1Yh/BHxeozZpnxsnFbA1soR
         CDjSmGCruHE6nPmvn3/nPRAo6knbDZsoTXhw1FiwBGAm7jrQynzd6Eef+IE5+7qEdZPq
         F9/35voq1+L1YkK0ibuaWgdnaDue1kGCBYqcebE+hQUo1D55mIvHYG0osACVHYXl0rGL
         uCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=VtF9+07gASHhrIu6wD3FN1xOsSjHByW20JZ9pcO8ds0=;
        b=L8SApChQNBP/GjnCnJFuGDW9EYtiWMrQmwGu4x00PGIFVfXMZ+Ii7Kl7j1vJhQQXeg
         nmW/4spTe/8M6OSiuomMG7pIG4fAtBOxLIhXsDppuFkSNb22AGpyBzCygeF4y9alfH/U
         jHTZGRt97uMTGJXPD86gP5Q5OnQ1TZzDiWvzTrgtKAxHCi9qCjUlksGamRTkOiBBWzP8
         miLgGBzfbwDwWkrgk59J13Oov9cyypeMEHldRWrKOMj1/BecrJwsPmtdsYFGRtycifKV
         VOJLPwU3PSblWGGDjksstCc+iq6KTQN/2biGu9+FazKmHFWqvBRi92w8aHG0AyL0XL/A
         Mhdw==
X-Gm-Message-State: AJIora9w1DpSDlHPMqf5ftpNupCeAgToDD8XkYu6coyAvAPGJf9gk/vZ
        +M6Qo4hXVP9KluZpEvDPwE3uIKSdl0v3qg==
X-Google-Smtp-Source: AGRyM1vlzCdD69HQD5gb1Q92kSqgBlWCPv0ppUY5psQ46BDf24I6J7L22UUFB0Qj3qfpd4QsIhj9Eg==
X-Received: by 2002:a05:6a00:134e:b0:52a:d5b4:19bb with SMTP id k14-20020a056a00134e00b0052ad5b419bbmr37009701pfu.45.1658292417692;
        Tue, 19 Jul 2022 21:46:57 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090a4b8500b001f0097c2fb2sm481628pjh.28.2022.07.19.21.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 21:46:56 -0700 (PDT)
Date:   Tue, 19 Jul 2022 21:46:56 -0700 (PDT)
X-Google-Original-Date: Tue, 19 Jul 2022 21:16:19 PDT (-0700)
Subject:     Re: [PATCH V3 0/5] Support for 64bit hartid on RV64 platforms
In-Reply-To: <20220527051743.2829940-1-sunilvl@ventanamicro.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, tglx@linutronix.de, ardb@kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        heinrich.schuchardt@canonical.com, apatel@ventanamicro.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, sunil.vl@gmail.com,
        sunilvl@ventanamicro.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sunilvl@ventanamicro.com
Message-ID: <mhng-4c49edf1-6367-4dd0-bec7-c6719745ecb5@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 26 May 2022 22:17:38 PDT (-0700), sunilvl@ventanamicro.com wrote:
> The hartid can be a 64bit value on RV64 platforms. This series updates
> the code so that 64bit hartid can be supported on RV64 platforms.
>
> The series has been tested on both RV32 and RV64 qemu platforms.
>
> Changes since V2:
> 	1) Modified commit messages to mention RV64 and add RB tags.
>
> Changes since V1:
> 	1) Updated RB tag for PATCH 1 and PATCH3
> 	2) Type Casting NR_CPUS before comparing with hartid in PATCH 2
> 	3) Changed commit message of PATCH 2 to provide details about
> 	   the bug it is fixing.
> 	4) Updated PATCH 5 for unaligned 64bit read
>
>
> Sunil V L (5):
>   riscv: cpu_ops_sbi: Add 64bit hartid support on RV64
>   riscv: spinwait: Fix hartid variable type
>   riscv: smp: Add 64bit hartid support on RV64
>   riscv: cpu: Add 64bit hartid support on RV64
>   riscv/efi_stub: Add 64bit boot-hartid support on RV64
>
>  arch/riscv/include/asm/processor.h        |  4 ++--
>  arch/riscv/include/asm/smp.h              |  4 ++--
>  arch/riscv/kernel/cpu.c                   | 26 +++++++++++++----------
>  arch/riscv/kernel/cpu_ops_sbi.c           |  4 ++--
>  arch/riscv/kernel/cpu_ops_spinwait.c      |  4 ++--
>  arch/riscv/kernel/cpufeature.c            |  6 ++++--
>  arch/riscv/kernel/smp.c                   |  4 ++--
>  arch/riscv/kernel/smpboot.c               |  9 ++++----
>  drivers/clocksource/timer-riscv.c         | 15 +++++++------
>  drivers/firmware/efi/libstub/riscv-stub.c | 13 +++++++++---
>  drivers/irqchip/irq-riscv-intc.c          |  7 +++---
>  drivers/irqchip/irq-sifive-plic.c         |  7 +++---
>  12 files changed, 60 insertions(+), 43 deletions(-)

Thanks, this is on for-next.
