Return-Path: <linux-efi+bounces-2210-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351999D921A
	for <lists+linux-efi@lfdr.de>; Tue, 26 Nov 2024 08:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C263616644F
	for <lists+linux-efi@lfdr.de>; Tue, 26 Nov 2024 07:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B61A190072;
	Tue, 26 Nov 2024 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="q2t3mhkT"
X-Original-To: linux-efi@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A417BB6;
	Tue, 26 Nov 2024 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732604702; cv=none; b=oJn03Dj3a9W1XJXioIZJXsRTOvNIjWFaJ9O+qr5im1xIGHpfJCToeNXjtR/C8dyoLJ2w2hSuhsVnOVIgaYi2/jvcLTMpADbmGfLOH0rwtG8S8/LSZflnpJltPYxy5p6W++Pdem5bS9pVPWDZMMqoeiIGhQ/igssThwIQaeN/sZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732604702; c=relaxed/simple;
	bh=vIXqP9YkTE+VyR7UcARNigtcHPpoZmvDYpifF25EnGA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XIaLjpv6p5oVrfHN2qQteoZxGPajAXThv4SXs98XRN6YT71SWxPkOvnaxp2amnH09Qqb4kKbOATAkCyYBlUWomhzEftiEZkJ+sSUmBDxScoOSKMzs1alFZqYo/n3FZcFQSW+m36pQ6829eAYQ5WOWNxKCW2V9saXwe504WVbebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=q2t3mhkT; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732604698; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=2QiaNCS7vZ2jTAUVLHD7wtG2gMb0msZ7gwW+/OdrtVI=;
	b=q2t3mhkTRU/Nqj7MWB7xAtkK7nAHi0g7cbM4CkTndkQh3oiSn8pEasR2YN46ukDx2W3YeGaHHFQpN/RXD9JrdQF6Lr9ee0Q7qNrbVrLktKfxT07Z5WqBKBt6vpdDqr7+kWRv4TNUMQle/y3s7E2mdL17IIOEHAPlBqMRZgFLK80=
