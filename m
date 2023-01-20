Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013FF675017
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jan 2023 10:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjATJDg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Jan 2023 04:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjATJDf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Jan 2023 04:03:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B865EC4A
        for <linux-efi@vger.kernel.org>; Fri, 20 Jan 2023 01:03:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DA3161E62
        for <linux-efi@vger.kernel.org>; Fri, 20 Jan 2023 09:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B16DC4339B
        for <linux-efi@vger.kernel.org>; Fri, 20 Jan 2023 09:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674205414;
        bh=t+lbGoWsZyyDsZZa2kD/4JDQecX9Eztf56PY0wj98Xc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X+fY8vfiPg9WcjeG160lUWztS/CVsn61CnXP0kQMRUyE21fFpxLkMNq1YtFjdc07f
         xGb120UMTp9ck3gzo32MWHTpiWCGVPncgO5wPF5Bzn0fVbPvjHTLwKQLgTaFSLZuPy
         /1vCay5NbvxM9PQW7CMNna57B8xJNE68aW6RovjQUn2QAkOWCZHs4vLWIhnBxdleMW
         a1bPHRkzHYAkF83ImENA7NBrb5d15I9aK1yZmmNGiSNJizbeQVkj0A1Wknm5QpKoQM
         Hg1zbGZWUvSgDoYxdgN4ZK9poO72ejJtvxZ/QuT6jyJC0Lnf7/OKB6Unu28RXu3sAR
         dVEL7WPcq7ctA==
Received: by mail-lf1-f52.google.com with SMTP id b3so7140604lfv.2
        for <linux-efi@vger.kernel.org>; Fri, 20 Jan 2023 01:03:33 -0800 (PST)
X-Gm-Message-State: AFqh2kp7DPOIR3+HmozI03gQePTB4gzmsgiwX4h2W93qPcqgL+SMdaH+
        o6KBo7r7R/8DoZ0baWIB2g3M5uckzBlQDyYBqa0=
X-Google-Smtp-Source: AMrXdXt1bkxpcjNBap06/cJlQkDehki1DqBEepPtiQh7Ee6fCaQmW+lLeByAC85S7nqBRZEDu3z1mxvZzdTvcrZCYXM=
X-Received: by 2002:a05:6512:118a:b0:4cc:9d69:4703 with SMTP id
 g10-20020a056512118a00b004cc9d694703mr1434821lfr.110.1674205412007; Fri, 20
 Jan 2023 01:03:32 -0800 (PST)
MIME-Version: 1.0
References: <f2503170d12dc567c00998d4e72ba806f7677730.camel@HansenPartnership.com>
In-Reply-To: <f2503170d12dc567c00998d4e72ba806f7677730.camel@HansenPartnership.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 20 Jan 2023 10:03:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFi8xmPo9gaq6ZGm=LpALWu-5=SH-=1eypJ-r51JKE5SQ@mail.gmail.com>
Message-ID: <CAMj1kXFi8xmPo9gaq6ZGm=LpALWu-5=SH-=1eypJ-r51JKE5SQ@mail.gmail.com>
Subject: Re: Is there a known boot failure with 6.2-rc and the Intel SDV EFI systems?
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 20 Jan 2023 at 00:15, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> I've got a Rainbow Bridge SDV I mostly use for TPM work, and I haven't
> updated it in a while.  Today I found that the recent 6.2-rc4 kernel
> won't boot and won't emit any kernel messages signalling a failure
> somewhere in the handoff code.  I did put some EFI boot stub prints in
> and verified it gets all the way to exit_boot_services before the
> problem, so it smells like it fails initializing the EFI console for
> runtime.  I've also verified that v6.1 release works just fine, so it
> looks like something that went into EFI in the recent merge window.
> I'm starting to bisect now, but thought I'd ask in case anyone else has
> already debugged this.
>

Nothing in particular comes to mind. Is this a mixed mode system?
