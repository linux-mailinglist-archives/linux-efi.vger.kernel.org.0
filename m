Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F157679275
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jan 2023 09:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjAXIAm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Jan 2023 03:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjAXIAj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Jan 2023 03:00:39 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6513EFC4
        for <linux-efi@vger.kernel.org>; Tue, 24 Jan 2023 00:00:38 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q5so8352237wrv.0
        for <linux-efi@vger.kernel.org>; Tue, 24 Jan 2023 00:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CqSZybdUuskI+UDVH1j93jvIbGoD0+XsFL55JSeaP+k=;
        b=b6H059p3q9xg6E9c9XQB6jeEpHYZpMtkObtgJ6shIqMFcjqV1MYW7qTz6S2CRHj27i
         1TKgxE7c8dtixSqWvF98vecR84mlfuZLI60RrLF4f/I406iDTKwZVOnoEw5xAJYTmbXA
         ngN8ug+S4wFE3dQ0QMTi4BOLCy2P3skctJM4mg9QhlJXWG22To0vkohGxqM4d3MokLSC
         GVmKpV3HRAOgqv8acmEXkW8AeyvWBiigkNMveO4uFIIHS4gK64om7JLDHTT+MlmIdSFN
         gaF9FbDAVVpedWKzzz3zdaZcywtPT71D0YdaPgUDV7O90c3s/sU/LQG5tjrC0EH4xyip
         RREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqSZybdUuskI+UDVH1j93jvIbGoD0+XsFL55JSeaP+k=;
        b=UI86G2aQy7FngpKI/hF+3uKWwx1LR2ryo22Ns02Kab89Ki+4OxFt0JW9x421Q06Gnb
         bRp8crE/4F1We7mxnP+Whnn+jDSgQEHmGxysi4Xv3g0IKXisVBf8BcMEU4dACSPW3SnK
         C8R27//umFyp3t3TH0XmLXi6/txGr0fT7pvtJKQvCSrjdcbsA+nIidkAHd/Sl5aqHSxV
         6BNyv8pcLLcAMnx6Z4FmZSONMUeS7BwtpHTarLv6U4t5VPpL2tbq56lVa2Tluym06sZ+
         RY6Ng+NlmiBAMj0KNqzPYEHnN2SjSgSQ4CKluua3sZICFRDOvgBfyngJ93i+nP7pt2Fx
         xkUw==
X-Gm-Message-State: AFqh2kqOspgZqPcqsmr4Ry9cbYHm/dsiwu9OTuQcHO54By6frPgocT+c
        624iCaDu1GKuAutgBntOzpFQd8e3/DG6ddCl7CjuRg==
X-Google-Smtp-Source: AMrXdXvPLscFw4dlQnNZxaTZSeeo5RV7pn56CWqRBz3ECJ7Gfy9qulLKrkg3tXoRsE2OvYfbItKgsSpGdywsTmb1+NA=
X-Received: by 2002:a5d:5190:0:b0:2bd:d6bc:e35c with SMTP id
 k16-20020a5d5190000000b002bdd6bce35cmr1218375wrv.144.1674547236441; Tue, 24
 Jan 2023 00:00:36 -0800 (PST)
MIME-Version: 1.0
References: <20230123100951.810807-1-alexghiti@rivosinc.com>
 <20230123100951.810807-2-alexghiti@rivosinc.com> <Y88HD2ocLQilIuDr@spud>
In-Reply-To: <Y88HD2ocLQilIuDr@spud>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 24 Jan 2023 09:00:25 +0100
Message-ID: <CAHVXubiSJMyeuy253wyFALQ0DzDn_yuuR4HWKy9rmGYLNeXpKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] riscv: Split early and final KASAN population functions
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Conor,

On Mon, Jan 23, 2023 at 11:15 PM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Alex,
>
> FYI this patch has a couple places with spaces used rather than tabs for
> indent.

Damn, I forgot to run checkpatch this time...

Thanks,

Alex

>
> >  static void __init kasan_populate_p4d(pgd_t *pgd,
> > -                                   unsigned long vaddr, unsigned long end,
> > -                                   bool early)
> > +                                   unsigned long vaddr, unsigned long end)
> >  {
> >       phys_addr_t phys_addr;
> >       p4d_t *p4dp, *base_p4d;
> >       unsigned long next;
> >
> > -     if (early) {
> > -             /*
> > -              * We can't use pgd_page_vaddr here as it would return a linear
> > -              * mapping address but it is not mapped yet, but when populating
> > -              * early_pg_dir, we need the physical address and when populating
> > -              * swapper_pg_dir, we need the kernel virtual address so use
> > -              * pt_ops facility.
> > -              */
> > -             base_p4d = pt_ops.get_p4d_virt(pfn_to_phys(_pgd_pfn(*pgd)));
> > -     } else {
> > -             base_p4d = (p4d_t *)pgd_page_vaddr(*pgd);
> > -             if (base_p4d == lm_alias(kasan_early_shadow_p4d)) {
> > -                     base_p4d = memblock_alloc(PTRS_PER_PUD * sizeof(p4d_t), PAGE_SIZE);
> > -                     memcpy(base_p4d, (void *)kasan_early_shadow_p4d,
> > -                             sizeof(p4d_t) * PTRS_PER_P4D);
> > -             }
> > -     }
> > +     base_p4d = (p4d_t *)pgd_page_vaddr(*pgd);
> > +     if (base_p4d == lm_alias(kasan_early_shadow_p4d)) {
> > +             base_p4d = memblock_alloc(PTRS_PER_PUD * sizeof(p4d_t), PAGE_SIZE);
> > +        memcpy(base_p4d, (void *)kasan_early_shadow_p4d,
> > +                sizeof(p4d_t) * PTRS_PER_P4D);
> > +    }
>
> ^^  here.
>
> Thanks,
> Conor.
>
