Return-Path: <linux-efi+bounces-1787-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B4897B220
	for <lists+linux-efi@lfdr.de>; Tue, 17 Sep 2024 17:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3B5B2BF6E
	for <lists+linux-efi@lfdr.de>; Tue, 17 Sep 2024 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EA7183CD6;
	Tue, 17 Sep 2024 15:24:35 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23716198A3D;
	Tue, 17 Sep 2024 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586675; cv=none; b=kjT/6LIoN089z40/f/9W9FZJUWMXNeblENGDjwbajrgxKa2wh7xpV0ZRH4mB5+f8VEAZT+i/qKLNcSAn0AC30zZAtS6KrpCOprNDdEKrjzHTjXSWEpdqS9cZetsLno5n022qtE0KVYWlKDjrz4GcgBtwSfWaeczF36o39hjW01U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586675; c=relaxed/simple;
	bh=ED0yhvW/AOWGsB2MptRdhD37yyUeLYPIR2Gmt+PU7ZU=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=FrNloUu3IL8QirdSKukTmTGRg83SV2+LyHWtgx+5pAS8Aj5nBzNnyC56BCNEEiPrbnzKLYQ4EmB+m0zaPMZzJEMZ4BPo0xQxSLjs7qusOy+xlP5SxxTa9sYPI7NjT/I0ia41E4SHk/QtvKD0EvWHMTBFBUWa3stWywwukILxDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:49924)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sqa3z-004JMP-Qj; Tue, 17 Sep 2024 09:24:23 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:41204 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sqa3y-007ZmI-J1; Tue, 17 Sep 2024 09:24:23 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,  Breno Leitao
 <leitao@debian.org>,  Usama Arif <usamaarif642@gmail.com>,
  linux-efi@vger.kernel.org,  kexec@lists.infradead.org,  bhe@redhat.com,
  vgoyal@redhat.com,  tglx@linutronix.de,  dave.hansen@linux.intel.com,
  x86@kernel.org,  linux-kernel@vger.kernel.org,  rmikey@meta.com,
  gourry@gourry.net
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
	<CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
	<2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
	<CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
	<20240912-wealthy-gabby-tamarin-aaba3c@leitao>
	<d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
	<20240913-careful-maroon-crab-8a0541@leitao>
	<5c525fe8f33fffebc0d275086cc7484e309dfae0.camel@HansenPartnership.com>
	<87o74n5p05.fsf@email.froward.int.ebiederm.org>
	<CAMj1kXF7EohKai9nyxSnvu32KNdUcNZxxP69Sz-vUZ-6nmvekg@mail.gmail.com>
