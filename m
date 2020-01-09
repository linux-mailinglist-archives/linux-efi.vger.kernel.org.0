Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3FB1135ACB
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2020 15:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbgAIOAo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jan 2020 09:00:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37587 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729572AbgAIOAn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Jan 2020 09:00:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so7534741wru.4
        for <linux-efi@vger.kernel.org>; Thu, 09 Jan 2020 06:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8xbfR1e+uIythd38166wCVY5KnjUVf+wZJ6jFWaQhg=;
        b=wQpb3FJkQMvVRdPTLz/ZEeOxsu9Om4MJxR1KRtPYR5JbY+7EuRwAbGeEmQe7twR+fg
         7z5ww8hk7wZpIF52etX2RsjS0jhKsWl5LI+eq9DMciZX0adY4/KfVzkwlsy4veLC9zWH
         1SZwYGAdfy5uLmSn5+uCPz35k9qJcHwtxtTEedlQTUDC2qZx/aquR+9ndc1kmBJfeg1z
         oRLeLE0PvIP82BDJ4f6twG7ILqFJkO9Ze0GkXrVj9x7C998Nce4kZvk8rZBnq9g89Mut
         2IrC6AbyAUuL8Flh2irof4z2acmkGF4Kl0GEE/1Jri6DfibaUPz/pmcUXMYx/PR/BU/m
         XTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8xbfR1e+uIythd38166wCVY5KnjUVf+wZJ6jFWaQhg=;
        b=ADx/EkEjeTDNIt1+dCBsiW2I6ywQJinBHfJNb7/Be0plK5MzFwJjDYezRi4I0ikiYx
         9mqPyFowuU0/osus99KgkmEqZ7xjluSrBvpXzjSrLiq3b6Z/nCgWEmK9xEvxhDPV/wYP
         pW8ldXVWkvIC47g3MvyRZhiL2rBlsSA5poic+IX+ygpqsftiJBcpUtua0Ya+0prHADd8
         D+3+AUjm7jSTRsaHfRYsea05pKAUWesdLYm8vg6Q2mhg+Yuw8s5PsLnVnOF7kHelYgAr
         pLb/l/gFevxMM/SRUgaImwFr7iF5l25yOCcdLoltUv0q0dVm8//Uxj4UaX2IKsRQ+Dm+
         QU0w==
X-Gm-Message-State: APjAAAU6HW5oBa73RBG/5+fxkPmbWJIDMYBEI4KOB3BAPm4lJPbsxqHo
        rar/SMVdnVHn8D0mw+aokeYRPn04tkNXLsYE8x9kTg==
X-Google-Smtp-Source: APXvYqxWquiIBHbuG6bV1XMbdGm6bS/RcE2rvYNATF5+D9Tep5mXvc7r+Liq4irXwUqNWK0IilpoNfAGru9LuFbNsFQ=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr10711881wrj.325.1578578441234;
 Thu, 09 Jan 2020 06:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20191224044146.232713-1-saravanak@google.com> <201912252258.5LQtnCYg%lkp@intel.com>
 <CAGETcx90nkOQXgKWtTSg7SRZCTmH9RQijYsZLP6CWpHCmW1Mxw@mail.gmail.com>
In-Reply-To: <CAGETcx90nkOQXgKWtTSg7SRZCTmH9RQijYsZLP6CWpHCmW1Mxw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 9 Jan 2020 15:00:30 +0100
Message-ID: <CAKv+Gu_3CGrWwMeP5tWYusD8p99r54KFsK4SvWn3zU=Q8X9jcQ@mail.gmail.com>
Subject: Re: [PATCH v2] efi: arm: defer probe of PCIe backed efifb on DT systems
To:     Saravana Kannan <saravanak@google.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 9 Jan 2020 at 03:23, Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Dec 25, 2019 at 6:46 AM kbuild test robot <lkp@intel.com> wrote:
> >
> > Hi Saravana,
> >
> > I love your patch! Yet something to improve:
> >
> > [auto build test ERROR on efi/next]
> > [cannot apply to rockchip/for-next keystone/next arm64/for-next/core arm-soc/for-next shawnguo/for-next clk/clk-next arm/for-next linux-rpi/for-rpi-next at91/at91-next v5.5-rc3 next-20191220]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> >
> > url:    https://github.com/0day-ci/linux/commits/Saravana-Kannan/efi-arm-defer-probe-of-PCIe-backed-efifb-on-DT-systems/20191225-182253
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> > config: arm64-alldefconfig (attached as .config)
> > compiler: aarch64-linux-gcc (GCC) 7.5.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.5.0 make.cross ARCH=arm64
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/firmware/efi/arm-init.o: In function `efifb_add_links':
> > >> arm-init.c:(.text+0x64): undefined reference to `of_pci_range_parser_init'
> >    arm-init.c:(.text+0x64): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `of_pci_range_parser_init'
> > >> arm-init.c:(.text+0x78): undefined reference to `of_pci_range_parser_one'
> >    arm-init.c:(.text+0x78): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `of_pci_range_parser_one'
>
> Ard,
>
> Not sure what's going on here. of_pci_range_parser_init() and
> of_pci_range_parser_one() has a stub if CONFIG_OF_ADDRESS isn't
> defined. So not sure why the bot is reporting "undefined symbol".
> Thoughts?
>

You'll need a #ifdef CONFIG_PCI somewhere, I guess.

> Also, thoughts on my patch?
>

Looks ok to me, but I haven't had a chance to test it yet.
