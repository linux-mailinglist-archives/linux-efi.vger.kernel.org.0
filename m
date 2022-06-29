Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7122155FB30
	for <lists+linux-efi@lfdr.de>; Wed, 29 Jun 2022 10:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiF2I6w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Jun 2022 04:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiF2I6s (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Jun 2022 04:58:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9101A1C914
        for <linux-efi@vger.kernel.org>; Wed, 29 Jun 2022 01:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27EB061DB2
        for <linux-efi@vger.kernel.org>; Wed, 29 Jun 2022 08:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABC5C3411E
        for <linux-efi@vger.kernel.org>; Wed, 29 Jun 2022 08:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656493121;
        bh=d0lDogo1O1YQ31dKYLuVCAweXgoIEWZykznRI7rniEA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qmrVY/vWCsOV7yVRzr+iUbkrjZHUROd+XOMcywEatHEsckcmOK8qe6qc5VZyMGAhc
         t1D9pyWVXJrDX+O920qmwO0bmWxVvffO4Wdyo8FEgXhfIWOypKvJAkVyzaIkUiXoYv
         PQ+xM+AtuHxaOG/Sem3nUY4jTJIkw5SV24SpGVM3v8gu3pJKX1yzoWZCQoYg9xq3zI
         GTJHh0CXvDramgdWlWMfl1tW2zXKVS882hDPPznl8ZeVo/UQtVdlrMZcil9CpEZBPK
         9TyrUfUSbzxTsrF3OI9yXunIiaXHW+7/2LWVLocFmHjhHLHp0dYUb6bJv2z1clDvyP
         NJbmHwjpbfpsg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-101d96fe0a5so20589625fac.2
        for <linux-efi@vger.kernel.org>; Wed, 29 Jun 2022 01:58:41 -0700 (PDT)
X-Gm-Message-State: AJIora/OzBExS7WF6FXiBmX1C31Bh60ABdbmtW2+iDMyJ133W3f3nzJj
        RbAQq1UEBsSPMWwFQ6ahE94COEzYaQZiGrmZpjU=
X-Google-Smtp-Source: AGRyM1vJdKx2owtoTBoeEVx2D+QdmaDa8sMsBrlb4ly4Bt1sPnJ+X/Qwp9gKEIBivQSxqZwIrbouaxLkrbepzsD//eg=
X-Received: by 2002:a05:6870:e98b:b0:fe:219a:2449 with SMTP id
 r11-20020a056870e98b00b000fe219a2449mr2171368oao.228.1656493120559; Wed, 29
 Jun 2022 01:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220628125938.694256-1-sudeep.holla@arm.com> <CAMj1kXENKbduN65vs-qAeuiApA8e=_ee5jxVPzRf5kxn8bAzcQ@mail.gmail.com>
 <20220628134738.xqj6gu5ngbsuql2f@bogus> <CAMj1kXG+CjXUa+ysfpoc64GZRPKvVwSVehgkUUU+on-gAUS+KA@mail.gmail.com>
 <20220628140929.do5e5ic77twmed5e@bogus> <CAMj1kXHyRgT0mM5+r6Gd0ww5ADB9coDGbuYY8KCQJibTJdzBSQ@mail.gmail.com>
 <20220629085619.jqujeyvsffxi6i6p@bogus>
In-Reply-To: <20220629085619.jqujeyvsffxi6i6p@bogus>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 29 Jun 2022 10:58:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFc7CaTV3vhJrskL+VZS2rAdb320Be1mhwX4VW=pSsdJA@mail.gmail.com>
Message-ID: <CAMj1kXFc7CaTV3vhJrskL+VZS2rAdb320Be1mhwX4VW=pSsdJA@mail.gmail.com>
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

On Wed, 29 Jun 2022 at 10:57, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Jun 28, 2022 at 07:58:38PM +0200, Ard Biesheuvel wrote:
> > On Tue, 28 Jun 2022 at 16:09, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Tue, Jun 28, 2022 at 03:57:38PM +0200, Ard Biesheuvel wrote:
> > > > On Tue, 28 Jun 2022 at 15:47, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > >
> > ...
> >
> > > > > I am yet to figure out how asm/efi.h and linux/efi.h are included so that
> > > > > we can have generic definition in linux/efi.h and x86 can undefine that
> > > > > and redefine its own version.
> > > > >
> > > > > Does that make sense ?
> > > > >
> > > >
> > > > I appreciate the effort, but for now, let's just fix the ones we need
> > > > to fix (and the ARM one too while we're at it). PRM can only be
> > > > enabled on x86 and arm64 anyway.
> > >
> > > True. OK then I will just update ARM version and leave loongarch as is.
> > >
> >
> > Actually, this was rather straight-forward so I folded this change
> > into your ARM patch.
>
> I see you have the generic version for all archs except arm64 and x86 as
> we discussed earlier. Since you have even included the arm64 changes, the
> PRMT enablement patches need to routed via your tree now as it depends on
> the change you have in your -next.
>
> Are you OK with that if Rafael agrees ? I can ask him on the other thread.
> No further changes are needed. Let me know.
>

Yes, that is fine. Or I can put that patch on a stable branch by itself.
