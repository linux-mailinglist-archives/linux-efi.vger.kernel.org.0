Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF34535650
	for <lists+linux-efi@lfdr.de>; Fri, 27 May 2022 01:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348675AbiEZXLH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 May 2022 19:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343802AbiEZXLF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 May 2022 19:11:05 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D33E5292
        for <linux-efi@vger.kernel.org>; Thu, 26 May 2022 16:11:03 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id p190so5267834ybg.4
        for <linux-efi@vger.kernel.org>; Thu, 26 May 2022 16:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZGHCrVooSnSaBJ1421cdSzd5G9rFzpjX8shobVkaIAE=;
        b=CNB3Gg6aJRwKV16DL8AAN/YunIfAda6Vh9mqkSZCekmqTFGMjI1PDLrJ/smmpyHE3r
         3VFTaijeamOq6xQ8/f2+qBwbPd/Hhg/Y1XNWie+qIkrQFHWVWSnQV32vNgqyIfNy9I56
         ofuaINcaI1yl19rqqKgGy4NsO1DhJf6rB2mII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZGHCrVooSnSaBJ1421cdSzd5G9rFzpjX8shobVkaIAE=;
        b=c548hBldnVWiWCmRbhGTmPUmPizAq46e3MPoyRuWjo6Qqh7jIgUNE42uEYgPqiE3w8
         BwbCnLbsGfJ4Wlirc1dMR+OtKJHabLEqsI8hT6zdXQaSsyZyw7cr6fdAboXU6LH4T7Jf
         l64Q4W6G8MySTW+d4d8TeQuKaMUS+9v8duVK11ZczA5OsW7C4G/YI71D9lql5RPTrIdg
         cOSkDB8B8cnK/QVpJpxxkGTPgY15zhqlKI55XGdJ6e5w3m4IFaecYv9GwIq8mDDehmoT
         1MPZrUc70HYzP9PLxaxAiaDaCZMtNTYtN1mVfDoj2BZgCW0c/yj1ODLuHO4vft9w0GN1
         4cdQ==
X-Gm-Message-State: AOAM5306plJUF1ptQcqbvhH8kUcibH8s1VP8B2Z4+ewfVnAcYQM3kuxM
        hT/ovC/qk3I1DE0dKgtj174fM/WCy3jDmypHcrqK
X-Google-Smtp-Source: ABdhPJxJN6oR7TiPQiZZsdfDVQFBZiYmY2m6PO9s1blTb9p/1fd91v+tSeVsebHz5ukXQs4rSPrOywCpXnYquCDswZ8=
X-Received: by 2002:a25:7c87:0:b0:655:f062:e8c5 with SMTP id
 x129-20020a257c87000000b00655f062e8c5mr9564995ybc.603.1653606662601; Thu, 26
 May 2022 16:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220526101131.2340729-1-sunilvl@ventanamicro.com> <20220526101131.2340729-5-sunilvl@ventanamicro.com>
In-Reply-To: <20220526101131.2340729-5-sunilvl@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 26 May 2022 16:10:51 -0700
Message-ID: <CAOnJCU+eutRHEEgXi8od+xY+0AyWj117MDwjY-hFVO3ZDjf1bg@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] riscv: cpu: Support for 64bit hartid
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

On Thu, May 26, 2022 at 3:12 AM Sunil V L <sunilvl@ventanamicro.com> wrote:
>
> Adds support for 64bit hartid in riscv_of_processor_hartid()

The commit text is a bit misleading as you are adding support for XLEN
hartid. For RV32, it is still 32bit.
This applies to the entire series.

