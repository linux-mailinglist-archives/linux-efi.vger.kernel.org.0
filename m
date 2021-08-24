Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5B3F5C37
	for <lists+linux-efi@lfdr.de>; Tue, 24 Aug 2021 12:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbhHXKi7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Aug 2021 06:38:59 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:41387 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235952AbhHXKi6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Aug 2021 06:38:58 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Gv5DL3XbNz9C;
        Tue, 24 Aug 2021 12:38:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1629801492; bh=bkSdTTCk57d8iy5mRqGsesttYt2yqy5GM4QwwvILfew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQgzHrnyVfo331tJOis3V6XAxhJXw/t45DLBRHtwzBsIlC6xyeLdd98Ar5oAvofrF
         Y/or9S6TOHzWi8FcGELvF9eU1ybAcykOQ+gqAbCd3oU4mchPL7emggASIvSWubKN4f
         LuvpywMLZSWt3VesdTrzGFJHn2zY3rOO/Bll4WQRBSiNJYFXeMW/58h/6usdbysZ/O
         k9sr7y7PMUGfqpT0AXwOSAyrVWlQxtKO8HuDcB5/uR2Z3UbDb/nOfid+GBVWh/gqwn
         KBC1VuCsljcgWi171dH/a61B/ORGN8/ha38Ar9kNx9xwVaYBZFye3EFY9fQf+GzK0W
         nLG5evIGhQVBg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Tue, 24 Aug 2021 12:38:08 +0200
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
Message-ID: <YSTMEM8JwwypL8Me@qmqm.qmqm.pl>
References: <20210818221920.3893-1-digetx@gmail.com>
 <YSAvnQb29XlhqY7k@qmqm.qmqm.pl>
 <e35a9053-a793-d189-ff79-04212e1227c2@gmail.com>
 <YSQx0vRrpIGb4OIj@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YSQx0vRrpIGb4OIj@qmqm.qmqm.pl>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 24, 2021 at 01:40:02AM +0200, Michał Mirosław wrote:
> On Sat, Aug 21, 2021 at 08:27:15PM +0300, Dmitry Osipenko wrote:
> > 21.08.2021 01:41, Michał Mirosław пишет:
> > > On Thu, Aug 19, 2021 at 01:19:15AM +0300, Dmitry Osipenko wrote:
> > >> This series adds the most minimal EFI partition support for NVIDIA Tegra
> > >> consumer devices, like Android tablets and game consoles, making theirs
> > >> eMMC accessible out-of-the-box using downstream bootloader and mainline
> > >> Linux kernel.  eMMC now works on Acer A500 tablet and Ouya game console
> > >> that are already well supported in mainline and internal storage is the
> > >> only biggest thing left to support.
> > > [...]
> > > 
> > > Could we provide the GPT sector via DT? As I understand this is for
> > > non-removable eMMC storage. It would remove the need for a cap bit and
> > > hardcoded calculations instead just checking if DT node of the controller
> > > contains a magic entry with a number.
> > 
> > The same device model usually comes in different flavors that have a
> > different eMMC unit and size. So no, it can't be hardcoded in DT.
> 
> I see. I was thinking how to avoid of going the whole way and creating
> another controller capability (since this is going to be core code) -
> could this workaround be enabled just by a boolean DT property at
> controller's node instead? Or do we expect non-DT platforms to be
> similarly broken?

Rewording my concern: I believe that this is platform's and not 
a controller's misfeature, so the controller driver feels like wrong
place fix. That's why I'd prefer that the enable came from the DT
and not from driver's code.

Best Regards
Michał Mirosław
