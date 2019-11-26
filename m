Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14DF7109CDF
	for <lists+linux-efi@lfdr.de>; Tue, 26 Nov 2019 12:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKZLQZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Nov 2019 06:16:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38104 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKZLQY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Nov 2019 06:16:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so22028199wro.5;
        Tue, 26 Nov 2019 03:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mPsIQyZB05XA1geV+/a9mGk6poY26Jzmyx/vRU1WfpY=;
        b=CvVd5h8yRpWWCZspKyZ2Geub44N8W7U4Jhjye1wj0+gjwAtkOVVmcul2n5Td6FtIOl
         TYG086TBeCaeOdVzPpwKhwlLc4pXmhKLeWtbE6m/dAKdho1uQ2gr6EZUmN0OfCnHu7vA
         CkekA1Jm7ugM9uREG/GBYK687qdaWRWRkE+2whjefu8rgH7tRkaaT/cLei9WaenddzQB
         YDNEo0bfRrPSjq0dSg9yxZszaBpoL3x1/rChO+3ehiBgMCnr9nBa16a76NKGQ4BuO449
         +5/bTc4kSISupGE5hditCGRORIPgm4bURLWXT4/8PYFGt4EyUpjU1VnqY7G7PQD752dr
         4Cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mPsIQyZB05XA1geV+/a9mGk6poY26Jzmyx/vRU1WfpY=;
        b=JZ31AVKIzLzaf/WndVNvbu0QnVoNkZQEL6ASaOVoji4KakROAMs2n+xtWjOk9vtnW0
         UpjBnOukcqvhYKXccEOmDqh89qH04T4IdffXwD5Lo/CtD2PxEtrphXJ5T4luLmeXmsK7
         zJ962Tede+pXbS4bY9uw264dSu2lpP7Kc4U9r1QhnQYCVGRx4ud6HmZdfxq8hSUyo+Ax
         oyjHwxKq7RuC8a43lhn7ijKilPO0RPaRe+T6Ff+qzMGdYDIx5ToFPHmr31dwLc/qLHoq
         lJ2Z3otrgkk44+nha6PD2Iez39ueBucyDcSgivyuBUvoss3WLPDB5teyhicaANUirR4N
         5zZQ==
X-Gm-Message-State: APjAAAXXxSAfyYSHx2u8PBj9b23INda3kNbLaHxTbxG+8Ogadccl65ab
        pXGyeajJE0lc4+a46GWUl8c=
X-Google-Smtp-Source: APXvYqxSB1tYKQQzsIwE/RCW4zstGtQNypAFngwnyjSt5EMF0PfBQcHF962Sesm4cfpD/IFXIDsxsQ==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr16155700wrp.292.1574766982078;
        Tue, 26 Nov 2019 03:16:22 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id b14sm2692135wmj.18.2019.11.26.03.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 03:16:21 -0800 (PST)
Date:   Tue, 26 Nov 2019 12:16:18 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Message-ID: <20191126111618.GA28423@gmail.com>
References: <20191119002121.4107-1-sean.j.christopherson@intel.com>
 <20191119002121.4107-12-sean.j.christopherson@intel.com>
 <7338293.UcAxln0NAJ@kreacher>
 <20191125104803.v6goacte2vjakx64@ucw.cz>
 <20191125170034.GB12178@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125170034.GB12178@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> On Mon, Nov 25, 2019 at 11:48:03AM +0100, Pavel Machek wrote:
> > > On Tuesday, November 19, 2019 1:21:20 AM CET Sean Christopherson wrote:
> > > > Convert acpi_wakeup_address from a raw variable into a function so that
> > > > x86 can wrap its dereference of the real mode boot header in a function
> > > > instead of broadcasting it to the world via a #define.  This sets the
> > > > stage for a future patch to move the definition of acpi_wakeup_address()
> > > > out of asm/acpi.h and thus break acpi.h's dependency on asm/realmode.h.
> > > > 
> > > > No functional change intended.
> > > > 
> > > > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > > 
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > > --- a/drivers/acpi/sleep.c
> > > > +++ b/drivers/acpi/sleep.c
> > > > @@ -63,9 +63,9 @@ static int acpi_sleep_prepare(u32 acpi_state)
> > > >  #ifdef CONFIG_ACPI_SLEEP
> > > >  	/* do we have a wakeup address for S2 and S3? */
> > > >  	if (acpi_state == ACPI_STATE_S3) {
> > > > -		if (!acpi_wakeup_address)
> > > > +		if (!acpi_wakeup_address())
> > > >  			return -EFAULT;
> > > > -		acpi_set_waking_vector(acpi_wakeup_address);
> > > > +		acpi_set_waking_vector(acpi_wakeup_address());
> > > >  
> > 
> > You might want to store result in a variable... especially since you are
> > turning inline function into real one in a next patch.
> > 
> > And maybe function should be called get_acip_wakeup_address or
> > something? This way it is easy to mistake actual wakeup address from
> > function that gets it...
> 
> Agreed on both counts.
> 
> 
> Ingo,
> 
> Would you prefer a v2 of the entire series (with Acks and removal of Fixes),
> or a v2 that includes only the last two patches?

Yep, that would be handy. I have them committed to tip:core/headers, but 
haven't sent it to Linus yet, and can redo that all with these 
improvements.

Thanks,

	Ingo
