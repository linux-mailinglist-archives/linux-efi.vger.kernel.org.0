Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F9355EAB0
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 19:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiF1RK4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 13:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiF1RKz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 13:10:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097322C126;
        Tue, 28 Jun 2022 10:10:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0298B81F22;
        Tue, 28 Jun 2022 17:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DA2C3411D;
        Tue, 28 Jun 2022 17:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656436252;
        bh=y7R0If87iXFVZW5EDCHe+hyyf85O9pxirHIaWDy/8wE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N4YwlwNAz30DRITabX3Aa+5JGYcPR9e32omzEgpDnKbr+EQoFBa50bmkiFKyWdM/Q
         0yKvkY19bRkO29VG1a1egn75rtteAcLeK30Cme2jVyvQo9wi7/vbrxf9zSLowYp3af
         nfJA9QmWFbaek3tB2sYSXJ8Zh8OupDrrTUmRUzsKl1uZkpkGUCL78Dtmw5GYduVjQp
         jZPjPnnunwSYjG+2uzu2+j09yTTGJtgXAmCsdzLDJvHldzUV+0A6+hnrGnlojiNz60
         csQhFQRPe4atnd7rwlPQDyrfZ0joeujGZ7Ov5XQN4JMcmq+fr4j9+gZOX0MSSIUCnS
         VCHnELG4CWtdA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-101ec2d6087so17907767fac.3;
        Tue, 28 Jun 2022 10:10:52 -0700 (PDT)
X-Gm-Message-State: AJIora80HJ9DnRSXy8gWgLvIjWsG5WkpKc1AM/wXQ9Wemx29XTNxgZVw
        2nq+67av1DP5LJIg2QwpCKS1s0r0DA7gUoNSe4E=
X-Google-Smtp-Source: AGRyM1viQhNsrIF6vca1gnBTJBbE8orJXMgOk/K90eoD5AAZtP9179RUZFCZdm3OIkBxzHMY32/iaZUjF9vazOp5sgA=
X-Received: by 2002:a05:6870:5b91:b0:108:374a:96b0 with SMTP id
 em17-20020a0568705b9100b00108374a96b0mr384342oab.126.1656436251542; Tue, 28
 Jun 2022 10:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220628125346.693304-1-sudeep.holla@arm.com> <20220628125346.693304-3-sudeep.holla@arm.com>
In-Reply-To: <20220628125346.693304-3-sudeep.holla@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Jun 2022 19:10:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFrYCOOcwYznde+bOD5_yTSKU5dTerue8192aNp4L9qjw@mail.gmail.com>
Message-ID: <CAMj1kXFrYCOOcwYznde+bOD5_yTSKU5dTerue8192aNp4L9qjw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm64: efi: Simplify arch_efi_call_virt() macro by
 using typeof()
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 28 Jun 2022 at 14:53, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Currently, the arch_efi_call_virt() assumes all users of it will have
> defined a type 'efi_##f##_t' to make use of it. It is unnecessarily
> forcing the users to create a new typedef when __efi_rt_asm_wrapper()
> actually expects void pointer.
>
> Simplify the arch_efi_call_virt() macro by using typeof(p->f) which must
> be a pointer as required by __efi_rt_asm_wrapper() and eliminate the
> explicit need for efi_##f##_t type for every user of this macro.
>
> This is needed now in preparation to enable PRMT support on ARM64.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/include/asm/efi.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index ad55079abe47..53376cdab175 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -29,8 +29,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
>
>  #define arch_efi_call_virt(p, f, args...)                              \
>  ({                                                                     \
> -       efi_##f##_t *__f;                                               \
> -       __f = p->f;                                                     \
> +       typeof(p->f) __f = p->f;                                        \
>         __efi_rt_asm_wrapper(__f, #f, args);                            \
>  })
>

Similar to the other patches, we could simply do

#define arch_efi_call_virt(p, f, args...) \
        __efi_rt_asm_wrapper((p)->f, #f, args)

here.

Note, though, that the second argument stringifies the struct field
name, which will contain "handler_addr" in the case of PRM, but this
is fine (we shouldn't hit that diagnostic for new code anyway, as it
is only used to check whether X18 was corrupted by the firmware)
