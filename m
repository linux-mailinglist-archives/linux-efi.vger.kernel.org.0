Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 594B4170124
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 15:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgBZO1S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 09:27:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40895 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgBZO1S (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Feb 2020 09:27:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id r17so1142678wrj.7;
        Wed, 26 Feb 2020 06:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qvwewPpyPisUxq2+kWUzRZ/RT7okvVOdDvyG3MamGi4=;
        b=JGVesDeXW6AiFT+U/l0Kjfw660LX/1y2rlwGek4WQJZcYK5xgtyIeeKzm+j+RP2ETz
         LynxD73vOUbYhJiLq3FH/Y5c5CnslDG//KThhRXtdsoJOTZB4AYBTdlt+hIhjuOqEvLS
         bS37WXySesacExUxg5ZHRa+zpyIw2slC0Wpt2o12bujdERhz1sZq5es9+jkB4mhIwl38
         9M54ag0ly4wMHEp6IGl6cJu9MoV5vAgf5yiN35TMmekmqXcMM4GhSCNlWEJXILE3uUhh
         cNubN6C0BdtyWs289njzeHwuaIlUL89nEiX+Kmzv/7HgYMWV9GEa7jYqfLhOBeku1/CU
         9x1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qvwewPpyPisUxq2+kWUzRZ/RT7okvVOdDvyG3MamGi4=;
        b=iAz2sw+0ZrwZRO+97O+fKho52uExZikmk/nrCByFuLIXPuiHbqRTdliRHezftqitbr
         rJXmHTRV8zbgtA9vhRVe91ueh1GttQMPK99d3/W+dZ1fiu1hvdogknrqp0iOvDtmiiyr
         WSvWYWTHLE6GyvwLwgVABq2IVB0fEzDoZdPh9DQo/MEG8D7WwwvXAcNisSEiK29hxFnM
         cqzCjpH8RzbGZFh5rwJ9ci110fARzr/uP2AHfJbKAKwWGeDoX1TQf3vZLY230naiR7sj
         vqUGR0AE5fG2/e7LZHniAbEBdFJXc9cUD1tF27ryC9dHuo7c/jmqGEXRr6u5C9WBiCCC
         G3FQ==
X-Gm-Message-State: APjAAAVvVkpE+EnBxnpnmi15SUWTbc5uBt0WDO57m26nm/Di3zl+CvGj
        J8ntB04/YGYaPON+5qQCsiA=
X-Google-Smtp-Source: APXvYqzJ8CkXHOicI58J6fwxH6zLMYwspMaE5Soe+kVGDjxBkFNm6k6dbq4VBzt+A9/56qYCq4GuQw==
X-Received: by 2002:adf:a3ca:: with SMTP id m10mr6055708wrb.148.1582727236659;
        Wed, 26 Feb 2020 06:27:16 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id j20sm3469414wmj.46.2020.02.26.06.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 06:27:16 -0800 (PST)
Date:   Wed, 26 Feb 2020 15:27:14 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [GIT PULL v2] EFI updates for v5.7
Message-ID: <20200226142713.GB3100@gmail.com>
References: <20200224133856.12832-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224133856.12832-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> Hello Ingo, Thomas,
> 
> I am sending this as an ordinary PR again, given the size. Please let me
> know if instead, you prefer me to send it out piecemeal as usual. Either
> works for me, I was just reluctant to spam people unsolicited.
> 
> Note that EFI for RISC-V may still arrive this cycle as well. 
> 
> Please take special note of the GDT changes by Arvind. They were posted to
> the list without any feedback, and they look fine to me, but I know very
> little about these x86 CPU low level details.
> 
> This was all build and boot tested on various different kinds of hardware,
> and all minor issues that were reported by the robots were fixed along the way.
> 
> Please pull,
> Ard.
> 
> 
> The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
> 
>   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next
> 
> for you to fetch changes up to dc235d62fc60a6549238eda7ff29769457fe5663:
> 
>   efi: Bump the Linux EFI stub major version number to #1 (2020-02-23 21:59:42 +0100)

>  66 files changed, 2718 insertions(+), 2638 deletions(-)

Pulled this as a Git tree, thanks Ard!

The boot-time GDT handling cleanups from Arvind look good to me too. 
There's a couple of arguably scary commits in there, so these might be 
'famous last words'. :-)

Thanks,

	Ingo
