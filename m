Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C18210381A
	for <lists+linux-efi@lfdr.de>; Wed, 20 Nov 2019 11:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfKTK7b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Nov 2019 05:59:31 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47022 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfKTK7b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Nov 2019 05:59:31 -0500
Received: from 79.184.253.244.ipv4.supernova.orange.pl (79.184.253.244) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id b6654c7cffd32f8a; Wed, 20 Nov 2019 11:59:28 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Nadav Amit <namit@vmware.com>,
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
Subject: Re: [PATCH 10/12] x86/ACPI/sleep: Remove an unnecessary include of asm/realmode.h
Date:   Wed, 20 Nov 2019 11:59:27 +0100
Message-ID: <3809579.i0RzbxhyKc@kreacher>
In-Reply-To: <20191119002121.4107-11-sean.j.christopherson@intel.com>
References: <20191119002121.4107-1-sean.j.christopherson@intel.com> <20191119002121.4107-11-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tuesday, November 19, 2019 1:21:19 AM CET Sean Christopherson wrote:
> None of the declarations in x86's acpi/sleep.h are in any way dependent
> on the real mode boot code.  Remove sleep.h's include of asm/realmode.h
> to limit the dependencies on realmode.h to code that actually interacts
> with the boot code.
> 
> Fixes: c9b77ccb52a5c ("x86, realmode: Move ACPI wakeup to unified realmode code")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/acpi/sleep.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/acpi/sleep.h b/arch/x86/kernel/acpi/sleep.h
> index fbb60ca4255c..d06c2079b6c1 100644
> --- a/arch/x86/kernel/acpi/sleep.h
> +++ b/arch/x86/kernel/acpi/sleep.h
> @@ -3,7 +3,7 @@
>   *	Variables and functions used by the code in sleep.c
>   */
>  
> -#include <asm/realmode.h>
> +#include <linux/linkage.h>
>  
>  extern unsigned long saved_video_mode;
>  extern long saved_magic;
> 




