Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8323F1EE7
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 19:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhHSRTm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 13:19:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35764 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhHSRTm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Aug 2021 13:19:42 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CDD611FDCB;
        Thu, 19 Aug 2021 17:19:03 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0284113DDF;
        Thu, 19 Aug 2021 17:18:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nnnJLYOSHmF3OwAAMHmgww
        (envelope-from <dave@stgolabs.net>); Thu, 19 Aug 2021 17:18:59 +0000
Date:   Thu, 19 Aug 2021 10:18:54 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
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
        Rob Herring <robh+dt@kernel.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v6 0/5] Support EFI partition on NVIDIA Tegra devices
Message-ID: <20210819171854.hmpycxs5pqiwq4qg@offworld>
References: <20210818221920.3893-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210818221920.3893-1-digetx@gmail.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 19 Aug 2021, Dmitry Osipenko wrote:

>    - Moved GPT calculation into MMC core and added MMC_CAP2_ALT_GPT_SECTOR
>      flag, like it was asked by Ulf Hansson. Me and Thierry have concerns
>      about whether it's better to have Tegra-specific function in a core
>      instead of Tegra driver, but it also works, so I decided to try that
>      variant.

I think this is better as you had it in v5. This is specific to tegra and
shouldn't be in generic code.

Thanks,
Davidlohr
