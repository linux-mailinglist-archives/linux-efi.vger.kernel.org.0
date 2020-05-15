Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87ADF1D4B2F
	for <lists+linux-efi@lfdr.de>; Fri, 15 May 2020 12:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgEOKkG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 May 2020 06:40:06 -0400
Received: from cheddar.halon.org.uk ([93.93.131.118]:58194 "EHLO
        cheddar.halon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgEOKkF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 May 2020 06:40:05 -0400
X-Greylist: delayed 2113 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 May 2020 06:40:04 EDT
Received: from bsmtp by cheddar.halon.org.uk with local-bsmtp (Exim 4.92)
        (envelope-from <steve@einval.com>)
        id 1jZXCM-0005Bp-LR; Fri, 15 May 2020 11:04:10 +0100
Received: from steve by tack.einval.org with local (Exim 4.92)
        (envelope-from <steve@einval.com>)
        id 1jZXBi-0000Vp-4M; Fri, 15 May 2020 11:03:30 +0100
Date:   Fri, 15 May 2020 11:03:30 +0100
From:   Steve McIntyre <steve@einval.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>,
        Nils =?iso-8859-1?Q?=D6stlund?= <nils@naltan.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v4 4/6] partitions/efi: Support GPT entry lookup at a
 non-standard location
Message-ID: <20200515100320.GB30674@tack.einval.com>
References: <20200515014143.12984-1-digetx@gmail.com>
 <20200515014143.12984-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515014143.12984-5-digetx@gmail.com>
X-attached: none
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 15, 2020 at 04:41:41AM +0300, Dmitry Osipenko wrote:
>Most of consumer-grade NVIDIA Tegra devices use a proprietary bootloader
>that can't be easily replaced because it's locked down using Secure Boot
>cryptography singing and the crypto keys aren't given to a device owner.
              ^^^^^^^ typo
>These devices usually have eMMC storage that is partitioned using a custom
>NVIDIA Tegra partition table format.  Of course bootloader and other
>"special things" are stored on the eMMC storage, and thus, the partition
>format can't be changed.

...

-- 
Steve McIntyre, Cambridge, UK.                                steve@einval.com
"Further comment on how I feel about IBM will appear once I've worked out
 whether they're being malicious or incompetent. Capital letters are forecast."
 Matthew Garrett, http://www.livejournal.com/users/mjg59/30675.html

