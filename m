Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B815BE6C6
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 15:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiITNMW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 09:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiITNMV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 09:12:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABD640BE6
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 06:12:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24B8AB82921
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 13:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9A5C433C1
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 13:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663679537;
        bh=kV3P1Ayurr/bUyQnpN7hYH6x3tDKNWtxOqn5JZnGQOA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qYDmhowgq0bLPjJpAQdB/m2Z9dDVLclNlK5OG600Z0yTVEgc1mNOYk1X2mGKAsFef
         QrKIqKxTqH4uZhPJG6qTtW1TojRTUau/uZI1Cy5Wh91y9y0xrKJ7d16bcdZcVLyaha
         KAv0ETstWCL4gR1Ll/f+nc1EbJEUA9mFefS1nK1pIR7rOhwVKssjj6Et4tdBYq5mhP
         G5St/U0w5yeqVxlUmPvZPRmjcgMe+6eBLry9hmjYy1u/yL33P30DN25SrZcg3kU9cM
         e//l5vpCznf2ztK8oOxiIzFMTshzrQXro9TlbHh64pbaNUV7HGcb8VfrWPGgfbUX6Y
         TsiZyMlAWnBOg==
Received: by mail-ua1-f47.google.com with SMTP id a14so1024006uat.13
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 06:12:17 -0700 (PDT)
X-Gm-Message-State: ACrzQf2xXdRgxnUzaErScQHMyNJCPkrAw8SZsQMP/YnA/68qUD54Ci0P
        YVIeX0qYiUoGTwW3wah1tHBsDklHNOq9IixabbI=
X-Google-Smtp-Source: AMsMyM7vDI9iLAx2A/cXKn4EzLGAeGBRDjsKWFoB9it34YPczV1kzlegKSbkLMbOg3ZTSypvOQmXHp7yXUuVI/rAw7s=
X-Received: by 2002:ab0:25d4:0:b0:3c1:c353:31cb with SMTP id
 y20-20020ab025d4000000b003c1c35331cbmr1070385uan.63.1663679536866; Tue, 20
 Sep 2022 06:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220918213544.2176249-1-ardb@kernel.org> <20220918213544.2176249-12-ardb@kernel.org>
 <CAAhV-H6Ke88sirvX9ut7JLWy+xaERZ7BeMEf97WHRWbsLqZC0A@mail.gmail.com>
 <CAMj1kXHuQHuCt9Z=qWRH_aZY5_+LzpicyE=agMyAX+O14khL_g@mail.gmail.com>
 <CAAhV-H7-JFwcwz5pBt7WZxJ2CkeUvc07OLgWxB9z-QTkr=njWw@mail.gmail.com>
 <CAMj1kXFKmvSt1092xBUHVXf9NxDFDSDyPDNpwfGUKWGWAPAE9Q@mail.gmail.com>
 <CAAhV-H7-9yx4EmtLrvE6arVahsT7AySLyyxk0yXUWPicWfgRjQ@mail.gmail.com>
 <CAMj1kXFuKo=SGGycD8E-FjN9kHsJ45ZCHaRdqgX3bT6XRG418A@mail.gmail.com>
 <CAAhV-H5PbYA+FL6KUVHVGkgC9R_4aNG02d78bTF7senikFPJLw@mail.gmail.com>
 <CAMj1kXHDo26TsVmQATagru6gqo+U8a0k-3uf2Di9JLLDVoGoSg@mail.gmail.com>
 <CAAhV-H78ErUvzKK-+tcjYq6YKT8G4gtV5VhzsGg-yZYQPRR+bA@mail.gmail.com>
 <CAMj1kXEG7=HWMmu-=_=CjG1gSgz6Q_eTsUjob7sP2uxt5q1_Eg@mail.gmail.com>
 <CAAhV-H67dgV_M2RW37wh_=aA8dr=f_nSbdab3sQPKUvDKws+xQ@mail.gmail.com>
 <CAMj1kXEWJ9TbhWRTiqFDtHr36dhkc1RfyL8ft06uDsN08x6eYA@mail.gmail.com>
 <CAAhV-H5BQAWFAT2vRZxO8L=pU0X5hGD-vHpyRVK0k7UKaLJJpQ@mail.gmail.com>
 <CAMj1kXEpFiRORzz=qQ5oCAUAgSDyCnf8p5Hb=NuMYMVcKfNYqw@mail.gmail.com>
 <CAAhV-H584umex2jcSBju3ZjqDELBQWpna8A6QxRYBDvvvueHGw@mail.gmail.com>
 <CAMj1kXGgV+Ucb=0076-9PBFWeL-1W6-XAFD3BK=miiZK6ddwPg@mail.gmail.com>
 <CAAhV-H5gtw1tb040mV8o=P=5onfTZwDEVm1tTooWLOW-kyHAMw@mail.gmail.com>
 <CAMj1kXGWLAJqf3fmqPm9JWTC06i=t2fhZi2_Tfjh40rtUQLwXg@mail.gmail.com>
 <CAAhV-H5iy1GC+JXGeSh0EPQ=TT9m_oFKMknk-7JSpQ-0HdK9Rw@mail.gmail.com>
 <CAMj1kXF=aGFktg1jGq4mN_73ko3j-jt4=Xc1xAR0jWx_OT0tVw@mail.gmail.com>
 <CAAhV-H5SVOwz9uM-SC_iDH2juGMhNEGMxd6j6itDsQhRENoBCw@mail.gmail.com> <CAMj1kXFVMtqRgiMQ0+ALVsRAmiBDtYZ8SGkqqtVYDLABm2HDoA@mail.gmail.com>
