Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581207D036F
	for <lists+linux-efi@lfdr.de>; Thu, 19 Oct 2023 22:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjJSUww (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Oct 2023 16:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjJSUwv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Oct 2023 16:52:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA12A113;
        Thu, 19 Oct 2023 13:52:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC3CC433C9;
        Thu, 19 Oct 2023 20:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697748769;
        bh=3dzWUTFAxmU3wipGFobehTK7P0p+nDlBGaKxyhwIuDs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q/VUvGCPD+aQ6/tm3hG0GsY1Wb4EyUW3sIPOHEyFhKSir6VgPDFZ2LYB60y+uYptJ
         PstLQ95C5kTtBd5omwncwSgHvwGBv1MhyUD7uEHyNh1acEgSjbenB/sUo6frnQbE3F
         T/dTLZcrnByOzjg/YJ3YBKC6G6aF+td+nXVqf8nj98yM+kCTiBCwqLA9uEYCuFO8C5
         VSHcEYoqE0WzAqcKCjUyo+SqBd1U003F6r8/6hjaJ4AamYyCAIb79kF1r1JmE6/x5r
         sQraZdU6+3TVWPrUOzkD89mUoyMI0Aqm9F+BTNF+n/uLrw6fWHrLoxW7qPzYrLP0OO
         cO0E+BfJD9TYQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b9338e4695so1254721fa.2;
        Thu, 19 Oct 2023 13:52:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YymY03qzHDIDNY+TooA7Tk081N1TSRjV93nSwmnGYRA7z8I/Di8
        6x6v/Rh7sIJwE117MiH4kBCrn+zPVXNshblVkeo=
X-Google-Smtp-Source: AGHT+IGCrajqrcehF155RNIPexecuwUd9uUBKdOjZSmNS43fowCn8+WhCmhmhyAmsVxzLrMoZ+cjhDv3FEXPDug63Zw=
X-Received: by 2002:a2e:bc12:0:b0:2c5:8b1:7561 with SMTP id
 b18-20020a2ebc12000000b002c508b17561mr87872ljf.10.1697748767605; Thu, 19 Oct
 2023 13:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231012230301.58500-1-Smita.KoralahalliChannabasappa@amd.com>
 <20231012230301.58500-2-Smita.KoralahalliChannabasappa@amd.com>
 <65288e68de994_2347eb294c2@iweiny-mobl.notmuch> <d5882c60-6636-f651-2886-02c433f77ae1@amd.com>
 <CAMj1kXFsqRuge48Ji5bujgBz_rzbPcLiN84dbXnRytH3yyJPjA@mail.gmail.com> <65302871abbc6_725832944e@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <65302871abbc6_725832944e@dwillia2-xfh.jf.intel.com.notmuch>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 19 Oct 2023 22:52:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGHoZS2x1u-J94P29-zxxOM=w0omN9__YZbSnj0xhUOaA@mail.gmail.com>
Message-ID: <CAMj1kXGHoZS2x1u-J94P29-zxxOM=w0omN9__YZbSnj0xhUOaA@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi/cper, cxl: Decode CXL Component Events General
 Media Event Record
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-efi@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 18 Oct 2023 at 20:48, Dan Williams <dan.j.williams@intel.com> wrote:
>
> Ard Biesheuvel wrote:
> > On Tue, 17 Oct 2023 at 22:52, Smita Koralahalli
> > <Smita.KoralahalliChannabasappa@amd.com> wrote:
> > >
> > > Hi Ira,
> > >
> > > On 10/12/2023 5:25 PM, Ira Weiny wrote:
> > > > Smita Koralahalli wrote:
> > > >> Add support for decoding CXL Component Events General Media Event Record
> > > >> as defined in CXL rev 3.0 section 8.2.9.2.1.1.
> > > >>
> > > >> All the event records as defined in Event Record Identifier field of the
> > > >> Common Event Record Format in CXL rev 3.0 section 8.2.9.2.1 follow the
> > > >> CPER format for representing the hardware errors if reported by a
> > > >> platform.
> > > >>
> > > >> According to the CPER format, each event record including the General
> > > >> Media is logged as a CXL Component Event as defined in UEFI 2.10
> > > >> Section N.2.14 and is identified by a UUID as defined by Event Record
> > > >> Identifier field in Common Event Record Format of CXL rev 3.0 section
> > > >> 8.2.9.2.1. CXL Component Event Log field in Component Events Section
> > > >> corresponds to the component/event specified by the section type UUID.
> > > >>
> > > >> Add support for decoding CXL Component Events as defined in UEFI 2.10
> > > >> Section N.2.14 and decoding Common Event Record as defined in CXL rev 3.0
> > > >> section 8.2.9.2.1.
> > > >>
> > > >> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > > >
> > > > [snip]
> > > >
> > > >> +
> > > >> +/*
> > > >> + * Compute Express Link Common Event Record
> > > >> + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> > > >> + */
> > > >> +struct common_event_record {
> > > >> +    u8 identifier[16];
> > > >
> > > > I interpreted the CPER structure as not having this identifier here.
> > > >
> > > >  From Section N.2.14:
> > > >
> > > > "For the CXL Component Event Log: Refer to the Common Event Record field
> > > > (Offset 16) of the Events Record Format for each CXL component."
> > > >
> > > > This implies that the data coming from the CPER record starts at length.
> > >
> > > Thanks for pointing this out. According to Spec, you are right. Our
> > > records did show up the identifier. Hence, I added that field. We should
> > > probably fix it from our end.
> > >
> > > Meanwhile, I'm taking a look at your patches.
> > >
> >
> > Thanks
> >
> > Once you've compared notes, can you please let me know how to proceed?
> > I will not consider Ira's patches or yours for merging before that.
>
> Ard, I have a higher-level question. If these CPER records get routed to
> the CXL subsystem to be emitted by code that is shared with the
> native-driver record-retrieval mechanism, is there still motivation to
> parse and emit them to the kernel log in the EFI code?
>
> The difference with these CXL memory error records vs other records like
> CPER_SEC_PLATFORM_MEM is that the record contains device-local addresses
> that need translation to be of use to other system-software and that
> translation needs topology information that the CXL subsystem has
> enumerated.
>
> So, my proposal is that the final form of this enabling would emit the
> record for CXL to consume, but otherwise not emit it via printk().

Yes, that makes sense. If CXL is needed to make sense of this
information, no point in printing the raw data.
