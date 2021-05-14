Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3178638026F
	for <lists+linux-efi@lfdr.de>; Fri, 14 May 2021 05:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhENDWU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 May 2021 23:22:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:55954 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhENDWU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 May 2021 23:22:20 -0400
IronPort-SDR: eF2LYTKiTBo3QI3tFoPeJKLw45Do2g6UxeXA/WbcBSCA/wuZ9N6+v6YnQEANkrBucJ9hJpBhzz
 JDx9glSxrSBA==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="180379099"
X-IronPort-AV: E=Sophos;i="5.82,298,1613462400"; 
   d="scan'208";a="180379099"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 20:21:08 -0700
IronPort-SDR: 3Y1sa61RD3w4yfX5aI+UpzMn0IdD3n+fLaRLSs4aRL0GIDxCBNOYs4HKlXEbZ57Q+9q+CNdpBL
 FBGkSiup4gWQ==
X-IronPort-AV: E=Sophos;i="5.82,298,1613462400"; 
   d="scan'208";a="626639296"
Received: from qiuxu-lab.sh.intel.com ([10.239.53.102])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 20:21:07 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     ardb@kernel.org
Cc:     qiuxu.zhuo@intel.com, keescook@chromium.org, liming.gao@intel.com,
        linux-efi@vger.kernel.org, matt@codeblueprint.co.uk,
        tony.luck@intel.com
Subject: RE: [PATCH v6 2/2] eif/capsule-pstore: Add capsule pstore backend
Date:   Fri, 14 May 2021 11:21:37 +0800
Message-Id: <20210514032137.94458-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <dad4cdef71cf415f8ee6f0987b467b01@intel.com>
References: <dad4cdef71cf415f8ee6f0987b467b01@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

>> From: linux-efi-owner@vger.kernel.org <linux-efi-owner@vger.kernel.org> On Behalf Of Ard Biesheuvel
>> ...
>> 
>> OK, so I see one complication with this. The EFI UpdateCapsule() runtime
>> service expects the OS to use the EFI ResetSystem() runtime service to
>> perform the reboot. pstore is designed to record whatever it can while the
>> system is crashing, and so it this would need reboot_on_panic at the very
>> least, but even then, it is not very likely that you would be able to do a
>> clean soft reboot from that state in the general case.
>> 
>> So unless there is a way to perform the test steps /without/ relying on
>> magic SysRq to do a soft reboot after the system has panicked, I'm not convinced this is worthwhile.


> Hi Ard,
>
> Your concern is reasonable! Thanks!
>
> Yes, the capsule-pstore driver depends on the EFI ResetSystem() runtime service
> to perform the reboot to save the capsules of crashing dump across a warm reset.
> Investigation on current Linux kernel reboot code (see the commits below) of
> arm64 and x86 shows that if the system is UEFI Runtime Services available or
> if an EFI capsule has been sent to the firmware then the system is forced to
> use EFI ResetSystem(). I.e., the EFI ResetSystem() will be the preferred reboot
> path if we have EFI capsules. 
>
>      arm64: 60c0d45a7f7a ("efi/arm64: use UEFI for system reset and poweroff") 
>        x86: 87615a34d561 ("x86/efi: Force EFI reboot to process pending capsules")
>
> So the capsule-pstore simply depends on reboot_on_panic. The dependency may
> make it seem to be different from some other pstore backend drivers that save
> the dump to some persistent memory, so they don’t care how the system is reset
> (could even be power-cycled). Whether rebooting the kernel or pinning it in a
> loop on panic is controlled by "panic_timeout" which is exported for external
> modules. The capsule-pstore driver may check it and print a warning message if
> it isn't set to trigger a reboot (panic_timeout=0). 
>
> One more example of pstore successfully using the capsule-pstore driver is showed
> as below (the panic_timeout=1 was pre-set, so the kernel got reboot on panic).
> It didn't relying on magic SysRq to reboot the system. Tested the capsule-pstore
> driver that it still worked well. 
>
> Summary: The capsule-pstore only depends on panic_timeout !=0. If panic_timeout !=0,
> then the capsule-pstore can work (certainly, the system should have EFI Runtime Services).
> Hope the capsule-pstore is still a worthwhile pstore backend.  :-)
> ...

Hi Ard,

Hope all is well with you. May I know whether the comments above make sense for you? 
Thanks!

-Qiuxu
