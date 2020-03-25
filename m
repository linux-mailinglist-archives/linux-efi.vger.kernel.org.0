Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB9DF192F52
	for <lists+linux-efi@lfdr.de>; Wed, 25 Mar 2020 18:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgCYRdn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Mar 2020 13:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbgCYRdm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Mar 2020 13:33:42 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D6B20740
        for <linux-efi@vger.kernel.org>; Wed, 25 Mar 2020 17:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585157622;
        bh=pphi18T7D1mIuaACHN5g5DSb3sNXUF78jLFaPNjg/FU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dBxFoHbT7V49DRyihWtbg6OjE4jYgotPj5t38WAkupzdLoXGYJfmJmRkOVOpsygqR
         XTa+WAWpwnwBGsmfzThtCd3Lc4NJWKPUovSvYn4zQ2EaD+es9pehj4wJDmCZjj0cTt
         9A3TeXbR83EY5Vxew92p8k/QCBtvnNwdhuhvZZsA=
Received: by mail-wr1-f44.google.com with SMTP id u10so4226344wro.7
        for <linux-efi@vger.kernel.org>; Wed, 25 Mar 2020 10:33:42 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0VHfi8xTUQucTlt8cT4W/w4E/jV2h5Zcf7dTVwLv86C9Qbi1UG
        1D2BoruxSoVC2gOXWtsCDwkokVmkOIQk+1sgZ5oLIQ==
X-Google-Smtp-Source: ADFU+vtx6OAR/Fi7rV5lGb0rQePCkeCAIrRpEVmnbHA2ofmwgacBNg5WhWV1S2kZoRi85Il2hsnPQskuGYBHW8/OEjM=
X-Received: by 2002:a5d:4fcf:: with SMTP id h15mr4548116wrw.262.1585157620715;
 Wed, 25 Mar 2020 10:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200312011312.70653-1-qiuxu.zhuo@intel.com> <CAKv+Gu9BvqZavV6XjfuacXXpabNCXLYEw-f=81fwX8hdL6Fn-A@mail.gmail.com>
 <d0a09900ca0341029980d351bbe2aecc@intel.com> <CAKv+Gu82OFMJk-jQKdvA0_Sgp_CCmvC1a63QYrY+Cc4Qjx3+Yw@mail.gmail.com>
 <abd0a0d1095f4bc4a8fc2be420a2478a@intel.com> <20200320192527.GA31764@agluck-desk2.amr.corp.intel.com>
 <CAKv+Gu9zJ7O29Y1+99TSBuQJ86RKDJ4MQHZSUs+rxq0WHKMEYg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9zJ7O29Y1+99TSBuQJ86RKDJ4MQHZSUs+rxq0WHKMEYg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 25 Mar 2020 18:33:29 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-XZEnxU5eGSfemhSWj8agZUFV59h23fPMH80Hk-pjuaA@mail.gmail.com>
Message-ID: <CAKv+Gu-XZEnxU5eGSfemhSWj8agZUFV59h23fPMH80Hk-pjuaA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add capsule-pstore backend support
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Gao, Liming" <liming.gao@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 25 Mar 2020 at 16:52, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 20 Mar 2020 at 20:25, Luck, Tony <tony.luck@intel.com> wrote:
> >
> > On Thu, Mar 19, 2020 at 01:53:38AM -0700, Zhuo, Qiuxu wrote:
> > > > From: linux-efi-owner@vger.kernel.org <linux-efi-owner@vger.kernel.org> On> Behalf Of Ard Biesheuvel
> > > > ...
> > > > > The following commit on the tip tree removes the variables 'config_table' from the efi structure.
> > > > >
> > > > >     9cd437ac0ef4 ("efi/x86: Make fw_vendor, config_table and runtime sysfs nodes x86 specific")
> > > > >
> > > > > But the external driver "capsule-pstore.ko" needs to access  'config_table' and 'nr_tables' to go through the configuration table to extract  crash capsules.
> > > > >
> > > > > Adding 'config_table' and 'nr_tables' back to the efi structure looks like not a good way.
> > > > > Do you have any  suggestion on how to export 'config_table' and 'nr_tables' variables for the external driver "capsule-pstore.ko"?
> > > > >
> > > >
> > > > I will get back to you on monday about this. In any case, this will have to wait until v5.8
> > >
> > > OK. Thanks!
> >
> > Would it be acceptable to take the first half of Qiuxu's
> > function efi_capsule_table_get() and move it into the
> > generic efi code naming it something like: "efi_get_table_by_guid()"?
> > Then EXPORT_GPL that function?
> >
>
> That sounds reasonable to me.

Actually, I don't think this is necessary. The capsule pstore
implementation uses a fixed GUID, which we could simply add to the
common_tables[] array so that its address gets recorded when we
iterate over the list of config tables.
