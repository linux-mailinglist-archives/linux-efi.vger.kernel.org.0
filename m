Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA35645911
	for <lists+linux-efi@lfdr.de>; Wed,  7 Dec 2022 12:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiLGLcy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Dec 2022 06:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiLGLcv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Dec 2022 06:32:51 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA7D1AF32
        for <linux-efi@vger.kernel.org>; Wed,  7 Dec 2022 03:32:49 -0800 (PST)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 377B741674
        for <linux-efi@vger.kernel.org>; Wed,  7 Dec 2022 11:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670412768;
        bh=XDg5r62PV7VGqC50P9tvlBcDd/B82GWTEhjgcrTBWj8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=SRRuI9O4oYtobtk8E3ECcRmzN0SwWJj/IPsxDGGjJGvQ87wZdKIURmx6MFyXBAfIf
         UAMM1bY80Qbmx2sBBIGu6oYe0iKGtjQ9QlJtGDjx2k/heVvLMR4n6E+fkEwmRGQEyU
         pUL6c8vbROt3CE7THmRwMvowZDu3wePYlrXy+xN78cY7qLv9y+JZ9QqnaIiDcJV768
         CPH4Aia38MICw0ZypmIp0VlhYPkc7Y3ovFTi1teTCMZei4IlGElQh2vukNA1aOi6pg
         te1RsslezGvtZLxZaThkxZQBEcsid6EPF9lb6q8Sl1nlc/U6ExFfDySE00JAVbxo5I
         Y2xrruEFzJO3g==
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-3dfb9d11141so155799807b3.3
        for <linux-efi@vger.kernel.org>; Wed, 07 Dec 2022 03:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDg5r62PV7VGqC50P9tvlBcDd/B82GWTEhjgcrTBWj8=;
        b=tTTCr0KH3wJFUWtebpTdxA6mhd0pNOh34NjH6HnG9UExMAMVRYGB0LO0fCpc93lBIu
         2I1H2AxlBc0pTyu2c7VMPrNRYVbtlxQ2lpD9PRr66cQL8Gg7RtJ2k2WNiYA8O3luAohG
         QPN4wXxY1ND6nj6pMwjZR5Pqvt9gkMuMqKItD449PArXlq8I+7xsdtaJc9QYMj8J4mGE
         vuKxbZ1+/tS9La9QrJpXELhmUaiP1/ObpU8AfdPIgePzUwfnOlzSDVfKD+ntPsUDWi5v
         VoONPVglD8NwFIXQMxUyxM5w0XvtBU7r/c9LZfkOEC9jZk2u+9JIHI7F5oAlCxfhbwF2
         1h7A==
X-Gm-Message-State: ANoB5pl7N0xKsh17OkujJnQuuXNKiCsCD+MJ/soiQxeWT/uL3R0diQKe
        j2MtuMQCUBAsxKgbjxjdFiG3FZ42rN23/DssVyEUIfcBi2+P6W4XzfKo7zdDYE5T3C0IYCS33vx
        MC9O4N8MCH/fjpnAFqvkyoxJ0wRqzBhM4grTzMnokSr9G1PS1IYRrkA==
X-Received: by 2002:a05:6902:1823:b0:6f9:a75a:2769 with SMTP id cf35-20020a056902182300b006f9a75a2769mr34991591ybb.439.1670412766633;
        Wed, 07 Dec 2022 03:32:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5GS+SKiPtcPQ+n8XGvO2Ld7AkncsuCUC6vSlQ3RvjvKP/oeM/FHM1etTSEUsVatBC35mzZRHFttFa+mExULCQ=
X-Received: by 2002:a05:6902:1823:b0:6f9:a75a:2769 with SMTP id
 cf35-20020a056902182300b006f9a75a2769mr34991572ybb.439.1670412766373; Wed, 07
 Dec 2022 03:32:46 -0800 (PST)
MIME-Version: 1.0
References: <20221130225614.1594256-1-heiko@sntech.de> <20221130225614.1594256-12-heiko@sntech.de>
 <CAJM55Z_xCOgFx=S+wDEMfWeOG6JVZ9y+g6YBPyr+9cofeT9nTg@mail.gmail.com>
In-Reply-To: <CAJM55Z_xCOgFx=S+wDEMfWeOG6JVZ9y+g6YBPyr+9cofeT9nTg@mail.gmail.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 7 Dec 2022 12:32:29 +0100
Message-ID: <CAJM55Z_9afPaq7wpVkqnGRfduoYFDy+CvfjeCPZwAi_4KW-H8Q@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] RISC-V: fix auipc-jalr addresses in patched alternatives
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        ajones@ventanamicro.com, ardb@kernel.org,
        linux-efi@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 7 Dec 2022 at 12:29, Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> On Wed, 30 Nov 2022 at 23:57, Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> >
