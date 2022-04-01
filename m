Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4063A4EE9CE
	for <lists+linux-efi@lfdr.de>; Fri,  1 Apr 2022 10:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243139AbiDAIgK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 1 Apr 2022 04:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiDAIgJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 1 Apr 2022 04:36:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430FD11CF5E;
        Fri,  1 Apr 2022 01:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A3B36CE2484;
        Fri,  1 Apr 2022 08:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138E6C340F3;
        Fri,  1 Apr 2022 08:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648802056;
        bh=Cncuw6yqenexeu+oWaSLLblZjy6J8jeXz+OAjdQ5xtk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Atx2Fv8o9O6J/7hIyJtr6yRT8ATN36+yKY6WQql8aA+mqGVD6GzExOjGMs8H/Dcqm
         c4msXs+fOJLs1qTJhu1aG6HrIBl7PclD7wlpqrZEk9OswZiQhs1pfwHGQlRpsD/e2K
         83+pgwzjU3OAmKsPEbrOL6Xvwk7cz4F8kCwkUIFKU7FP/sxlZTMxsKPN7Ov4NXmVQs
         DLw1uTjt8YS0b/xHpOIoEjKLymTp/GWW34fAvMR0kPbglRWpcKIKGg9VaVpFfuXSUH
         cTnArqqcKb1DKKIaBnwGCIwzo5HNnzT98CfTEMAhaNCBtpic80B3OXKuO2LcIeWwQF
         kOrphnZY8WV5w==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-de3eda6b5dso2038029fac.0;
        Fri, 01 Apr 2022 01:34:16 -0700 (PDT)
X-Gm-Message-State: AOAM531Jl2JyJe3fE0HEMdE1ay4KhxuO1IN2yKRsi3OMVZu5M8LkNcUS
        aHwbDm2Osts7qdkuZy7k2e5aCtrp2VE2yyL/4wA=
X-Google-Smtp-Source: ABdhPJw87XIU8FxsZOyjQjE5PaT7P+Ik2xZ3cgPuXugVdVZG6AxSTNO1MN5wHSyteT84mp7c/EhxB48Z9U578Sj6uac=
X-Received: by 2002:a05:6870:b027:b0:de:7fcd:fabf with SMTP id
 y39-20020a056870b02700b000de7fcdfabfmr4575684oae.126.1648802055182; Fri, 01
 Apr 2022 01:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220331151654.184433-1-javierm@redhat.com> <CAMj1kXHgyjB_BVzXx+CK0tBuJpZ3h=8XKus7nWiyovECjVQ0gw@mail.gmail.com>
 <YkYA/Wpqa/PMczkp@lx-t490> <CAFOAJEeKNy0HW82W6HV_49d5sc5L0m62QDfY9qA1906_ZzGRYg@mail.gmail.com>
 <Ykas9iX/D3WURx8T@linutronix.de> <78a0360d-1a27-5280-10bf-d27d1d306fa5@redhat.com>
In-Reply-To: <78a0360d-1a27-5280-10bf-d27d1d306fa5@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 1 Apr 2022 10:34:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGEBtcdD+3MFK5gO6vCw8dg=ruTthdWGVUu1eJpgZXf8Q@mail.gmail.com>
Message-ID: <CAMj1kXGEBtcdD+3MFK5gO6vCw8dg=ruTthdWGVUu1eJpgZXf8Q@mail.gmail.com>
Subject: Re: [PATCH v2] efi: Allow to enable EFI runtime services by default
 on RT
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Brian Masney <bmasney@redhat.com>, Al Stone <ahs3@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 1 Apr 2022 at 10:33, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Hello Sebastian,
>
> On 4/1/22 09:42, Sebastian Andrzej Siewior wrote:
> > On 2022-04-01 00:19:57 [+0200], Javier Martinez Canillas wrote:
> >>> In case of (CONFIG_PREEMPT_RT=y && CONFIG_EFI_DISABLE_RUNTIME=n),
> >>> shouldn't we add a small message in the kernel log warning that EFI
> >>> runtime services are enabled for the RT kernel?
> >>>
> >>> In almost all HW, except custom ones with "verified" firmware, such a
> >>> warning would be useful... This is especially true since in the embedded
> >>
> >> I considered that as well but was not sure about what that message should be.
> >
> > This makes sense and we had this in the past but dropped it for some
> > reason.
> >
>
> Ok, something like the following maybe? If you agree, I'll squash in v3:
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index ff57db8f8d05..08d329a5179b 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -362,6 +362,8 @@ static int __init efisubsys_init(void)
>
>         if (!efi_enabled(EFI_RUNTIME_SERVICES))
>                 efi.runtime_supported_mask = 0;
> +       else if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +               pr_warn("EFI runtime services can lead to high latencies on Real-Time kernels\n");
>
>         if (!efi_enabled(EFI_BOOT))
>                 return 0;
>


I don't think we need another warning.

The kernel log already tells you whether or not EFI runtime services
are enabled.
