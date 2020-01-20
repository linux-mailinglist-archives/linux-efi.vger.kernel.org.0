Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47CFE14337A
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2020 22:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgATVmn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Jan 2020 16:42:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:43080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbgATVmn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 20 Jan 2020 16:42:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 22C13AD5D;
        Mon, 20 Jan 2020 21:42:41 +0000 (UTC)
Date:   Mon, 20 Jan 2020 22:42:04 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Young <dyoung@redhat.com>, linux-efi@vger.kernel.org,
        ard.biesheuvel@linaro.org, matt@codeblueprint.co.uk,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 2/2] firmware: dmi_scan: Pass dmi_entry_point to
 kexec'ed kernel
Message-ID: <20200120224204.4e5cc0df@endymion>
In-Reply-To: <87a76i9ksr.fsf@x220.int.ebiederm.org>
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
        <20161202195416.58953-3-andriy.shevchenko@linux.intel.com>
        <20161215122856.7d24b7a8@endymion>
        <20161216023213.GA4505@dhcp-128-65.nay.redhat.com>
        <1481890738.9552.70.camel@linux.intel.com>
        <20161216143330.69e9c8ee@endymion>
        <20161217105721.GB6922@dhcp-128-65.nay.redhat.com>
        <20200120121927.GJ32742@smile.fi.intel.com>
        <87a76i9ksr.fsf@x220.int.ebiederm.org>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 20 Jan 2020 10:04:04 -0600, Eric W. Biederman wrote:
> Second.  I looked at your test results and they don't directly make
> sense.  dmidecode bypasses the kernel completely or it did last time
> I looked so I don't know why you would be using that to test if
> something in the kernel is working.

That must have been long ago. A recent version of dmidecode (>= 3.0)
running on a recent kernel
(>= d7f96f97c4031fa4ffdb7801f9aae23e96170a6f, v4.2) will read the DMI
data from /sys/firmware/dmi/tables, so it is very much relying on the
kernel doing the right thing. If not, it will still try to fallback to
reading from /dev/mem directly on certain architectures. You can force
that old method with --no-sysfs.

Hope that helps,
-- 
Jean Delvare
SUSE L3 Support
