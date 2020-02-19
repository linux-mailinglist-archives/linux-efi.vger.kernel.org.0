Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B903164A4D
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 17:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgBSQ1w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 11:27:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgBSQ1v (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Feb 2020 11:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+CojvMx93xsodiDvTtV8/VrGBaV6zZUC2VstkM1u1l4=; b=MjkW87BVQNY2tB0+8h16ljneX5
        hvtTluLOHHUfLC/dX/YPRFHXtmiZhwcCvDndhqME9bbd7LrfHXdOxvEqcY6zTbuQDftls28L4iATG
        uQ80SplXnwJ+VyJN/vbPrIStB9Qlopf+NUovvu0r91zcG6z+L5LHOZ9sHM/fnfm+An5Fvq5OLASn9
        RHakAxi18QNh9YlhSkm0qGy+/1Diq11nU5wrk/W1APzhp+vQT88P7AtvVcxxopYf6qR4fueaKexJm
        u8f34hRz8qFCwj+kwcRxMtypfZBZQ75fcNBAcHNdoStX4ZhR5tDdid67P9vIckdkv/1Z3DtdMRKss
        cOvT7kZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4SCI-0002si-55; Wed, 19 Feb 2020 16:27:38 +0000
Date:   Wed, 19 Feb 2020 08:27:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Davidlohr Bueso <dave@stgolabs.net>,
        Colin Cross <ccross@android.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-efi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] partitions/efi: Add 'gpt_sector' kernel cmdline
 parameter
Message-ID: <20200219162738.GA10644@infradead.org>
References: <20200219162339.16192-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219162339.16192-1-digetx@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 19, 2020 at 07:23:39PM +0300, Dmitry Osipenko wrote:
> The gpt_sector=<sector> causes the GPT partition search to look at the
> specified sector for a valid GPT header if the GPT is not found at the
> beginning or the end of block device.
> 
> In particular this is needed for NVIDIA Tegra consumer-grade Android
> devices in order to make them usable with the upstream kernel because
> these devices use a proprietary / closed-source partition table format
> for the EMMC and it's impossible to change the partition's format. Luckily
> there is a GPT table in addition to the proprietary table, which is placed
> in uncommon location of the EMMC storage and bootloader passes the
> location to kernel using "gpt gpt_sector=<sector>" cmdline parameters.
> 
> This patch is based on the original work done by Colin Cross for the
> downstream Android kernel.

I don't think a magic command line is the way to go.  The best would be
to reverse-engineer the proprietary partition table format.  If that is
too hard we can at least key off the odd GPT location based of it's
magic number.
