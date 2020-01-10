Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F02E1375EA
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2020 19:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgAJSNQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jan 2020 13:13:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38037 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgAJSNQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jan 2020 13:13:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so2935499wmc.3;
        Fri, 10 Jan 2020 10:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D7tqF1S/AHMK+lknMwDpNu4EUIRduZ4LfsbbkDPnHoY=;
        b=N/amrr6hSwQ9bbj6MJ/Swf6DaW34rBJUxs4nIOLpt9jLZCvacZIfKlxH7rQi6vuwcB
         JK3HyBx5ANRWppBEDdojmAzPJANyIve6PLSI8ROO8EnLNJtQFs/dUw9/wlMt66jVrC4P
         QyQioZV5HZRDPXqK3JIrJGiEIykMDLeTmfNK66C2Hg31HkhUzzlrpSmUQ88VXJ2rb8Ki
         rJZJ0GzQMV+5xh79XtwkuFbglsWxRAY9+s7cxVecfdsSFOdbgnorul1Q6zmbedOp7OjW
         SO/CE94cir9ihdXLuBEuDzcIK9g83bQfQawHLZ4+MxHTWbOg3P2qj4lklCy85Jrd0XtR
         wF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=D7tqF1S/AHMK+lknMwDpNu4EUIRduZ4LfsbbkDPnHoY=;
        b=ic5VMwbjGcSbc6PfXGrZF8/OOxMi2lHraYocOzuGRfuZOjeK3jVVbEsmvsVczMul6L
         AlsQgqoQwjWa/BrwnYvjZYFndMF/rH9ceQ45DohC0wZlZT4vPv6D2JH/eQv+DjzGG5tQ
         X1XZWqpLWdvGpKz2HRECXdHj/arBpCplPHlGFH9maVRq0c0TWKABDE2IPvHTaeEbP8HL
         IhDrBYs4ILVhu6v9yThR68CiDFZ54qItZSlI7f8IlgBWgfyvp7ObffJzEmw3mf+ZDar+
         uO1fCTL3OJbhd8KoPg7oFrQeHmF/5pkMHIpvB+9eoy57Si6VdcYB32Vc3q12kir+pFyg
         eKxg==
X-Gm-Message-State: APjAAAWQEs8sHm3/YETlfNFMlHB2LouRl8OPnYFCFndC9ipGesFYB5Iy
        6YeHWlX9V9naFxlGi6gZkacbrQei
X-Google-Smtp-Source: APXvYqxaTfMSmkvn/xLA7Sknx430oqAYGgoLs2g6pujekkUMRJTHG+c5i6y2BRUJzWE/rLPkuPxqVg==
X-Received: by 2002:a1c:9d81:: with SMTP id g123mr5662317wme.29.1578679994501;
        Fri, 10 Jan 2020 10:13:14 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x6sm3014907wmi.44.2020.01.10.10.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 10:13:14 -0800 (PST)
Date:   Fri, 10 Jan 2020 19:13:12 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [GIT PULL 00/20] More EFI updates for v5.6
Message-ID: <20200110181312.GB83292@gmail.com>
References: <20200103113953.9571-1-ardb@kernel.org>
 <CAKv+Gu8pzDSs6G5k9JfX77NB4q2kerxSuprnzFzeGBPd2kPd5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8pzDSs6G5k9JfX77NB4q2kerxSuprnzFzeGBPd2kPd5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On Fri, 3 Jan 2020 at 12:40, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Ingo, Thomas,
> >
> > This is the second batch of EFI updates for v5.6. Two things are still
> > under discussion, so I'll probably have a few more changes for this
> > cycle in a week or so.
> >
> > The following changes since commit 0679715e714345d273c0e1eb78078535ffc4b2a1:
> >
> >   efi/libstub/x86: Avoid globals to store context during mixed mode calls (2019-12-25 10:49:26 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next
> >
> > for you to fetch changes up to d95e4feae5368a91775c4597a8f298ba84f31535:
> >
> >   efi/x86: avoid RWX mappings for all of DRAM (2020-01-03 11:46:15 +0100)
> >
> 
> Ingo, Thomas,
> 
> I'll be submitting another PR later today or tomorrow that goes on top
> of these changes. Please let me know if you would like a v2 of this PR
> with the new content included, or rather keep them separate.

So there's one complication I noticed, there's conflicts with ongoing 
x86/mm work. I've merged x86/mm into efi/core (and will send the branches 
in that order in the merge window), and the final three patches conflict.

Mind sending those three patches and your other patches on top of the 
latest efi/core (4444f8541dad)?

Thanks,

	Ingo
