Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEF5108C47
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2019 11:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfKYKsG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Nov 2019 05:48:06 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:52386 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfKYKsF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Nov 2019 05:48:05 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 141771C1FD1; Mon, 25 Nov 2019 11:48:03 +0100 (CET)
Date:   Mon, 25 Nov 2019 11:48:03 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Len Brown <len.brown@intel.com>,
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
Subject: Re: [PATCH 11/12] ACPI/sleep: Convert acpi_wakeup_address into a
 function
Message-ID: <20191125104803.v6goacte2vjakx64@ucw.cz>
References: <20191119002121.4107-1-sean.j.christopherson@intel.com>
 <20191119002121.4107-12-sean.j.christopherson@intel.com>
 <7338293.UcAxln0NAJ@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7338293.UcAxln0NAJ@kreacher>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> On Tuesday, November 19, 2019 1:21:20 AM CET Sean Christopherson wrote:
> > Convert acpi_wakeup_address from a raw variable into a function so that
> > x86 can wrap its dereference of the real mode boot header in a function
> > instead of broadcasting it to the world via a #define.  This sets the
> > stage for a future patch to move the definition of acpi_wakeup_address()
> > out of asm/acpi.h and thus break acpi.h's dependency on asm/realmode.h.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> > --- a/drivers/acpi/sleep.c
> > +++ b/drivers/acpi/sleep.c
> > @@ -63,9 +63,9 @@ static int acpi_sleep_prepare(u32 acpi_state)
> >  #ifdef CONFIG_ACPI_SLEEP
> >  	/* do we have a wakeup address for S2 and S3? */
> >  	if (acpi_state == ACPI_STATE_S3) {
> > -		if (!acpi_wakeup_address)
> > +		if (!acpi_wakeup_address())
> >  			return -EFAULT;
> > -		acpi_set_waking_vector(acpi_wakeup_address);
> > +		acpi_set_waking_vector(acpi_wakeup_address());
> >  

You might want to store result in a variable... especially since you are
turning inline function into real one in a next patch.

And maybe function should be called get_acip_wakeup_address or
something? This way it is easy to mistake actual wakeup address from
function that gets it...

Best regards,
									Pavel
> 
> 
