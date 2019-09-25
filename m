Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1F8BDB6C
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2019 11:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfIYJvX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Sep 2019 05:51:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:32918 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfIYJvX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Sep 2019 05:51:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 02:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,547,1559545200"; 
   d="scan'208";a="191290854"
Received: from dariusvo-mobl.ger.corp.intel.com (HELO localhost) ([10.249.39.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Sep 2019 02:51:17 -0700
Date:   Wed, 25 Sep 2019 12:51:14 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Matthew Garrett <matthewgarrett@google.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        x86@kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86, efi: never relocate kernel below lowest
 acceptable address
Message-ID: <20190925095114.GB5173@linux.intel.com>
References: <20190919160521.13820-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919160521.13820-1-kasong@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 20, 2019 at 12:05:21AM +0800, Kairui Song wrote:
> Currently, kernel fails to boot on some HyperV VMs when using EFI.
> And it's a potential issue on all platforms.
> 
> It's caused a broken kernel relocation on EFI systems, when below three
> conditions are met:
> 
> 1. Kernel image is not loaded to the default address (LOAD_PHYSICAL_ADDR)
>    by the loader.
> 2. There isn't enough room to contain the kernel, starting from the
>    default load address (eg. something else occupied part the region).
> 3. In the memmap provided by EFI firmware, there is a memory region
>    starts below LOAD_PHYSICAL_ADDR, and suitable for containing the
>    kernel.
> 
> Efi stub will perform a kernel relocation when condition 1 is met. But
> due to condition 2, efi stub can't relocate kernel to the preferred
> address, so it fallback to query and alloc from EFI firmware for lowest
> usable memory region.
> 
> It's incorrect to use the lowest memory address. In later stage, kernel
> will assume LOAD_PHYSICAL_ADDR as the minimal acceptable relocate address,
> but efi stub will end up relocating kernel below it.
> 
> Then before the kernel decompressing. Kernel will do another relocation
> to address not lower than LOAD_PHYSICAL_ADDR, this time the relocate will
> over write the blockage at the default load address, which efi stub tried
> to avoid, and lead to unexpected behavior. Beside, the memory region it
> writes to is not allocated from EFI firmware, which is also wrong.
> 
> To fix it, just don't let efi stub relocate the kernel to any address
> lower than lowest acceptable address.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>

Acked-by:  <jarkko.sakkinen@linux.intel.com>

/Jarkko