> > Alternatives live in a different section, so addresses used by call
> > functions will point to wrong locations after the patch got applied.
> >
> > Similar to arm64, adjust the location to consider that offset.
> >
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > ---
> >  arch/riscv/include/asm/alternative.h |  3 ++
> >  arch/riscv/kernel/alternative.c      | 72 ++++++++++++++++++++++++++++
> >  arch/riscv/kernel/cpufeature.c       | 11 ++++-
> >  3 files changed, 84 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
> > index 6511dd73e812..c58ec3cc4bc3 100644
> > --- a/arch/riscv/include/asm/alternative.h
> > +++ b/arch/riscv/include/asm/alternative.h
> > @@ -27,6 +27,9 @@ void __init apply_boot_alternatives(void);
> >  void __init apply_early_boot_alternatives(void);
> >  void apply_module_alternatives(void *start, size_t length);
> >
> > +void riscv_alternative_fix_auipc_jalr(void *alt_ptr, unsigned int len,
> > +                                     int patch_offset);
> > +
> >  struct alt_entry {
> >         void *old_ptr;           /* address of original instruciton or data  */
> >         void *alt_ptr;           /* address of replacement instruction or data */
> > diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
> > index a7d26a00beea..292cc42dc3be 100644
> > --- a/arch/riscv/kernel/alternative.c
> > +++ b/arch/riscv/kernel/alternative.c
> > @@ -15,6 +15,8 @@
> >  #include <asm/vendorid_list.h>
> >  #include <asm/sbi.h>
> >  #include <asm/csr.h>
> > +#include <asm/insn.h>
> > +#include <asm/patch.h>
> >
> >  struct cpu_manufacturer_info_t {
> >         unsigned long vendor_id;
> > @@ -53,6 +55,76 @@ static void __init_or_module riscv_fill_cpu_mfr_info(struct cpu_manufacturer_inf
> >         }
> >  }
> >
> > +static unsigned int riscv_instruction_at(void *p, unsigned int offset)
> > +{
> > +       u16 *parcel = p + (offset * sizeof(u32));
> > +
> > +       return (unsigned int)parcel[0] | (unsigned int)parcel[1] << 16;
> > +}
> > +
> > +static inline bool riscv_insn_is_auipc_jalr(u32 insn1, u32 insn2)
> > +{
> > +       return riscv_insn_is_auipc(insn1) && riscv_insn_is_jalr(insn2);
> > +}
> > +
> > +#define JALR_SIGN_MASK         BIT(RV_I_IMM_SIGN_OPOFF - RV_I_IMM_11_0_OPOFF)
> > +#define AUIPC_PAD              (0x00001000)
> > +
> > +#define to_jalr_imm(value)                                             \
> > +       ((value & RV_I_IMM_11_0_MASK) << RV_I_IMM_11_0_OPOFF)
> > +
> > +#define to_auipc_imm(value)                                            \
> > +       ((value & JALR_SIGN_MASK) ?                                     \
> > +       ((value & RV_U_IMM_31_12_MASK) + AUIPC_PAD) :   \
> > +       (value & RV_U_IMM_31_12_MASK))
> > +
> > +void riscv_alternative_fix_auipc_jalr(void *alt_ptr, unsigned int len,
> > +                                     int patch_offset)
> > +{
> > +       int num_instr = len / sizeof(u32);
> > +       unsigned int call[2];
> > +       int i;
> > +       int imm;
> > +       u32 rd1;
> > +
> > +       /*
> > +        * stop one instruction before the end, as we're checking
> > +        * for auipc + jalr
> > +        */
> > +       for (i = 0; i < num_instr - 1; i++) {
> > +               u32 inst1 = riscv_instruction_at(alt_ptr, i);
> > +               u32 inst2 = riscv_instruction_at(alt_ptr, i + 1);
> > +
> > +               if (!riscv_insn_is_auipc_jalr(inst1, inst2))
> > +                       continue;
> > +
> > +               /* call will use ra register */
> > +               rd1 = RV_EXTRACT_RD_REG(inst1);
> > +               if (rd1 != 1)
> > +                       continue;
> > +
> > +               /* get and adjust new target address */
> > +               imm = RV_EXTRACT_UTYPE_IMM(inst1);
> > +               imm += RV_EXTRACT_ITYPE_IMM(inst2);
> > +               imm -= patch_offset;
> > +
> > +               /* pick the original auipc + jalr */
> > +               call[0] = inst1;
> > +               call[1] = inst2;
> > +
> > +               /* drop the old IMMs */
> > +               call[0] &= ~(RV_U_IMM_31_12_MASK);
> > +               call[1] &= ~(RV_I_IMM_11_0_MASK << RV_I_IMM_11_0_OPOFF);
> > +
> > +               /* add the adapted IMMs */
> > +               call[0] |= to_auipc_imm(imm);
> > +               call[1] |= to_jalr_imm(imm);
>
> It's fine like this, but as explained in
> https://git.kernel.org/torvalds/c/0966d385830de3470b7131db8e86c0c5bc9c52dc
> we can get rid of the conditional by doing
>
> call[0] |= (imm + 0x800) >> 12;
> call[1] |= imm & 0xfff;

Ugh, sorry this is of course wrong. It still needs to take into
account how the immediates are encoded in the instruction, but
calculating the immediates can still be done without a conditional.

> > +
> > +               /* patch the call place again */
> > +               patch_text_nosync(alt_ptr + i * sizeof(u32), call, 8);
> > +       }
> > +}
> > +
> >  /*
> >   * This is called very early in the boot process (directly after we run
> >   * a feature detect on the boot CPU). No need to worry about other CPUs
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 694267d1fe81..ba62a4ff5ccd 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -316,8 +316,15 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
> >                 }
> >
> >                 tmp = (1U << alt->errata_id);
> > -               if (cpu_req_feature & tmp)
> > -                       patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
> > +               if (cpu_req_feature & tmp) {
> > +                       /* do the basic patching */
> > +                       patch_text_nosync(alt->old_ptr, alt->alt_ptr,
> > +                                         alt->alt_len);
> > +
> > +                       riscv_alternative_fix_auipc_jalr(alt->old_ptr,
> > +                                                        alt->alt_len,
> > +                                                        alt->old_ptr - alt->alt_ptr);
> > +               }
> >         }
> >  }
> >  #endif
> > --
> > 2.35.1
> >
