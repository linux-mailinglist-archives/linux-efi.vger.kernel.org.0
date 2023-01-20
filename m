Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6028675979
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jan 2023 17:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjATQEb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Jan 2023 11:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjATQEa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Jan 2023 11:04:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4294737F29;
        Fri, 20 Jan 2023 08:04:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFCE461FD8;
        Fri, 20 Jan 2023 16:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B2DC433D2;
        Fri, 20 Jan 2023 16:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674230669;
        bh=Ec4H1FXPr6bovVxs4vc810kRh1msVN4iB85TbOfb4ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEoxzo6adt5Ed6rCJIuoSySpq1ZPl7v5+teYwR3RfNP/H7oyumltXJUdDjvJia+m0
         G4DTKete4ggG3ww2DJ5vcFJDTO+TfYdcX/3iybFNBuVkOg+FcIX/lM32qmwd1HZtMB
         o4BV1i2VJOAUkzB+n62e5zfYY92PX9ZY+fNjwuoxWujAVyBsWlY7wt8slGtJ15kz37
         5xVBfgXNpKR3CUT8Egin490uUkm2luvme5s3oEUg4vkuyZXjEpy6bADaCpe/7GIBc1
         TuiR9dB3uVGDEgEzTd7Jgr4HqAcdgRS11fH9amLTjabQP/MXwAbecIVJk4Abv1EHMC
         BHIhzYlMokYLQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pItsx-0008Ih-TV; Fri, 20 Jan 2023 17:04:59 +0100
Date:   Fri, 20 Jan 2023 17:04:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] efivarfs: always register filesystem
Message-ID: <Y8q7qz29QMfeNdMV@hovoldconsulting.com>
References: <20230119164255.28091-1-johan+linaro@kernel.org>
 <20230119164255.28091-3-johan+linaro@kernel.org>
 <CAMj1kXEOOh8MrAt=L7aBt9wX5Pcmh4irnDuKqsDF7pB5-xnmog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEOOh8MrAt=L7aBt9wX5Pcmh4irnDuKqsDF7pB5-xnmog@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 20, 2023 at 10:23:18AM +0100, Ard Biesheuvel wrote:
> (cc Peter, Heinrich)
> 
> On Thu, 19 Jan 2023 at 17:45, Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > The efivar ops are typically registered at subsys init time so that
> > they are available when efivarfs is registered at module init time.
> >
> > Other efivars implementations, such as Google SMI, exists and can
> > currently be build as modules which means that efivar may not be
> > available when efivarfs is initialised.
> >
> > Move the efivar availability check from module init to when the
> > filesystem is mounted to allow late registration of efivars.
> >
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> I think this change is fine in principle, but I 'm not sure if there
> is user space code that the distros are carrying that might get
> confused by this: beforehand, efivarfs would not exist in
> /proc/filesystems and now, it will but trying to mount it might fail.

User space must already handle mount failing since commit 483028edacab
("efivars: respect EFI_UNSUPPORTED return from firmware") so that should
not be an issue.

Johan
