Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D992A109CF7
	for <lists+linux-efi@lfdr.de>; Tue, 26 Nov 2019 12:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfKZLZH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Nov 2019 06:25:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37655 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfKZLZH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Nov 2019 06:25:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id g7so1305834wrw.4;
        Tue, 26 Nov 2019 03:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m/i5xPJ0FKQ+YENCg/aVtw4x62F/uvwBKEc2M7XaGDI=;
        b=TJdKxImt6sjLXcxQGqTWRVcr08BKg+fZjVhuWqgz0JsfocOLavkvGojfsZaOgcoEra
         BT6eA6LqiifU1yojTo0EDAd4tqi+ws+g9sASEE2Gkpe791qoUFGbDuhB5sLVh5qJhOnx
         VDMwrEiSdmE1Bjz1DHEDVdn0RNcSxHepnoPYu9p7lAgC6YNf/4XGsr39KuhhpoI9nfgK
         gpN3vyng/NtbJ/vcGopYeeKv6AAXOvjqbworBHtuqcCKoljYYdkFscjdzEnuj6VnmKUy
         yExQxZVN4/c0u7gnTDlKiwjFFNuMVGwnLvRdiuIscblw1wfhqR2LmbpPkUevhKEjdCZn
         xSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=m/i5xPJ0FKQ+YENCg/aVtw4x62F/uvwBKEc2M7XaGDI=;
        b=DD8fSEFbI30OuXxXSSClfjf77YDBt3uhc2Iq96ZSExJkAvuMaPSdc3qm+9TRP/szCA
         3N+C0FsSsU7nFaSm/SbpVmsZPFbdR38+KRPqsRzdGJacnkgdi08pUMTlwnbXCzS0m/uQ
         I+NwmYC6tmUER13IYLuCJM0AMFIhlIQfbuEwKxeBrxm5RVsLG41OgccFT4viG41VgE5Y
         qof6Gbrc3Axkktx0NIdCK92DcUcB84osukhyQKWgIrlYXPugsNFZzQI/KxTw/XB6Tgq0
         74W4qaNsQiEz0xGl/WnFsKSsFXbPgkRbQoJHSfzFZpRHjF0W/KuI5/YNRrUv89UigAby
         4+8w==
X-Gm-Message-State: APjAAAVSXJHZbboxJ///NQpC7ggeVGNvOcQxAGvGzAMgAdndE7YTxt10
        XZPT4u97DGfYpYPIwVALhHuHGq4O
X-Google-Smtp-Source: APXvYqyK3PbiVAg9Qj+mFkNQk3riegujZ5/UjYWliJ5HX71s975YJFoSxYX0SOw0LD1PTy5+Ajq/CA==
X-Received: by 2002:adf:a31a:: with SMTP id c26mr35562373wrb.330.1574767504340;
        Tue, 26 Nov 2019 03:25:04 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 5sm2606084wmk.48.2019.11.26.03.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 03:25:03 -0800 (PST)
Date:   Tue, 26 Nov 2019 12:25:00 +0100
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
Message-ID: <20191126112500.GA36931@gmail.com>
References: <20191119002121.4107-1-sean.j.christopherson@intel.com>
 <20191119002121.4107-12-sean.j.christopherson@intel.com>
 <7338293.UcAxln0NAJ@kreacher>
 <20191125104803.v6goacte2vjakx64@ucw.cz>
 <20191125170034.GB12178@linux.intel.com>
 <20191126111618.GA28423@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126111618.GA28423@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > Would you prefer a v2 of the entire series (with Acks and removal of 
> > Fixes), or a v2 that includes only the last two patches?
> 
> Yep, that would be handy. I have them committed to tip:core/headers, 
> but haven't sent it to Linus yet, and can redo that all with these 
> improvements.

Now these bits are back in tip:WIP.core/headers, waiting for the v2 
submission.

Thanks,

	Ingo
