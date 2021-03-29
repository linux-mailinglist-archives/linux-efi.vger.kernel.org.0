Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4CF34C3BB
	for <lists+linux-efi@lfdr.de>; Mon, 29 Mar 2021 08:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhC2GUI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Mar 2021 02:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhC2GUG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Mar 2021 02:20:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A10C061574;
        Sun, 28 Mar 2021 23:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sq1uYVoQTXMfZgTwubV+poh66gR8IPfBn1Jh5qo2ZyY=; b=HIK9ChXrCn4n0LY/ocJkIAnMC8
        hhbVgZNJI/kqZXN9AUUxXdCB7IOhpm+6+SRihZNCTNRKYvkNqoNt4K+e12MGcT5aogaP3puBewvp/
        ia2NKSC+MocnJmo0CMN+INON/2xS61wz1GpQ1WETJaSb6vLYuByjnxTtzmr1RorMRKC5QlY/bzQy7
        Ebo5tfJLPPLisXlgZy4Sh5oTvD9Vc2/+h36KoyWFi/bVAIMKDciKjEvTiFO1/a6KjcRIiaHlN2kc7
        TXvwb4r+cLIjO1XSOfg5Cr2EQyZ0wjhX82Y0Gsu0yLK+aQ0z9okx/6epXfG2om0kidjUxOIUWQt0v
        P7PC91kw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lQlEg-0015iv-Km; Mon, 29 Mar 2021 06:18:56 +0000
Date:   Mon, 29 Mar 2021 07:18:50 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Micha?? Miros??aw <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] partitions/efi: Support gpt_sector parameter
 needed by NVIDIA Tegra devices
Message-ID: <20210329061850.GA258398@infradead.org>
References: <20210327212100.3834-1-digetx@gmail.com>
 <20210327212100.3834-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327212100.3834-4-digetx@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Mar 28, 2021 at 12:21:00AM +0300, Dmitry Osipenko wrote:
> All NVIDIA Tegra20..124 Android devices use proprietary bootloader
> which supplies the gpt_sector=<sector> kernel cmdline parameter that
> should be used for looking up the EFI partition table on internal EMMC
> storage.  If the kernel cmdline parameter isn't supplied, then the
> partition is expected to be placed around the last but one sector of EMMC.
> 
> Apparently this was done in order to hide the PT from a usual userspace
> tools since EFI entry exists only for compatibility with a Linux kernel,

That's weird, because nothin in Linux relies in EFI partition tables.

> while a custom proprietary partition table is what is really used by
> these Android devices, thus these tools may corrupt the real PT, making
> device unbootable and very difficult to restore.
> 
> Add support for the gpt_sector cmdline parameter which will be used
> for finding EFI entry on internal EMMC storage of NVIDIA Tegra20+ devices.

Didn't we plan to just support the actual partition table format insted?
