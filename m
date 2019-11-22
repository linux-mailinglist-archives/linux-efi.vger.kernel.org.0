Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8707C105E85
	for <lists+linux-efi@lfdr.de>; Fri, 22 Nov 2019 03:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKVCM1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Nov 2019 21:12:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfKVCM1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 21 Nov 2019 21:12:27 -0500
Received: from oasis.local.home (unknown [66.170.99.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD8F20692;
        Fri, 22 Nov 2019 02:12:25 +0000 (UTC)
Date:   Thu, 21 Nov 2019 21:12:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
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
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
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
Subject: Re: [PATCH 04/12] x86/kprobes: Explicitly include vmalloc.h for
 set_vm_flush_reset_perms()
Message-ID: <20191121211224.15f006b4@oasis.local.home>
In-Reply-To: <20191119002121.4107-5-sean.j.christopherson@intel.com>
References: <20191119002121.4107-1-sean.j.christopherson@intel.com>
        <20191119002121.4107-5-sean.j.christopherson@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 18 Nov 2019 16:21:13 -0800
Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> The inclusion of linux/vmalloc.h, which is required for its definition
> of set_vm_flush_reset_perms(), is somehow dependent on asm/realmode.h
> being included by asm/acpi.h.  Explicitly include linux/vmalloc.h so
> that a future patch can drop the realmode.h include from asm/acpi.h
> without breaking the build.
> 
> Fixes: 241a1f2238064 ("x86/kprobes: Use vmalloc special flag")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  arch/x86/kernel/kprobes/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 4f13af7cbcdb..a0c223ab7264 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -40,6 +40,7 @@
>  #include <linux/frame.h>
>  #include <linux/kasan.h>
>  #include <linux/moduleloader.h>
> +#include <linux/vmalloc.h>
>  
>  #include <asm/text-patching.h>
>  #include <asm/cacheflush.h>

