Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBD1561F71
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jun 2022 17:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiF3PhI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Jun 2022 11:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiF3PhH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Jun 2022 11:37:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EB75592;
        Thu, 30 Jun 2022 08:37:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85D4D61DB3;
        Thu, 30 Jun 2022 15:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1643C34115;
        Thu, 30 Jun 2022 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656603425;
        bh=kZbOqe/xE4kleh/0TVsBn0tTBsln64oKNXrCJvFiA6o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OE+6vr57qcvTC/GgQn1VwWH5hW+jP10cUQqG35fV759WaxsLmKqZ3h37EiNcSvTfg
         HDUefQfCEeNWj/RvT1teYEUtJn72KqAT8BGmSgMtRC9pLfw11z9y5KC1gvlLfMruTF
         1Oktg7fA6doHMx1Os7Bds2fQPIgLvxKMh0bqnp8yAN9+m6YyCj6biqsCHgnTmruG0+
         zyT70Lh9hKUdXIUt3wPflRjrYw0JYx0gXha4+fHeSN9IAo+JGaSX4SUbJMwEBjkI+O
         l1z2aBSuu80Clzg9JUB9yzR12ZDlMTI25lcOnCXOJtUTq9Xg15gdyC35Cb/oJ5IOjQ
         CJy0tQ22qlf2A==
Received: by mail-lj1-f180.google.com with SMTP id b19so10870272ljf.6;
        Thu, 30 Jun 2022 08:37:05 -0700 (PDT)
X-Gm-Message-State: AJIora+YP8rzgtE3BTeLH25VqkeUW65MLAVvYEJWoUum55CIisAzigWS
        C5z/CkANekF82E2eXtenFiRZDuey2ZtPu4wcbY4=
X-Google-Smtp-Source: AGRyM1sK3oxBA4xCy2NRMFQmIeJKy1LoQS/DBLnZDSeWYXNKimZxHQi1aUp5PrdtOtXLA8lU6mc8US0zoShFZoH41PI=
X-Received: by 2002:a2e:b555:0:b0:25b:bfa0:30f1 with SMTP id
 a21-20020a2eb555000000b0025bbfa030f1mr5451706ljn.373.1656603423945; Thu, 30
 Jun 2022 08:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220628125346.693304-1-sudeep.holla@arm.com> <20220629090635.6kf7thawc4qc4zi2@bogus>
 <20220629092137.a5fl33recfds7bq3@bogus> <CAJZ5v0iuOMxmwbHr_2F4V6+VtNLR42BxkXDuty-EFhaeZwHvNg@mail.gmail.com>
 <20220630130200.4jukcfwiescii32t@bogus>
In-Reply-To: <20220630130200.4jukcfwiescii32t@bogus>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 30 Jun 2022 17:36:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFTbPQfkxskJS2ifECRF-oejm_hKXDL29_ScPir=voxYg@mail.gmail.com>
Message-ID: <CAMj1kXFTbPQfkxskJS2ifECRF-oejm_hKXDL29_ScPir=voxYg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] ACPI: Enable Platform Runtime Mechanism(PRM)
 support on ARM64
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>
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

On Thu, 30 Jun 2022 at 15:03, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jun 29, 2022 at 09:12:39PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 29, 2022 at 11:22 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Wed, Jun 29, 2022 at 10:06:35AM +0100, Sudeep Holla wrote:
> > > > Hi Rafael,
> > > >
> > > > On Tue, Jun 28, 2022 at 01:53:42PM +0100, Sudeep Holla wrote:
> > > > > Hi,
> > > > >
> > > > > This tiny series is to enable Platform Runtime Mechanism(PRM) support on
> > > > > ARM64. Not much changes. Just enabling the build and moving the config
> > > > > option so that it is not listed under the topmost menu for ARM64.
> > > > >
> > > >
> > > > Ard has slightly modified version of patch 2/4 which updates few other
> > > > arch code. Since the PRMT driver build is dependent on that, is it OK
> > > > for you to ACK if you agree with other 3 patches(1,3,4) so that it can
> > > > be routed via efi tree. Alternatively, Ard has offered to provide a stable
> > > > branch if needed.
> > >
> > > Sorry pressed enter too early. I wanted to add reference to the commit in
> > > Ard's efi queue I was referring[1] and the email where we discussed how
> > > to deal with these PRMT patches[2]
> >
> > The ACPI changes in this series are fine with me, so please feel free to add
> >
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > to the patches and route them through the EFI tree.
> >
>
> Thanks Rafael.
>
> Hi Ard,
>
> I assume you will pick up the patches(except 2/4 which is already in your
> -next) with Rafael's ack.
>

OK, I've queued them up now.
