Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1003C1A9503
	for <lists+linux-efi@lfdr.de>; Wed, 15 Apr 2020 09:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635280AbgDOHpY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Apr 2020 03:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635275AbgDOHpH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Apr 2020 03:45:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EA8C061A0C;
        Wed, 15 Apr 2020 00:45:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h9so17879871wrc.8;
        Wed, 15 Apr 2020 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mea28piwCzgRuQ3mfdsmk7Ai20oILdWCske3DP+bUC0=;
        b=eMorzzOfrAaP7sksuzpfZg+IHXqttTLbtLhh2Xp4BLS8MlGL35hXWrQlaYXju1Hsks
         3bscde2H23OC5O771jlYBwBUytFuYjArh/PX+q05qxiQBWc+q1/Yv6aWp8CS6KIza/Fi
         fUT8hjHaZNm7Wxuz6/a4Xh4dx3Jo4nvZDGSrgMn5V+6XeR8jp59TBw9w5eNqsTZ7NI5y
         bvo5jLupS35G4eP7tha//RzzvHnjggiLinELJ2rubqJApOcOOuqEVmg5EW+VK9yo+WI9
         wFl1chztUtgy51mfch4JsWN1tIh8KFQfjyHLC2EAwMDz0Et+f7Fq6O+qTBQlYIgcxc79
         xIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mea28piwCzgRuQ3mfdsmk7Ai20oILdWCske3DP+bUC0=;
        b=uDFVvkiCWA5iiiOVR2MaJ/syl8lOW1oezDa//yYri2Ul/GgGUBQD4xVhKruZglTipW
         3WFp+2l181jnw68TSD/3CrAJs+7PWsrDWEbq7jZa1VrY9zblAeH526x6fQLwj3LHVfTG
         efan/LZaMfgy20bAzDHogxMdp8pM9kcsuvkuzY6lgLyHtuWK4yozdFy4FxrZiXtTuwkj
         e35ZcLd2EcfTVzfzZr/6akOK1s+xiV7LaDcBK6OxFmTmUFjy4nTZO2ebDM/Li4OlZiR6
         D4vwiFX56s26d4kDFnjVb7qYINUF8na+ELNU6Fn9XvOLWwcHPf7h0FzTOmg/1vFm03ua
         izvw==
X-Gm-Message-State: AGi0PuYew8uLbRkuk5b9InmOUhU8BGsEMTLRWU/3I7u1+FViPev8Jn1c
        UJjdOXUMt+iPoYK2Ml5U8R77uoXK
X-Google-Smtp-Source: APiQypIzsY6ps2ND34ujHajJnX5HRPX2jbUkLANg5d8a8Y/rBMNWx4Y5MiSvcSH3ST2qgDWSpqEl0w==
X-Received: by 2002:adf:c188:: with SMTP id x8mr26374042wre.136.1586936706163;
        Wed, 15 Apr 2020 00:45:06 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a10sm22166232wrm.87.2020.04.15.00.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 00:45:04 -0700 (PDT)
Date:   Wed, 15 Apr 2020 09:45:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     =?iso-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Kernel V5.7-rc1 doesn't boot (EFI?)
Message-ID: <20200415074502.GA111015@gmail.com>
References: <CADDKRnBdM_T1W=iECrt89hmAmbRRyskGhS4d3ozTz1nWj_i_qQ@mail.gmail.com>
 <CAMj1kXGuMjHi=E6cVGGpwrKF_-KXcj0VRcvAdFS_vmwV7PudCQ@mail.gmail.com>
 <CADDKRnAvC7U6kWdiqmib40cJ7r41COyic4LTdO9utsp4GOJnvA@mail.gmail.com>
 <CAMj1kXEDJ67oJJjKtDC--VXmr+z8-voPhHnRnaMCEfo5Pc6Sqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXEDJ67oJJjKtDC--VXmr+z8-voPhHnRnaMCEfo5Pc6Sqg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Tue, 14 Apr 2020 at 18:32, Jörg Otte <jrg.otte@gmail.com> wrote:
> >
> > Am Di., 14. Apr. 2020 um 12:50 Uhr schrieb Ard Biesheuvel <ardb@kernel.org>:
> > >
> > > On Tue, 14 Apr 2020 at 12:40, Jörg Otte <jrg.otte@gmail.com> wrote:
> > > >
> > > > Booting my notebook with kernel V57-rc1 I get following
> > > > display:
> > > >
> > > > exit_boot() failed!
> > > > efi_main() failed!
> > > > StartImage failed: Buffer Too Small
> > > >
> > > > Booting Kernel V5.6 works well.
> > > >
> > > > From dmesg (kernel V5.6):
> > > > efi: EFI v2.31 by Phoenix Technologies Ltd.
> > > > efi:  ACPI=0xdcffe000  ACPI 2.0=0xdcffe014  SMBIOS=0xdce80000  RNG=0xdc3cd198
> > > > efi: seeding entropy pool
> > > > efi: [Firmware Bug]: Invalid EFI memory map entries:
> > > > efi: mem47: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> > > > |  ] range=[0x0000000000000000-0x0000000000000000] (invalid)
> > > > efi: mem48: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> > > > |  ] range=[0x0000000000000000-0x0000000000000000] (invalid)
> > > > efi: mem49: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> > > > |  ] range=[0x0000000000000000-0x0000000000000000] (invalid)
> > > > efi: mem50: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> > > > |  ] range=[0x0000000000000000-0x0000000000000000] (invalid)
> > > > efi: mem51: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> > > > |  ] range=[0x0000000000000000-0x0000000000000000] (invalid)
> > > > efi: Removing 5 invalid memory map entries.
> > > >
> > >
> > > Thanks for the report.
> > >
> > > Can you try booting with efi=no_disable_early_pci_dma passed via the
> > > kernel command line? [*]
> > >
> > Yes, that works!
> >
> > > If that does not help, can you try to reproduce with this branch?
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=efi/urgent
> >
> > Should I give that branch a try anyway?
> >
> 
> Your test proves that BSS is not being cleared correctly, so I have
> the answer I was looking for. However, I would appreciate it if you
> could test that branch, just to double check.

I'll send efi/urgent to Linus within the next couple of hours, to get the 
fix to Linus:

  105cb9544b16: ("efi/x86: Move efi stub globals from .bss to .data")

Thanks,

	Ingo
