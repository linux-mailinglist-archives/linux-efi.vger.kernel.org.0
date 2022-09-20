Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2055BE963
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 16:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiITOyQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 10:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiITOyO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 10:54:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E193AB06
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 07:54:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3725B820D6
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 14:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66238C433B5
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 14:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663685650;
        bh=CaM7s7Djov6G3qBXIFRlh7mvT4+isDDpGNm0u28qY9g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=toqFeBOQM0HvyEP+jvIiiKU5kHE2TVz2kzCTwTeAtmEd/OJ2GNULC32VLnoZ7TX0Q
         X9o0475d2NVhtiivfmSCnCLiDLB69Qs5MFLgFh2kIBj/ouzI1C5/mUfktORXJUyC3F
         QFrvm80kyxuLMAF5Hho3XFuvPXeVXZlctwJGB5HTfe8JRJRHxi8Ah9PvEB3GCws8Yt
         kGFGmxK/VEf+uL0Q8QDOFnY1SygJsqBTXMFMPpB+cbnwzi0LT3f7ACqVT0HKsYXWFc
         zu/PZKJ0EX2nokD1KiTTsJt7aQZqQWo/XIpHdIBJDIYLWwcAKJMszXxtQtavqH7D8J
         oV2ejtxQ2FmEg==
Received: by mail-lf1-f46.google.com with SMTP id k10so4226579lfm.4
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 07:54:10 -0700 (PDT)
X-Gm-Message-State: ACrzQf2CMc/16sXdfQEqPFGuMJ/5Ll1JZr7+eNy2COykRUhazjW5Vck6
        iCLyBui73vmBCHnGp+YqZ0rwE+kvBrnlDHIgFT0=
X-Google-Smtp-Source: AMsMyM6CLpSd6Zxv69dKhdFodSrz06aukD3OG5n1an7+70s/lN+D0T9ucERS/QQiUm1N4IY+Zh5HSArxvjcdQbTZTfE=
X-Received: by 2002:ac2:4431:0:b0:497:aaf5:83eb with SMTP id
 w17-20020ac24431000000b00497aaf583ebmr8148815lfl.228.1663685648461; Tue, 20
 Sep 2022 07:54:08 -0700 (PDT)
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
 <CAAhV-H5SVOwz9uM-SC_iDH2juGMhNEGMxd6j6itDsQhRENoBCw@mail.gmail.com>
 <CAMj1kXFVMtqRgiMQ0+ALVsRAmiBDtYZ8SGkqqtVYDLABm2HDoA@mail.gmail.com> <CAAhV-H5FPNaD532ZbgjV_SiH8-YaLsLNPvPttAm-a1T+9eW4EQ@mail.gmail.com>
In-Reply-To: <CAAhV-H5FPNaD532ZbgjV_SiH8-YaLsLNPvPttAm-a1T+9eW4EQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 20 Sep 2022 16:53:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH-LPThkCPPPK4Vgxk_Y-UtQLAa0=FMYqztNO3POvo83A@mail.gmail.com>
Message-ID: <CAMj1kXH-LPThkCPPPK4Vgxk_Y-UtQLAa0=FMYqztNO3POvo83A@mail.gmail.com>
Subject: Re: [PATCH 11/12] efi/loongarch: libstub: remove dependency on
 flattened DT
To:     Huacai Chen <chenhuacai@kernel.org>
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

On Tue, 20 Sept 2022 at 15:12, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Ard,
>
> On Tue, Sep 20, 2022 at 4:04 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 20 Sept 2022 at 03:45, Huacai Chen <chenhuacai@kernel.org> wrote:
> > >
> > > Hi, Ard,
> > >
> > ...
> > > I'm very sorry, after an offline discussion with my colleagues,
> > > non-EFI DT boot is still needed (very sadly, we want to drop non-EFI
> > > firmware but we can't do that). However, for non-EFI DT boot we will
> > > use the same parameter passing method (a0=efi boot flag, a1=cmdline,
> > > a2=systemtable), firmware will generate a simple systemtable only for
> > > DT. In this way all boot methods share the same logic, and also make
> > > kexec easy to implement.
> > >
> >
> > OK, that should work. So I suppose you create a EFI system table along
> > with EFI configuration tables for DT, SMBIOS, etc? In this case, I
> > suggest you omit the MEMMAP config table that I am adding here, so
> > that there is no ambiguity between the EFI provided memory map and the
> > one provided by DT.
> >
> > I think that should be a clean way to implement this.
> OK, thanks.
>
> I have merged efi-cleanups-for-v6.1-v2 to
> https://github.com/loongson/linux/commits/loongarch-next. It seems
> everything work well except kexec.
>

OK thanks for testing. I will send out a v2 today and merge the
changes into efi/next tomorrow.
