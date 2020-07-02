Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D177213048
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jul 2020 01:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgGBX5Z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jul 2020 19:57:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:9519 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgGBX5Z (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 2 Jul 2020 19:57:25 -0400
IronPort-SDR: Writ7GFlqQM+pzM6GUF6l7eWJBklM3+ps9qkTwT+4XXSNg1hA4OEjDhMw0J26ibh+rToVjO73v
 iopcHVZQmPkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="144572124"
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="144572124"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 16:57:24 -0700
IronPort-SDR: +yYtbwe8ez2z9Sh14NIXVLtojyMdup0jF+My1NFWwh7wOTLutIjw20Pma2hCj90y3iyH19ZONc
 56aZFZOZH71Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="481859602"
Received: from chadjitt-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.41.125])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2020 16:57:19 -0700
Date:   Fri, 3 Jul 2020 02:57:18 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Petr Vandrovec <petr@vmware.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Require that all digests are present in
 TCG_PCR_EVENT2 structures
Message-ID: <20200702235718.GI31291@linux.intel.com>
References: <20200615232504.1848159-1-tyhicks@linux.microsoft.com>
 <CAMj1kXHJbsxA2-jqpbLnUeeNfM0oC8Sh70+axOKoBCFMJ8+jKQ@mail.gmail.com>
 <20200617230958.GC62794@linux.intel.com>
 <20200630183321.GE4694@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630183321.GE4694@sequoia>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 30, 2020 at 01:33:21PM -0500, Tyler Hicks wrote:
> Jarkko, is this an ack from you?
> 
> Is there anything I can do to help along this fix?
> 
> I've spoke with two others that have poured through these specs to
> implement firmware event log parsers and they thought the change made
> sense.
> 
> Tyler

I revisited the original patch and this stroke into my eye:

"This is true, for example, when firmware passes the event log to the
kernel via a reserved memory region described in device tree."

During this discussion you gave an explanation what can trigger the bug
but in the commit message nothing anchors to anything.

Please give a concrete example what can trigger the issue directly in
the commit message instead. It's obviously needed.

In addition, you could also rewrite the existing inline comment to be
something more reasonable to the context.

/Jarkko
