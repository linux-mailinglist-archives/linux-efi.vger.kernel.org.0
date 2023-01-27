Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AB367DF61
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jan 2023 09:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjA0IiV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Jan 2023 03:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjA0IiU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Jan 2023 03:38:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BCE27484;
        Fri, 27 Jan 2023 00:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 282ACB81FB5;
        Fri, 27 Jan 2023 08:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E81C4339E;
        Fri, 27 Jan 2023 08:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674808696;
        bh=6vCyZSA7Qvqq9e4x31KbE2hnDSnSWO3YH3sRuWYvyQE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C2ibkqBg3iIUaX3i1FnLdNzR8KHlH5f0cvvoc/JDmINObA2yx6dd8lY7xGynbHkyR
         6gpTeAWepDcXSTeY86R0rBBQevJcnxRAXXSZo+MgYfGo8ry8hrZGDuiZONN6d6MQIh
         g0+y8iKjdRXcCO8rtPyPUpNDjuhG0XYVnltYTA1mJhf/BHVgtrPXhGnV8DpUhg8qYZ
         JzZxCIPwpOf4Yppcmsko4xNkcRfc+D/3XLSa9LF1+iDOojkYW6l2y+89EwErBN7Eio
         adWBqlTXtvG+jqTC9mLp2suCSnbRxuvFI81KTEBzEIipEdIxWYR2qXdyW8Hv+7axP2
         uMVgqKilebC+w==
Received: by mail-lf1-f52.google.com with SMTP id h24so7046994lfv.6;
        Fri, 27 Jan 2023 00:38:16 -0800 (PST)
X-Gm-Message-State: AFqh2kpJfqRSAdPR0XLtP0wju4QF0aigipTkev6Cv3hccmbDRL4PWEX/
        4AepzVUmONxmW+ec6hGwivhGTNQds/DXekJfMp4=
X-Google-Smtp-Source: AMrXdXvb/7wiJ76VBxdr5Y4yHrzXKHsg78AOjqGskO2tP2ce7Pg73DzmSHaQ9u9SCByMva1jHNhfQaEo6RR82qNbvF0=
X-Received: by 2002:a19:6511:0:b0:4cb:bea6:dac6 with SMTP id
 z17-20020a196511000000b004cbbea6dac6mr2559234lfb.344.1674808694733; Fri, 27
 Jan 2023 00:38:14 -0800 (PST)
MIME-Version: 1.0
References: <20230126112129.4602-1-johan+linaro@kernel.org>
 <CAMj1kXEUKChvqA8D_T3Bt-pQhvjBmsGxyy69uqDqyn0EBmQ1pw@mail.gmail.com> <Y9OLG5/yeuG6KT0f@hovoldconsulting.com>
In-Reply-To: <Y9OLG5/yeuG6KT0f@hovoldconsulting.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 27 Jan 2023 09:38:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHiWBA99KG_OXD12rGH3zk84dii3LWZ6OybahudXp3vwA@mail.gmail.com>
Message-ID: <CAMj1kXHiWBA99KG_OXD12rGH3zk84dii3LWZ6OybahudXp3vwA@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: fix NULL-deref on mount when no efivars
To:     Johan Hovold <johan@kernel.org>
Cc:     Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 27 Jan 2023 at 09:28, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Jan 26, 2023 at 09:32:27PM +0100, Ard Biesheuvel wrote:
> > On Thu, 26 Jan 2023 at 12:23, Johan Hovold <johan+linaro@kernel.org> wrote:
> > >
> > > The VFS calls kill_sb() also in case mount fails in get_tree().
> > >
> > > Add the missing check to make sure that efivars has been registered also
> > > to kill_sb() to avoid dereferencing a NULL pointer when trying to remove
> > > efivar entries.
> > >
> > > Fixes: c3fd71b428b8 ("efivarfs: always register filesystem")
> > > Reported-by: Steev Klimaszewski <steev@kali.org>
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >
> > Thanks - I have squashed this with the original patch.
>
> Thanks, Ard. And sorry about not catching this before posting.
>

No worries.
