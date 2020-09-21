Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C21E273229
	for <lists+linux-efi@lfdr.de>; Mon, 21 Sep 2020 20:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgIUSpb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Sep 2020 14:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbgIUSpb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 21 Sep 2020 14:45:31 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1EBE22262
        for <linux-efi@vger.kernel.org>; Mon, 21 Sep 2020 18:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600713930;
        bh=D38yzDnk5pdQJRh4UypuW5ViUhkPPUUooDwBraVuIcY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HV+9H4YYE5PRrBdq75LW6MRYdE40CakfW0rzsgyAFXR9cOzkUigiXP+9gjFTH0zGl
         mJM9eRRDJHAT856oabszgk8JPmeo2sl93lV+sfIU+Yva5bJ2L02WXlQKxZ+484krPq
         UIbQiVIG8jQV9ZW7x1Lpv4MgiQa81Rb+c0EIZBtg=
Received: by mail-ot1-f52.google.com with SMTP id g96so13274562otb.12
        for <linux-efi@vger.kernel.org>; Mon, 21 Sep 2020 11:45:29 -0700 (PDT)
X-Gm-Message-State: AOAM530Ivt7DJqDnmhFjChXvLfXBrG2wZQ9/t7pkks19mfUP75mIellG
        E26hsfxoqE7OODJNXKak2a7yCUi6zHIucfpz7fs=
X-Google-Smtp-Source: ABdhPJwi8ix5nIcTnE2/HAC7R3clXeWl95KlMco90J7BBIobGFQSsCHgpG1AV0oOzhWd5O1H2JJT0NZHaGHDMYQh2AE=
X-Received: by 2002:a9d:6250:: with SMTP id i16mr567404otk.77.1600713929155;
 Mon, 21 Sep 2020 11:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-10-ardb@kernel.org>
 <nycvar.YSQ.7.78.906.2009211419560.2680@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.78.906.2009211419560.2680@knanqh.ubzr>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 21 Sep 2020 20:45:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH=MKG1t+AU7zh598n5yTLO48WHJwrj98Mz=2Gf1N2xSg@mail.gmail.com>
Message-ID: <CAMj1kXH=MKG1t+AU7zh598n5yTLO48WHJwrj98Mz=2Gf1N2xSg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] ARM: p2v: switch to MOVW for Thumb2 and ARM/LPAE
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 21 Sep 2020 at 20:29, Nicolas Pitre <nico@fluxnic.net> wrote:
>
> On Mon, 21 Sep 2020, Ard Biesheuvel wrote:
>
> > In preparation for reducing the phys-to-virt minimum relative alignment
> > from 16 MiB to 2 MiB, switch to patchable sequences involving MOVW
> > instructions that can more easily be manipulated to carry a 12-bit
> > immediate. Note that the non-LPAE ARM sequence is not updated: MOVW
> > may not be supported on non-LPAE platforms, and the sequence itself
> > can be updated more easily to apply the 12 bits of displacement.
>
> I'm still wondering what is the advantage of a movw+lsl vs two adds?
> I think I remember but I'd have to go back in the ARM ARM to be sure.
> You could elaborate a bit more on the  "more easily be manipulated"
> please.  No need to resend just for this.
>

The reason for using movw+lsl for Thumb2 is that it allows us to use
the same patching code for all three sequences: every MOVW gets the
low order offset patched in, and every MVN the high order offset.
Also, as the immediate format is different between MOVW and ADD/SUB,
and not as easily patchable in the latter case, we'd have to keep four
different values to patch into the opcodes (one for movw, one for
mov/mvn, one for the first add/sub, and one for the second), and have
logic to distinguish between all those opcodes.

