Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797C15EB4CB
	for <lists+linux-efi@lfdr.de>; Tue, 27 Sep 2022 00:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiIZWwf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Sep 2022 18:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIZWwe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Sep 2022 18:52:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7487F134;
        Mon, 26 Sep 2022 15:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E97CAB815D7;
        Mon, 26 Sep 2022 22:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9030BC433B5;
        Mon, 26 Sep 2022 22:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664232750;
        bh=X+i9bYu7/jWxfKAIE3i62yvVnxdBvG/IiRya+AP0Akw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k+WJCcJepmSQ14q6DF5jb4UgCKZYbXeY7nACK6WAMaM/uPrYsQ+x8Qku3yU28PjFn
         PBeq/7jXzTW5J7/I1aqFgjDWN6Qv9cXBfLIQh5FAgNZfj+dcU2GHS9dh5S7NTNVbP6
         OsuUnzF7FrpO3kLanOffFkQtonPMofZ/ELbU56XCKeHwvPoSLxg+bV/2f7ehoFgFJl
         FKdtkqoi+DknB7qodCR5V55GUwjO6qJ3LfnKEwE5FJhXqV8k/JlVDRy2jzgrI1B4JE
         2KQ4vLyOR6v+Ll4oUKdjtWIV0Q+QHJHHuHkzMqbZFkJTnaS6fPFr9x02dCBwO2e9Nb
         ora+TTneLbDhg==
Received: by mail-ua1-f44.google.com with SMTP id p89so2961343uap.12;
        Mon, 26 Sep 2022 15:52:30 -0700 (PDT)
X-Gm-Message-State: ACrzQf3UgtrfHDvTiB1MppHlZEiA8+Ofmk1wyQQ74kYZ8h1tM28qy/zP
        KYOJkx3l7yOalzXNOecd+Ivx9qdBeEZ9YQPXSg==
X-Google-Smtp-Source: AMsMyM43QjpEBGgBdeXDtHcyhT0+TUAlXLvP8qGgbv5J2u9gIos+nqDadyw2zzx9fWZeWcsqwCL4JDInZkzVBkDATYI=
X-Received: by 2002:ab0:2715:0:b0:3c9:90c2:1aea with SMTP id
 s21-20020ab02715000000b003c990c21aeamr7366736uao.77.1664232749469; Mon, 26
 Sep 2022 15:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210416040924.2882771-1-danielwa@cisco.com> <b517fac5-2fdc-a8c9-75d0-174c67f5a2de@seco.com>
 <20220922205334.GV4320@zorba> <dcff9b0f-82c8-5aa7-0fff-b749a05fcb20@seco.com>
 <20220922211026.GW4320@zorba> <1663881344.25129.23.camel@chimera>
In-Reply-To: <1663881344.25129.23.camel@chimera>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 26 Sep 2022 17:52:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLibRSi2n389Q7cf+1gQSidvfiZHjHCcGirgi0hgJ53-A@mail.gmail.com>
Message-ID: <CAL_JsqLibRSi2n389Q7cf+1gQSidvfiZHjHCcGirgi0hgJ53-A@mail.gmail.com>
Subject: Re: [PATCH 0/8] generic command line v4
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Daniel Walker <danielwa@cisco.com>
Cc:     Sean Anderson <sean.anderson@seco.com>,
        Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 22, 2022 at 4:15 PM Daniel Gimpelevich
<daniel@gimpelevich.san-francisco.ca.us> wrote:
>
> On Thu, 2022-09-22 at 14:10 -0700, Daniel Walker wrote:
> > On Thu, Sep 22, 2022 at 05:03:46PM -0400, Sean Anderson wrote:
> [snip]
> > > As recently as last month, someone's patch to add such support was
> > > rejected for this reason [1].
> > >
> > > --Sean
> > >
> > > [1] https://lore.kernel.org/linux-arm-kernel/20220812084613.GA3107@willie-the-truck/
> >
> >
> > I had no idea.. Thanks for pointing that out. I guess I will re-submit in that
> > case.
> >
> > Daniel
>
> This has been happening repeatedly since circa 2014, on multiple
> architectures. It's quite frustrating, really.

It must not be that important. From the last time, IMO Christophe's
version was much closer to being merged than this series. This is not
how you get things upstream:

> * Dropped powerpc changes
>   Christophe Leroy has reservations about the features for powerpc. I
>   don't think his reservations are founded, and these changes should
>   fully work on powerpc. However, I dropped these changes so Christophe
>   can have more time to get comfortable with the changes.

Rob
