Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A433A3137
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jun 2021 18:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhFJQrV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Jun 2021 12:47:21 -0400
Received: from foss.arm.com ([217.140.110.172]:36630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230396AbhFJQrU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 10 Jun 2021 12:47:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45919ED1;
        Thu, 10 Jun 2021 09:45:24 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.7.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F4F13F719;
        Thu, 10 Jun 2021 09:45:21 -0700 (PDT)
Date:   Thu, 10 Jun 2021 17:45:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [PATCH v10 3/7] arm64: hyperv: Add Hyper-V
 clocksource/clockevent support
Message-ID: <20210610164519.GB63335@C02TD0UTHF1T.local>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
 <1620841067-46606-4-git-send-email-mikelley@microsoft.com>
 <20210514123711.GB30645@C02TD0UTHF1T.local>
 <MWHPR21MB15932B44EC1E55614B219F5ED7509@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210517130815.GC62656@C02TD0UTHF1T.local>
 <MWHPR21MB15930A4EE785984292B1D72BD72D9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210518170016.GP82842@C02TD0UTHF1T.local>
 <MWHPR21MB1593800A20B55626ACE6A844D7379@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593800A20B55626ACE6A844D7379@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Michael,

[trimming the bulk of the thrread]

On Tue, Jun 08, 2021 at 03:36:06PM +0000, Michael Kelley wrote:
> I've had a couple rounds of discussions with the Hyper-V team.   For
> the clocksource we've agreed to table the live migration discussion, and
> I'll resubmit the code so that arm_arch_timer.c provides the
> standard arch_sys_counter clocksource.  As noted previously, this just
> works for a Hyper-V guest.  The live migration discussion may come
> back later after a deeper investigation by Hyper-V.

Great; thanks for this!

> For clockevents, there's not a near term fix.  It's more than just plumbing
> an interrupt for Hyper-V to virtualize the ARM64 arch timer in a guest VM.
> From their perspective there's also benefit in having a timer abstraction
> that's independent of the architecture, and in the Linux guest, the STIMER
> code is common across x86/x64 and ARM64.  It follows the standard Linux
> clockevents model, as it should. The code is already in use in out-of-tree
> builds in the Linux VMs included in Windows 10 on ARM64 as part of the
> so-called "Windows Subsystem for Linux".
> 
> So I'm hoping we can get this core support for ARM64 guests on Hyper-V
> into upstream using the existing STIMER support.  At some point, Hyper-V
> will do the virtualization of the ARM64 arch timer, but we don't want to
> have to stay out-of-tree until after that happens.

My main concern here is making sure that we can rely on architected
properties, and don't have to special-case architected bits for hyperv
(or any other hypervisor), since that inevitably causes longer-term
pain.

While in abstract I'm not as worried about using the timer
clock_event_device specifically, that same driver provides the
clocksource and the event stream, and I want those to work as usual,
without being tied into the hyperv code. IIUC that will require some
work, since the driver won't register if the GTDT is missing timer
interrupts (or if there is no GTDT).

I think it really depends on what that looks like.

Thanks,
Mark.
