Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ADA5EB50B
	for <lists+linux-efi@lfdr.de>; Tue, 27 Sep 2022 01:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiIZXEL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Sep 2022 19:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiIZXEK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Sep 2022 19:04:10 -0400
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30874A8CFA;
        Mon, 26 Sep 2022 16:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1694; q=dns/txt; s=iport;
  t=1664233447; x=1665443047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UfqbhAK++DNIhImH/1VT+jrMLWJa1wTzmPtEjmwVs+A=;
  b=KrZ9bMa/yreybfkpXCZL3pwGiKf0MTZsvWFzgIqJzhI21GvNa6nwQwFe
   klJBeA0q9lIxZmV9AKO8HzcsNmyA/XRUAX9L51YKFKgQl8O66TbpXGQqi
   jIt6ja1hMiXVqD9CHVoq6G2+Bn2gvaLJZ9IZB2Al/rM2AM2uJ/H9Y/QuE
   I=;
X-IPAS-Result: =?us-ascii?q?A0AwAACPLzJj/5hdJa1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIqelU+RYxthlCCKJFoiyqBfAsBAQENAQE5CQQBAYFTgzIChGwCJ?=
 =?us-ascii?q?TQJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEHBIEJE4VoDYZDAQU6PxALG?=
 =?us-ascii?q?C5XBhOCfoMgAxCpd3iBNIEBg1ABGBiEHIFfBiSBGQGQKCccgUlEhD8+iFKCL?=
 =?us-ascii?q?gSZJTgDRB1BAwtCNRgDFAMFJAcDGQ8jDQ0EFgcMAwMFJQMCAhsHAgIDAgYTB?=
 =?us-ascii?q?QICTTYIBAgEKyQPBQIHLwUELwIeBAUGEQgCFgIGBAQEBBUCEAgCCCYXBxMzG?=
 =?us-ascii?q?QEFWRAJIRwOGg0FBhMDIG8FRA8oMWsrHRsKgQwqKBUDBAQDAgYTAwMiAhAqM?=
 =?us-ascii?q?RQEKRMSLQcrcwkCAyJnBQMDBCgsAwkhHwcoJjwHWDoBBAMCECI9BgMJAwIkW?=
 =?us-ascii?q?4EvKAUDDRkmCAUjFx4ECDwCBQZXEwIKEgMTD5hlgguBQXuBQjqSUYJkjT+BM?=
 =?us-ascii?q?J0vg2OBSYlylGJMEahzlwuNPJR0hRACBAYFAhaBYTyBWTMaCBsVgyITPhkPl?=
 =?us-ascii?q?yaFaiQxAjkCBgsBAQMJilABAQ?=
IronPort-Data: A9a23:kwPseKymHrMObNdZ/xR6t+crxirEfRIJ4+MujC+fZmUNrF6WrkVWn
 WAbWjuAa/3ZYzejfNF0OoTg8ksAupLWydNlGgZopVhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJloCCWa/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA3J7oWGthh
 fuo+5eFYA7/hWYuWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxMUlaENQ4ZW7
 86apF2I1juxEyUFU7tJoZ6nGqE+eYM+CCDV4pZgtwdOtTAZzsA6+v5T2PPx8i67gR3R9zx64
 I0lWZBd1W7FM4WU8NnxXSW0HAkuIKtWv6PiMEK+tOqz03CfaHrgkvFhWRRe0Y0woo6bAElU/
 vAebTsKdB3G3qS9wamwTa9ngcFLwMvDZdxE/Co/i2CCS697G/gvQI2SjTNc9Ds5gMFDGenXT
 8EYcjFoKh/HZnWjP39GU8Jkxrvz3CGXnztwg2iro68swXLv61Zyi+SzP//4SN3QfJAA9qqfj
 iecl4jjOTkeNdqC2X+I/HOEmODCh2X4VZgUGbn+8eRl6HWXx2oOGFgVX0a6pfWRlEGzQZRcJ
 lYS9y5oqrI9nGSnQ8f8VBCkunOJlgATVsAWEOAg7gyJjK3O7G6xAmkCUy4Ea9E8ssIybSIl2
 0XPnN7zAzFr9rqPRhq18raSsCP3MDIQaGwPfykJSSMB4sL/u8cyiBzVR9puGaLzicf6cRnw2
 zmivjkigK9VhskOv42//Fbakyq0rd3FQxAd4gTMQnnj6RF9bYS+IYuy5jDz6fdGMZbcS1iZp
 1AalMWEquMDF5eAkGqKWuplNKH5ud6GPSfajFopGIMunxyk+GamVYRR5ixuYUluL8AIcCPoZ
 0mVvhlejLdYPGGrdrNwe4K8TcAn16/xPd/+WerTc8IIb4UZXBCG+CVGZkOK2W3p1k82nskXI
 pqSd4ClC3oXE79gyhKtSuwal7Qsw0gWyWrVRJ3/5xum1KKTYHOLSLwFdkCHaKU39qqCqwTO+
 NEZPMLM1g43ePf5aCn/8oMJK10Oa38hCvjLR9d/bOWPJE9tH3ssTqaXyrI6cIsjlKNQ/gvVw
 kyAtoZj4AKXrRX6xc+iNhiPtJuHsU5DkE8G