Received: from 30.246.161.197(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WKHOCd2_1732604695 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Nov 2024 15:04:56 +0800
Message-ID: <0a57d695-d671-4382-aa53-6517b1caf4a7@linux.alibaba.com>
Date: Tue, 26 Nov 2024 15:04:53 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [RFC PATCH v2 0/9] Use ERST for persistent storage of MCE and
 APEI errors
To: Borislav Petkov <bp@alien8.de>
Cc: keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
 rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, ardb@kernel.org, robert.moore@intel.com,
 linux-hardening@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-efi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
 baolin.wang@linux.alibaba.com
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
 <20230928144345.GAZRWRIXH1Tfgn5EpO@fat_crate.local>
 <f654be8f-aa98-1bed-117b-ebdf96d23df1@linux.alibaba.com>
 <20231026133209.GCZTpqWVNUmqtBrnTw@fat_crate.local>
In-Reply-To: <20231026133209.GCZTpqWVNUmqtBrnTw@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/10/26 21:32, Borislav Petkov 写道:

Hi, Borislav,

Sorry for the late reply.

> On Sat, Oct 07, 2023 at 03:15:45PM +0800, Shuai Xue wrote:
>> So, IMHO, it's better to add a way to retrieve MCE records through switching
>> to the new generation rasdaemon solution.
> 
> rasdaemon already collects errors and even saves them in a database of
> sorts. No kernel changes needed.

I did not figure out how rasdaemon *already* collects errors.

Both rasdaemon and mcelog are designed to collect errors generated by the
x86_mce_decoder_chain notifier. However, due to the queuing of mce_irq_work on
the current CPU during an MCE context, the associated notifier_call is not
executed, preventing error collection before a system panic occurs. As a
result, neither rasdaemon nor mcelog can capture errors at this critical time.

Upon inspection, rasdaemon fails to record any errors, as evidenced by the
output of `ras-mc-ctl --errors`, which shows no memory or PCIe AER errors,
among others.

   # run after a new reboot caused by fatal memory error
   #ras-mc-ctl --errors
   No Memory errors.
   
   No PCIe AER errors.
   
   No Extlog errors.
   
   No devlink errors.
   
   No disk errors.
   
   No Memory failure errors.
   
   No MCE errors.

Conversely, mcelog is able to retrieve and log detailed MCE error records
post-reboot, providing valuable insights into hardware error events, even in
the case of fatal errors.

   #journalctl -u mcelog --no-pager
   -- Reboot --
   systemd[1]: Started Machine Check Exception Logging Daemon.
   mcelog[2783]: Running trigger `dimm-error-trigger' (reporter: memdb)
   mcelog[2783]: Hardware event. This is not a software error.
   mcelog[2783]: MCE 0
   mcelog[2783]: not finished?
   mcelog[2783]: CPU 0 BANK 16 TSC 2307d829a77
   mcelog[2783]: RIP !INEXACT! 10:ffffffffa9588d6b
   mcelog[2783]: MISC a0001201618f886 ADDR 1715d9880
   mcelog[2783]: TIME 1732588816 Tue Nov 26 10:40:16 2024
   mcelog[2783]: MCG status:RIPV MCIP
   mcelog[2783]: MCi status:
   mcelog[2783]: Uncorrected error
   mcelog[2783]: Error enabled
   mcelog[2783]: MCi_MISC register valid
   mcelog[2783]: MCi_ADDR register valid
   mcelog[2783]: Processor context corrupt
   mcelog[2783]: MCA: MEMORY CONTROLLER RD_CHANNEL1_ERR
   mcelog[2783]: Transaction: Memory read error
   mcelog[2783]: MemCtrl: Uncorrected read error
   mcelog[2783]: bank: 0x2 bankgroup: 0x1 row: 0x402c3 column: 0x1f0
   mcelog[2783]: rank: 0x2 subrank: 0x0
   mcelog[2783]: ecc mode: SDDC
   mcelog[2783]: STATUS be00000200a00091 MCGSTATUS 5
   mcelog[2783]: MCGCAP f000c15 APICID 0 SOCKETID 0
   mcelog[2783]: PPIN 74f8640abf43c587
   mcelog[2783]: MICROCODE 2b000571
   mcelog[2783]: CPUID Vendor Intel Family 6 Model 143 Step 4

This patchset is based on the fact that we can not collect the MCE records
which are written to persistent storage if we switch to rasdaemon. Please
correct me if I missed anything.

> 
>> Sorry for the poor cover letter. I hope the following response can clarify
>> the matter.
>>
>> Q1: What is the exact problem?
>>
>> Traditionally, fatal hardware errors will cause Linux print error log to
>> console, e.g. print_mce() or __ghes_print_estatus(), then reboot. With
>> Linux, the primary method for obtaining debugging information of a serious
>> error or fault is via the kdump mechanism.
> 
> Not necessarily - see above.
> 
>> In the public cloud scenario, multiple virtual machines run on a
>> single physical server, and if that server experiences a failure, it can
>> potentially impact multiple tenants. It is crucial for us to thoroughly
>> analyze the root causes of each instance failure in order to:
>>
>> - Provide customers with a detailed explanation of the outage to reassure them.
>> - Collect the characteristics of the failures, such as ECC syndrome, to enable fault prediction.
>> - Explore potential solutions to prevent widespread outages.
> 
> Huh, are you talking about providing customers with error information
> from the *underlying* physical machine which runs the cloud VMs? That
> sounds suspicious, to say the least.
> 
> AFAICT, all you can tell the VM owner is: yah, the hw had an
> uncorrectable error in its memory and crashed. Is that the use case?

Yes, I mean that the MCE record is a important evidence to dig out the root
cause for every panic in production to aovid suffering potential wildly
outages, so we want to collect as many error logs as possible.

> 
> To be able to tell the VM owners why it crashed?
> 
>> In short, it is necessary to serialize hardware error information available
>> for post-mortem debugging.
>>
>> Q2: What exactly I wanna do:
>>
>> The MCE handler, do_machine_check(), saves the MCE record to persistent
>> storage and it is retrieved by mcelog. Mcelog has been deprecated when
>> kernel 4.12 released in 2017, and the help of the configuration option
>> CONFIG_X86_MCELOG_LEGACY suggest to consider switching to the new
>> generation rasdaemon solution. The GHES handler does not support APEI error
>> record now.
> 
> I think you're confusing things: MCEs do get reported to userspace
> through the trace_mc_record tracepoint and rasdaemon opens it and reads
> error info from there. And then writes it out to its db. So that works
> now.

For recoverable errors, MCEs are recorded in rasdaemon by the trace_mc_record
tracepoint. But not for fatal errors. See my experiment above.

> 
> GHES is something different: it is a fw glue around error reporting so
> that you don't have to develop a reporting driver for every platform but
> you can use a single one - only the fw glue needs to be added.
> 
> The problem with GHES is that it is notoriously buggy and currently
> it loads on a single platform only on x86.

As far as I know, GHES is wildly used on ARM platfrom and it is the primary
method to dliver error record from firmware to OS.

> 
> ARM are doing something in that area - you're better off talking to
> James Morse about it. And he's on Cc.

Thanks.

> 
>> To serialize hardware error information available for post-mortem
>> debugging:
>> - add support to save APEI error record into flash via ERST before go panic,
>> - add support to retrieve MCE or APEI error record from the flash and emit
>> the related tracepoint after system boot successful again so that rasdaemon
>> can collect them
> 
> Now that is yet another thing: you want to save error records into
> firmware. First of all, you don't really need it if you do kdump as
> explained above.
> 
> Then, that thing has its own troubles: it is buggy like every firmware
> is and it can brick the machine.
> 
> I'm not saying it is not useful - there are some use cases for it which
> are being worked on but if all you wanna do is dump MCEs to rasdaemon,
> that works even now.
> 
> But then you have an ARM patch there and I'm confused because MCEs are
> x86 thing - ARM has different stuff.
> 
> So I think you need to elaborate more here.


Yes, may I need to split this patchset into two parts.

> 
> Thx.
> 


Thanks for valuable comments.

Best Regards,
Shuai

