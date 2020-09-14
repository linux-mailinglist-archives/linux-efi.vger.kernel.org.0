Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E64268CD5
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 16:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgINOG1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 10:06:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51850 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgINOGX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Sep 2020 10:06:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 19278101F31;
        Mon, 14 Sep 2020 10:06:17 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=jnog3bZtEiooO2inDTRS7fkVXb8=; b=Q5v4zd
        jzX+ZjDgse6NdbUytzw/2ws+pAojfbpase15OOY9ppOWuVLI0lyygzJ4ycfMl1Wa
        5HTkX5M2nO6Assw1Q86Ksq2rUL41zBJqYNv9nnQmrV4EpoV8xtMVn9wNZgrp+qP4
        cIDwH/yPUc9y9u2Tm/g5YlbG4/8QM1DlFBef4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 107C5101F30;
        Mon, 14 Sep 2020 10:06:17 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=H3743/bOvCp/robf4PLfXUhicryWbuIMyIlA/xDwS5c=; b=0m+PRHJ4CRW2omxP53j6k2it4393SyKgmzB1pZvOcdQ0D8qlEScdWGcCCRXzKskZkXNPQijm+pei5ibHc5NMbEyTdv+tfF08Llu6rX5Af1oJES3bs5q3WLWmQhXCwww867+iAjNGIGat1OLKUyNniS1rdqtY4EcZxKCQqchcrrw=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 734A6101F2F;
        Mon, 14 Sep 2020 10:06:13 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 716392DA0C6E;
        Mon, 14 Sep 2020 10:06:11 -0400 (EDT)
Date:   Mon, 14 Sep 2020 10:06:11 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Ard Biesheuvel <ardb@kernel.org>
cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Smith <Peter.Smith@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 00/12] ARM: use adr_l/ldr_l macros for PC-relative
 references
In-Reply-To: <20200914095706.3985-1-ardb@kernel.org>
Message-ID: <nycvar.YSQ.7.78.906.2009141003360.4095746@knanqh.ubzr>
References: <20200914095706.3985-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 72CD1E1C-F693-11EA-A8E8-F0EA2EB3C613-78420484!pb-smtp20.pobox.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 14 Sep 2020, Ard Biesheuvel wrote:

> This is a respin of the adr_l/ldr_l code I wrote some years ago in the
> context of my KASLR proof of concept for 32-bit ARM.
> 
> A new use case came up, in the form of Clang, which does not implement
> the 'adrl' pseudo-instruction in its assembler, and so for PC-relative
> references that don't fit into a ARM adr instruction, we need something
> else. Patch #2 addresses an actual Clang build issue of this nature, by
> replacing an occurrence of adrl with adr_l.
> 
> I have included my existing cleanup patches that were built on top of the
> adr_l macro, which replace several occurrences of open coded arithmetic to
> calculate runtime addresses based on link time virtual addresses stored
> in literals.
> 
> Note that all of these patches with the exception of #2 were reviewed or
> acked by Nico before, but given that this was a while ago (and the fact

Certainly it must have been, as I didn't remember much of it.

> that neither of us work for Linaro anymore), I have dropped these. Note
> that only patch #1 deviates significantly from the last version that I
> sent out, the remaining ones were just freshened up (and their commit
> logs slightly expanded).

Reviewed-by: Nicolas Pitre <nico@fluxnic.net>

> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Peter Smith <Peter.Smith@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> 
> Ard Biesheuvel (12):
>   ARM: assembler: introduce adr_l, ldr_l and str_l macros
>   ARM: efistub: replace adrl pseudo-op with adr_l macro invocation
>   ARM: module: add support for place relative relocations
>   ARM: head-common.S: use PC-relative insn sequence for __proc_info
>   ARM: head-common.S: use PC-relative insn sequence for idmap creation
>   ARM: head.S: use PC-relative insn sequence for secondary_data
>   ARM: kernel: use relative references for UP/SMP alternatives
>   ARM: head: use PC-relative insn sequence for __smp_alt
>   ARM: sleep.S: use PC-relative insn sequence for
>     sleep_save_sp/mpidr_hash
>   ARM: head.S: use PC-relative insn sequences for __fixup_pv_table
>   ARM: head.S: use PC relative insn sequence to calculate PHYS_OFFSET
>   ARM: kvm: replace open coded VA->PA calculations with adr_l call
> 
>  arch/arm/boot/compressed/head.S  | 18 +---
>  arch/arm/include/asm/assembler.h | 88 ++++++++++++++++++-
>  arch/arm/include/asm/elf.h       |  5 ++
>  arch/arm/include/asm/processor.h |  2 +-
>  arch/arm/kernel/head-common.S    | 22 ++---
>  arch/arm/kernel/head.S           | 90 +++++---------------
>  arch/arm/kernel/hyp-stub.S       | 27 +++---
>  arch/arm/kernel/module.c         | 20 ++++-
>  arch/arm/kernel/sleep.S          | 19 ++---
>  9 files changed, 159 insertions(+), 132 deletions(-)
> 
> -- 
> 2.17.1
> 
> 
