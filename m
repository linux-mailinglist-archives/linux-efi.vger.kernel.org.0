Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584CD63F5D6
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 18:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLARAc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 12:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiLARA2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 12:00:28 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208A7A555F
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 09:00:27 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v8so3234639edi.3
        for <linux-efi@vger.kernel.org>; Thu, 01 Dec 2022 09:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7miDirFJY1Nmg3d+qikKLoNLyLAQWnhDP4Byuq3V3o=;
        b=k/hwVVqGgL4EJ9jE6PKeYQdlm1jmrUTME/dA9rl0pq54Vld9bpKOqIF4oI2spMgro1
         59kPaTrD90z3o1lpC9k2dcRMFoOnjKpwsg14oZ3MrwCVjAd6JXbBmBOo4JvYC4p4fxVu
         c10suF8fSk8a/tyiPki3WAnEPC2vU9VvLFHsVln5EWTFDzy6Me2culyzCvglvAgLkpNs
         1IbsH0kZK/+9FTXzrMk4AK9HrIqwZYqtWRz2xfZTZfuZdgojj9Vs3PYn2GZRHz/8yRvN
         FwBPj2QEzZd/PZdULO6RNsTtAb4G3/Try+LYIkIpzcXk8sncYAPppKoFpDETI4RHZQ8t
         bF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7miDirFJY1Nmg3d+qikKLoNLyLAQWnhDP4Byuq3V3o=;
        b=bTcUek9FyAF6eoscywLT/UyL82p6nYYIt0mn3DiQakUfFYxLp/BB40Th56uRt/tpAJ
         ssITnhX0qt8BJY1/UrdCFeOfqTcsNjqV4O5RWRzJgbrSb1Kn/x8uurw2yWGVMbm1xpkx
         DqOATzg/mN4Uh3nMnsxRIuRlBURk7P+NZGeUDyHc/lTyYYA8eEKj9D7RNw0f8HVj7ipq
         KA9zcD6OkTtxbteAssmYaPLnislKRCCsbKDjffDwonDNJb2hfPjhVtf8zmTKWRpsHTli
         FW5GhE2G3SygZ0Q0ZzB8qd7DyG0Vadz+/cJYifuTrksTY/g1ifq+nHzdjyRbwmaqetnA
         i5kg==
X-Gm-Message-State: ANoB5pnyBHqt8WmfT5+rOqHwa0Jlk/LN/czD/kDWTOcgukp7fUG2FQDt
        oBSueDvtjgGiAWRQ6NH60VlxxA==
X-Google-Smtp-Source: AA0mqf7LyO7T3W5UEDkOeO7mdJHSNU2UkBpluS08LCpZllWWmvuNHNTggYUdGfFlGhkzqo/2BFkF7w==
X-Received: by 2002:a05:6402:3711:b0:461:b6a9:c5cb with SMTP id ek17-20020a056402371100b00461b6a9c5cbmr46563386edb.148.1669914025685;
        Thu, 01 Dec 2022 09:00:25 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b007ae1e528390sm1947652ejh.163.2022.12.01.09.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:00:25 -0800 (PST)
Date:   Thu, 1 Dec 2022 18:00:23 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        emil.renner.berthing@canonical.com, ardb@kernel.org,
        linux-efi@vger.kernel.org, Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v3 01/14] RISC-V: fix funct4 definition for c.jalr in
 parse_asm.h
Message-ID: <20221201170023.tocmgewlwjrc7t6d@kamzik>
References: <20221130225614.1594256-1-heiko@sntech.de>
 <20221130225614.1594256-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130225614.1594256-2-heiko@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 30, 2022 at 11:56:01PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> The opcode definition for c.jalr is
>     c.jalr c_rs1_n0  1..0=2 15..13=4 12=1 6..2=0
> 
> This means funct4 consisting of bit [15:12] is 1001b, so the value is 0x9.

I presume kgdb c.jalr stepping was broken before this patch and, if so,
then we should add a comment stating that and also

  Fixes: edde5584c7ab ("riscv: Add SW single-step support for KDB")

and maybe to help keep me motivated :-)

  Reported-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/include/asm/parse_asm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/parse_asm.h b/arch/riscv/include/asm/parse_asm.h
> index f36368de839f..7fee806805c1 100644
> --- a/arch/riscv/include/asm/parse_asm.h
> +++ b/arch/riscv/include/asm/parse_asm.h
> @@ -125,7 +125,7 @@
>  #define FUNCT3_C_J		0xa000
>  #define FUNCT3_C_JAL		0x2000
>  #define FUNCT4_C_JR		0x8000
> -#define FUNCT4_C_JALR		0xf000
> +#define FUNCT4_C_JALR		0x9000
>  
>  #define FUNCT12_SRET		0x10200000
>  
> -- 
> 2.35.1
> 
