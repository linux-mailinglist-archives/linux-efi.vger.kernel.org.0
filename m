Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A9655EB97
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 19:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiF1R6y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 13:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiF1R6w (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 13:58:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF7012A81
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 10:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 094E6619E2
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 17:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8B9C341C6
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 17:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656439130;
        bh=tCHnSP+PYlGDf2skRCINaSQeIMKSTx2yxy8HuYSWhyA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aIccCxapykEzMbpAtlobX3t+FnzJdgQY5tmENxu7JByJEwU4yPcNrUVEpDyhrIECM
         Nlz3zuyU6p3LYkg129G7cuowPQLLoc32iJJ+QKhDtw1rj+zj6u2HcnmZODCHJ7TrLC
         2yf73rvw4xjVL25vwgZcV7LxvU82EevCeM1cXXZbs8aGmwr4afYU2rDl50yK1+CN0Q
         4DgF+eO2RKzk5CP7cxjIAmGC1KuK2YvdTLSq1LhaJwzg7iHZ5/GYCcN3D+ZkZhhpF7
         pKS5z3mAm3ZcUklJzDrlmBaierndpSPF4YruDsFZ8kKsRW3qIi82boF6/9o7ZT/VQ5
         VV5qWCc6rlW3g==
Received: by mail-oi1-f180.google.com with SMTP id l81so18234714oif.9
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 10:58:50 -0700 (PDT)
X-Gm-Message-State: AJIora+YtmUwtO31/mrmw05XCeypaKY8xRmYeh+2L5JVh35xrhRGPS2W
        JJTT3d0xeo8JTyyBL4h/E9D/6TZy7nvmJSf1YVs=
X-Google-Smtp-Source: AGRyM1sGlYHFN2EQpaJsdu0ZWFpo9yQuWnuQCOFeHmnipdsUFak6KS+GrmcJ9RCEvVNdRw6oWbUGatGq2AGNMwzF2xE=
X-Received: by 2002:a05:6808:300e:b0:32c:425e:df34 with SMTP id
 ay14-20020a056808300e00b0032c425edf34mr552032oib.126.1656439129610; Tue, 28
 Jun 2022 10:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220628125938.694256-1-sudeep.holla@arm.com> <CAMj1kXENKbduN65vs-qAeuiApA8e=_ee5jxVPzRf5kxn8bAzcQ@mail.gmail.com>
 <20220628134738.xqj6gu5ngbsuql2f@bogus> <CAMj1kXG+CjXUa+ysfpoc64GZRPKvVwSVehgkUUU+on-gAUS+KA@mail.gmail.com>
 <20220628140929.do5e5ic77twmed5e@bogus>
In-Reply-To: <20220628140929.do5e5ic77twmed5e@bogus>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Jun 2022 19:58:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHyRgT0mM5+r6Gd0ww5ADB9coDGbuYY8KCQJibTJdzBSQ@mail.gmail.com>
Message-ID: <CAMj1kXHyRgT0mM5+r6Gd0ww5ADB9coDGbuYY8KCQJibTJdzBSQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: efi: Simplify arch_efi_call_virt() macro by using typeof()
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 28 Jun 2022 at 16:09, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Jun 28, 2022 at 03:57:38PM +0200, Ard Biesheuvel wrote:
> > On Tue, 28 Jun 2022 at 15:47, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
...

> > > I am yet to figure out how asm/efi.h and linux/efi.h are included so that
> > > we can have generic definition in linux/efi.h and x86 can undefine that
> > > and redefine its own version.
> > >
> > > Does that make sense ?
> > >
> >
> > I appreciate the effort, but for now, let's just fix the ones we need
> > to fix (and the ARM one too while we're at it). PRM can only be
> > enabled on x86 and arm64 anyway.
>
> True. OK then I will just update ARM version and leave loongarch as is.
>

Actually, this was rather straight-forward so I folded this change
into your ARM patch.
