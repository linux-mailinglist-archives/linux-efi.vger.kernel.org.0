Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36A6610B459
	for <lists+linux-efi@lfdr.de>; Wed, 27 Nov 2019 18:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfK0RZf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Nov 2019 12:25:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35013 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfK0RZf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Nov 2019 12:25:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id n5so8497877wmc.0;
        Wed, 27 Nov 2019 09:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GIWTen+5j6jzQO7o6tpc6/Z9sJf3yIWCCW0dpewfY9w=;
        b=RlV38rohZsHWP6W2uu20DWA/s1IhZ2IC/SYB4xs7hy9qevDfnWn/I0nKHjnjaUv8kv
         qR5MSZfR2nZs6CI8hdoweycKsJ6lFJCSxY5T3ZtSxiH8ajmRQWw6ZrKS7tBrtZs1RsuO
         oDfO6GINiNf7+J6qhHu+P79MwTiu/duNRgLG7LUpuvEGb30gESPBtzmfn1wYzkg6IqDW
         rrI/BuhMwZeZ/AimV5lPWII/FJ0x7ftyFV0GwlrHqoJnb6AeAfBPRT3DsNQ6vofG88vp
         HGizPYbvoD6TBzOU0YmAW4VjQHyO7Ibte43yjLebSO+Pru4z3lsiOoaMy3J+unILV/c4
         mzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GIWTen+5j6jzQO7o6tpc6/Z9sJf3yIWCCW0dpewfY9w=;
        b=HUzBMnyViYjozRosJkzllVam8vsBmBOqFs6SV7JRI++dCUQKmSGS3Pkb2anq6Meqo1
         scPgBEt8tMLmTE/RsvnpFycSKNl38NqudfzRMYdn/doyugSzYFfObBYLbDW4Bnt82f/v
         Mbkaiahb14VYbVvTRMOfahYRfKWinmSwjnwfda0GN93alNAo9eqWLlLFM/e9HCI0CWv8
         1NCvcN8hGEBDNptTEUyZnu4peDHmMJsado1tPKMR5qaM5KbXrtJ6X7y9c1Zeh6j7oCg5
         PoJ6prZUmHWv2GlGzjNXzxM+/42z4qW1bwQEJnQXgzaATtPL3Cxo2G6m9gKDZtV1m3pA
         P99Q==
X-Gm-Message-State: APjAAAXSIZNcP4xXQXYJXPurGcZUFdc7nNoF1sPV8Rqm1MTtS2y5RwAk
        4Qndtc9KIW4PPXnZsbFJJiE=
X-Google-Smtp-Source: APXvYqxFiW/Mp2X1vB+r+J0HbWgWDFGtW9f4Sr2KuXrzxMISLMbu42rPGv6iTdCJnEauHcYx2r0kjw==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr5860604wml.115.1574875532538;
        Wed, 27 Nov 2019 09:25:32 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 76sm7691881wma.0.2019.11.27.09.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:25:31 -0800 (PST)
Date:   Wed, 27 Nov 2019 18:25:28 +0100
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
Message-ID: <20191127172528.GB10957@gmail.com>
References: <20191126165417.22423-1-sean.j.christopherson@intel.com>
 <20191127072057.GB94748@gmail.com>
 <20191127144703.GA18530@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127144703.GA18530@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> > You didn't include every patch from v1 though, such us my fix to 
> > Quark:
> > 
> >   [PATCH] x86/platform/intel/quark: Explicitly include linux/io.h for virt_to_phys()
> > 
> > I've applied that one too and your updated patches, and it's now all 
> > pushed out into tip:WIP.core/headers.
> 
> Sorry, it wasn't clear to me whether or not to include that one.  Next 
> time I'll ask.

No problem - in general it's best to include all, because in general it's 
much easier for maintainers to leave out something than to remember to 
add it back in. ;-)

Thanks,

	Ingo
