Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C784539849D
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 10:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhFBIzD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 04:55:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:34379 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232853AbhFBIzA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 04:55:00 -0400
IronPort-SDR: KIJsP7sO0GKywWobxwCQIhaXBTQ6pXPTsWWKjf5BnbvmFgKjW9XvrsmhrpS+vKTYkVYtamFhbG
 iurVB82xG08g==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="267614485"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="267614485"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 01:53:17 -0700
IronPort-SDR: Em2W56IYgpfUhiS+w8EjxJEvSY2cqLISTskIMV63zE2eYZoft2/InKBmgGUwViGpeUlinaVS/g
 GwE9j8hydFZg==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="550053390"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 01:53:14 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1loMch-00GfBC-Gc; Wed, 02 Jun 2021 11:53:11 +0300
Date:   Wed, 2 Jun 2021 11:53:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Javier =?iso-8859-1?B?VGnh?= <javier.tia@gmail.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        Eric Biederman <ebiederm@xmission.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v1 0/2] firmware: dmi_scan: Make it work in kexec'ed
 kernel
Message-ID: <YLdG91qspr19heDS@smile.fi.intel.com>
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <YLdEZoSWI41fcTB1@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLdEZoSWI41fcTB1@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

+Cc: Ard

On Wed, Jun 02, 2021 at 11:42:14AM +0300, Andy Shevchenko wrote:
> On Fri, Dec 02, 2016 at 09:54:14PM +0200, Andy Shevchenko wrote:
> > Until now DMI information is lost when kexec'ing. Fix this in the same way as
> > it has been done for ACPI RSDP.
> > 
> > Series has been tested on Galileo Gen2 where DMI is used by drivers, in
> > particular the default I2C host speed is choosen based on DMI system
> > information and now gets it correct.
> 
> Still nothing happens for a while and problem still exists.
> Can we do something about it, please?

-- 
With Best Regards,
Andy Shevchenko