Date: Tue, 17 Sep 2024 10:24:14 -0500
In-Reply-To: <CAMj1kXF7EohKai9nyxSnvu32KNdUcNZxxP69Sz-vUZ-6nmvekg@mail.gmail.com>
	(Ard Biesheuvel's message of "Tue, 17 Sep 2024 08:45:44 +0200")
Message-ID: <874j6e482p.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sqa3y-007ZmI-J1;;;mid=<874j6e482p.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+9ipVF3FoT/chdK5FAp73S6hvA62izX5A=
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
	*      [score: 0.3072]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Ard Biesheuvel <ardb@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 583 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 4.8 (0.8%), b_tie_ro: 3.3 (0.6%), parse: 1.29
	(0.2%), extract_message_metadata: 15 (2.6%), get_uri_detail_list: 3.4
	(0.6%), tests_pri_-2000: 16 (2.8%), tests_pri_-1000: 2.0 (0.3%),
	tests_pri_-950: 1.00 (0.2%), tests_pri_-900: 0.81 (0.1%),
	tests_pri_-90: 79 (13.5%), check_bayes: 77 (13.3%), b_tokenize: 10
	(1.6%), b_tok_get_all: 9 (1.5%), b_comp_prob: 2.9 (0.5%),
	b_tok_touch_all: 53 (9.1%), b_finish: 0.72 (0.1%), tests_pri_0: 449
	(77.1%), check_dkim_signature: 0.42 (0.1%), check_dkim_adsp: 2.9
	(0.5%), poll_dns_idle: 1.55 (0.3%), tests_pri_10: 2.3 (0.4%),
	tests_pri_500: 8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: gourry@gourry.net, rmikey@meta.com, linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de, vgoyal@redhat.com, bhe@redhat.com, kexec@lists.infradead.org, linux-efi@vger.kernel.org, usamaarif642@gmail.com, leitao@debian.org, James.Bottomley@hansenpartnership.com, ardb@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Ard Biesheuvel <ardb@kernel.org> writes:

> Hi Eric,
>
> Thanks for chiming in.

It just looked like after James gave some expert input the
conversation got stuck, so I am just trying to move it along.

I don't think anyone knows what this whole elephant looks like,
which makes solving the problem tricky.

> On Mon, 16 Sept 2024 at 22:21, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> James Bottomley <James.Bottomley@HansenPartnership.com> writes:
>>
>> > On Fri, 2024-09-13 at 04:57 -0700, Breno Leitao wrote:
>> >> Hello James,
>> >>
>> >> On Thu, Sep 12, 2024 at 12:22:01PM -0400, James Bottomley wrote:
>> >> > On Thu, 2024-09-12 at 06:03 -0700, Breno Leitao wrote:
>> >> > > Hello Ard,
>> >> > >
>> >> > > On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
>> >> > > > I don't see how this could be an EFI bug, given that it does
>> >> > > > not deal with E820 tables at all.
>> >> > >
>> >> > > I want to back up a little bit and make sure I am following the
>> >> > > discussion.
>> >> > >
>> >> > > From what I understand from previous discussion, we have an EFI
>> >> > > bug as the root cause of this issue.
>> >> > >
>> >> > > This happens because the EFI does NOT mark the EFI TPM event log
>> >> > > memory region as reserved (EFI_RESERVED_TYPE). Not having an
>> >> > > entry for the event table memory in EFI memory mapped, then
>> >> > > libstub will ignore it completely (the TPM event log memory
>> >> > > range) and not populate e820 table with it.
>> >> >
>> >> > Wait, that's not correct.  The TPM log is in memory that doesn't
>> >> > survive ExitBootServices (by design in case the OS doesn't care
>> >> > about it).  So the EFI stub actually copies it over to a new
>> >> > configuration table that is in reserved memory before it calls
>> >> > ExitBootServices.  This new copy should be in kernel reserved
>> >> > memory regardless of its e820 map status.
>> >>
>> >> First of all, thanks for clarifying some points here.
>> >>
>> >> How should the TPM log table be passed to the next kernel when
>> >> kexecing() since it didn't surive ExitBootServices?
>> >
>> > I've no idea.  I'm assuming you don't elaborately reconstruct the EFI
>> > boot services, so you can't enter the EFI boot stub before
>> > ExitBootServices is called?  So I'd guess you want to preserve the EFI
>> > table that copied the TPM data in to kernel memory.
>>
>> This leaves two practical questions if I have been following everything
>> correctly.
>>
>> 1) How to get kexec to avoid picking that memory for the new kernel to
>>    run in before it initializes itself. (AKA the getting stomped by
>>    relocate kernel problem).
>>
>> 2) How to point the new kernel to preserved tpm_log.
>>
>>
>> This recommendation is from memory so it may be a bit off but
>> the general structure should work.  The idea is as follows.
>>
>> - Pass the information between kernels.
>>
>>   It is probably simplest for the kernel to have a command line option
>>   that tells the kernel the address and size of the tpm_log.
>>
>>   We have a couple of mechanisms here.  Assuming you are loading a
>>   bzImage with kexec_file_load you should be able to have the in kernel
>>   loader to add those arguments to the kernel command line.
>>
>
> This shouldn't be necessary, and I think it is actively harmful to
> keep inventing special ways for the kexec kernel to learn about these
> things that deviate from the methods used by the first kernel. This is
> how we ended up with 5 sources of truth for the physical memory map
> (EFI memory map, memblock and 3 different versions of the e820 memory
> map).
>
> We should try very hard to make kexec idempotent, and reuse the
> existing methods where possible. In this case, the EFI configuration
> table is already being exposed to the kexec kernel, which describes
> the base of the allocation. The size of the allocation can be derived
> from the table header.
>
>> - Ensure that when the loader is finding an address to load the new
>>   kernel it treats the address of the tpm_log as unavailable.
>>
>
> The TPM log is a table created by the EFI stub loader, which is part
> of the kernel. So if we need to tweak this for kexec's benefit, I'd
> prefer changing it in a way that can accommodate the first kernel too.
> However, I think the current method already has that property so I
> don't think we need to do anything (modulo fixing the bug)

I am fine with not inventing a new mechanism, but I think we need
to reuse whatever mechanism the stub loader uses to pass it's
table to the kernel.  Not the EFI table that disappears at
ExitBootServices().

> That said, I am doubtful that the kexec kernel can make meaningful use
> of the TPM log to begin with, given that the TPM will be out of sync
> at this point. But it is still better to keep it for symmetry, letting
> the higher level kexec/kdump logic running in user space reason about
> whether the TPM log has any value to it.

Someone seems to think so or there would not be a complaint that it is
getting corrupted.

This should not be the kexec-on-panic kernel as that runs in memory
that is reserved solely for it's own use.  So we are talking something
like using kexec as a bootloader.

Eric


