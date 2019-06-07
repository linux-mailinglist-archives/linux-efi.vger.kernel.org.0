Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B90A38F4B
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 17:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfFGPkP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 11:40:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43774 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbfFGPkP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jun 2019 11:40:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id w33so3605169edb.10;
        Fri, 07 Jun 2019 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Y4RUf49nvZm45YHDjjNhw1tLCuIx8QoAvl1tOKskzE=;
        b=kbDte6CGOb2ST61SG9x9hqY0lRB8nn8zgCOYrJc652rqCclLy6YA5nRlsb8wEfAtb5
         MZGgKGuCY+mog724nQP9sYYlXSDYzslktLsoDGTgQCqdERQNwPiuOSjeM4gwpFXA3Fqi
         ConOcmfy5Ckw/wDCdpLlc1ea1V7nymtFr5VOpx7s7AguIip7Nh6nQnsptAKFJCI+iTcK
         2bpU4R+NZn6A0FCK6hSYcVNpjtaBSqc9a/0JFI5nzR53Ua5zG6xAb3FKONGbK+/b42NR
         vFyOA5xjUiljikRB9JGednCrGYC6bswdPdh4qn+nunROutn1Hdd9aT0kEafSIUzWr53i
         e3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Y4RUf49nvZm45YHDjjNhw1tLCuIx8QoAvl1tOKskzE=;
        b=Iu04EXJBS/uSjiQGI55Vra+JveSjNLLs+UPHPkN3c1pI+lPF6Ksc/JJCdlvpfBIQXb
         wWhofXoI2dVDBYsXETQ3ShKDnq3k+EQ3jAmtM7YrJ4V83Z+vsFQQRMEKciseCHCC8Jiv
         R1JpcZYLQu6WrmgNRz/dz9LHaCGX/WbU1nsEY5iGddxrTxSqTnxBkeJkLtXeg6uv2nH9
         SiInYW5U69rCsFwM7tqoPw6AXPLN0/7ipWQ7vdavlRItw9h2nQxu5sAJvqbc5uVr6NT5
         +uby5Ea5/Rg6ihs20KvX+knQiVfs6un8EgrWdm1qnBRMVGfxGi5npSPPEPUgQHR7AT6X
         yQZA==
X-Gm-Message-State: APjAAAWTNuWafXfaxlnHiyaN6mJE17nY1axa9oAGAcPnX48sxSAfQcjG
        OZ86gO4ZnrVoQ9OMJIQMisE=
X-Google-Smtp-Source: APXvYqyMpGRltJQMC8voSnI0XNseSfgwO+9HFUckN7SrunfF41iexjVLl4do8OglGFQAQcY7g2J2jw==
X-Received: by 2002:a50:ba1b:: with SMTP id g27mr37488311edc.18.1559922013018;
        Fri, 07 Jun 2019 08:40:13 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id y3sm427843ejp.41.2019.06.07.08.40.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 08:40:12 -0700 (PDT)
Date:   Fri, 7 Jun 2019 08:40:10 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: "arm64: Silence gcc warnings about arch ABI drift" breaks clang
Message-ID: <20190607154010.GA41392@archlinux-epyc>
References: <1559920965.6132.56.camel@lca.pw>
 <20190607152517.GC19862@fuggles.cambridge.arm.com>
 <1559921171.6132.57.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559921171.6132.57.camel@lca.pw>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 07, 2019 at 11:26:11AM -0400, Qian Cai wrote:
> On Fri, 2019-06-07 at 16:25 +0100, Will Deacon wrote:
> > On Fri, Jun 07, 2019 at 11:22:45AM -0400, Qian Cai wrote:
> > > The linux-next commit "arm64: Silence gcc warnings about arch ABI drift" [1]
> > > breaks clang build where it screams that unknown option "-Wno-psabi" and
> > > generates errors below,
> > 
> > So that can be easily fixed with cc-option...
> > 
> > > [1] https://lore.kernel.org/linux-arm-kernel/1559817223-32585-1-git-send-ema
> > > il-D
> > > ave.Martin@arm.com/
> > > 
> > > ./drivers/firmware/efi/libstub/arm-stub.stub.o: In function
> > > `install_memreserve_table':
> > > ./linux/drivers/firmware/efi/libstub/arm-stub.c:73: undefined reference to
> > > `__efistub___stack_chk_guard'
> > > ./linux/drivers/firmware/efi/libstub/arm-stub.c:73: undefined reference to
> > > `__efistub___stack_chk_guard'
> > > ./linux/drivers/firmware/efi/libstub/arm-stub.c:93: undefined reference to
> > > `__efistub___stack_chk_guard'
> > > ./linux/drivers/firmware/efi/libstub/arm-stub.c:93: undefined reference to
> > > `__efistub___stack_chk_guard'
> > > ./linux/drivers/firmware/efi/libstub/arm-stub.c:94: undefined reference to
> > > `__efistub___stack_chk_fail
> > 
> > ... but this looks unrelated. Are you saying you don't see these errors if
> > you revert Dave's patch?
> 
> Yes.

I suspect the reason for this is -Wunknown-warning-option causes
cc-option to fail. I see some disabled warnings like
-Waddress-of-packed-member and -Wunused-const-variable when -Wno-psabi
is unconditionally added.

I'll do some further triage but I think the obvious fix as Will
suggested is to use cc-disable-warning. I'll send a patch.

Cheers,
Nathan
