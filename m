Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F25669E3F1
	for <lists+linux-efi@lfdr.de>; Tue, 21 Feb 2023 16:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjBUPun (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Feb 2023 10:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjBUPum (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Feb 2023 10:50:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B942684B;
        Tue, 21 Feb 2023 07:50:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22DCAB80F03;
        Tue, 21 Feb 2023 15:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62303C433D2;
        Tue, 21 Feb 2023 15:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676994638;
        bh=mz1tP6BevVUDwP7gGFCXZ6st2qmh6ulbhacqzwUvUso=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GBgce3wlKR5rpfnz/ODQ0zKLchmDKoi2uiK6MkclthkVW7rUR/b0V8MXCYj6wrIiD
         V/lZbK5MeV07fqkb+EHzIP0wW+rTmvtDsIpbSLtHUf9Tc75UK9YYj7wqCWlyH9u9Fw
         X7Y0kxQll0sSTor+6HssmDImeEoQXk4RIiIp4cTXOiOfYxIv4TOWCJasfcrGtsZVri
         6GJl5n+t3WDeVtcz+YqMxWs3Xfzs7QGek1ngsZnUb0Z3QB0gy63MghJFdy66j/6muU
         r+Q059k6Ov+NN9fgSbCbmkujKargusrMpITLkizyFvGsdsSWu5khC1Qvpn5/Lr1+pM
         Z4mHNBdvkQhog==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH 0/4] riscv: Introduce KASLR
In-Reply-To: <20230215145113.465558-1-alexghiti@rivosinc.com>
References: <20230215145113.465558-1-alexghiti@rivosinc.com>
Date:   Tue, 21 Feb 2023 16:50:36 +0100
Message-ID: <878rgrqapf.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> The following KASLR implementation allows to randomize the kernel mapping:
>
> - virtually: we expect the bootloader to provide a seed in the device-tree
> - physically: only implemented in the EFI stub, it relies on the firmware=
 to
>   provide a seed using EFI_RNG_PROTOCOL. arm64 has a similar implementati=
on
>   hence the patch 3 factorizes KASLR related functions for riscv to take
>   advantage.
>
> The new virtual kernel location is limited by the early page table that o=
nly
> has one PUD and with the PMD alignment constraint, the kernel can only ta=
ke
> < 512 positions.
>
> Note that the patch "riscv: Use PUD/P4D/PGD pages for the linear
> mapping" is necessary to retrieve the memory below the physical kernel
> address, so that the EFI stub does not have to try to relocate the kernel
> as close as possible to the start of dram.
>
> This patchset is rebased on top of:
>
> Introduce 64b relocatable kernel (https://lore.kernel.org/lkml/2023021514=
3626.453491-1-alexghiti@rivosinc.com/)
> RISC-V kasan rework (https://lore.kernel.org/lkml/Y6TTvku%2FyuSjm42j@spud=
/T/)
> riscv: Use PUD/P4D/PGD pages for the linear mapping (https://lore.kernel.=
org/lkml/20230125114229.hrhsyw4aegrnmoau@orel/T/)
> riscv: Allow to downgrade paging mode from the command line (https://lore=
.kernel.org/lkml/CAHVXubjeSMvfTPnvrnYRupOGx6+vUvUGfRS3piTeo=3DTH2cHKNg@mail=
.gmail.com/)
> base-commit-tag: v6.2-rc7
>
> This patchset was tested with u-boot boottime service for the seed on:
> - ubuntu defconfig + kasan outline (sv39, sv48, sv57): OK
> - ubuntu defconfig + kasan inline (sv39, sv48, sv57): OK
> - ubuntu defconfg (sv39, sv48, sv57): OK

I've taken the series for a spin (qemu u-boot UEFI, and qemu non-UEFI),
on-top of the patches outline above, but with 6.2 proper.

For the series:
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