IronPort-HdrOrdr: A9a23:hDjVf602tBeE9/+AL1j+3QqjBLckLtp133Aq2lEZdPWaSKOlfu
 SV7ZEmPH7P+VQssR4b8+xoVJPsfZqYz+8Q3WBzB8bAYOCFggqVxehZhOOI/9SjIU3DH4Vmu5
 uIHZITNDU1ZmIK6/oTJ2KDYrEd/OU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,347,1654560000"; 
   d="scan'208";a="938224320"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 26 Sep 2022 23:03:45 +0000
Received: from zorba ([10.25.129.98])
        by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id 28QN3fDH020704
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 26 Sep 2022 23:03:43 GMT
Date:   Mon, 26 Sep 2022 16:03:41 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Sean Anderson <sean.anderson@seco.com>,
        Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH 0/8] generic command line v4
Message-ID: <20220926230341.GD4320@zorba>
References: <20210416040924.2882771-1-danielwa@cisco.com>
 <b517fac5-2fdc-a8c9-75d0-174c67f5a2de@seco.com>
 <20220922205334.GV4320@zorba>
 <dcff9b0f-82c8-5aa7-0fff-b749a05fcb20@seco.com>
 <20220922211026.GW4320@zorba>
 <1663881344.25129.23.camel@chimera>
 <CAL_JsqLibRSi2n389Q7cf+1gQSidvfiZHjHCcGirgi0hgJ53-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLibRSi2n389Q7cf+1gQSidvfiZHjHCcGirgi0hgJ53-A@mail.gmail.com>
X-Outbound-SMTP-Client: 10.25.129.98, [10.25.129.98]
X-Outbound-Node: rcdn-core-1.cisco.com
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 26, 2022 at 05:52:18PM -0500, Rob Herring wrote:
> On Thu, Sep 22, 2022 at 4:15 PM Daniel Gimpelevich
> <daniel@gimpelevich.san-francisco.ca.us> wrote:
> >
> > On Thu, 2022-09-22 at 14:10 -0700, Daniel Walker wrote:
> > > On Thu, Sep 22, 2022 at 05:03:46PM -0400, Sean Anderson wrote:
> > [snip]
> > > > As recently as last month, someone's patch to add such support was
> > > > rejected for this reason [1].
> > > >
> > > > --Sean
> > > >
> > > > [1] https://lore.kernel.org/linux-arm-kernel/20220812084613.GA3107@willie-the-truck/
> > >
> > >
> > > I had no idea.. Thanks for pointing that out. I guess I will re-submit in that
> > > case.
> > >
> > > Daniel
> >
> > This has been happening repeatedly since circa 2014, on multiple
> > architectures. It's quite frustrating, really.
> 
> It must not be that important. From the last time, IMO Christophe's
> version was much closer to being merged than this series. This is not
> how you get things upstream:
> 
> > * Dropped powerpc changes
> >   Christophe Leroy has reservations about the features for powerpc. I
> >   don't think his reservations are founded, and these changes should
> >   fully work on powerpc. However, I dropped these changes so Christophe
> >   can have more time to get comfortable with the changes.
> 
> Rob

I don't submit often enough, that's true. However, I figured maintainers don't
want the changes. This is a common occurrence in industry, people may submit
once or twice, no traction and they give up. I suppose it's a combination of
problems.

Christophe's don't have the same features, so they are really totally different
but conflicting.

Daniel
