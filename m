Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452E75B084D
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 17:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiIGPTs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 11:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIGPTr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 11:19:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3B31183B
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 08:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA59E61927
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 15:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BBEC433D7
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662563985;
        bh=reOF5s7klL1o+7hUZ0hnXG+k2+T3qj0fVEX64wDQL7k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ohs1BpFeUjUPkzL0rcAcbVdXKBi74kN3QX31OJYt7Q2vNQCxb4UVC3nOHEqFKWVmo
         GgCFi98lJ1I8RJzKWpFyRjXq0Sj2ASfsIeCrLbemYAqMogFeBT5Fo6brN82MKInUxF
         q+sxiJR8ltEG66pMaPC92Mcw3j6ayXR7J0Xh3HHGGPYpLf6E6zwVaJd9iELopUuhbF
         QB80sQEvcz1VRBrxNkWj8+CYu+RMFk/H9n86TBTzBjVi3SwbFVD7doWPQIl4sF6byL
         nOJai1Dz0Q1SKCjNzyklPFPNzwdnXnDDGtXEiaup0FmV4fCZnh+BDI19jzrW3qBlBY
         7O0vCXweb0/zg==
Received: by mail-lj1-f181.google.com with SMTP id z23so16412875ljk.1
        for <linux-efi@vger.kernel.org>; Wed, 07 Sep 2022 08:19:45 -0700 (PDT)
X-Gm-Message-State: ACgBeo0tsaJpYIeVqgiM6JnGYIZ0YSaWByf+Fsn8OQnd8R7a804bDgFa
        Vcqz7MhQ2ep20a+sG9Yp0+R93MOZzw/YlxfpyKA=
X-Google-Smtp-Source: AA6agR5vlQSDOU1Ceu+U7DKHy4tw0FtfReTmhiSMayvnGlXsvOQU/mr7Fwc5YRnkaXuVNI5PYTLOf+vbHiUpiFzMgjs=
X-Received: by 2002:a2e:9115:0:b0:26a:c086:5138 with SMTP id
 m21-20020a2e9115000000b0026ac0865138mr1060546ljg.189.1662563983145; Wed, 07
 Sep 2022 08:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220626103248.GA57385@ubuntu> <CAMj1kXHo91v8u_RcXfu4r=x5eh-tShBu4gSDZXBRveOC275Fnw@mail.gmail.com>
 <20220907102920.GA88602@ubuntu> <CAMj1kXHKBkP8JHUSyzEELovvSzUpfO1j2nA+eUbP-smLWjKPog@mail.gmail.com>
 <20220907145426.GA127455@ubuntu> <20220907151701.GA127727@ubuntu>
In-Reply-To: <20220907151701.GA127727@ubuntu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 7 Sep 2022 17:19:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG9Q8B6zugJdUzeFNHD5=obnNZJAWJzzKeXWv0ankYEaQ@mail.gmail.com>
Message-ID: <CAMj1kXG9Q8B6zugJdUzeFNHD5=obnNZJAWJzzKeXWv0ankYEaQ@mail.gmail.com>
Subject: Re: [PATCH] efi/capsule-loader: Fix use-after-free in efi_capsule_write
To:     Hyunwoo Kim <imv4bel@gmail.com>
Cc:     linux-efi@vger.kernel.org
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

On Wed, 7 Sept 2022 at 17:17, Hyunwoo Kim <imv4bel@gmail.com> wrote:
>
> On Wed, Sep 07, 2022 at 07:54:26AM -0700, Hyunwoo Kim wrote:
> > efi_capsule_flush() seems to exist for the purpose of canceling uploads in the middle.
> >
> > If buffer release is moved to .release, will there be any compatibility issues?
>
> The way to submit capsules is to submit by calling write() multiple times by the user,
> rather than in a structure that processes the copy operation at once inside efi_capsule_write().
> In other words, if you just call close() when you want to cancel upload,
> .release is automatically called after write() is finished, and upload is stopped.
> So there is no need for .flush to exist.
>
> So I think it would be ok to move the buffer free part to .release.
>
> I'll submit you a v4 patch that moves the buffre free part to .release.

OK
