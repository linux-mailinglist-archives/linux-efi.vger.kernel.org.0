Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660FF53562F
	for <lists+linux-efi@lfdr.de>; Fri, 27 May 2022 00:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345350AbiEZWyg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 May 2022 18:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349375AbiEZWyf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 May 2022 18:54:35 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBF2EABBA
        for <linux-efi@vger.kernel.org>; Thu, 26 May 2022 15:54:34 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ef5380669cso30579807b3.9
        for <linux-efi@vger.kernel.org>; Thu, 26 May 2022 15:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9bg+crCjcsCCT/8h3P6Is3peQSYKpx7Yjut2+MuLpo=;
        b=J9BFbfwXM92YHYo1pMX9ukbHtBF65rYzCKp1SEODqtfOWVCqvC1kpJ6Gx+6e25KsXx
         7dXCLexRSucYejUcHQzOHbDQkvIK0DDJ1C4R9pGPO9oJyX8xhIz0VeZLSF84V61l4zzO
         gI/sGQb0hwqh6SzlSHeraOUVufItGmBY08l/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9bg+crCjcsCCT/8h3P6Is3peQSYKpx7Yjut2+MuLpo=;
        b=2mrxLZsgkheQJ0qyzG3eWFE/M+Mtjr1iv7uxqLlO8h6pHXOkObzo4mzpLjSov4Nq7N
         7GsIPAwy7L6AxDilaL/JpKLNDtLBIPp4MkDT5tDF6de/LIrG0Ov+yhpfor6CJ0DojSi7
         RZ88pbiHB+O5eMpDNU/sIEPJd3KQ+Lre4M2ApPZdYlBYFSCjj3faf4bckEbZP/BU1M+0
         dQk7B7wx5Z/3Vv5KAmtXvHC6KYLQ6agN3jMUUcGZ5I2VF7foB6xo9CR9UX2p9ZxgYBjs
         Q7yjEOU8jZMX9URoFAW0e8rf0UsjziLC+//Tw3lFP4Wj15Gon5KlRS+yHnopxVZRqIVV
         oPAA==
X-Gm-Message-State: AOAM532I8t2UxvLZAAKxw0kg3N5kHBdXA1HBCRugtq4ni83GrUMXQLSy
        A1U/i1LMq7iLMVDqLZZ5PXOMCFhpkWRph3IGVYIv
X-Google-Smtp-Source: ABdhPJzygxe4mJbRicGsvX2RuWGHFEoIpEz1ZlS3KbXSJc+1j/7lums2g1CvEJbfk0hVJxaHTik5jNooh1w7+04S4Jg=
X-Received: by 2002:a81:238e:0:b0:300:642f:fdb2 with SMTP id
 j136-20020a81238e000000b00300642ffdb2mr8594216ywj.373.1653605673706; Thu, 26
 May 2022 15:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220526101131.2340729-1-sunilvl@ventanamicro.com> <20220526101131.2340729-2-sunilvl@ventanamicro.com>
In-Reply-To: <20220526101131.2340729-2-sunilvl@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 26 May 2022 15:54:22 -0700
Message-ID: <CAOnJCUJNScpqEY=j6CYFyqea-+GR9J6wLFH6TFG1wvhHwOMtbQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/5] riscv: cpu_ops_sbi: Support for 64bit hartid
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Sunil V L <sunil.vl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 26, 2022 at 3:11 AM Sunil V L <sunilvl@ventanamicro.com> wrote:
>
> The hartid can be a 64bit value on RV64 platforms. This patch modifies
> the hartid variable type to unsigned long so that it can hold 64bit
> value on RV64 platforms.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/kernel/cpu_ops_sbi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
> index 4f5a6f84e2a4..efa0f0816634 100644
> --- a/arch/riscv/kernel/cpu_ops_sbi.c
> +++ b/arch/riscv/kernel/cpu_ops_sbi.c
> @@ -65,7 +65,7 @@ static int sbi_hsm_hart_get_status(unsigned long hartid)
>  static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
>  {
>         unsigned long boot_addr = __pa_symbol(secondary_start_sbi);
> -       int hartid = cpuid_to_hartid_map(cpuid);
> +       unsigned long hartid = cpuid_to_hartid_map(cpuid);
>         unsigned long hsm_data;
>         struct sbi_hart_boot_data *bdata = &per_cpu(boot_data, cpuid);
>
> @@ -107,7 +107,7 @@ static void sbi_cpu_stop(void)
>  static int sbi_cpu_is_stopped(unsigned int cpuid)
>  {
>         int rc;
> -       int hartid = cpuid_to_hartid_map(cpuid);
> +       unsigned long hartid = cpuid_to_hartid_map(cpuid);
>
>         rc = sbi_hsm_hart_get_status(hartid);
>
> --
> 2.25.1
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
-- 
Regards,
Atish
