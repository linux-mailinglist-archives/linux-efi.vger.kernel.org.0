Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBEB7D83A0
	for <lists+linux-efi@lfdr.de>; Thu, 26 Oct 2023 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjJZNcn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Oct 2023 09:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjJZNcm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 Oct 2023 09:32:42 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E1EAB;
        Thu, 26 Oct 2023 06:32:40 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DC34B40E01A3;
        Thu, 26 Oct 2023 13:32:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c6-HFodZqlYJ; Thu, 26 Oct 2023 13:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698327155; bh=IJ1V12YW64qC6BC7ZhZrpC5tlmChNK1ADdplDg6cN1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlM4dY7kejY+5ZPpNqUXaknSK9h3QGnUbWAWftm4h2R6kml3tNrQsAM50HfvkVkAH
         JJDxckvoURo8eWdEMsw+6wH9X/ElJs+2mPj4SvaRkXA9LzvkiFwPOY3SRwEpYeY9QN
         vIokrVV6jPGeJVc44SqK8FLpCHXK4hBUzNf4CmKDff/EZLjsIaAxdOuhDsFUkD0GpO
         OS+dGWFWb571Bcgn8Y7xhNSqzqvaAWV+Y65CKVGTFRy3aKTwRLw6OQi345ovl219pZ
         jm+6K0OJ7G1LSVg2WBzI1G5HxRU8IRXVmUU0V/EgfkqKU7tVAfPMbkaa2SGOqaF8Jw
         foLokjuwiVQPaRBHWStqjg9y2QdrRmaJkXk/71tM1eH+DepiC/PO3kdzlvEXEBcKrN
         6eO5EAecViH4eM1HwZA9d1iWrdwBALWu/JioLEGn7CgEoqdHoP3IKGUaj8UgH7amlB
         EKAVcpE3u1DETWOpRlRsEusXrtHp58s+6qXB2Ylux3cPz7ePRYzhXtk9qt0F71Rh5T
         CA+ZWk8DdfBhc73MHZMrgwWEQKwiCWiuwERz5HeYDSgta8cJYSQlWCA+IaRpOErkQv
         S/LxWakrGtaQaCNJh+PXbk1w3wLcU+91tcF5cV3nD/BOf1o0iIq/zRm0k2F3IVotkD
         WcmkBrAOJtZpQRxQT7eGCQBE=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D3FC40E0173;
        Thu, 26 Oct 2023 13:32:14 +0000 (UTC)
Date:   Thu, 26 Oct 2023 15:32:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        robert.moore@intel.com, linux-hardening@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        baolin.wang@linux.alibaba.com
Subject: Re: [RFC PATCH v2 0/9] Use ERST for persistent storage of MCE and
 APEI errors
Message-ID: <20231026133209.GCZTpqWVNUmqtBrnTw@fat_crate.local>
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
 <20230928144345.GAZRWRIXH1Tfgn5EpO@fat_crate.local>
 <f654be8f-aa98-1bed-117b-ebdf96d23df1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f654be8f-aa98-1bed-117b-ebdf96d23df1@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Oct 07, 2023 at 03:15:45PM +0800, Shuai Xue wrote:
> So, IMHO, it's better to add a way to retrieve MCE records through switching
> to the new generation rasdaemon solution.

rasdaemon already collects errors and even saves them in a database of
sorts. No kernel changes needed.

> Sorry for the poor cover letter. I hope the following response can clarify
> the matter.
> 
> Q1: What is the exact problem?
> 
> Traditionally, fatal hardware errors will cause Linux print error log to
> console, e.g. print_mce() or __ghes_print_estatus(), then reboot. With
> Linux, the primary method for obtaining debugging information of a serious
> error or fault is via the kdump mechanism.

Not necessarily - see above.

> In the public cloud scenario, multiple virtual machines run on a
> single physical server, and if that server experiences a failure, it can
> potentially impact multiple tenants. It is crucial for us to thoroughly
> analyze the root causes of each instance failure in order to:
> 
> - Provide customers with a detailed explanation of the outage to reassure them.
> - Collect the characteristics of the failures, such as ECC syndrome, to enable fault prediction.
> - Explore potential solutions to prevent widespread outages.

Huh, are you talking about providing customers with error information
from the *underlying* physical machine which runs the cloud VMs? That
sounds suspicious, to say the least.

AFAICT, all you can tell the VM owner is: yah, the hw had an
uncorrectable error in its memory and crashed. Is that the use case?

To be able to tell the VM owners why it crashed?

> In short, it is necessary to serialize hardware error information available
> for post-mortem debugging.
> 
> Q2: What exactly I wanna do:
> 
> The MCE handler, do_machine_check(), saves the MCE record to persistent
> storage and it is retrieved by mcelog. Mcelog has been deprecated when
> kernel 4.12 released in 2017, and the help of the configuration option
> CONFIG_X86_MCELOG_LEGACY suggest to consider switching to the new
> generation rasdaemon solution. The GHES handler does not support APEI error
> record now.

I think you're confusing things: MCEs do get reported to userspace
through the trace_mc_record tracepoint and rasdaemon opens it and reads
error info from there. And then writes it out to its db. So that works
now.

GHES is something different: it is a fw glue around error reporting so
that you don't have to develop a reporting driver for every platform but
you can use a single one - only the fw glue needs to be added.

The problem with GHES is that it is notoriously buggy and currently
it loads on a single platform only on x86.

ARM are doing something in that area - you're better off talking to
James Morse about it. And he's on Cc.

> To serialize hardware error information available for post-mortem
> debugging:
> - add support to save APEI error record into flash via ERST before go panic,
> - add support to retrieve MCE or APEI error record from the flash and emit
> the related tracepoint after system boot successful again so that rasdaemon
> can collect them

Now that is yet another thing: you want to save error records into
firmware. First of all, you don't really need it if you do kdump as
explained above.

Then, that thing has its own troubles: it is buggy like every firmware
is and it can brick the machine.

I'm not saying it is not useful - there are some use cases for it which
are being worked on but if all you wanna do is dump MCEs to rasdaemon,
that works even now.

But then you have an ARM patch there and I'm confused because MCEs are
x86 thing - ARM has different stuff.

So I think you need to elaborate more here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
