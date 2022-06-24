Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF0155A033
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 20:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiFXRp2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 13:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiFXRp2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 13:45:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFEE2D1ED;
        Fri, 24 Jun 2022 10:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB9B361F70;
        Fri, 24 Jun 2022 17:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B93C3411C;
        Fri, 24 Jun 2022 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656092726;
        bh=RKDop+bWIdjv464C6OGTy10qedAhmre4ppBVO0W3ht0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JQcBB2CV2B5y+HiKYixxPjS3BvrjccqvOE2sfF5uTLLfA4LRge94j1sWg1WFwchvA
         f8KtQ6zjHXnz6n0vXxNMycYX8jsPirlZQhdjATRt7ntKPDQK8a6YiqGPG2hpsBlCr/
         lFFD4qeZK6vfS1mdgG3kZMLfOyP4g3naKjb8KL/h0D2qkkZmXyZ3g7savqZJYOiC34
         bqw4zx1LWFyx5v7anlxcqTqZ4+GAjW5mYK8DcGU+FrN6T6e/mQs1tiA1gOozaaGRX0
         kKQHcuX2EWvAxMC3tIl8No52Eo2ZJuDEQ1HwoKL/Ou8vnwohPTKT/fdY9Sn5p+l2TE
         DMkhf7WAXs+Kw==
Received: by mail-oi1-f173.google.com with SMTP id h65so4443762oia.11;
        Fri, 24 Jun 2022 10:45:26 -0700 (PDT)
X-Gm-Message-State: AJIora9fxcxLTWG6eXU8+n+v30qpXLdH75yA8PSNzeZDofbcW3CBpmKq
        WaZFuuNem0J/k5Y7342M+uT+qrP35SPv0UY5bpE=
X-Google-Smtp-Source: AGRyM1tK8v3Q8ZYLzRmkYVKLPDhBz186byWk+vyJMnzVUc/hxHwE3SN9TMkIlN/8LHXFiZy7uTSDlvVR3yvGd2/qx0E=
X-Received: by 2002:a05:6808:300e:b0:32c:425e:df34 with SMTP id
 ay14-20020a056808300e00b0032c425edf34mr154469oib.126.1656092725494; Fri, 24
 Jun 2022 10:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220624152331.4009502-1-sudeep.holla@arm.com> <20220624152331.4009502-2-sudeep.holla@arm.com>
In-Reply-To: <20220624152331.4009502-2-sudeep.holla@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 24 Jun 2022 19:45:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFAwzttyi=--fJyh9bGXv30Z4dkVR02_taS3JtKJXsLhA@mail.gmail.com>
Message-ID: <CAMj1kXFAwzttyi=--fJyh9bGXv30Z4dkVR02_taS3JtKJXsLhA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: efi: Simplify arch_efi_call_virt macro by not
 using efi_##f##_t type
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 24 Jun 2022 at 17:23, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Currently, the arch_efi_call_virt() assumes all users of it will have
> defined a type 'efi_##f##_t' to make use of it. It is unnecessarily
> forcing the users to create a new typedef when __efi_rt_asm_wrapper()
> actually expects void pointer.
>
> Simplify the arch_efi_call_virt() macro by typecasting p->f to (void *)
> as required by __efi_rt_asm_wrapper() and eliminate the explicit need
> for efi_##f##_t type for every user of this macro.
>

Can't we just use typeof() here?

__efi_rt_asm_wrapper() was intended as a temporary thing, so I'd
prefer to avoid starting to rely on the void* type of its first
argument.


> This is needed now in preparation to enable PRMT support on ARM64.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/include/asm/efi.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> Hi Ard,
>
> I am not sure if you prefer to add type for each users of this or this
> is acceptable. I see only compile time advantage but I am not sure if
> it make sense to add typedefs in ACPI PRMT driver just for this reason.
>
> Let me know.
>
> Regards,
> Sudeep
>
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index ad55079abe47..263d7fd67207 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -29,9 +29,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
>
>  #define arch_efi_call_virt(p, f, args...)                              \
>  ({                                                                     \
> -       efi_##f##_t *__f;                                               \
> -       __f = p->f;                                                     \
> -       __efi_rt_asm_wrapper(__f, #f, args);                            \
> +       __efi_rt_asm_wrapper((void *)p->f, #f, args);                   \
>  })
>
>  #define arch_efi_call_virt_teardown()                                  \
> --
> 2.36.1
>
