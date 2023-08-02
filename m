Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CA476D0AC
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 16:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjHBOzn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 10:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjHBOzm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 10:55:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3AA134;
        Wed,  2 Aug 2023 07:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7201619D6;
        Wed,  2 Aug 2023 14:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2C4C433CB;
        Wed,  2 Aug 2023 14:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690988141;
        bh=FZMPhXQrHyK9eeuZN1J/jrG/TyLK6PIVTmkTcWu2x8Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nf9+x2Nau3IaPligYAwj77m2G8cVmC3xLAgRSYIxggCfuHTvqe9UxQcRObhU3LB6F
         1v4ZMmPclGeYuyAmt37pw09cOJ8INnHVNQfK19PHJC0Ul0uukSTwF4UnpaqZiOVNOH
         otSck7fW999Mqi6onftfzhTWKYAU4IVnj9oPXtDy9o0gz20LYgk6br0mHtbNwopoJK
         y8VZixxHCG2a0A4bc/BOxEL9l1dgrJsb2Ikp2PV85GGk80a0TMpBq62qIR2mbO2L/z
         cAE16MeEIN5qpa83iieROd2qpUkpfbppPSb39FZxtGg/fo1bEYpfhmu21hyTZBky4l
         /EpiUINyLQZwA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4fe1c285690so10266862e87.3;
        Wed, 02 Aug 2023 07:55:40 -0700 (PDT)
X-Gm-Message-State: ABy/qLboc5+b4WcRZn0Wy5uZK7E699r0NJoLYEK2GTdfFqN+LDAhxDwD
        peVQ5ufe7tIWHyDvswt/a8vmgqEC3k2CiRsnTyo=
X-Google-Smtp-Source: APBJJlFkgTdGC/+fMRk0576THqIS5DHxPQs47yVN+ZI5ALLSkyek+7GbY4Kn3l6ILVEhda600DZTBdXCm8GHDpwxGSg=
X-Received: by 2002:ac2:4e81:0:b0:4f9:5396:ed1b with SMTP id
 o1-20020ac24e81000000b004f95396ed1bmr4371719lfr.28.1690988139082; Wed, 02 Aug
 2023 07:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
 <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local> <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
 <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local> <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
 <20230802093927.GAZMokT57anC5jBISK@fat_crate.local> <99cb3813-1737-9d10-1f24-77565e460c55@amd.com>
 <20230802135856.GBZMphIHHLa3dXRRVe@fat_crate.local>
In-Reply-To: <20230802135856.GBZMphIHHLa3dXRRVe@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 2 Aug 2023 16:55:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEM5hGknVGwHh_w99D4L8yrYrTFycwGHZ0CQun70CLipw@mail.gmail.com>
Message-ID: <CAMj1kXEM5hGknVGwHh_w99D4L8yrYrTFycwGHZ0CQun70CLipw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, Tao Liu <ltao@redhat.com>,
        Michael Roth <michael.roth@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, bhe@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2 Aug 2023 at 15:59, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Aug 02, 2023 at 08:40:36AM -0500, Tom Lendacky wrote:
> > Short of figuring out how to map page accesses earlier through the
> > boot_page_fault IDT routine
>
> And you want to do that because?
>

... because now, entering via startup_32 is broken, given that it only
maps the kernel image itself and relies on the #PF handling for
everything else it accesses, including firmware tables.

AFAICT this also means that entering via startup_32 is broken entirely
for any configuration that enables the cc blob config table check,
regardless of the platform.
