Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3482A26C949
	for <lists+linux-efi@lfdr.de>; Wed, 16 Sep 2020 21:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgIPTGR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Sep 2020 15:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbgIPRpm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Sep 2020 13:45:42 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB2BB22284;
        Wed, 16 Sep 2020 13:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600261787;
        bh=HXKmEB+gVrlnCwL4jhYUdk21Fx+cEGbZ7v9sMWjklP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uQO56onJR6+k5d43NMLAzyz6MEFicSp6F7461G5ZQ2b5GldA75myUsfICEmpy0J9I
         lkVENS4IZJjYTFRXZaD8JdU1nppQ5lIYQ+uQ9gkMfbgrN7Kwv9RwWo6ouMipQvVHxV
         p2wAZQ6gyFTVO85A82cU+ZwQmlS0lQN3B0tHpGWg=
Received: by mail-ot1-f42.google.com with SMTP id e23so6622457otk.7;
        Wed, 16 Sep 2020 06:09:47 -0700 (PDT)
X-Gm-Message-State: AOAM530TLHYkYzkGLarrX3x4bX98t+0eBIv2EI03Eyyxgn/Wy8ARCA3x
        RC69pw/yjWCu5a6gaseDSKPW5Glbt/xPZxjC7Bw=
X-Google-Smtp-Source: ABdhPJzWXGjnWT4sGj/Dszvt19cOxly0HZeAV+QlcRdZunOCvR5gkuzck5v/O3RtX241uYgNwOf7IQwEUMe0MfHJdzM=
X-Received: by 2002:a9d:335:: with SMTP id 50mr2259149otv.90.1600261787088;
 Wed, 16 Sep 2020 06:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200819143544.155096-1-alex.kluver@hpe.com> <20200819143544.155096-2-alex.kluver@hpe.com>
 <20200915163312.GO14436@zn.tnic> <CAMj1kXHmVhB88qZc-1mHAD1ovNJQnWRBncmQJTR_4+kV0fXG5w@mail.gmail.com>
 <CAMj1kXGvfiqZz-j5=LU0Z6yYCkr24pCz6aJS62QL8cBYUP_S=w@mail.gmail.com> <20200915171910.GQ14436@zn.tnic>
In-Reply-To: <20200915171910.GQ14436@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 16 Sep 2020 16:09:36 +0300
X-Gmail-Original-Message-ID: <CAMj1kXE6PKb==h_154hRKwZLr3Ek+4z4A8FdTHx=co18ww5d3Q@mail.gmail.com>
Message-ID: <CAMj1kXE6PKb==h_154hRKwZLr3Ek+4z4A8FdTHx=co18ww5d3Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] edac,ghes,cper: Add Row Extension to Memory Error Record
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alex Kluver <alex.kluver@hpe.com>, linux-edac@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mchehab@kernel.org, russ.anderson@hpe.com,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        kluveralex@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 15 Sep 2020 at 20:19, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 15, 2020 at 08:12:31PM +0300, Ard Biesheuvel wrote:
> > Boris - do you anticipate any conflicts? If so, please take these via
> > the EDAC tree - the CPER code is mostly self contained so I don't
> > expect any conflicts with the EFI tree in that case.
>
> None so far, and I applied them for testing ontop of my EDAC queue for
> 5.10 so it should be all good. But if you want me, I can test-merge your
> branch once ready, just in case...
>

I managed to apply these patches by using a different base and
cherrypicking them into efi/next

I expect to send out a couple of PRs tomorrow, once the bots have had
a go at building the branches. In the meantime, you can take a look at

git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
