Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979BE1AC797
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 16:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgDPO4o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Apr 2020 10:56:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:7588 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409182AbgDPO4l (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 16 Apr 2020 10:56:41 -0400
IronPort-SDR: s8YkELX1IbRRK2DsNPzM2BtwZjK5310yHKkRIn75auguFMjRyW/FBz5KtFndcvcC8XWdJYpv31
 QoP3iQIoSUUQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 07:56:40 -0700
IronPort-SDR: uLbV3hxQRXypLeaOz3XOjU4fzbZM2N0R9vWON9psEM7DrROpZqt+eYG7CGc2dwHondC2MgtJMy
 O3nzONKtczOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="332865081"
Received: from mylly.fi.intel.com (HELO [10.237.72.51]) ([10.237.72.51])
  by orsmga001.jf.intel.com with ESMTP; 16 Apr 2020 07:56:38 -0700
Subject: Re: Regression with commit 0a67361dcdaa
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <eb0d88d0-879e-c500-261e-69c76fb68a89@linux.intel.com>
 <CAMj1kXGGdwuP6X5jvbqmjsP2+bZ7CoJKZ5-WVoPYEjq9HTjuDA@mail.gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <9ae0c751-5024-6eda-ca78-80cfd1ed066f@linux.intel.com>
Date:   Thu, 16 Apr 2020 17:56:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXGGdwuP6X5jvbqmjsP2+bZ7CoJKZ5-WVoPYEjq9HTjuDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/16/20 5:36 PM, Ard Biesheuvel wrote:
> On Thu, 16 Apr 2020 at 16:35, Jarkko Nikula
> <jarkko.nikula@linux.intel.com> wrote:
>>
>> Hi
>>
>> v5.7-rc1 hangs in early boot on an Intel Atom based prototype hardware
>> while v5.6 boots fine. I bisected the regression into 0a67361dcdaa
>> ("efi/x86: Remove runtime table address from kexec EFI setup data").
>>
>> v5.7-rc1 caused a reboot loop on another Intel Core based prototype HW.
>> Reboots also on top of 0a67361dcdaa but boots fine with that commit
>> reverted.
>>
>> Our test system uses kexec to boot the test kernel. These two machines
>> got regression with v5.7-rc1. We have also others that boot fine.
>>
> 
> This should already be fixed in Linus's tree. Please report back
> whether that solves your problem or not.
> 
Ah, I forgot to pull & test before bisecting...

Yes, both machines boot fine with the HEAD 00086336a8d9 ("Merge tag 
'efi-urgent-2020-04-15' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip").

-- 
Jarkko
