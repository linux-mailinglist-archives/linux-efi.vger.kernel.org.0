Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73D431023E5
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2019 13:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfKSMHE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Nov 2019 07:07:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43087 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfKSMHD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Nov 2019 07:07:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id n1so23484649wra.10;
        Tue, 19 Nov 2019 04:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iS9pe3dkEr673iYSaJKKJUNkDW4+uEgv0fqUdbRhkeY=;
        b=PabPFLNnFg+osS4gNu3ve83xkE7uJnUNXpSrSSYdyB+wz75KRN+RYHuREBbIQnguYe
         7McNl8SJlgKrybc85/YwRgc4iU54VnjupxbyrPZSvqhU2N1UwqgPad4GZ49FisE+IXcS
         dkxk6uWwKwLHdOJNJUkVamniu8SPq4uYwijcBi8SUpoN4XkLfkcdFyDbBWF+vRHFTzi0
         ffvAC9a5YNXYE0stOHRlyJ91IzRRqbeuiSypd4TWNO3YzP2jf316TViCT5omueEwu7LK
         XjahRaErn4jd7xpk9dfhwg+rJTjhXuPMhS9eIvKeSpCFSNZiI8XlY7Kq1Mz7K1TBCWVc
         BAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iS9pe3dkEr673iYSaJKKJUNkDW4+uEgv0fqUdbRhkeY=;
        b=Ts0ummNh1aSYv2xXxcK0OHuoEHZ6tzyA0CPtD4iEFcx60O3HVEsiSm4FbUJ0L6zBcJ
         Y09L7TBz2GLrkJp3K3js9BO+16C/X17FrYQcUjaw+AsDPOk3gVdpHdcwgwO42531f8TU
         aCXfXMZC6FJM0sLHCl761k5nYgksSb6J1WThF2MS5o5hOBohivPcUKG/R0WxHcrFQpXw
         Cz+DNVC6rf+Hwu592VSA/ASAhlNvHuJumDEwKiOlZdgsKihzOkldAID/jfN6Qklbsna9
         qtyKorORkpLUo2DfecXuYuiJtC7UZnetaVXQB9hsdC+v48BimZikacXwQdSEyd2GZT42
         BrkA==
X-Gm-Message-State: APjAAAVxxu1MPDZqIf9u1bwdRgC/nYmBKUn70ePcGuJIG72nHyiaw37P
        jvQWpxd02r58wPp5a3/kzO4=
X-Google-Smtp-Source: APXvYqy6/EXJc0eQicn3FQeArcMb/Ms9rjozFz8E96Loyy5wHW/D99fzz5dYrgDIkdPwH0r24aSwqA==
X-Received: by 2002:a5d:6706:: with SMTP id o6mr16067898wru.54.1574165219202;
        Tue, 19 Nov 2019 04:06:59 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id v184sm2965490wme.31.2019.11.19.04.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 04:06:58 -0800 (PST)
Date:   Tue, 19 Nov 2019 13:06:55 +0100
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
Subject: [PATCH] x86/platform/intel/quark: Explicitly include linux/io.h for
 virt_to_phys()
Message-ID: <20191119120655.GA31444@gmail.com>
References: <20191119002121.4107-1-sean.j.christopherson@intel.com>
 <20191119111012.GA109842@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119111012.GA109842@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> I've applied them to tip:WIP.core/headers as a work-in-progress tree, 
> and I'm testing them on randconfigs to make sure there's no broken 
> dependencies. I'll wait for the ACPI acks.

One more fix was needed, for the intel-quark driver that is only built on 
32-bit configs:

==================>
From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 19 Nov 2019 12:51:56 +0100
Subject: [PATCH] x86/platform/intel/quark: Explicitly include linux/io.h for virt_to_phys()

Similarly to the previous patches by Sean Christopherson:

 "Through a labyrinthian sequence of includes, usage of virt_to_phys() is
  dependent on the include of asm/io.h in x86's asm/realmode.h, which is
  included in x86's asm/acpi.h and thus by linux/acpi.h.  Explicitly
  include linux/io.h to break the dependency on realmode.h so that a
  future patch can remove the realmode.h include from acpi.h without
  breaking the build."

Cc: linux-kernel@vger.kernel.org
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/platform/intel-quark/imr.c          | 2 ++
 arch/x86/platform/intel-quark/imr_selftest.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/platform/intel-quark/imr.c b/arch/x86/platform/intel-quark/imr.c
index 6dd25dc5f027..e9d97d52475e 100644
--- a/arch/x86/platform/intel-quark/imr.c
+++ b/arch/x86/platform/intel-quark/imr.c
@@ -29,6 +29,8 @@
 #include <asm/cpu_device_id.h>
 #include <asm/imr.h>
 #include <asm/iosf_mbi.h>
+#include <asm/io.h>
+
 #include <linux/debugfs.h>
 #include <linux/init.h>
 #include <linux/mm.h>
diff --git a/arch/x86/platform/intel-quark/imr_selftest.c b/arch/x86/platform/intel-quark/imr_selftest.c
index 42f879b75f9b..4307830e1b6f 100644
--- a/arch/x86/platform/intel-quark/imr_selftest.c
+++ b/arch/x86/platform/intel-quark/imr_selftest.c
@@ -14,6 +14,8 @@
 #include <asm-generic/sections.h>
 #include <asm/cpu_device_id.h>
 #include <asm/imr.h>
+#include <asm/io.h>
+
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/types.h>

