Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17BB7C6DBB
	for <lists+linux-efi@lfdr.de>; Thu, 12 Oct 2023 14:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347216AbjJLMOY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Oct 2023 08:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347214AbjJLMOX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Oct 2023 08:14:23 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9079ABA
        for <linux-efi@vger.kernel.org>; Thu, 12 Oct 2023 05:14:21 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7b5fd0b7522so388908241.0
        for <linux-efi@vger.kernel.org>; Thu, 12 Oct 2023 05:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697112860; x=1697717660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uIVKgMbPrdbBiBUZkSG3/934vJNvcwEmUkQTpoFMZCk=;
        b=S4j+QVXjMd45R/VsU35Ht0vsq4T5CVBnpFinZ6DEBTdmseVNJiOroQqa3kk/I20j9r
         V8kWBhtg8LxsIFa2MeEzZnoCxfPxxkK1CpQLUhXsv0cW2VRMU7m9FZ2oih2rqPpon08u
         K8VzrWekTog4muxMx3NVUb7LaSQKeny09tFDTnGrkjQQDkJICbgRn4gD94Hpw0JyDUF2
         MQFXXwZsAZqQ4mIqa4+iZPtNTd4R0GcPeDUVWtRBiindr4E1DMv8BLG8d16IbKuiNg4Q
         ChD6RYk7oEhKu2FVz9lixT/Z3LERnj4oZPUmayAtUsWB3Jn+h7eodd+xKU7FBxf4cO0H
         m8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697112860; x=1697717660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIVKgMbPrdbBiBUZkSG3/934vJNvcwEmUkQTpoFMZCk=;
        b=j4fjIGMTo1tCj2ZldE63EdICRy9wxetGMTRLYL5kPqJPs/Vobz1Qtkn6EN2Q6512yF
         S+AKa5gNMR7nZ5DQEYuoGMgHUg4k5BEjwgLjZX0L6FGDlqUse+4w6PYwejvDLrDy5/Xv
         GAYcypCvp89hoPylLqegx/FF/f0x4/+AQc7teAPIgScb89q9kw938FER1aGNIGGUcsbA
         sixiZf2XTF6nVY9MAtI2fNHa5fsp7n1HVMeiOylcneiXfb6qTs/sZhWYg3q1EhLn1RN5
         +4FfWK/hWGiTc9FMfJnoUDqVHwpE/8rQdgdQFZL2LaYR/b/DGwT4+zAhcO3t33Sh5L2c
         yVkw==
X-Gm-Message-State: AOJu0YwR34t3EnOPkZdK7S8af2aonyMOD18Or7x1BPEws6wYWapXcrN5
        QR8PX+93/cjYK2sC28PuVZc5h5b8/A8oOs4AeRxDUw==
X-Google-Smtp-Source: AGHT+IGSoIb8uQABAFJTeUJgo2RfYY4jfayfwcYkHHdPEVjq+eBHhrTPQ/7URUajOd/zOEzWZ81EtKRuSQPLeMl9XzI=
X-Received: by 2002:a05:6102:54a2:b0:457:a8fb:3251 with SMTP id
 bk34-20020a05610254a200b00457a8fb3251mr3718012vsb.0.1697112860491; Thu, 12
 Oct 2023 05:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231002151031.110551-1-alexghiti@rivosinc.com> <20231002151031.110551-5-alexghiti@rivosinc.com>
In-Reply-To: <20231002151031.110551-5-alexghiti@rivosinc.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Oct 2023 14:13:44 +0200
Message-ID: <CANpmjNMvQUSNU+U80nWrUWPc4sszvSTGvivJjk0HOw8LRWx1sg@mail.gmail.com>
Subject: Re: [PATCH 4/5] riscv: Suffix all page table entry pointers with 'p'
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2 Oct 2023 at 17:14, Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>
> That makes it more clear what the underlying type is, no functional
> changes intended.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/kfence.h     |  6 +-
>  arch/riscv/include/asm/kvm_host.h   |  2 +-
>  arch/riscv/include/asm/pgalloc.h    | 86 +++++++++++++-------------
>  arch/riscv/include/asm/pgtable-64.h | 20 +++---
>  arch/riscv/kvm/mmu.c                | 22 +++----
>  arch/riscv/mm/fault.c               | 38 ++++++------
>  arch/riscv/mm/hugetlbpage.c         | 78 +++++++++++------------
>  arch/riscv/mm/init.c                | 30 ++++-----
>  arch/riscv/mm/kasan_init.c          | 96 ++++++++++++++---------------
>  arch/riscv/mm/pageattr.c            | 74 +++++++++++-----------
>  arch/riscv/mm/pgtable.c             | 46 +++++++-------
>  11 files changed, 251 insertions(+), 247 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm/kfence.h
> index 0bbffd528096..3b482d0a4633 100644
> --- a/arch/riscv/include/asm/kfence.h
> +++ b/arch/riscv/include/asm/kfence.h
> @@ -15,12 +15,12 @@ static inline bool arch_kfence_init_pool(void)
>
>  static inline bool kfence_protect_page(unsigned long addr, bool protect)
>  {
> -       pte_t *pte = virt_to_kpte(addr);
> +       pte_t *ptep = virt_to_kpte(addr);
>
>         if (protect)
> -               set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
> +               set_pte(ptep, __pte(pte_val(*ptep) & ~_PAGE_PRESENT));
>         else
> -               set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
> +               set_pte(ptep, __pte(pte_val(*ptep) | _PAGE_PRESENT));
>
>         flush_tlb_kernel_range(addr, addr + PAGE_SIZE);

As others expressed, this seems unnecessary. It doesn't make the code
any clearer to me.

However, for your subsystem you make the rules. I would just suggest
to keep things consistent with other kernel code, although there are
already stylistic deviations between subsystems (e.g. comment style in
net and rcu vs rest), I'd simply vote for fewer deviations between
subsystems.

Real downsides of stylistic changes that have unclear benefit:
1. stable backports become more difficult.
2. chasing a change with git blame becomes harder.