>   - Separate return value and status code.
>   - Make hartid variable type as unsigned long.
>   - Update the callers.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/include/asm/processor.h |  4 ++--
>  arch/riscv/kernel/cpu.c            | 26 +++++++++++++++-----------
>  arch/riscv/kernel/cpufeature.c     |  6 ++++--
>  arch/riscv/kernel/smpboot.c        |  9 +++++----
>  drivers/clocksource/timer-riscv.c  | 15 ++++++++-------
>  drivers/irqchip/irq-riscv-intc.c   |  7 ++++---
>  drivers/irqchip/irq-sifive-plic.c  |  7 ++++---
>  7 files changed, 42 insertions(+), 32 deletions(-)
>
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 0749924d9e55..99fae9398506 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -75,8 +75,8 @@ static inline void wait_for_interrupt(void)
>  }
>
>  struct device_node;
> -int riscv_of_processor_hartid(struct device_node *node);
> -int riscv_of_parent_hartid(struct device_node *node);
> +int riscv_of_processor_hartid(struct device_node *node, unsigned long *hartid);
> +int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid);
>
>  extern void riscv_fill_hwcap(void);
>  extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index ccb617791e56..477a33b34c95 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -14,37 +14,36 @@
>   * Returns the hart ID of the given device tree node, or -ENODEV if the node
>   * isn't an enabled and valid RISC-V hart node.
>   */
> -int riscv_of_processor_hartid(struct device_node *node)
> +int riscv_of_processor_hartid(struct device_node *node, unsigned long *hart)
>  {
>         const char *isa;
> -       u32 hart;
>
>         if (!of_device_is_compatible(node, "riscv")) {
>                 pr_warn("Found incompatible CPU\n");
>                 return -ENODEV;
>         }
>
> -       hart = of_get_cpu_hwid(node, 0);
> -       if (hart == ~0U) {
> +       *hart = (unsigned long) of_get_cpu_hwid(node, 0);
> +       if (*hart == ~0UL) {
>                 pr_warn("Found CPU without hart ID\n");
>                 return -ENODEV;
>         }
>
>         if (!of_device_is_available(node)) {
> -               pr_info("CPU with hartid=%d is not available\n", hart);
> +               pr_info("CPU with hartid=%lu is not available\n", *hart);
>                 return -ENODEV;
>         }
>
>         if (of_property_read_string(node, "riscv,isa", &isa)) {
> -               pr_warn("CPU with hartid=%d has no \"riscv,isa\" property\n", hart);
> +               pr_warn("CPU with hartid=%lu has no \"riscv,isa\" property\n", *hart);
>                 return -ENODEV;
>         }
>         if (isa[0] != 'r' || isa[1] != 'v') {
> -               pr_warn("CPU with hartid=%d has an invalid ISA of \"%s\"\n", hart, isa);
> +               pr_warn("CPU with hartid=%lu has an invalid ISA of \"%s\"\n", *hart, isa);
>                 return -ENODEV;
>         }
>
> -       return hart;
> +       return 0;
>  }
>
>  /*
> @@ -53,11 +52,16 @@ int riscv_of_processor_hartid(struct device_node *node)
>   * To achieve this, we walk up the DT tree until we find an active
>   * RISC-V core (HART) node and extract the cpuid from it.
>   */
> -int riscv_of_parent_hartid(struct device_node *node)
> +int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
>  {
> +       int rc;
> +
>         for (; node; node = node->parent) {
> -               if (of_device_is_compatible(node, "riscv"))
> -                       return riscv_of_processor_hartid(node);
> +               if (of_device_is_compatible(node, "riscv")) {
> +                       rc = riscv_of_processor_hartid(node, hartid);
> +                       if (!rc)
> +                               return 0;
> +               }
>         }
>
>         return -1;
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 1b2d42d7f589..49c05bd9352d 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -67,8 +67,9 @@ void __init riscv_fill_hwcap(void)
>         struct device_node *node;
>         const char *isa;
>         char print_str[NUM_ALPHA_EXTS + 1];
> -       int i, j;
> +       int i, j, rc;
>         static unsigned long isa2hwcap[256] = {0};
> +       unsigned long hartid;
>
>         isa2hwcap['i'] = isa2hwcap['I'] = COMPAT_HWCAP_ISA_I;
>         isa2hwcap['m'] = isa2hwcap['M'] = COMPAT_HWCAP_ISA_M;
> @@ -86,7 +87,8 @@ void __init riscv_fill_hwcap(void)
>                 DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
>                 const char *temp;
>
> -               if (riscv_of_processor_hartid(node) < 0)
> +               rc = riscv_of_processor_hartid(node, &hartid);
> +               if (rc < 0)
>                         continue;
>
>                 if (of_property_read_string(node, "riscv,isa", &isa)) {
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 622f226454d5..4336610a19ee 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -76,15 +76,16 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  void __init setup_smp(void)
>  {
>         struct device_node *dn;
> -       int hart;
> +       unsigned long hart;
>         bool found_boot_cpu = false;
>         int cpuid = 1;
> +       int rc;
>
>         cpu_set_ops(0);
>
>         for_each_of_cpu_node(dn) {
> -               hart = riscv_of_processor_hartid(dn);
> -               if (hart < 0)
> +               rc = riscv_of_processor_hartid(dn, &hart);
> +               if (rc < 0)
>                         continue;
>
>                 if (hart == cpuid_to_hartid_map(0)) {
> @@ -94,7 +95,7 @@ void __init setup_smp(void)
>                         continue;
>                 }
>                 if (cpuid >= NR_CPUS) {
> -                       pr_warn("Invalid cpuid [%d] for hartid [%d]\n",
> +                       pr_warn("Invalid cpuid [%d] for hartid [%lu]\n",
>                                 cpuid, hart);
>                         continue;
>                 }
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 1767f8bf2013..55142c27f0bc 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -101,20 +101,21 @@ static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
>
>  static int __init riscv_timer_init_dt(struct device_node *n)
>  {
> -       int cpuid, hartid, error;
> +       int cpuid, error;
> +       unsigned long hartid;
>         struct device_node *child;
>         struct irq_domain *domain;
>
> -       hartid = riscv_of_processor_hartid(n);
> -       if (hartid < 0) {
> -               pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
> +       error = riscv_of_processor_hartid(n, &hartid);
> +       if (error < 0) {
> +               pr_warn("Not valid hartid for node [%pOF] error = [%lu]\n",
>                         n, hartid);
> -               return hartid;
> +               return error;
>         }
>
>         cpuid = riscv_hartid_to_cpuid(hartid);
>         if (cpuid < 0) {
> -               pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
> +               pr_warn("Invalid cpuid for hartid [%lu]\n", hartid);
>                 return cpuid;
>         }
>
> @@ -140,7 +141,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>                 return -ENODEV;
>         }
>
> -       pr_info("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
> +       pr_info("%s: Registering clocksource cpuid [%d] hartid [%lu]\n",
>                __func__, cpuid, hartid);
>         error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);
>         if (error) {
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> index b65bd8878d4f..499e5f81b3fe 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -95,10 +95,11 @@ static const struct irq_domain_ops riscv_intc_domain_ops = {
>  static int __init riscv_intc_init(struct device_node *node,
>                                   struct device_node *parent)
>  {
> -       int rc, hartid;
> +       int rc;
> +       unsigned long hartid;
>
> -       hartid = riscv_of_parent_hartid(node);
> -       if (hartid < 0) {
> +       rc = riscv_of_parent_hartid(node, &hartid);
> +       if (rc < 0) {
>                 pr_warn("unable to find hart id for %pOF\n", node);
>                 return 0;
>         }
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index bb87e4c3b88e..4710d9741f36 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -317,7 +317,8 @@ static int __init plic_init(struct device_node *node,
>         for (i = 0; i < nr_contexts; i++) {
>                 struct of_phandle_args parent;
>                 irq_hw_number_t hwirq;
> -               int cpu, hartid;
> +               int cpu;
> +               unsigned long hartid;
>
>                 if (of_irq_parse_one(node, i, &parent)) {
>                         pr_err("failed to parse parent for context %d.\n", i);
> @@ -341,8 +342,8 @@ static int __init plic_init(struct device_node *node,
>                         continue;
>                 }
>
> -               hartid = riscv_of_parent_hartid(parent.np);
> -               if (hartid < 0) {
> +               error = riscv_of_parent_hartid(parent.np, &hartid);
> +               if (error < 0) {
>                         pr_warn("failed to parse hart ID for context %d.\n", i);
>                         continue;
>                 }
> --
> 2.25.1
>

Otherwise, it looks good.

Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
