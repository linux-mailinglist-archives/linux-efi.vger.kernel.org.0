Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9691A478E
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 16:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgDJOhe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 10:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgDJOhe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Apr 2020 10:37:34 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 621CC214DB
        for <linux-efi@vger.kernel.org>; Fri, 10 Apr 2020 14:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586529454;
        bh=Z7jwyP2YIo+tZuJUBf+I9TQcwmxTpRoTYKEYM9GjXnU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=05xM/d7FTMx3Hm7AgKf0uySrqEZ07ZiCup/2iPA9xp2xt1r/7rqLmla8WdchRpxqd
         9jEqT8XWxJfVTNOCau2KiK68U6DSVWR6WNNu/u9ki+5n5lg9Z3P27GJr2MIBgrr7vz
         FIALJJANMx3Jhzb7P5R748E7lwr2tGGJCxxN7njA=
Received: by mail-io1-f54.google.com with SMTP id o127so1963744iof.0
        for <linux-efi@vger.kernel.org>; Fri, 10 Apr 2020 07:37:34 -0700 (PDT)
X-Gm-Message-State: AGi0Pubn6enWmSA2qWbicEhAeSjrr6IcOC+Zz05y55k8ZgVBq3q82cLf
        s/pFen4NNMuZM2GchlPc9MbBrB5Pod/bbfZytpk=
X-Google-Smtp-Source: APiQypILfZjHRweFRWy/NTWA4yyEihfNb9gcdnBTwp1cd9A2O7g+VfZP/40WXeqcbWUOuKJ7h+p4l4wvh9sUw4n3GjM=
X-Received: by 2002:a6b:f413:: with SMTP id i19mr4587125iog.203.1586529453796;
 Fri, 10 Apr 2020 07:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200410074320.16589-1-ardb@kernel.org> <20200410135644.GB6772@dhcp-128-65.nay.redhat.com>
 <20200410140151.GC6772@dhcp-128-65.nay.redhat.com> <CAMj1kXEM13Y5FCh8GvJGTueen3fa0u_JX66j0X10KPf4Z0c4Jg@mail.gmail.com>
 <20200410143313.GB8205@zn.tnic>
In-Reply-To: <20200410143313.GB8205@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Apr 2020 16:37:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGn+RuJx2PJ+X5KJ3rtMyRRX2eOK2Zu5GuK1NHxum1M4w@mail.gmail.com>
Message-ID: <CAMj1kXGn+RuJx2PJ+X5KJ3rtMyRRX2eOK2Zu5GuK1NHxum1M4w@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Revert struct layout change to fix kexec boot regression
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Ingo Molnar <mingo@kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 10 Apr 2020 at 16:34, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Apr 10, 2020 at 04:22:49PM +0200, Ard Biesheuvel wrote:
> > > BTW, a fixes tag is good to have..
> >
> > I usually omit those for patches that fix bugs that were introduced in
> > the current cycle.
>
> A valid use case for having the Fixes: tag anyway are the backporting
> kernels gangs which might pick up the first patch for whatever reason
> and would probably be thankful if they find the second one, i.e., the
> fix for the first one, through grepping or other, automated means.
>

Fair point.
