Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5514E5653
	for <lists+linux-efi@lfdr.de>; Wed, 23 Mar 2022 17:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbiCWQ33 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Mar 2022 12:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbiCWQ32 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Mar 2022 12:29:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9103413F6C
        for <linux-efi@vger.kernel.org>; Wed, 23 Mar 2022 09:27:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso6942557pjb.0
        for <linux-efi@vger.kernel.org>; Wed, 23 Mar 2022 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+GkM0EsIpmPEs+2fEuWOpfnSs20UxwWfYqecrAXhXLY=;
        b=QF3UUYiCGO0ViS4CuMlDVBr4REmIM+Fg/874L9K8EsFLMZEcwyY66S3OiF/Sn8CmlN
         w510dTQHFNL79JLWdyeXLg8qwMWPV12BBrShW3e+KTsIvOcs7iMKTFMgTCnXuhFctgsS
         tKyyhZVL0h9ZmrSWpJWI0iaKhHoBy6Lm3tz6Sm2YaOSb8VWG4jZA3qjllYGm8Xbd27/7
         dBKb36Brw6auML+vARie2pdIEzTRmZGcvkaX6150GSjin1Qh8gbhhGmrpIUKwRCFsaJ1
         GvVRKp2/SejAxChhSj+W7RAmlSX+Mhrz3KFmuqOL5H6+dX8pNuZb/XH+oM6wM3wzWg0c
         9CKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+GkM0EsIpmPEs+2fEuWOpfnSs20UxwWfYqecrAXhXLY=;
        b=gkQuS06iCpH8pBrnorFE6pX2FLuudR5zQLP7TybBLUdaAjI2nOaaagspLFEutgJGkK
         EAcMbbifLDRVS9Hk9iWG5Qu8zUoGqmJjitNefSzj6l+WmWf3xFITQcnaT+Cn+8YR4zT1
         B43wek+aVJRPNyVdUN3XXjtj9m+GiN7aJqFqdSjAo/F3j5mYaPTCLqFs8TfzuQapzPYF
         cjiidNGp+MtUDd5bc8BdLWEMEZz7tuBdsiQ6bwQpBqvaWSo1gDp2nCBo0JgSOv42cPZZ
         xPTzWpHrgSpNJGbDOG+NphrFvZJ6tI0m4e6nMv0emfxb5y87kMKs1KxzRynp3d0f+hsd
         mCfg==
X-Gm-Message-State: AOAM5302VlMiW2qM62YR2yV99FFx6SVMAWXzX1qrJJ/8QTe4UwsTtI7Z
        7RplIb442NIm4iL4lDW4PXO4aw==
X-Google-Smtp-Source: ABdhPJxdyw30bh2pKE+3hwkGOES/bE/U5B9N1OxqWylkElPtex6mxLZrmYAnSavkrnoUSGgDJYnPog==
X-Received: by 2002:a17:902:d48d:b0:153:a517:6ff2 with SMTP id c13-20020a170902d48d00b00153a5176ff2mr756437plg.141.1648052878061;
        Wed, 23 Mar 2022 09:27:58 -0700 (PDT)
Received: from sunil-laptop ([49.206.7.17])
        by smtp.gmail.com with ESMTPSA id r1-20020a63b101000000b00380989bcb1bsm289959pgf.5.2022.03.23.09.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 09:27:57 -0700 (PDT)
Date:   Wed, 23 Mar 2022 21:57:48 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     ardb@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, heinrich.schuchardt@canonical.com,
        Atish Patra <atishp@rivosinc.com>, apatel@ventanamicro.com,
        abner.chang@hpe.com, jrtc27@jrtc27.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH V2 0/1] RISCV_EFI_BOOT_PROTOCOL support in linux
Message-ID: <20220323162748.GA55066@sunil-laptop>
References: <20220303145944.307321-1-sunilvl@ventanamicro.com>
 <mhng-5eb23850-e2a9-43d3-8093-2f588c71de00@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-5eb23850-e2a9-43d3-8093-2f588c71de00@palmer-ri-x1c9>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Mar 22, 2022 at 06:32:22PM -0700, Palmer Dabbelt wrote:
> On Thu, 03 Mar 2022 06:59:43 PST (-0800), sunilvl@ventanamicro.com wrote:
> > This patch adds support for getting the boot hart ID using new
> > RISCV_EFI_BOOT_PROTOCOL in linux efi stub. While there is an existing
> > solution of passing the boot hart ID through Device Tree, it doesn't work
> > for ACPI. Hence an EFI protocol protocol is recommended which works for
> > both DT and ACPI based platforms.
> > 
> > The latest draft spec of this new protocol is available at
> > https://github.com/riscv-non-isa/riscv-uefi/releases/download/1.0-rc2/RISCV_UEFI_PROTOCOL-spec.pdf
> 
> This looks fine to me, but we need the spec folk to commit to this being a
> stable interface before we can start using it.  Historically that's been
> "frozen" for RISC-V specs, but I'm not sure how that all fits together in
> EFI land as IIUC we also have to follow the UEFI forum's process.  Last I
> checked you guys understood that better than I did, so

Thank you Palmer. The specification is in frozen state now. 
http://lists.infradead.org/pipermail/linux-riscv/2022-March/013431.html.

Thanks
Sunil
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # pending spec freeze
> 
> I had a minor comment about the error message, as well.
> 
> Thanks!
> 
> > This linux ptach can be found in:
> > riscv_boot_protocol_rfc_v2 branch at
> > https://github.com/vlsunil/linux.git
> > 
> > This is tested in qemu with u-boot 2022.04.rc3.
> > 
> > Changes since V1:
> >   - Rebased to get the "Fix get_boot_hartid_from_fdt() return value"
> >     patch
> >   - Removed mixed_mode member
> >   - Separated return value and status.
> > 
> > Sunil V L (1):
> >   riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL
> > 
> >  drivers/firmware/efi/libstub/efistub.h    |  7 ++++++
> >  drivers/firmware/efi/libstub/riscv-stub.c | 29 +++++++++++++++++++----
> >  include/linux/efi.h                       |  1 +
> >  3 files changed, 32 insertions(+), 5 deletions(-)
