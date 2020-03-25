Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F380192D74
	for <lists+linux-efi@lfdr.de>; Wed, 25 Mar 2020 16:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgCYPwW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Mar 2020 11:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbgCYPwW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Mar 2020 11:52:22 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C86772078A
        for <linux-efi@vger.kernel.org>; Wed, 25 Mar 2020 15:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585151542;
        bh=A4aToqgYItAqaRXK+3xYpi8GGWZeOAW9vy5r583WeHs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bI1HIvZMrl1CxxMsAyD8uC2fDT7OXAvzGPSnDrUThrlUHbWlZUcYMmqN7dzktVOwV
         fgkiche1KVleEB6GbMo5BRNvfKfoqj0P6X5Jff4EgzSPpRYU3PRpG3Rkezdrt/6ejm
         56HvU5HSbIrf9Xcvsstm1ubMPSwD1JfJo3VTTnWI=
Received: by mail-wm1-f48.google.com with SMTP id a81so3278239wmf.5
        for <linux-efi@vger.kernel.org>; Wed, 25 Mar 2020 08:52:21 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1qvOyZrvZP6h7V/qK2rjgXX75oyng62Y84eSfNpQRB/0I2G2Do
        evsH3mrSYecEekG+J47OPvw1syEoNHAXSYue16QXWw==
X-Google-Smtp-Source: ADFU+vt8735ZWRnBwRWD9SqkPAn5QRqdMwZN/c2sk954h87LHobbuMDhyHh7DZF84UWK+AvlpFCnB2rr2aczEq6qvrM=
X-Received: by 2002:a1c:ac8a:: with SMTP id v132mr3934539wme.62.1585151540255;
 Wed, 25 Mar 2020 08:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200312011312.70653-1-qiuxu.zhuo@intel.com> <CAKv+Gu9BvqZavV6XjfuacXXpabNCXLYEw-f=81fwX8hdL6Fn-A@mail.gmail.com>
 <d0a09900ca0341029980d351bbe2aecc@intel.com> <CAKv+Gu82OFMJk-jQKdvA0_Sgp_CCmvC1a63QYrY+Cc4Qjx3+Yw@mail.gmail.com>
 <abd0a0d1095f4bc4a8fc2be420a2478a@intel.com> <20200320192527.GA31764@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200320192527.GA31764@agluck-desk2.amr.corp.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 25 Mar 2020 16:52:09 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9zJ7O29Y1+99TSBuQJ86RKDJ4MQHZSUs+rxq0WHKMEYg@mail.gmail.com>
Message-ID: <CAKv+Gu9zJ7O29Y1+99TSBuQJ86RKDJ4MQHZSUs+rxq0WHKMEYg@mail.gmail.com>
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

On Fri, 20 Mar 2020 at 20:25, Luck, Tony <tony.luck@intel.com> wrote:
>
> On Thu, Mar 19, 2020 at 01:53:38AM -0700, Zhuo, Qiuxu wrote:
> > > From: linux-efi-owner@vger.kernel.org <linux-efi-owner@vger.kernel.org> On> Behalf Of Ard Biesheuvel
> > > ...
> > > > The following commit on the tip tree removes the variables 'config_table' from the efi structure.
> > > >
> > > >     9cd437ac0ef4 ("efi/x86: Make fw_vendor, config_table and runtime sysfs nodes x86 specific")
> > > >
> > > > But the external driver "capsule-pstore.ko" needs to access  'config_table' and 'nr_tables' to go through the configuration table to extract  crash capsules.
> > > >
> > > > Adding 'config_table' and 'nr_tables' back to the efi structure looks like not a good way.
> > > > Do you have any  suggestion on how to export 'config_table' and 'nr_tables' variables for the external driver "capsule-pstore.ko"?
> > > >
> > >
> > > I will get back to you on monday about this. In any case, this will have to wait until v5.8
> >
> > OK. Thanks!
>
> Would it be acceptable to take the first half of Qiuxu's
> function efi_capsule_table_get() and move it into the
> generic efi code naming it something like: "efi_get_table_by_guid()"?
> Then EXPORT_GPL that function?
>

That sounds reasonable to me.
