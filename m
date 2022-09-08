Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB015B1760
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 10:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiIHInp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 04:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiIHInj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 04:43:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EC1A1D5E
        for <linux-efi@vger.kernel.org>; Thu,  8 Sep 2022 01:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7093761AEF
        for <linux-efi@vger.kernel.org>; Thu,  8 Sep 2022 08:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2271C433D7
        for <linux-efi@vger.kernel.org>; Thu,  8 Sep 2022 08:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662626616;
        bh=DhzHuntc8+sV4HyXmagYzw6SoEZd+NfPnojiEXThL6M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FR73hDhdf1xdyVfobMbopBlWB8J2LeJ4BwEc6hF1BSzkajAahWHjSwd1ZvGdf5Gfq
         d/SwbgN8Qxw+TdTvuwc2GxfEXhEvMTRd6HY+jYVl+xlhlqQwxPiU/Gx3RXBpK7W126
         6nzCu60fcaeyZ+HZ1FB3l9uvKEf7SZRZbb5iQTin9eShzAQUF7z1Bb5UwulWnGJMpt
         XpgWdsX06Dl3IO6UDlFEaHQ1Gh9Y62o0XR8FufPp+KnhOJHvEcyLlAGbuuSFW0Ndym
         zu+kGmmxnRH3V3X6ZTzBEIZ0AseqGz+RTJQRaH4VakxVidlxu3NmCXzmuYDzpET+qw
         tBkSmbV3EAAyw==
Received: by mail-lj1-f181.google.com with SMTP id b19so19014140ljf.8
        for <linux-efi@vger.kernel.org>; Thu, 08 Sep 2022 01:43:36 -0700 (PDT)
X-Gm-Message-State: ACgBeo2OuQ+kyPVInRveXxAMd1SYlse5qeY55AsHdmTtlWxkBclyGFuM
        ny1HHxpUr8r8XbLP0wx5YlcYINUYD8p+TqtrWnw=
X-Google-Smtp-Source: AA6agR5pu/MMqhnnPMR9Q8OaRYgnBobuZONJRpVPgGd/yD2cxJIbuPmYwPYwW60SvmHVeFNN1wrmum5mejM3AF/Y0Yo=
X-Received: by 2002:a2e:3006:0:b0:266:6677:5125 with SMTP id
 w6-20020a2e3006000000b0026666775125mr2361970ljw.352.1662626614860; Thu, 08
 Sep 2022 01:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220907023255.35237-1-chenzhang@kylinos.cn> <ba9c545066d80740df279a34c4fa795a@ispras.ru>
In-Reply-To: <ba9c545066d80740df279a34c4fa795a@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 8 Sep 2022 10:43:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFJHht=9r054cCKCzAjnSCrbRi9pD--XLNc-xrpHQnFBA@mail.gmail.com>
Message-ID: <CAMj1kXFJHht=9r054cCKCzAjnSCrbRi9pD--XLNc-xrpHQnFBA@mail.gmail.com>
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

On Thu, 8 Sept 2022 at 10:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> On 2022-09-07 05:32, chen zhang wrote:
> > The variable "has_system_memory" is unused in
> > function =E2=80=98adjust_memory_range_protection=E2=80=99, remove it.
> >
>
> Thanks for pointing out.
> Will change that in v2.
>

v2 of what? Isn't this code already in mainline?
