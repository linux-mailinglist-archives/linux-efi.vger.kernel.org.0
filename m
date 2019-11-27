Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBF810B19C
	for <lists+linux-efi@lfdr.de>; Wed, 27 Nov 2019 15:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfK0OrF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Nov 2019 09:47:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:18703 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfK0OrF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 27 Nov 2019 09:47:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 06:47:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,249,1571727600"; 
   d="scan'208";a="203094641"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2019 06:47:03 -0800
Date:   Wed, 27 Nov 2019 06:47:03 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 00/12] treewide: break dependencies on x86's RM header
Message-ID: <20191127144703.GA18530@linux.intel.com>
References: <20191126165417.22423-1-sean.j.christopherson@intel.com>
 <20191127072057.GB94748@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127072057.GB94748@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 27, 2019 at 08:20:57AM +0100, Ingo Molnar wrote:
> 
> * Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> 
> > x86's asm/realmode.h, which defines low level structures, variables and
> > helpers used to bring up APs during SMP boot, ends up getting included in
> > practically every nook and cranny of the kernel because the address used
> > by ACPI for resuming from S3 also happens to be stored in the real mode
> > header, and ACPI bleeds the dependency into its widely included headers.
> > 
> > As a result, modifying realmode.h for even the most trivial change to the
> > boot code triggers a full kernel rebuild, which is frustrating to say the
> > least as it some of the most difficult code to get exactly right *and* is
> > also some of the most functionally isolated code in the kernel.
> > 
> > To break the kernel's widespread dependency on realmode.h, add a wrapper
> > in the aforementioned ACPI S3 code to access the real mode header instead
> > of derefencing the header directly in asm/acpi.h and thereby exposing it
> > to the world via linux/acpi.h.
> > 
> > v2:
> >   - Rebased on tip/x86/cleanups, commit b74374fef924 ("x86/setup: Enhance
> >     the comments").
> >   - Use acpi_get_wakeup_address() as new function name. [Boris and Pavel]
> >   - Capture acpi_get_wakeup_address() in a local address. [Pavel]
> >   - Collect acks.  I didn't add Rafael's acks on patches 11 and 12 due to
> >     the above changes.
> >   - Explicitly call out the removal of <asm/realmode.h> from <asm/acpi.h>
> >     in patch 12. [Ingo]
> >   - Remove superfluous Fixes: tags. [Ard]
> 
> You didn't include every patch from v1 though, such us my fix to Quark:
> 
>   [PATCH] x86/platform/intel/quark: Explicitly include linux/io.h for virt_to_phys()
> 
> I've applied that one too and your updated patches, and it's now all 
> pushed out into tip:WIP.core/headers.

Sorry, it wasn't clear to me whether or not to include that one.  Next
time I'll ask.
