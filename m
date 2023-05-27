Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841FA713621
	for <lists+linux-efi@lfdr.de>; Sat, 27 May 2023 20:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjE0Smi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 May 2023 14:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjE0Smh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 May 2023 14:42:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A10099;
        Sat, 27 May 2023 11:42:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD7DB615B0;
        Sat, 27 May 2023 18:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A77C433EF;
        Sat, 27 May 2023 18:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685212955;
        bh=ILLm7sjS2AUbgX5ZU3V6OvdwznjKgFXN4a/oNoiqZNE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NUkjfs+FLPecL9MScQaHcjH42z08/Anpuon7d1M1eUg6dsY+F0Orwnz+00gcUcPVx
         U0XH+Oce0uRcTtKwG5Bebcm2vgVFN30IF5We+cbfmYS5TIP5uS/qz+wUodCkoisbqH
         8O/fmbZt1Rp2kMn1pPxyA13RdSiJwxe+ITqKtq3KZAxxCcCgIZm65bcRFYvcbN4XBF
         uUjKrgT4w9we1CU/hIAODtjR/fj3hV9t7mqGRc030Ap8U2O1dGj/Z5cAJR/fCqEZYg
         H4v+6DMcmIZ3edMQH4QKiMSkJPzIBYDFrBf10HdwD5xZ9iaM819AdydDMg/679U6K0
         FaYBLjaaZijhA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2af2602848aso18691191fa.2;
        Sat, 27 May 2023 11:42:34 -0700 (PDT)
X-Gm-Message-State: AC+VfDwLXdx2QImlWGSuWoE3ERd7j4XgxqHGwG81/HE2wQupLrHmnqtI
        6+7cyynGDJG15R1uQNm+MuiWlS4AGDLlISHz3fc=
X-Google-Smtp-Source: ACHHUZ6cjZTU+MaVWVZBdrSI6NnR4VUENr+IJy/gE11EQm0JbKPhjcTfU05GXxO9wspVLC8vMwpOFa/iC3DfdJ1ePoM=
X-Received: by 2002:a2e:7c18:0:b0:2af:23c2:5dce with SMTP id
 x24-20020a2e7c18000000b002af23c25dcemr2054843ljc.25.1685212952230; Sat, 27
 May 2023 11:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <efd6f2d4-547c-1378-1faa-53c044dbd297@gmail.com>
 <CAG8fp8SaHi0X-tZHnji_93wBADp1_=brjauWCVXuLaG7iP0p=A@mail.gmail.com>
 <CAG8fp8QXoEkndCzyaYZmg6+ZrszKOfh_YSi0o2_weV7y1_xYkQ@mail.gmail.com>
 <CAMj1kXGjkKK-oHm64Y9P-AbYQWd9jnEdsNucRbY_-7mgJ_4yAA@mail.gmail.com> <CAG8fp8ReYLaNYO9LYE1WeeSDg1pO1hz3f-8_WPZkLVWbzzyCvg@mail.gmail.com>
In-Reply-To: <CAG8fp8ReYLaNYO9LYE1WeeSDg1pO1hz3f-8_WPZkLVWbzzyCvg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 27 May 2023 20:42:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEGTJufrrcrqjjKqeR-FN+nLsbzx8xGgO+gPfc2YPsy2w@mail.gmail.com>
Message-ID: <CAMj1kXEGTJufrrcrqjjKqeR-FN+nLsbzx8xGgO+gPfc2YPsy2w@mail.gmail.com>
Subject: Re: mix of ACPICA regression and EFISTUB regression (Was: kernel >=
 v6.2 no longer boots on Apple's Virtualization.framework (x86_64); likely to
 be related to ACPICA)
To:     Akihiro Suda <suda.kyoto@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux x86 <x86@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux ACPICA <acpica-devel@lists.linuxfoundation.org>,
        Linux Stable <stable@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 27 May 2023 at 20:34, Akihiro Suda <suda.kyoto@gmail.com> wrote:
>
> > Are you using OVMF? Which versions of qemu and OVMF are you using?
>
> I'm using Apple's Virtualization.framework, not QEMU.
>
> It doesn't use UEFI when it directly loads bzImage.
> ( dmesg: https://bugzilla.kernel.org/attachment.cgi?id=304323 )
>
> Despite that, it still expects LINUX_EFISTUB_MINOR_VERSION
> (include/linux/pe.h) referred from arch/x86/boot/header.S to be 0x0.
> I confirmed that the kernel can boot by just setting
> LINUX_EFISTUB_MINOR_VERSION to 0x0.
>

Thanks for checking that, that is very helpful/

> Would it be possible to revert the LINUX_EFISTUB_MINOR_VERSION value
> (not the actual code) to 0x0?
> Or will it break something else?
>
> Anyway, I'll try to make a request to Apple to remove the
> LINUX_EFISTUB_MINOR_VERSION check.
>

Yes, that makes the most sense. If the existing virtual machine BIOS
has a hardcoded check that the EFI stub version is 1.0 even if it does
not boot via EFI to begin with, I don't see how we can reasonably
treat this as a regression that needs fixing on the Linux side.

The version bump to PE image version v1.1 sets a baseline across all
Linux archifectures that can boot via EFI that initrd loading is
supported via the command line as well as via the LoadFile2 protocol.
Reverting that would substantially reduce the value of having this
identification embedded into the image.
