Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E39013514D
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2020 03:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgAICXt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jan 2020 21:23:49 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34707 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgAICXs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jan 2020 21:23:48 -0500
Received: by mail-oi1-f194.google.com with SMTP id l136so4598316oig.1
        for <linux-efi@vger.kernel.org>; Wed, 08 Jan 2020 18:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vpKaB37AOhauoPCsPH8bCGxpP6t6MKruJ0CgWLMvrAQ=;
        b=eJuCns1dXxBhRe1TlIMfPzPKNzHTMfprez4L1XuLDNKaTvgwktSOZtLd9ECSFDVMWJ
         6YJiyTT5//7FJfppJyPR8URJDhZ7/oJecMDnrt7OraKYbdSek5ZWsjmLI3fC3zEVDpc4
         VxLXsFULGwn+yMCS60UNZsWdNUFJ+Y1Xl0/wYY8/YjZfJ2xysocjML6rtpH485bTlvHW
         xyfkOKkP2sDZurOG6An86U7m/E9Zj+XL40lz2YrjEoH15IkM5502qzJkjcGAXnFdXku+
         kaQNhnFWCIAueDv2LdxPd9iCrg8Pivakfc0bTpzWQ79rR3yroEQmCubGCK1Denn8ScYC
         Br1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpKaB37AOhauoPCsPH8bCGxpP6t6MKruJ0CgWLMvrAQ=;
        b=RMJbSiK6jFbhKbq9N9DXEzfFAUINcNDS2SfWZTUYvH693G7hE+27yqsmy5Zk2Ubr5r
         0Yp4UQ4axWpc0ujtb8gbz5ia9miEKGqBDO0WnrHROCzs3hAdpqwaw9OFW1N0aSKe6Dym
         Ih5d7iv1T9ftWRf+uHmMhuN9AkuytBgnNQy1PihCglifldKECOPggklsCZXs8sruqLCH
         QSrJswpwDjGlvdBCi5TE/hwN1o95uJ9gg39Pp1Ga8/IhT8FM9cYyF9zzigx2MdoC2G1s
         QUXJ3cOf2SYpxcPsbDM76Qx5N36MfjnYE8vFSmv9PBI2JGiV9bvec0/gQeDaRXG/CtnY
         rLmQ==
X-Gm-Message-State: APjAAAXxCIwpkjR5ykUa55wN1kfwdZ5Gl8gncY+Jy8Ibt7rUZnJqmBRW
        vQrgyvUAqg4SBkyeuOoQGL9oD7cfUdfXGgRekzFwT00qKyM=
X-Google-Smtp-Source: APXvYqyrjfLuM3Ikl0VFoqq+4wnh7pbPU3Lx3LyfVTtVIDSYzNAFc6LUwH5lVk6ZGkPQiEswGf9zja02f8W2MC6dPrY=
X-Received: by 2002:a54:4f8d:: with SMTP id g13mr1337770oiy.43.1578536627730;
 Wed, 08 Jan 2020 18:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20191224044146.232713-1-saravanak@google.com> <201912252258.5LQtnCYg%lkp@intel.com>
In-Reply-To: <201912252258.5LQtnCYg%lkp@intel.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 8 Jan 2020 18:23:11 -0800
Message-ID: <CAGETcx90nkOQXgKWtTSg7SRZCTmH9RQijYsZLP6CWpHCmW1Mxw@mail.gmail.com>
Subject: Re: [PATCH v2] efi: arm: defer probe of PCIe backed efifb on DT systems
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Ard Biesheuvel <ardb@kernel.org>,
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

On Wed, Dec 25, 2019 at 6:46 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Saravana,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on efi/next]
> [cannot apply to rockchip/for-next keystone/next arm64/for-next/core arm-soc/for-next shawnguo/for-next clk/clk-next arm/for-next linux-rpi/for-rpi-next at91/at91-next v5.5-rc3 next-20191220]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Saravana-Kannan/efi-arm-defer-probe-of-PCIe-backed-efifb-on-DT-systems/20191225-182253
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> config: arm64-alldefconfig (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=arm64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/firmware/efi/arm-init.o: In function `efifb_add_links':
> >> arm-init.c:(.text+0x64): undefined reference to `of_pci_range_parser_init'
>    arm-init.c:(.text+0x64): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `of_pci_range_parser_init'
> >> arm-init.c:(.text+0x78): undefined reference to `of_pci_range_parser_one'
>    arm-init.c:(.text+0x78): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `of_pci_range_parser_one'

Ard,

Not sure what's going on here. of_pci_range_parser_init() and
of_pci_range_parser_one() has a stub if CONFIG_OF_ADDRESS isn't
defined. So not sure why the bot is reporting "undefined symbol".
Thoughts?

Also, thoughts on my patch?

-Saravana
