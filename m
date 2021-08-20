Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073C03F3692
	for <lists+linux-efi@lfdr.de>; Sat, 21 Aug 2021 00:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhHTWmU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 18:42:20 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:5699 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233567AbhHTWmT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 18:42:19 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4GrxSx5Mzgz6q;
        Sat, 21 Aug 2021 00:41:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1629499299; bh=dReQbCqzMBnPYZYQCC3ZPA0hKt+oRD/wuekxzfsrifk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VWAlxPNpdBW/4CoWX1YZJ/MCVVkydV7sbTHA+8dckaNuJwD3eTM7E6HfMpkkYrFKU
         9BK8xCu6k6+GDh1ep3qWpa5ko4KOQv8Ba1dEBnSrTewETCCeeIYD2zuT7Ii1RrLw1C
         m7mfSTqCFjTOVKNTvMWjnMc4qVRDMfFdvamIuibU/DuIfuCP4z/FBAJmOEp0hPr0w1
         PMdPJGvfR3u6SGV4Xz9y5eeCy5/Usl7nrtxNMEt7m/NMkjcbg4j55JDq0i+XIUG0oR
         Jw4223EpLgHjNYXSbM7Jt1AvW5UeKpQ0gqgx4tdBBM9jeonrTeCMfjhHAFopmBr61f
         aLwGTfNDflJ3g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Sat, 21 Aug 2021 00:41:33 +0200
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
Message-ID: <YSAvnQb29XlhqY7k@qmqm.qmqm.pl>
References: <20210818221920.3893-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210818221920.3893-1-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 19, 2021 at 01:19:15AM +0300, Dmitry Osipenko wrote:
> This series adds the most minimal EFI partition support for NVIDIA Tegra
> consumer devices, like Android tablets and game consoles, making theirs
> eMMC accessible out-of-the-box using downstream bootloader and mainline
> Linux kernel.  eMMC now works on Acer A500 tablet and Ouya game console
> that are already well supported in mainline and internal storage is the
> only biggest thing left to support.
[...]

Could we provide the GPT sector via DT? As I understand this is for
non-removable eMMC storage. It would remove the need for a cap bit and
hardcoded calculations instead just checking if DT node of the controller
contains a magic entry with a number.

Best Regards
Micha³ Miros³aw
