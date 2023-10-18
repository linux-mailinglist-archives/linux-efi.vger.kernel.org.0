Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC62F7CD71B
	for <lists+linux-efi@lfdr.de>; Wed, 18 Oct 2023 10:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjJRI41 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Oct 2023 04:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJRI40 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Oct 2023 04:56:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7539D;
        Wed, 18 Oct 2023 01:56:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA057C433C8;
        Wed, 18 Oct 2023 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697619385;
        bh=KRyk2UahrrFPBEIK3F5R5UL123qYTEWCilr8OIr+Ni0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=onskFz8n7eY4HE6UxY+Qt+j/CPAfiEGsY6LTSwau9SSFWKCeKtx+HxkXJef6hRfuy
         VDquXqxg6ExoZT8WW0kzz2MRSlmRWECHonoRFvrti8Y8OMq4R72j5b1FNDX0BzVKQj
         sO1/8rEF24ZdlroAAaof8oFG0eEnjLq2g38dNiur/ehl0swWvslrXu+oOjX2wMmoXd
         NvnL5/1pcrd71EGTM/91m5f0jNFcPJBF78ui28bE1i5Lm6ujNZQA/pi3dQpjgBPOif
         m4Wm5IXtEktwDh4feIf8qKVkwThP7Xj5PFLnxRhppTy8dz2XLdvzdUnfg4WI8+ze53
         QoHakNiC40UpQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2c5210a1515so48576131fa.0;
        Wed, 18 Oct 2023 01:56:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YxuVzebr/EG8W9kDbfj9O9v4K3pDoj8t4+eBeIRfUCKIJlyHJ5N
        yj4kkZabbnCBmhYusNL3BU7eOcK30ajlq1YPbds=
X-Google-Smtp-Source: AGHT+IEhp1iO2i1tWSOeunjt6aZOI3eQGzjG8XCyIg+y3rSAPvpMTSdQoRamZx5Q6F/1pYjIpU/l9lPNV7qBbWouxx8=
X-Received: by 2002:a2e:bc12:0:b0:2c5:9a5:a1c2 with SMTP id
 b18-20020a2ebc12000000b002c509a5a1c2mr5539058ljf.30.1697619383146; Wed, 18
 Oct 2023 01:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231012230301.58500-1-Smita.KoralahalliChannabasappa@amd.com>
 <20231012230301.58500-2-Smita.KoralahalliChannabasappa@amd.com>
 <65288e68de994_2347eb294c2@iweiny-mobl.notmuch> <d5882c60-6636-f651-2886-02c433f77ae1@amd.com>
In-Reply-To: <d5882c60-6636-f651-2886-02c433f77ae1@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 18 Oct 2023 10:56:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFsqRuge48Ji5bujgBz_rzbPcLiN84dbXnRytH3yyJPjA@mail.gmail.com>
Message-ID: <CAMj1kXFsqRuge48Ji5bujgBz_rzbPcLiN84dbXnRytH3yyJPjA@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi/cper, cxl: Decode CXL Component Events General
 Media Event Record
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-efi@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
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

On Tue, 17 Oct 2023 at 22:52, Smita Koralahalli
<Smita.KoralahalliChannabasappa@amd.com> wrote:
>
> Hi Ira,
>
> On 10/12/2023 5:25 PM, Ira Weiny wrote:
> > Smita Koralahalli wrote:
> >> Add support for decoding CXL Component Events General Media Event Record
> >> as defined in CXL rev 3.0 section 8.2.9.2.1.1.
> >>
> >> All the event records as defined in Event Record Identifier field of the
> >> Common Event Record Format in CXL rev 3.0 section 8.2.9.2.1 follow the
> >> CPER format for representing the hardware errors if reported by a
> >> platform.
> >>
> >> According to the CPER format, each event record including the General
> >> Media is logged as a CXL Component Event as defined in UEFI 2.10
> >> Section N.2.14 and is identified by a UUID as defined by Event Record
> >> Identifier field in Common Event Record Format of CXL rev 3.0 section
> >> 8.2.9.2.1. CXL Component Event Log field in Component Events Section
> >> corresponds to the component/event specified by the section type UUID.
> >>
> >> Add support for decoding CXL Component Events as defined in UEFI 2.10
> >> Section N.2.14 and decoding Common Event Record as defined in CXL rev 3.0
> >> section 8.2.9.2.1.
> >>
> >> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> >
> > [snip]
> >
> >> +
> >> +/*
> >> + * Compute Express Link Common Event Record
> >> + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> >> + */
> >> +struct common_event_record {
> >> +    u8 identifier[16];
> >
> > I interpreted the CPER structure as not having this identifier here.
> >
> >  From Section N.2.14:
> >
> > "For the CXL Component Event Log: Refer to the Common Event Record field
> > (Offset 16) of the Events Record Format for each CXL component."
> >
> > This implies that the data coming from the CPER record starts at length.
>
> Thanks for pointing this out. According to Spec, you are right. Our
> records did show up the identifier. Hence, I added that field. We should
> probably fix it from our end.
>
> Meanwhile, I'm taking a look at your patches.
>

Thanks

Once you've compared notes, can you please let me know how to proceed?
I will not consider Ira's patches or yours for merging before that.

-- 
Ard.
