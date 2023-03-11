Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5EC6B5EC6
	for <lists+linux-efi@lfdr.de>; Sat, 11 Mar 2023 18:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjCKR2H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Mar 2023 12:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCKR2F (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Mar 2023 12:28:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0D7F74E;
        Sat, 11 Mar 2023 09:28:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC86FB80690;
        Sat, 11 Mar 2023 17:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8685C433A7;
        Sat, 11 Mar 2023 17:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678555681;
        bh=MgWZFw77Mq4oyTN1crwuDMPhX/uS/XNa2w3f/KUQH1s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d9M2olfRzTUVasTmQ53pfkalSBPnQsljd94ecPgo7/B28+RtNutaG3x1qfIFu3Uk1
         8e4o/IHrQ5rgYRsuqSdvtCFAGFlBmNPrZrfSK1RI46bSrQUPwmywHbXz+B1YLO8ZV2
         H2j9Wk+aRsfqrTppQmlqrGD/QUWCPAOt5zpt8WuP/c6/eWFqeBRVH4BEkkPm/DfxGe
         Izu/rOkMxe+fO6xQKGzXXhr+/3rx05vfdZ94pmP6k4nc6ZAeTrDWYHUEJiOubANlsp
         bIqp3cAiYEhpUOcqaoNxhoHtSZezSn5zDswCBxDydkUMEcSv+UIWo9nl0PArAFRjro
         hlrnaaJFSZqKQ==
Received: by mail-lf1-f51.google.com with SMTP id t11so10672359lfr.1;
        Sat, 11 Mar 2023 09:28:01 -0800 (PST)
X-Gm-Message-State: AO0yUKXyD1UWBynrhCvxF10K2jsQRWu8NHx55X9RVI5fFxw+zl1s/Z5m
        q5BY0gdJTQbasfcTyeIVqktW99Scw7rQhyc6i/4=
X-Google-Smtp-Source: AK7set/DORTs5gwcCfki/6Zgo3sscNdW6pA/sij/js5ziMvcFOJCYdnwwNmj4VEXMUd8p9ndyRAgUzDVQjJqjYjUjuM=
X-Received: by 2002:ac2:546c:0:b0:4d5:ca42:aee7 with SMTP id
 e12-20020ac2546c000000b004d5ca42aee7mr9081052lfn.7.1678555679698; Sat, 11 Mar
 2023 09:27:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <cb62472011a0c4151276b6a05b83b60b1bf6f352.1671098103.git.baskov@ispras.ru>
 <CAMj1kXHnQZ2EDg1F_whTPHajYvqox7Ss35aqUyJuC8RLyiuCxg@mail.gmail.com> <ec07e6f7af7b901ad3ff1aa9a8c8fbcb@ispras.ru>
In-Reply-To: <ec07e6f7af7b901ad3ff1aa9a8c8fbcb@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 11 Mar 2023 18:27:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEySE_GuNx+xLPu9pvkZoA6Sph=7BZt-gzVCi4pD1COPA@mail.gmail.com>
Message-ID: <CAMj1kXEySE_GuNx+xLPu9pvkZoA6Sph=7BZt-gzVCi4pD1COPA@mail.gmail.com>
Subject: Re: [PATCH v4 17/26] x86/boot: Reduce size of the DOS stub
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 11 Mar 2023 at 15:49, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> On 2023-03-10 17:59, Ard Biesheuvel wrote:
> > On Thu, 15 Dec 2022 at 13:40, Evgeniy Baskov <baskov@ispras.ru> wrote:
> >>
> >> This is required to fit more sections in PE section tables,
> >> since its size is restricted by zero page located at specific offset
> >> after the PE header.
> >>
> >> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> >> Tested-by: Peter Jones <pjones@redhat.com>
> >> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> >
> > I'd prefer to rip this out altogether.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=9510f6f04f579b9a3f54ad762c75ab2d905e37d8
>
> Sounds great! Can I replace this patch with yours in v5?
>

Of course.

> >
> > (and refer to the other thread in linux-efi@)
>
> Which thread exactly? The one about the removal of
> real-mode code?
>

Yes, this one

https://lore.kernel.org/linux-efi/20230308202209.2980947-1-ardb@kernel.org/
