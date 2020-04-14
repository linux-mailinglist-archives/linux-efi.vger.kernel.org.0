Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED5F1A73A0
	for <lists+linux-efi@lfdr.de>; Tue, 14 Apr 2020 08:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405992AbgDNG10 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Apr 2020 02:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405990AbgDNG1V (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Apr 2020 02:27:21 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD22C0A3BDC
        for <linux-efi@vger.kernel.org>; Mon, 13 Apr 2020 23:27:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id u13so12458699wrp.3
        for <linux-efi@vger.kernel.org>; Mon, 13 Apr 2020 23:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pp3TbajE6USya1p1kPwUAIS7aCYW8lYss1z9XY1NLSU=;
        b=k+k79ZaMkCSE5EVgFSHlRI8rVTLKrsQZXC6dAZUCs8lP7k/E4TemgfyRl9Uhu0lEI/
         WMBkxfk8NIhBPtZCwEvc310Pp0eO59AMi0ubXDs3Dq83gK0B46kLNBrjetd4d7+wfGZa
         nzh9CFpYA8pG95u6IhCEOw37EZcOQE/E7wN+UYFzMP36mFhmkzHtY/ky0SJW+QgIFmtS
         5McQHisGlJxjyQpP+cfjDiyQqnUppeluFEKaTzPxlCU+QrAu6sSC94ZATnWnCRkLM/zX
         LWuOL3o5+Tm/5pNp6YKUDVxREs2Tsx/Cx+I68hP7QYPLGQiVIHlEFzeQROBvrEgVqzAz
         hVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pp3TbajE6USya1p1kPwUAIS7aCYW8lYss1z9XY1NLSU=;
        b=Suru2Z4n9SVrLqCy+OA+6Hc6qku9paio3N60cJmLkpPO15Ag4qZGa3YMsw9lpVsNoa
         rDr5JB4z9fxffXldW9OBKXUXFKrA/G8aO9IJ9iMHUDisUDoK4gVoafOXtWqPP930le+b
         /WUQsGrxHBC1rf1lD8BiP69tNEZQFeFUL0XZXKZ69Uw+mXxcf50mGRfcYN6fw93Uu6Dx
         eIEqVT+6gh0caEJAhDpgC7k4JxaP88WJb8lnWGzP4RUy5SZdWN2E5mPJ+ql2NCvR0ajp
         /4k6h8wxMcNU4ji6SZ82wK1WKD3Z5DPYR/Agl3Azh7wSIZTS4MaKp4hdelSja9zf+CwU
         +cog==
X-Gm-Message-State: AGi0PuakD7QljB7WpPxftQ7vAv8dddUPGVomjYVrg6rPZcI6+DBY7Rb1
        MDFhI9IYOJJAdA9Xc4LrPJg=
X-Google-Smtp-Source: APiQypLspMLRNRywgfLvdyn9tUzStiaUbcdWfbTU1t1J5ecrnnJPqSAi40+a/VRrvcDU4/aPihV9zg==
X-Received: by 2002:a5d:4752:: with SMTP id o18mr8283149wrs.283.1586845639044;
        Mon, 13 Apr 2020 23:27:19 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a7sm1028199wrs.61.2020.04.13.23.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 23:27:18 -0700 (PDT)
Date:   Tue, 14 Apr 2020 08:27:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, kexec@lists.infradead.org
Subject: Re: [PATCH] efi/x86: Revert struct layout change to fix kexec boot
 regression
Message-ID: <20200414062716.GB84326@gmail.com>
References: <20200410074320.16589-1-ardb@kernel.org>
 <20200410135644.GB6772@dhcp-128-65.nay.redhat.com>
 <20200410140151.GC6772@dhcp-128-65.nay.redhat.com>
 <CAMj1kXEM13Y5FCh8GvJGTueen3fa0u_JX66j0X10KPf4Z0c4Jg@mail.gmail.com>
 <20200410143313.GB8205@zn.tnic>
 <CAMj1kXGn+RuJx2PJ+X5KJ3rtMyRRX2eOK2Zu5GuK1NHxum1M4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGn+RuJx2PJ+X5KJ3rtMyRRX2eOK2Zu5GuK1NHxum1M4w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Fri, 10 Apr 2020 at 16:34, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Apr 10, 2020 at 04:22:49PM +0200, Ard Biesheuvel wrote:
> > > > BTW, a fixes tag is good to have..
> > >
> > > I usually omit those for patches that fix bugs that were introduced in
> > > the current cycle.
> >
> > A valid use case for having the Fixes: tag anyway are the backporting
> > kernels gangs which might pick up the first patch for whatever reason
> > and would probably be thankful if they find the second one, i.e., the
> > fix for the first one, through grepping or other, automated means.
> >
> 
> Fair point.

I've added:

  Fixes: 0a67361dcdaa29 ("efi/x86: Remove runtime table address from kexec EFI setup data")

Out of abundance of caution. :-)

Thanks,

	Ingo