In-Reply-To: <CAMj1kXFVMtqRgiMQ0+ALVsRAmiBDtYZ8SGkqqtVYDLABm2HDoA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 20 Sep 2022 21:12:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5FPNaD532ZbgjV_SiH8-YaLsLNPvPttAm-a1T+9eW4EQ@mail.gmail.com>
Message-ID: <CAAhV-H5FPNaD532ZbgjV_SiH8-YaLsLNPvPttAm-a1T+9eW4EQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] efi/loongarch: libstub: remove dependency on
 flattened DT
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, loongarch@lists.linux.dev,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Ard,

On Tue, Sep 20, 2022 at 4:04 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 20 Sept 2022 at 03:45, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Ard,
> >
> ...
> > I'm very sorry, after an offline discussion with my colleagues,
> > non-EFI DT boot is still needed (very sadly, we want to drop non-EFI
> > firmware but we can't do that). However, for non-EFI DT boot we will
> > use the same parameter passing method (a0=efi boot flag, a1=cmdline,
> > a2=systemtable), firmware will generate a simple systemtable only for
> > DT. In this way all boot methods share the same logic, and also make
> > kexec easy to implement.
> >
>
> OK, that should work. So I suppose you create a EFI system table along
> with EFI configuration tables for DT, SMBIOS, etc? In this case, I
> suggest you omit the MEMMAP config table that I am adding here, so
> that there is no ambiguity between the EFI provided memory map and the
> one provided by DT.
>
> I think that should be a clean way to implement this.
OK, thanks.

I have merged efi-cleanups-for-v6.1-v2 to
https://github.com/loongson/linux/commits/loongarch-next. It seems
everything work well except kexec.

Huacai
>
> > So, let's make a0 the real "efi boot flag" and let it control
> > EFI_BOOT, for efistub, we can just pass "true" unconditionally
> > (whether support efi_novamap is not as important as the efi boot flag
> > for us, as you said, efi_novamap is just for broken firmware).
>
> Indeed. So as before, I will just set efi_novamap to false. You can
> still use noefi or efi=noruntime to turn off the EFI runtime pieces if
> needed (e.g., PREEMPT_RT tends to disable those by default to preserve
> their bounded worst case latency)
