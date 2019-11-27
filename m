Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8960510AAFD
	for <lists+linux-efi@lfdr.de>; Wed, 27 Nov 2019 08:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfK0HVE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Nov 2019 02:21:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56139 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfK0HVE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Nov 2019 02:21:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id a131so1567216wme.5;
        Tue, 26 Nov 2019 23:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kCncgZfNLfu/DMj0wXER7XvmqE7+H8NXbrnKF+xxq0U=;
        b=RSC3imGkI2eVKkgg38Jlm1TsR+Yjp09v6ffKoandFuxhXe+nBgW9uOHL+l020Y7rdF
         tSYsjMmQCs6HaS/TUMfPNAarUe2TJ0CqybUceItnNLhGo9az8T3Y5fNOH3GLZnX3jWQm
         jisTx/sLc7NDTLdHJbfTfFjGwYGuuKVV4/d96w5zdcKRtmsI6jd1GM9EA/jQgTY8Vu4z
         83O39LSKtgLiosa1NNh8Vo9Cv1oYVXNALrsUmYDlpqUlQKgLeOzmXyrSO9N3UJef1UAD
         dUG5ZLwAMqKaIBiXpIpT8vxX4HmooGbATxlPXMKIaxtINEPsboG+CsqGwvTnCJnfU8tC
         a9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kCncgZfNLfu/DMj0wXER7XvmqE7+H8NXbrnKF+xxq0U=;
        b=aEGDG5mmXMLRGDRcVRsffO/4UtSqO1bkmRzqczOe8OkeYGyXe8jrOuNCzuNGr7A3Rz
         MmTKtqXE2tAqK+pWgrltl6Oi7qp/HH/OKkyhg+roCIgtaIRdlu9xJnwbvPJ/VsTLxJ+L
         WgJ429DjqQj3hcDJ+RuiR2zqAYho0lbfxcEIYI0JgM/Gxwl5gg3jIE3L90D0FDgicP/j
         jkX6VT8Sp0qsQ8j6iu9twhQMn8I+g6cFSNLbAMBMausB1Hj2Aw3QB31h6onrqFOc8Y2O
         CmRaGeYSkSv2zWPQSaH5AgPqOSFC4zIrc1sEXD4cSh/QuDJTpyMHFqDxRsqWfUFnT/HS
         5tGg==
X-Gm-Message-State: APjAAAVYHnihbxknaVIdujTUljq8TUMZugws2HLG1lQ3htEoMFCkOPSk
        xg/UccLFR1zk/a/O0z847C5MyIjJ
X-Google-Smtp-Source: APXvYqxrSAjRPVtPzeiTNsYJZTIC0WUoeM08Y93jY7ZHuWeAPoH8sbaPbhCv3NuqgLVIdvVnq6xVHw==
X-Received: by 2002:a1c:5415:: with SMTP id i21mr2803843wmb.120.1574839261678;
        Tue, 26 Nov 2019 23:21:01 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h2sm18649610wrt.45.2019.11.26.23.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 23:21:00 -0800 (PST)
Date:   Wed, 27 Nov 2019 08:20:57 +0100
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
Message-ID: <20191127072057.GB94748@gmail.com>
References: <20191126165417.22423-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126165417.22423-1-sean.j.christopherson@intel.com>
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
> v2:
>   - Rebased on tip/x86/cleanups, commit b74374fef924 ("x86/setup: Enhance
>     the comments").
>   - Use acpi_get_wakeup_address() as new function name. [Boris and Pavel]
>   - Capture acpi_get_wakeup_address() in a local address. [Pavel]
>   - Collect acks.  I didn't add Rafael's acks on patches 11 and 12 due to
>     the above changes.
>   - Explicitly call out the removal of <asm/realmode.h> from <asm/acpi.h>
>     in patch 12. [Ingo]
>   - Remove superfluous Fixes: tags. [Ard]

You didn't include every patch from v1 though, such us my fix to Quark:

  [PATCH] x86/platform/intel/quark: Explicitly include linux/io.h for virt_to_phys()

I've applied that one too and your updated patches, and it's now all 
pushed out into tip:WIP.core/headers.

Thanks,

	Ingo
