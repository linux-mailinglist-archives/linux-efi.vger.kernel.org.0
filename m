Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612935B17D6
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 10:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiIHI4o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 04:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiIHI4o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 04:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABFBD51C6
        for <linux-efi@vger.kernel.org>; Thu,  8 Sep 2022 01:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA6AF61BEC
        for <linux-efi@vger.kernel.org>; Thu,  8 Sep 2022 08:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499D6C4347C
        for <linux-efi@vger.kernel.org>; Thu,  8 Sep 2022 08:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662627402;
        bh=zXD0AhIkAs9V9ujmbhY+ItD4u4SB0nRzuzTmbqt13Nk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cu1m4CWz2lDiSxNPa0/CLUV0zrxoViOugUPioSZ+wTCsBQSyY55w7K7OadtEQU5UQ
         cxaFLEZi54G29alXivtIxnS6M60JqZoZdPn9NigT3cquV82PBwfcJGyaOAL/YE/QTT
         tsn+5Fdb7ZnNrxVhRIj6oOAIgfVzALUSamb9E7TJsiydCaMZkZN/QLD4f0Uencm2aq
         m6G2lzls4xvf0j6Wk2IP+9osIGL2/WI/y44ZH53sMhunDyF4lN889JVdOJSbTv0yke
         I30MQYuKdtH7d1NLBl9SFwTSN/g/qiYavF50i6R4XkFgH8WU67e9lmRm8G5BPVpLA8
         UtVIVG7GYuOMw==
Received: by mail-lj1-f176.google.com with SMTP id z23so19099987ljk.1
        for <linux-efi@vger.kernel.org>; Thu, 08 Sep 2022 01:56:42 -0700 (PDT)
X-Gm-Message-State: ACgBeo3mJGLRcwd6zYRgjIZB/a1Wiu1sotivP5/2S8uYnhxSQ3MoK7+m
        K458er2QOtThJXI1AHGd8OTkKW5PMKAlDzKWm5k=
X-Google-Smtp-Source: AA6agR4kxwUVNNkpcbi+yox6dCY4sg4NP3PS5hDfkUXqVOOxolWBGrqZzuZh5ifSB/NQHLftbTlCFI4Ko0wETR7WDXY=
X-Received: by 2002:a2e:7314:0:b0:26a:ca18:60eb with SMTP id
 o20-20020a2e7314000000b0026aca1860ebmr1994798ljc.69.1662627400199; Thu, 08
 Sep 2022 01:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220907023255.35237-1-chenzhang@kylinos.cn> <ba9c545066d80740df279a34c4fa795a@ispras.ru>
 <CAMj1kXFJHht=9r054cCKCzAjnSCrbRi9pD--XLNc-xrpHQnFBA@mail.gmail.com> <f0ca5dbabdd289fa14e0b0fe852b761c@ispras.ru>
In-Reply-To: <f0ca5dbabdd289fa14e0b0fe852b761c@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 8 Sep 2022 10:56:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEVavPX6xHLs2zs4DTgfEHDeLweev9Z1NbAYJQPVBL4cA@mail.gmail.com>
Message-ID: <CAMj1kXEVavPX6xHLs2zs4DTgfEHDeLweev9Z1NbAYJQPVBL4cA@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: libstub: remove unused variables
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     chen zhang <chenzhang@kylinos.cn>, ilias.apalodimas@linaro.org,
        chenzhang_0901@163.com, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 8 Sept 2022 at 10:48, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> On 2022-09-08 11:43, Ard Biesheuvel wrote:
> > On Thu, 8 Sept 2022 at 10:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
> >>
> >> On 2022-09-07 05:32, chen zhang wrote:
> >> > The variable "has_system_memory" is unused in
> >> > function =E2=80=98adjust_memory_range_protection=E2=80=99, remove it=
.
> >> >
> >>
> >> Thanks for pointing out.
> >> Will change that in v2.
> >>
> >
> > v2 of what? Isn't this code already in mainline?
>
> Oh, right.
>
> There are just more patches pending that change
> that function. I can do that via separate patch later
> today, I guess.
>

But Chen Zhang already sent a patch that fixes this, so why bother?

I will queue this as a fix. Please rebase your patches on top if this
causes a conflict.

Thanks,
