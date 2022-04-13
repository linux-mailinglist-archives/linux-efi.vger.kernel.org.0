Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5E84FFC2A
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 19:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiDMROa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 13:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbiDMRO3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 13:14:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8A56AA4A;
        Wed, 13 Apr 2022 10:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D77FFB82663;
        Wed, 13 Apr 2022 17:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991B3C385AB;
        Wed, 13 Apr 2022 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649869925;
        bh=gbreY5EZm5Hdz5VUm0yMo/CRP2FBt1ekdqTihXr4SLc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=laZncea9PrRC8w3saqV1Xp5IMP1QrvwfkDGFEH0GLMCtB/gLohQTS7tiq9N9PEz42
         d8+zjNjCeTn4HUSzlEsK2qrwTb3Qk/YCd1Z8hqIiYt0QqrVs9NhUYeUypl31ZkmWxv
         YZaUNwCZbnfAVisEGC93GUduQraPt2BejdvgMBqJ9QxirWDPSuvsFrRmGp7BLtZcgs
         J4tVdWcG6LUpAhhY14r8CtgAvsAFYAjVEQs9TxhQXMdjrMSWlM3xTiZkI9JVTXrK4R
         CI0GEYMqZtkSIjLlY7rCnwNPWubhS0iz9DFD3Fnv5BYluX0bY+4B0tVrxwzvODQxpI
         y8uUWmmwpKQrw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so2659566fac.7;
        Wed, 13 Apr 2022 10:12:05 -0700 (PDT)
X-Gm-Message-State: AOAM5325JJqGAy2rIe8ytUxooCO2Nbpzgv1AYTd2FiQOQTNdTZINMDGf
        Pz/lLyzpGRdCvjJxy1kQkucet517Hz6p92Q6aq8=
X-Google-Smtp-Source: ABdhPJzoUiYv3LpSzqOKsqPieARDNusXrE6TCTNTkWIprk1YtpkigP2Z70J0SrtJMKGrVJ0d1EWF2cNPezysAZRi2/M=
X-Received: by 2002:a05:6870:b027:b0:de:7fcd:fabf with SMTP id
 y39-20020a056870b02700b000de7fcdfabfmr4819279oae.126.1649869924713; Wed, 13
 Apr 2022 10:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220331151654.184433-1-javierm@redhat.com> <CAMj1kXHgyjB_BVzXx+CK0tBuJpZ3h=8XKus7nWiyovECjVQ0gw@mail.gmail.com>
 <YkYA/Wpqa/PMczkp@lx-t490> <CAFOAJEeKNy0HW82W6HV_49d5sc5L0m62QDfY9qA1906_ZzGRYg@mail.gmail.com>
 <Ykas9iX/D3WURx8T@linutronix.de> <78a0360d-1a27-5280-10bf-d27d1d306fa5@redhat.com>
 <CAMj1kXGEBtcdD+3MFK5gO6vCw8dg=ruTthdWGVUu1eJpgZXf8Q@mail.gmail.com> <YkbAPPDJyiZ/FLN1@linutronix.de>
In-Reply-To: <YkbAPPDJyiZ/FLN1@linutronix.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 13 Apr 2022 19:11:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEZa__9KK2xaSqCQ8ftfinL5g-5BeG6aXzEC8GVdAgtgA@mail.gmail.com>
Message-ID: <CAMj1kXEZa__9KK2xaSqCQ8ftfinL5g-5BeG6aXzEC8GVdAgtgA@mail.gmail.com>
Subject: Re: [PATCH v2] efi: Allow to enable EFI runtime services by default
 on RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
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

On Fri, 1 Apr 2022 at 11:05, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-04-01 10:34:03 [+0200], Ard Biesheuvel wrote:
> > I don't think we need another warning.
>
> exactly.
>
> > The kernel log already tells you whether or not EFI runtime services
> > are enabled.
>
> Correct. We either warn about all problematic options or none but this
> is independent of this patch.
>

Queued up now in efi/next. Thanks all.
