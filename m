Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 450C11022A6
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2019 12:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKSLKV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Nov 2019 06:10:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39805 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfKSLKU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Nov 2019 06:10:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id t26so3051969wmi.4;
        Tue, 19 Nov 2019 03:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NYWeXLuQGLvOPwK8pHNuzurveHjA/E4XL3deYT2CQ6Q=;
        b=skdJ1UEHu5PJl89Mkk9VRRqLagIUdwLLzIvfE7qxc79DduSNiquwoFXzoJXVUbZ9zw
         g1cNgucakgJrNBfc9PtJPQUQH7hiPIbQNdvm4HfPAxaPqEE5yDoU/Fm0WZrr770x6z9Z
         1mV4N6EIFIO+H5heFTgopWe3ElCwZHNDP6TrB6ZxXDF+BVJoJCgzBj9WZ81yUaCLfyGK
         QBfOV9xXA4+nU1SmqoIng5FZDcMYQif9wRQNWBuakBreDAgwkdsGdC6lPo7bjUeRutEb
         FqwSvcrmf/LrgaSpoIWvYSkunbCfPVklaj+EQbJw7jUcxpmgoRV0aJoU4yUuzBudNnyu
         7iYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NYWeXLuQGLvOPwK8pHNuzurveHjA/E4XL3deYT2CQ6Q=;
        b=hZmXTyiyx7aVpTe+a8ydQ0G4XT+90owkQ5cxH1ixfdTTwdvTgb0r4PkMJeqhvjlpV5
         vZWknw9yZOszz1sQUHUC/AzaE74Vwxy9ZhC1/zSmm2vinDq19hphlDcM4QQCshQe6CU+
         HJXBERLE6vh7N0to9kNRNm/mr1mYY47a0dJ+LE2uwVZCltntBE2ZVUjDA55HdUVxlONc
         JnKUEqVZUxEZ5DsRLjLe5yLoSHBIh8umj3Rgk58xywo86ikHpsoBkyQza/nD/LFsYnZH
         k/YAIO/ro2U8w205N0idlkMnzyDb5qGSlou/o67wPxA1ItWynr5d6ProFXaSuYhB4WiW
         nwSw==
X-Gm-Message-State: APjAAAURyIdLbu0gCAqW4G/EW90ZQ3Rrmta4rIEKzEu/L9lVmkJfbXdL
        aQYaC6TW1B09T3/3NR/mxoA=
X-Google-Smtp-Source: APXvYqxkMDs2asP+vgJXKZTaN6ik3+6S/o6ZGiHDU8XukZ5zzOg6DqoFabjwqzDackICD1Kv7aubiw==
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr4628412wmj.106.1574161816817;
        Tue, 19 Nov 2019 03:10:16 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id z4sm2754237wmf.36.2019.11.19.03.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 03:10:15 -0800 (PST)
Date:   Tue, 19 Nov 2019 12:10:12 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
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
Subject: Re: [PATCH 00/12] treewide: break dependencies on x86's RM header
Message-ID: <20191119111012.GA109842@gmail.com>
References: <20191119002121.4107-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119002121.4107-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> x86's asm/realmode.h, which defines low level structures, variables and
> helpers used to bring up APs during SMP boot, ends up getting included in
> practically every nook and cranny of the kernel because the address used
> by ACPI for resuming from S3 also happens to be stored in the real mode
> header, and ACPI bleeds the dependency into its widely included headers.
> 
> As a result, modifying realmode.h for even the most trivial change to the
> boot code triggers a full kernel rebuild, which is frustrating to say the
> least as it some of the most difficult code to get exactly right *and* is
> also some of the most functionally isolated code in the kernel.
> 
> To break the kernel's widespread dependency on realmode.h, add a wrapper
> in the aforementioned ACPI S3 code to access the real mode header instead
> of derefencing the header directly in asm/acpi.h and thereby exposing it
> to the world via linux/acpi.h.
> 
> Build tested on x86 with allyesconfig and allmodconfig, so hopefully there
> aren't more build issues lurking, but at this point it wouldn't surprise
> me in the least if this somehow manages to break the build.
> 
> Based on tip/master, commit ceceaf1f12ba ("Merge branch 'WIP.x86/cleanups'").
> 
> Patch Synopsis:
>   - Patches 01-09 fix a variety of build errors that arise when patch 12
>     drops realmode.h from asm/acpi.h.  Most of the errors are quite absurb
>     as they have no relation whatsoever to x86's RM boot code, but occur
>     because realmode.h happens to include asm/io.h.

Yeah, these kind of parasitic header dependencies are the main driving 
force behind kernel header spaghetti hell: it's super easy to add a new 
header, but very hard to remove them...

Hence they practically only accumulate.

As a result header removal patches get priority, from me at least. :-)

>   - Patch 10 removes a spurious include of realmode.h from an ACPI header.
> 
>   - Patches 11 and 12 implement the wrapper and move it out of acpi.h.

So if the ACPI maintainers are fine with -tip carrying patches #11 and #12
then I'd be glad to route these patches upstream.

I've applied them to tip:WIP.core/headers as a work-in-progress tree, and 
I'm testing them on randconfigs to make sure there's no broken 
dependencies. I'll wait for the ACPI acks.

I edited the title of patch 12 slightly, to:

   c8bceb321209: x86/ACPI/sleep: Move acpi_wakeup_address() definition into sleep.c, remove <asm/realmode.h> from <asm/acpi.h>

to make sure the big header dependency change is obvious at first sight.

Thanks,

	Ingo
