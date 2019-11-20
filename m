Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6232110380F
	for <lists+linux-efi@lfdr.de>; Wed, 20 Nov 2019 11:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfKTK6g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Nov 2019 05:58:36 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49359 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbfKTK6f (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Nov 2019 05:58:35 -0500
Received: from 79.184.253.244.ipv4.supernova.orange.pl (79.184.253.244) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 469c83978beedbff; Wed, 20 Nov 2019 11:58:32 +0100
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
Subject: Re: [PATCH 11/12] ACPI/sleep: Convert acpi_wakeup_address into a function
Date:   Wed, 20 Nov 2019 11:58:31 +0100
Message-ID: <7338293.UcAxln0NAJ@kreacher>
In-Reply-To: <20191119002121.4107-12-sean.j.christopherson@intel.com>
References: <20191119002121.4107-1-sean.j.christopherson@intel.com> <20191119002121.4107-12-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tuesday, November 19, 2019 1:21:20 AM CET Sean Christopherson wrote:
> Convert acpi_wakeup_address from a raw variable into a function so that
> x86 can wrap its dereference of the real mode boot header in a function
> instead of broadcasting it to the world via a #define.  This sets the
> stage for a future patch to move the definition of acpi_wakeup_address()
> out of asm/acpi.h and thus break acpi.h's dependency on asm/realmode.h.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/ia64/include/asm/acpi.h | 5 ++++-
>  arch/ia64/kernel/acpi.c      | 2 --
>  arch/x86/include/asm/acpi.h  | 5 ++++-
>  drivers/acpi/sleep.c         | 4 ++--
>  4 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
> index f886d4dc9d55..36d7003eee71 100644
> --- a/arch/ia64/include/asm/acpi.h
> +++ b/arch/ia64/include/asm/acpi.h
> @@ -38,7 +38,10 @@ int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
>  /* Low-level suspend routine. */
>  extern int acpi_suspend_lowlevel(void);
>  
> -extern unsigned long acpi_wakeup_address;
> +static inline unsigned long acpi_wakeup_address(void)
> +{
> +	return 0;
> +}
>  
>  /*
>   * Record the cpei override flag and current logical cpu. This is
> diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
> index 70d1587ddcd4..a5636524af76 100644
> --- a/arch/ia64/kernel/acpi.c
> +++ b/arch/ia64/kernel/acpi.c
> @@ -42,8 +42,6 @@ int acpi_lapic;
>  unsigned int acpi_cpei_override;
>  unsigned int acpi_cpei_phys_cpuid;
>  
> -unsigned long acpi_wakeup_address = 0;
> -
>  #define ACPI_MAX_PLATFORM_INTERRUPTS	256
>  
>  /* Array to record platform interrupt vectors for generic interrupt routing. */
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index bc9693c9107e..57788ec6fa82 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -62,7 +62,10 @@ static inline void acpi_disable_pci(void)
>  extern int (*acpi_suspend_lowlevel)(void);
>  
>  /* Physical address to resume after wakeup */
> -#define acpi_wakeup_address ((unsigned long)(real_mode_header->wakeup_start))
> +static inline unsigned long acpi_wakeup_address(void)
> +{
> +	return ((unsigned long)(real_mode_header->wakeup_start));
> +}
>  
>  /*
>   * Check if the CPU can handle C2 and deeper
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 2af937a8b1c5..9e66c4109556 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -63,9 +63,9 @@ static int acpi_sleep_prepare(u32 acpi_state)
>  #ifdef CONFIG_ACPI_SLEEP
>  	/* do we have a wakeup address for S2 and S3? */
>  	if (acpi_state == ACPI_STATE_S3) {
> -		if (!acpi_wakeup_address)
> +		if (!acpi_wakeup_address())
>  			return -EFAULT;
> -		acpi_set_waking_vector(acpi_wakeup_address);
> +		acpi_set_waking_vector(acpi_wakeup_address());
>  
>  	}
>  	ACPI_FLUSH_CPU_CACHE();
> 




