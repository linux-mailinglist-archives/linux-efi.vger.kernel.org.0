Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BFB62F1D4
	for <lists+linux-efi@lfdr.de>; Fri, 18 Nov 2022 10:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiKRJvG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Nov 2022 04:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241311AbiKRJvF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Nov 2022 04:51:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CBF2D7
        for <linux-efi@vger.kernel.org>; Fri, 18 Nov 2022 01:51:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20909623DB
        for <linux-efi@vger.kernel.org>; Fri, 18 Nov 2022 09:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A38C43470
        for <linux-efi@vger.kernel.org>; Fri, 18 Nov 2022 09:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668765062;
        bh=n/nGaPUKKquVXIhh+6sLM6/p00iyOlkoI1sNUDeyuQs=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=eWjVhcODDTPuCqUr4FXL0uflP6HNju/PjldI9C+IdLbwc/CXY2ylAy0fXIYuAg1Ct
         oo8sZOsxDDFZQJiwGkFOeLPdq0yGvj8L554GEvi8EfaYX85oSqy8O8HsjsVe9CUpGj
         iybKQ3K6zyvFofCGCFC6Bsxn2uLSAeaC1lQCee978T7ANtGEfXTBb8sHVqxuvpBrq4
         PzTWXoSU913KRJqUggTCLmsWyv0OBPaqwWbu8itlDNi8fmuO2d+OWKN831XNMrWbZ5
         RpTsq7gRblaj95/85q2byWnGbBTrhfF3VxhpGz85k7vrED6lptQRyIFiVGqqAZQKJG
         +2VO4px5YVKjw==
Received: by mail-lf1-f53.google.com with SMTP id r12so7395535lfp.1
        for <linux-efi@vger.kernel.org>; Fri, 18 Nov 2022 01:51:02 -0800 (PST)
X-Gm-Message-State: ANoB5png3KGxmWQF84G5ijZuCkPRLQAfVaNFhA+eYFCJdFEkVs8Lqujk
        nWaq3ewmiSr1AVCET57h3gYPoDevxtfCSDLkZcY=
X-Google-Smtp-Source: AA0mqf7FA/eIi+WI7Ruhu1z19deHn3VaAeNoNpurFgP04V//ggc9kn1AD/GsUQPvHKP+9FfuVxZ0XZIA4pX00CSS6JU=
X-Received: by 2002:ac2:5ec9:0:b0:4a2:2aad:95c4 with SMTP id
 d9-20020ac25ec9000000b004a22aad95c4mr2531540lfq.110.1668765060389; Fri, 18
 Nov 2022 01:51:00 -0800 (PST)
MIME-Version: 1.0
References: <5877854.lOV4Wx5bFT@big>
In-Reply-To: <5877854.lOV4Wx5bFT@big>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 18 Nov 2022 10:50:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG9HRWDoW66rVBCNX_jfu+Od9vQdPxphKh94fWkEfYBdA@mail.gmail.com>
Message-ID: <CAMj1kXG9HRWDoW66rVBCNX_jfu+Od9vQdPxphKh94fWkEfYBdA@mail.gmail.com>
Subject: Re: Efi-stub-kernel with embedded initramfs does not boot
To:     =?UTF-8?Q?Peter_B=C3=B6hm?= <peter.bo@web.de>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 15 Nov 2022 at 15:34, Peter B=C3=B6hm <peter.bo@web.de> wrote:
>
> Dear Ard Biesheuvel,
>
> this is my first kernel bug report ever (and I am not a native english
> speaker), please be patient with me ;-)
>

Hello Peter,

Thanks for the report.

> I have read
> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
> and found your email address here:
> https://www.kernel.org/doc/html/latest/process/maintainers.html#maintaine=
rs
>
> I configure my kernels since 20 years but I am not a kernel hacker. I hav=
e a
> working LTS kernel (5.15.78) in a Gentoo system.
>

So if I am understanding this correctly, you are reporting that the
config below simply does not work at all, and this 5.15 kernel does
not use a built-in initramfs, right? Or did something get broken after
5.15 was released?

>
> A) Bug Summary:
>
> Kbuild allows me to add an embedded (=3Dbuilt-in) initramfs to my working=
 efi-
> stub-kernel (signed because of secureboot). This combination does not boo=
t:
> BIOS boot screen starts with: "EFI Stub: UEFI Secure Boot is enabled"; th=
en
> blank screen; then two beeps; then trying to boot again; endless loop can=
 only
> be stopped by pressing <F12> and entering UEFI BIOS (and selecting a work=
ing
> kernel).
>
> Note: Kernel builds without any error message (of course I have beside th=
e
> initramfs_list also a init in /usr/src/initramfs)
>

How much does the size of the bzImage increase due to the initramfs
being incorporated? Given the below, it should be tiny, right?


>
> B) Difference between working kernel and failed:
>
> CONFIG_BLK_DEV_INITRD=3Dy
> CONFIG_INITRAMFS_SOURCE=3D"/usr/src/initramfs/initramfs_list"
> CONFIG_INITRAMFS_ROOT_UID=3D0
> CONFIG_INITRAMFS_ROOT_GID=3D0
> CONFIG_RD_GZIP=3Dy
> CONFIG_INITRAMFS_COMPRESSION_GZIP=3Dy
>
> I also know a solution called "UKI" (unified kernel image) in other
> distributions; but why building such scrap if my beloved kernel has all
> necessary pieces also ? Kernel hast efi-stub, built-in kernel command lin=
e and
> embedded initramfs ...
>

Agreed. You shouldn't need UKI for this.

However, I tested this locally with a rootfs.cpio file I use for
testing, and it happily boots in EFI mode and going through the stub
etc.

Can you check and see if earlycon=3Defifb produces some more output?
