Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9728D1AC631
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 16:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394314AbgDPOfT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Apr 2020 10:35:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:32947 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390489AbgDPOfQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 16 Apr 2020 10:35:16 -0400
IronPort-SDR: +EoHWgc5JHZbsFU6TEE873X72BrAPnLUjSQe0ZhoXXntDb2Re65mKPQMIltgMo4o89+AEAH6bZ
 l1Vvkef/BVcQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 07:35:16 -0700
IronPort-SDR: Yczz4GfRLg57htWIkGagIvfQxxAfgXJ/Yc+9bq+5r6lkNggGyJwnt2bduztBdXN2nuoMj+0k6m
 j7/qTxPSTwVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="332860044"
Received: from mylly.fi.intel.com (HELO [10.237.72.51]) ([10.237.72.51])
  by orsmga001.jf.intel.com with ESMTP; 16 Apr 2020 07:35:14 -0700
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Regression with commit 0a67361dcdaa
Message-ID: <eb0d88d0-879e-c500-261e-69c76fb68a89@linux.intel.com>
Date:   Thu, 16 Apr 2020 17:35:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi

v5.7-rc1 hangs in early boot on an Intel Atom based prototype hardware 
while v5.6 boots fine. I bisected the regression into 0a67361dcdaa 
("efi/x86: Remove runtime table address from kexec EFI setup data").

v5.7-rc1 caused a reboot loop on another Intel Core based prototype HW. 
Reboots also on top of 0a67361dcdaa but boots fine with that commit 
reverted.

Our test system uses kexec to boot the test kernel. These two machines 
got regression with v5.7-rc1. We have also others that boot fine.

-- 
Jarkko
