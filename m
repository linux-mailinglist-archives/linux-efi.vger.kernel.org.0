Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA823F64AD
	for <lists+linux-efi@lfdr.de>; Tue, 24 Aug 2021 19:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbhHXRG0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Aug 2021 13:06:26 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:45301 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239555AbhHXRE1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Aug 2021 13:04:27 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4GvFn64S48z9C;
        Tue, 24 Aug 2021 19:03:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1629824619; bh=Gi98RIyFxIAwT/ummlw73IPkyZzTIzAx+S3ca4JwLOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnwnuJh1yIhuJ141FvbpAtf+SNScolAUBpOrU+5Gy4LXh7Oxujhl/r+SVn+3nogdD
         H0JdA3ob5W8ZpbEyYOtMttHuX0cCuoFv1K2FlF5tFO+TMoGJYuIAARrFpohYSQcy8e
         WgLJY+YrudnoTWGvKgTlg6Q4fsvyglqZT9LhcBYsGlieAz79J0IMZY/yZcahCzUUnr
         i7pk0y37vPRCamkw1c6NTarhNTPWBCj06HPROBFfR8FBJjAfKUtQxcmh7hbaPbMZqS
         6E2YTIHcWBgE9Ugmr9Uqr6cI0tQTzT/Mj47JvqbRy6yTHrs9KcKubHLdvKN+O+05LJ
         vOtbgidvdQHdQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Tue, 24 Aug 2021 19:03:36 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rob Herring <robh+dt@kernel.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v6 0/5] Support EFI partition on NVIDIA Tegra devices
Message-ID: <YSUmaAiRx1Q4eEc/@qmqm.qmqm.pl>
References: <20210818221920.3893-1-digetx@gmail.com>
 <YSAvnQb29XlhqY7k@qmqm.qmqm.pl>
 <e35a9053-a793-d189-ff79-04212e1227c2@gmail.com>
 <YSQx0vRrpIGb4OIj@qmqm.qmqm.pl>
 <YSTMEM8JwwypL8Me@qmqm.qmqm.pl>
 <390673a8-f275-fd96-50a3-15db416aa6e6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <390673a8-f275-fd96-50a3-15db416aa6e6@gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 24, 2021 at 07:06:18PM +0300, Dmitry Osipenko wrote:
> 24.08.2021 13:38, Michał Mirosław пишет:
> > On Tue, Aug 24, 2021 at 01:40:02AM +0200, Michał Mirosław wrote:
> >> On Sat, Aug 21, 2021 at 08:27:15PM +0300, Dmitry Osipenko wrote:
> >>> 21.08.2021 01:41, Michał Mirosław пишет:
> >>>> On Thu, Aug 19, 2021 at 01:19:15AM +0300, Dmitry Osipenko wrote:
> >>>>> This series adds the most minimal EFI partition support for NVIDIA Tegra
> >>>>> consumer devices, like Android tablets and game consoles, making theirs
> >>>>> eMMC accessible out-of-the-box using downstream bootloader and mainline
> >>>>> Linux kernel.  eMMC now works on Acer A500 tablet and Ouya game console
> >>>>> that are already well supported in mainline and internal storage is the
> >>>>> only biggest thing left to support.
> >>>> [...]
> >>>>
> >>>> Could we provide the GPT sector via DT? As I understand this is for
> >>>> non-removable eMMC storage. It would remove the need for a cap bit and
> >>>> hardcoded calculations instead just checking if DT node of the controller
> >>>> contains a magic entry with a number.
> >>>
> >>> The same device model usually comes in different flavors that have a
> >>> different eMMC unit and size. So no, it can't be hardcoded in DT.
> >>
> >> I see. I was thinking how to avoid of going the whole way and creating
> >> another controller capability (since this is going to be core code) -
> >> could this workaround be enabled just by a boolean DT property at
> >> controller's node instead? Or do we expect non-DT platforms to be
> >> similarly broken?
> > 
> > Rewording my concern: I believe that this is platform's and not 
> > a controller's misfeature, so the controller driver feels like wrong
> > place fix. That's why I'd prefer that the enable came from the DT
> > and not from driver's code.
> 
> The alternative GPT entry requires user to add 'gpt' argument to
> kernel's cmdline. If board already uses proper alternative GPT entry at
> the last sector, then nothing changed for that board.
> 
> The case where board uses 'gpt' cmdline + it had stale GPT entry at the
> special location used by Android devices and chance that now suddenly
> that GPT entry will pop up is close to zero.
> 
> All old partition table entries should be erased on reparation. If it
> wasn't done, then it's not a kernel's problem, it's much more a user's
> problem. Even though kernel could help that poor user if will be really
> needed.
> 
> There is no reason to over-engineer unless somebody will tell that it
> broke the very special board. Neither of currently supported boards
> should require more quirks. Hence, why bother?

You could drop patch 4 from v7 if you checked DT boolean property
instead of adding a capability in patch 3. (Patch 4 would be replaced
by DT changes for relevant boards.)

Best Regards
Michał Mirosław