> > For Thumb2, which has many more versions of opcodes, switch to a sequence
> > that can be patched by the same patching code for both versions. Note
> > that the Thumb2 opcodes for MOVW and MVN are unambiguous, and have no
> > rotation bits in their immediate fields, so there is no need to use
> > placeholder constants in the asm blocks.
> >
> > While at it, drop the 'volatile' qualifiers from the asm blocks: the
> > code does not have any side effects that are invisible to the compiler,
> > so it is free to omit these sequences if the outputs are not used.
>
> Indeed. Weird that the volatile was there in the first place.
>
>
> >
> > Suggested-by: Russell King <linux@armlinux.org.uk>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm/include/asm/memory.h |  44 ++++--
> >  arch/arm/kernel/phys2virt.S   | 147 +++++++++++++++-----
> >  2 files changed, 148 insertions(+), 43 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> > index 4121662dea5a..ccf55cef6ab9 100644
> > --- a/arch/arm/include/asm/memory.h
> > +++ b/arch/arm/include/asm/memory.h
> > @@ -183,6 +183,7 @@ extern const void *__pv_table_begin, *__pv_table_end;
> >  #define PHYS_OFFSET  ((phys_addr_t)__pv_phys_pfn_offset << PAGE_SHIFT)
> >  #define PHYS_PFN_OFFSET      (__pv_phys_pfn_offset)
> >
> > +#ifndef CONFIG_THUMB2_KERNEL
> >  #define __pv_stub(from,to,instr)                     \
> >       __asm__("@ __pv_stub\n"                         \
> >       "1:     " instr "       %0, %1, %2\n"           \
> > @@ -192,25 +193,45 @@ extern const void *__pv_table_begin, *__pv_table_end;
> >       : "=r" (to)                                     \
> >       : "r" (from), "I" (__PV_BITS_31_24))
> >
> > -#define __pv_stub_mov_hi(t)                          \
> > -     __asm__ volatile("@ __pv_stub_mov\n"            \
> > -     "1:     mov     %R0, %1\n"                      \
> > +#define __pv_add_carry_stub(x, y)                    \
> > +     __asm__("@ __pv_add_carry_stub\n"               \
> > +     "0:     movw    %R0, #0\n"                      \
> > +     "       adds    %Q0, %1, %R0, lsl #24\n"        \
> > +     "1:     mov     %R0, %2\n"                      \
> > +     "       adc     %R0, %R0, #0\n"                 \
> >       "       .pushsection .pv_table,\"a\"\n"         \
> > -     "       .long   1b - .\n"                       \
> > +     "       .long   0b - ., 1b - .\n"               \
> >       "       .popsection\n"                          \
> > -     : "=r" (t)                                      \
> > -     : "I" (__PV_BITS_7_0))
> > +     : "=&r" (y)                                     \
> > +     : "r" (x), "I" (__PV_BITS_7_0)                  \
> > +     : "cc")
> > +
> > +#else
> > +#define __pv_stub(from,to,instr)                     \
> > +     __asm__("@ __pv_stub\n"                         \
> > +     "0:     movw    %0, #0\n"                       \
> > +     "       lsl     %0, #24\n"                      \
> > +     "       " instr " %0, %1, %0\n"                 \
> > +     "       .pushsection .pv_table,\"a\"\n"         \
> > +     "       .long   0b - .\n"                       \
> > +     "       .popsection\n"                          \
> > +     : "=&r" (to)                                    \
> > +     : "r" (from))
> >
> >  #define __pv_add_carry_stub(x, y)                    \
> > -     __asm__ volatile("@ __pv_add_carry_stub\n"      \
> > -     "1:     adds    %Q0, %1, %2\n"                  \
> > +     __asm__("@ __pv_add_carry_stub\n"               \
> > +     "0:     movw    %R0, #0\n"                      \
> > +     "       lsls    %R0, #24\n"                     \
> > +     "       adds    %Q0, %1, %R0\n"                 \
> > +     "1:     mvn     %R0, #0\n"                      \
> >       "       adc     %R0, %R0, #0\n"                 \
> >       "       .pushsection .pv_table,\"a\"\n"         \
> > -     "       .long   1b - .\n"                       \
> > +     "       .long   0b - ., 1b - .\n"               \
> >       "       .popsection\n"                          \
> > -     : "+r" (y)                                      \
> > -     : "r" (x), "I" (__PV_BITS_31_24)                \
> > +     : "=&r" (y)                                     \
> > +     : "r" (x)                                       \
> >       : "cc")
> > +#endif
> >
> >  static inline phys_addr_t __virt_to_phys_nodebug(unsigned long x)
> >  {
> > @@ -219,7 +240,6 @@ static inline phys_addr_t __virt_to_phys_nodebug(unsigned long x)
> >       if (sizeof(phys_addr_t) == 4) {
> >               __pv_stub(x, t, "add");
> >       } else {
> > -             __pv_stub_mov_hi(t);
> >               __pv_add_carry_stub(x, t);
> >       }
> >       return t;
> > diff --git a/arch/arm/kernel/phys2virt.S b/arch/arm/kernel/phys2virt.S
> > index be8fb0d89877..a4e364689663 100644
> > --- a/arch/arm/kernel/phys2virt.S
> > +++ b/arch/arm/kernel/phys2virt.S
> > @@ -1,7 +1,7 @@
> >  /* SPDX-License-Identifier: GPL-2.0-only */
> >  /*
> >   *  Copyright (C) 1994-2002 Russell King
> > - *  Copyright (c) 2003 ARM Limited
> > + *  Copyright (c) 2003, 2020 ARM Limited
> >   *  All Rights Reserved
> >   */
> >
> > @@ -58,55 +58,140 @@ __fixup_a_pv_table:
> >       mov     r6, r6, lsr #24
> >       cmn     r0, #1
> >  #ifdef CONFIG_THUMB2_KERNEL
> > +     @
> > +     @ The Thumb-2 versions of the patchable sequences are
> > +     @
> > +     @ phys-to-virt:                 movw    <reg>, #offset<31:24>
> > +     @                               lsl     <reg>, #24
> > +     @                               sub     <VA>, <PA>, <reg>
> > +     @
> > +     @ virt-to-phys (non-LPAE):      movw    <reg>, #offset<31:24>
> > +     @                               lsl     <reg>, #24
> > +     @                               add     <PA>, <VA>, <reg>
> > +     @
> > +     @ virt-to-phys (LPAE):          movw    <reg>, #offset<31:24>
> > +     @                               lsl     <reg>, #24
> > +     @                               adds    <PAlo>, <VA>, <reg>
> > +     @                               mov     <PAhi>, #offset<39:32>
> > +     @                               adc     <PAhi>, <PAhi>, #0
> > +     @
> > +     @ In the non-LPAE case, all patchable instructions are MOVW
> > +     @ instructions, where we need to patch in the offset into the
> > +     @ second halfword of the opcode (the 16-bit immediate is encoded
> > +     @ as imm4:i:imm3:imm8)
> > +     @
> > +     @       15       11 10  9           4 3    0  15  14  12 11 8 7    0
> > +     @      +-----------+---+-------------+------++---+------+----+------+
> > +     @ MOVW | 1 1 1 1 0 | i | 1 0 0 1 0 0 | imm4 || 0 | imm3 | Rd | imm8 |
> > +     @      +-----------+---+-------------+------++---+------+----+------+
> > +     @
> > +     @ In the LPAE case, we also need to patch in the high word of the
> > +     @ offset into the immediate field of the MOV instruction, or patch it
> > +     @ to a MVN instruction if the offset is negative. In this case, we
> > +     @ need to inspect the first halfword of the opcode, to check whether
> > +     @ it is MOVW or MOV/MVN, and to perform the MOV to MVN patching if
> > +     @ needed. The encoding of the immediate is rather complex for values
> > +     @ of i:imm3 != 0b0000, but fortunately, we never need more than 8 lower
> > +     @ order bits, which can be patched into imm8 directly (and i:imm3
> > +     @ cleared)
> > +     @
> > +     @      15       11 10  9        5         0  15  14  12 11 8 7    0
> > +     @     +-----------+---+---------------------++---+------+----+------+
> > +     @ MOV | 1 1 1 1 0 | i | 0 0 0 1 0 0 1 1 1 1 || 0 | imm3 | Rd | imm8 |
> > +     @ MVN | 1 1 1 1 0 | i | 0 0 0 1 1 0 1 1 1 1 || 0 | imm3 | Rd | imm8 |
> > +     @     +-----------+---+---------------------++---+------+----+------+
> > +     @
> >       moveq   r0, #0x200000           @ set bit 21, mov to mvn instruction
> > -     lsls    r6, #24
> > -     beq     .Lnext
> > -     clz     r7, r6
> > -     lsr     r6, #24
> > -     lsl     r6, r7
> > -     bic     r6, #0x0080
> > -     lsrs    r7, #1
> > -     orrcs   r6, #0x0080
> > -     orr     r6, r6, r7, lsl #12
> > -     orr     r6, #0x4000
> >       b       .Lnext
> >  .Lloop:      add     r7, r4
> > -     adds    r4, #4
> > -     ldrh    ip, [r7, #2]
> > -ARM_BE8(rev16        ip, ip)
> > -     tst     ip, #0x4000
> > -     and     ip, #0x8f00
> > -     orrne   ip, r6                  @ mask in offset bits 31-24
> > -     orreq   ip, r0                  @ mask in offset bits 7-0
> > -ARM_BE8(rev16        ip, ip)
> > -     strh    ip, [r7, #2]
> > -     bne     .Lnext
> > +     adds    r4, #4                  @ clears Z flag
> > +#ifdef CONFIG_ARM_LPAE
> >       ldrh    ip, [r7]
> >  ARM_BE8(rev16        ip, ip)
> > -     bic     ip, #0x20
> > -     orr     ip, ip, r0, lsr #16
> > +     tst     ip, #0x200              @ MOVW has bit 9 set, MVN has it clear
> > +     bne     0f                      @ skip to MOVW handling (Z flag is clear)
> > +     bic     ip, #0x20               @ clear bit 5 (MVN -> MOV)
> > +     orr     ip, ip, r0, lsr #16     @ MOV -> MVN if offset < 0
> >  ARM_BE8(rev16        ip, ip)
> >       strh    ip, [r7]
> > +     @ Z flag is set
> > +0:
> > +#endif
> > +     ldrh    ip, [r7, #2]
> > +ARM_BE8(rev16        ip, ip)
> > +     and     ip, #0xf00              @ clear everything except Rd field
> > +     orreq   ip, r0                  @ Z flag set -> MOV/MVN -> patch in high bits
> > +     orrne   ip, r6                  @ Z flag clear -> MOVW -> patch in low bits
> > +ARM_BE8(rev16        ip, ip)
> > +     strh    ip, [r7, #2]
> >  #else
> >  #ifdef CONFIG_CPU_ENDIAN_BE8
> >  @ in BE8, we load data in BE, but instructions still in LE
> > -#define PV_BIT22     0x00004000
> > +#define PV_BIT24     0x00000001
> >  #define PV_IMM8_MASK 0xff000000
> > -#define PV_ROT_MASK  0x000f0000
> >  #else
> > -#define PV_BIT22     0x00400000
> > +#define PV_BIT24     0x01000000
> >  #define PV_IMM8_MASK 0x000000ff
> > -#define PV_ROT_MASK  0xf00
> >  #endif
> >
> > +     @
> > +     @ The ARM versions of the patchable sequences are
> > +     @
> > +     @ phys-to-virt:                 sub     <VA>, <PA>, #offset<31:24>, lsl #24
> > +     @
> > +     @ virt-to-phys (non-LPAE):      add     <PA>, <VA>, #offset<31:24>, lsl #24
> > +     @
> > +     @ virt-to-phys (LPAE):          movw    <reg>, #offset<31:24>
> > +     @                               adds    <PAlo>, <VA>, <reg>, lsl #24
> > +     @                               mov     <PAhi>, #offset<39:32>
> > +     @                               adc     <PAhi>, <PAhi>, #0
> > +     @
> > +     @ In the non-LPAE case, all patchable instructions are ADD or SUB
> > +     @ instructions, where we need to patch in the offset into the
> > +     @ immediate field of the opcode, which is emitted with the correct
> > +     @ rotation value. (The effective value of the immediate is imm12<7:0>
> > +     @ rotated right by [2 * imm12<11:8>] bits)
> > +     @
> > +     @      31   28 27      23 22  20 19  16 15  12 11    0
> > +     @      +------+-----------------+------+------+-------+
> > +     @  ADD | cond | 0 0 1 0 1 0 0 0 |  Rn  |  Rd  | imm12 |
> > +     @  SUB | cond | 0 0 1 0 0 1 0 0 |  Rn  |  Rd  | imm12 |
> > +     @  MOV | cond | 0 0 1 1 1 0 1 0 |  Rn  |  Rd  | imm12 |
> > +     @  MVN | cond | 0 0 1 1 1 1 1 0 |  Rn  |  Rd  | imm12 |
> > +     @      +------+-----------------+------+------+-------+
> > +     @
> > +     @ In the LPAE case, we use a MOVW instruction to carry the low offset
> > +     @ word, and patch in the high word of the offset into the immediate
> > +     @ field of the subsequent MOV instruction, or patch it to a MVN
> > +     @ instruction if the offset is negative. We can distinguish MOVW
> > +     @ instructions based on bits 23:22 of the opcode, and ADD/SUB can be
> > +     @ distinguished from MOV/MVN (all using the encodings above) using
> > +     @ bit 24.
> > +     @
> > +     @      31   28 27      23 22  20 19  16 15  12 11    0
> > +     @      +------+-----------------+------+------+-------+
> > +     @ MOVW | cond | 0 0 1 1 0 0 0 0 | imm4 |  Rd  | imm12 |
> > +     @      +------+-----------------+------+------+-------+
> > +     @
> >       moveq   r0, #0x400000           @ set bit 22, mov to mvn instruction
> >       b       .Lnext
> >  .Lloop:      ldr     ip, [r7, r4]
> > +#ifdef CONFIG_ARM_LPAE
> > +     tst     ip, #PV_BIT24           @ ADD/SUB have bit 24 clear
> > +     beq     1f
> > +ARM_BE8(rev  ip, ip)
> > +     tst     ip, #0xc00000           @ MOVW has bits 23:22 clear
> > +     bic     ip, ip, #0x400000       @ clear bit 22
> > +     bfc     ip, #0, #12             @ clear imm12 field of MOV[W] instruction
> > +     orreq   ip, ip, r6              @ MOVW -> mask in offset bits 31-24
> > +     orrne   ip, ip, r0              @ MOV  -> mask in offset bits 7-0 (or bit 22)
> > +ARM_BE8(rev  ip, ip)
> > +     b       2f
> > +1:
> > +#endif
> >       bic     ip, ip, #PV_IMM8_MASK
> > -     tst     ip, #PV_ROT_MASK                @ check the rotation field
> > -     orrne   ip, ip, r6 ARM_BE8(, lsl #24)   @ mask in offset bits 31-24
> > -     biceq   ip, ip, #PV_BIT22               @ clear bit 22
> > -     orreq   ip, ip, r0 ARM_BE8(, ror #8)    @ mask in offset bits 7-0 (or bit 22)
> > +     orr     ip, ip, r6 ARM_BE8(, lsl #24)   @ mask in offset bits 31-24
> > +2:
> >       str     ip, [r7, r4]
> >       add     r4, r4, #4
> >  #endif
> > --
> > 2.17.1
> >
> >
