Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACF0669669
	for <lists+linux-efi@lfdr.de>; Fri, 13 Jan 2023 13:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241175AbjAMMIP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Jan 2023 07:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbjAMMH1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Jan 2023 07:07:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC25F50E6C;
        Fri, 13 Jan 2023 03:58:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 768E161298;
        Fri, 13 Jan 2023 11:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9CBC433F1;
        Fri, 13 Jan 2023 11:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673611101;
        bh=xgsnTy32xcDNfnTQM10m7sY5s0ofOjbgWgjhxJOwFsY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eF07eTqNQs9K7vJs5PJCmrc2o8Pvf3Lwl0dnooPFnpfYSBv9GEm4YArPkDhxEjtiH
         eGcT2iHdp3CZUWhSciZ9lbcn8DuGhof4/k3Q/DjTe/Vv2pq4XcVaCiuv/JKKVPa3Tf
         R0famaoGcXivntznXDSq3y6REzF/SP5wIeTnpD9x8k34WsCJE8zaUWUblq+CUZM9QC
         bI1vkKA4ryOEL+DVP8pU1CnJBRIjLWNHZIuGkcy36RcyQd57GrgVwEdYp2lgsrsfp3
         yUYzDUUsrKbVdG+XSZ1tzHLA8HaNs+ry8BGWqbHMrP/WAAh32ExvAsGigzBUqehL5A
         hbD9ONFpb8JcQ==
Received: by mail-lf1-f44.google.com with SMTP id f34so32776963lfv.10;
        Fri, 13 Jan 2023 03:58:21 -0800 (PST)
X-Gm-Message-State: AFqh2ko6XwIwdGI7oUx6IoObsON5qFwjXDfAVxRvHumSMpZhGNn5Wjdn
        3ScbOscwiK91mei1Y18OWuDXAFpL90rMD0dXR8k=
X-Google-Smtp-Source: AMrXdXtuOuCrnlEgPVru52/iX8Ur/0jt5yRuwUBNFDBlF0KqZJJku4Xmuzf4dhLnmIi4kgM76bW+bdcrAECZoVERASE=
X-Received: by 2002:a05:6512:3d93:b0:4b8:9001:a694 with SMTP id
 k19-20020a0565123d9300b004b89001a694mr3894521lfv.426.1673611099794; Fri, 13
 Jan 2023 03:58:19 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMxNc4iObjL+8RyJN=Kcy5X1r21ez_05oAuy93J=gQ2gZw@mail.gmail.com>
In-Reply-To: <CAKXUXMxNc4iObjL+8RyJN=Kcy5X1r21ez_05oAuy93J=gQ2gZw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 13 Jan 2023 12:58:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH3hoGWF=c7UVsWi3xoJsJ1VyFK74CV+L8SO8u2o2xdsQ@mail.gmail.com>
Message-ID: <CAMj1kXH3hoGWF=c7UVsWi3xoJsJ1VyFK74CV+L8SO8u2o2xdsQ@mail.gmail.com>
Subject: Re: linker problem with Ubuntu 18.04 tool chain: unknown architecture
 of input file `arch/arm64/boot/vmlinuz.o' is incompatible with aarch64 output
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-efi@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 13 Jan 2023 at 12:50, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Dear Ard,
>
> with my Ubuntu 18.04 arm gcc tool chain, I encounter this linker error
> in my allyesconfig build:
>
>  LD      arch/arm64/boot/vmlinuz.efi.elf
> aarch64-linux-gnu-ld: unknown architecture of input file
> `arch/arm64/boot/vmlinuz.o' is incompatible with aarch64 output
> drivers/firmware/efi/libstub/Makefile.zboot:41: recipe for target
> 'arch/arm64/boot/vmlinuz.efi.elf' failed
> make[1]: *** [arch/arm64/boot/vmlinuz.efi.elf] Error 1
> arch/arm64/Makefile:173: recipe for target 'vmlinuz.efi' failed
> make: *** [vmlinuz.efi] Error 2
>
> I bisected it back to happen since commit c37b830fef13 ("arm64: efi:
> enable generic EFI compressed boot"), and it still appears with the
> latest next-20230113 (on linux-next, I have to remove DRM_MSM as it
> currently comes with a build error).
>
> The specific compiler and linker versions on my system are:
>
> $ aarch64-linux-gnu-ld --version
> GNU ld (GNU Binutils for Ubuntu) 2.30
>
> $ aarch64-linux-gnu-gcc --version
> aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
>
>
> IMHO, I run pretty standard commands:
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 32 mrproper
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 32 allyesconfig
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 32 all
>
> Let me know if you need more information.
>

Hello Lukas,

This seems to mean that AArch64 ld.bfd 2.30 is not able to combine
generic ELF objects with AArch64 ELF objects. vmlinuz.o only contains
a compressed blob in an ELF data section, and more modern toolchains
have no issue with this at all.

Given that building allyesconfig with fairly outdated toolchains is
not something anyone is likely to obsess about, I don't have a strong
preference as to how we work around this, put perhaps the easiest
approach would be for CONFIG_EFI_ZBOOT to depend on !CONFIG_LD_IS_BFD
|| CONFIG_LD_VERSION >= 23xxx here? (We'll need to check the exact
version)
