Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6D467776B
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jan 2023 10:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjAWJ3q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Jan 2023 04:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjAWJ3o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Jan 2023 04:29:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE961EFE4;
        Mon, 23 Jan 2023 01:29:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26FD560DDD;
        Mon, 23 Jan 2023 09:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88067C433D2;
        Mon, 23 Jan 2023 09:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674466182;
        bh=PrPYdPRy1KNd+wh2VcTPN/iRpEk1FlVdB7KZDlBtuJ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i6D45WXeJXaWElvMmFUTe6ke8K/eBRy6252UFha7p1+xA4s8854YR4660NACBwJKt
         re5pUYApQ0DAJmujikWY/VMdfuiBvtFdfJYKguoRBCpvl42XXJ7ovfVJcjd2SNFemu
         Ya3AF71Ns3ON3j2BFtLHOXAT/s8iivLurz/KfDYYMP3tP8zb6c9QRbzRUQ02YNVeQv
         eIqwlqdqbCyhlZtfUxbIIqWpOpmkKdkJWIW+rJ81t84y/yp1oEqKeRuyXrJphQ39xJ
         QkWGs4YmMg14dG/rmOGySjQCIJM5tZcKpljzF9c3GTEbQNKJj0fox0gki6CnNmEtYl
         FiGh6sJUwRbIg==
Received: by mail-lj1-f179.google.com with SMTP id t12so4878978lji.13;
        Mon, 23 Jan 2023 01:29:42 -0800 (PST)
X-Gm-Message-State: AFqh2kpLt5UaJ5W2nnd11TDHsKeikzAhW/pUdtjlDrELAaYrsMfkB+4/
        x+HAvFVz8K/ks/eJkV6JoIqL1qmw3dqHqxTVXL0=
X-Google-Smtp-Source: AMrXdXvE2wugZMtf5ZFgSut5pSvotlGEF3KkDmuftzbbENeB0PRihTJPLS0LeYEasCiNpfLShzYR+6EqEICmoABXOak=
X-Received: by 2002:a05:651c:315:b0:27f:ef88:3ecb with SMTP id
 a21-20020a05651c031500b0027fef883ecbmr1096404ljp.189.1674466180602; Mon, 23
 Jan 2023 01:29:40 -0800 (PST)
MIME-Version: 1.0
References: <20230123081905.27283-1-johan+linaro@kernel.org>
 <CAMj1kXGPo4-igHOseNhvoBuS0O2YLd+e=cqD8RJJYSgP0zTi0Q@mail.gmail.com> <Y85MYpfHOsFJ8GF6@hovoldconsulting.com>
In-Reply-To: <Y85MYpfHOsFJ8GF6@hovoldconsulting.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 23 Jan 2023 10:29:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE5O-R3J2+kQcOQ+Tm2xoTPQj3HJ7F31DDLTkjr7=N53w@mail.gmail.com>
Message-ID: <CAMj1kXE5O-R3J2+kQcOQ+Tm2xoTPQj3HJ7F31DDLTkjr7=N53w@mail.gmail.com>
Subject: Re: [PATCH v2] efi: drop obsolete efivars sysfs documentation
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        kernel test robot <lkp@intel.com>, linux-efi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 23 Jan 2023 at 09:59, Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Jan 23, 2023 at 09:39:41AM +0100, Ard Biesheuvel wrote:
> > On Mon, 23 Jan 2023 at 09:19, Johan Hovold <johan+linaro@kernel.org> wrote:
> > >
> > > The efivars sysfs interface was removed by commit 0f5b2c69a4cb ("efi:
> > > vars: Remove deprecated 'efivars' sysfs interface").
> > >
> > > Remove also the corresponding sysfs ABI documentation.
> > >
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >
> > > Changes in v2
> > >  - drop reference in gsmi sysfs documentation
> > >  - drop reference in efivarfs.rst (kernel test robot)
> > >
> >
> > Ugh. So there is a remaining implementation of that interface. That is
> > a bit disappointing, tbh.
>
> No, you removed the implementation in the commit mentioned above. The
> Google SMI driver only provides a efivars "backend" but the interface
> was shared. The driver continues to work with efivarfs.
>

Ugh. So as far as I can tell, this interface is still being used
internally at Google.

> > So for now, let's disregard this patch, and I will check internally
> > whether or not that sysfs gsmi interface is actually used. If it is,
> > the docs should be kept but updated to clarify that it only describes
> > gsmi sysfs. Otherwise, we can drop the whole thing, including the gsmi
> > sysfs pieces themselves.
>
> So you'd need to bring back the sysfs implementation and make it Google
> SMI specific if it's still needed by someone. I don't think we want to
> do that if it can be avoided.
>

Indeed.
