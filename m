Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578A73F53B4
	for <lists+linux-efi@lfdr.de>; Tue, 24 Aug 2021 01:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhHWXkv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Aug 2021 19:40:51 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:61298 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233093AbhHWXkv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 23 Aug 2021 19:40:51 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Gtpd03NltzKc;
        Tue, 24 Aug 2021 01:40:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1629762006; bh=qwPmxSCbcInO/eyiUPjnhxEQ5MqYKo21su0OGAIP8zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJrSKNpoXRQS5hFI7c50USjwJClWUGt5vZOZp2UAXk0WyKSRzlIg9rrFRN1JqtVue
         X7V8gCHcP1jjj5XCIMw2Va5XH/DgXiEAcxjru7FbEOEXtVpZgiNUmh3uNZI7/AEMAt
         Bi5cP8LqxNnvMrcgZLTDUjc5njiamlbwEk03dPWwW/yV3cHxEgURdDHAi06tzXy9Nn
         wibl6Uy5qScKoW2zHAR+eRuCDS0SPbSYomRn2sL4aLE0w1tHticWo8I6/9/3XPi1sW
         7pfj1GvOxdNZd8yvqHZU4Jdi5I1t5MKSSZ1+/i2hT2OdzU38OMbjsAX/kWbr4Vq5hx
         YIHU8R7pXCxrA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Tue, 24 Aug 2021 01:40:02 +0200
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
Message-ID: <YSQx0vRrpIGb4OIj@qmqm.qmqm.pl>
References: <20210818221920.3893-1-digetx@gmail.com>
 <YSAvnQb29XlhqY7k@qmqm.qmqm.pl>
 <e35a9053-a793-d189-ff79-04212e1227c2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e35a9053-a793-d189-ff79-04212e1227c2@gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Aug 21, 2021 at 08:27:15PM +0300, Dmitry Osipenko wrote:
> 21.08.2021 01:41, Michał Mirosław пишет:
> > On Thu, Aug 19, 2021 at 01:19:15AM +0300, Dmitry Osipenko wrote:
> >> This series adds the most minimal EFI partition support for NVIDIA Tegra
> >> consumer devices, like Android tablets and game consoles, making theirs
> >> eMMC accessible out-of-the-box using downstream bootloader and mainline
> >> Linux kernel.  eMMC now works on Acer A500 tablet and Ouya game console
> >> that are already well supported in mainline and internal storage is the
> >> only biggest thing left to support.
> > [...]
> > 
> > Could we provide the GPT sector via DT? As I understand this is for
> > non-removable eMMC storage. It would remove the need for a cap bit and
> > hardcoded calculations instead just checking if DT node of the controller
> > contains a magic entry with a number.
> 
> The same device model usually comes in different flavors that have a
> different eMMC unit and size. So no, it can't be hardcoded in DT.

I see. I was thinking how to avoid of going the whole way and creating
another controller capability (since this is going to be core code) -
could this workaround be enabled just by a boolean DT property at
controller's node instead? Or do we expect non-DT platforms to be
similarly broken?

Best Regards
Michał Mirosław
