Return-Path: <linux-efi+bounces-1789-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729A797B70C
	for <lists+linux-efi@lfdr.de>; Wed, 18 Sep 2024 05:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982BB1C212B0
	for <lists+linux-efi@lfdr.de>; Wed, 18 Sep 2024 03:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEC43DBB6;
	Wed, 18 Sep 2024 03:14:06 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD38DF6C;
	Wed, 18 Sep 2024 03:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726629246; cv=none; b=VDEW+naM8PsSbqhOkRIhiLOKKD+ODUJ4gxmHDbwYgREjoH6IT/8AKKGudL/MlKsPXfu8f3Im8PRNnhcIi2buZ4nzIe1Z2aEdfkaPSAFiRCwdeSulfOgOkTlpWKs41oF8sp7UshNSelD6pSeWZSCF/JdDzHq2nUnRowklFO+/aJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726629246; c=relaxed/simple;
	bh=xh+XcUuIMrUpj2yQ8yPIhRLDpHYypWVi6tFGNbA83WE=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=d3uXv1jf0sHbODduf67xMTm56tIJQEVSWqrg/4QBLWIzuz6i9EPCMsi5pvtIv88nWy+JXD3ak5XvdjTmg+dDWtSxveHh+nnzoQTCnZ8mhkG20462z1a8QvQqHKqeTO31UMYDqZxrhPhAQe9aEJPc4bOLo9/jsQuoSx8sdbtkYrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:34848)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sql8d-004Anw-KA; Tue, 17 Sep 2024 21:13:55 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:41268 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sql8c-005NV4-DJ; Tue, 17 Sep 2024 21:13:55 -0600
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
	<874j6e482p.fsf@email.froward.int.ebiederm.org>
	<CAMj1kXEa4DSY8omHGhoTK0U5isvK2G-PJO9go-QK_Mzny=g6ow@mail.gmail.com>
Date: Tue, 17 Sep 2024 22:13:30 -0500
In-Reply-To: <CAMj1kXEa4DSY8omHGhoTK0U5isvK2G-PJO9go-QK_Mzny=g6ow@mail.gmail.com>
	(Ard Biesheuvel's message of "Tue, 17 Sep 2024 17:35:20 +0200")
Message-ID: <87setx3b8l.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sql8c-005NV4-DJ;;;mid=<87setx3b8l.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+kvMZT12Ifk9zEW+PAKwuz6Tn0dqFT3Ew=
X-Spam-Level: *
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4543]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  1.0 T_XMDrugObfuBody_06 obfuscated drug references
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Ard Biesheuvel <ardb@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 576 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 4.1 (0.7%), b_tie_ro: 2.9 (0.5%), parse: 0.80
	(0.1%), extract_message_metadata: 10 (1.8%), get_uri_detail_list: 2.7
	(0.5%), tests_pri_-2000: 10 (1.8%), tests_pri_-1000: 2.0 (0.4%),
	tests_pri_-950: 1.02 (0.2%), tests_pri_-900: 0.79 (0.1%),
	tests_pri_-90: 82 (14.3%), check_bayes: 81 (14.1%), b_tokenize: 9
	(1.6%), b_tok_get_all: 12 (2.1%), b_comp_prob: 2.5 (0.4%),
	b_tok_touch_all: 55 (9.5%), b_finish: 0.68 (0.1%), tests_pri_0: 453
	(78.7%), check_dkim_signature: 0.43 (0.1%), check_dkim_adsp: 2.9
	(0.5%), poll_dns_idle: 1.72 (0.3%), tests_pri_10: 1.73 (0.3%),
	tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: gourry@gourry.net, rmikey@meta.com, linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de, vgoyal@redhat.com, bhe@redhat.com, kexec@lists.infradead.org, linux-efi@vger.kernel.org, usamaarif642@gmail.com, leitao@debian.org, James.Bottomley@hansenpartnership.com, ardb@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Ard Biesheuvel <ardb@kernel.org> writes:

> On Tue, 17 Sept 2024 at 17:24, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Ard Biesheuvel <ardb@kernel.org> writes:
>>
>> > Hi Eric,
>> >
>> > Thanks for chiming in.
>>
>> It just looked like after James gave some expert input the
>> conversation got stuck, so I am just trying to move it along.
>>
>> I don't think anyone knows what this whole elephant looks like,
>> which makes solving the problem tricky.
>>
>> > On Mon, 16 Sept 2024 at 22:21, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> >>
> ...
>> >>
>> >> This leaves two practical questions if I have been following everything
>> >> correctly.
>> >>
>> >> 1) How to get kexec to avoid picking that memory for the new kernel to
>> >>    run in before it initializes itself. (AKA the getting stomped by
>> >>    relocate kernel problem).
>> >>
>> >> 2) How to point the new kernel to preserved tpm_log.
>> >>
>> >>
>> >> This recommendation is from memory so it may be a bit off but
>> >> the general structure should work.  The idea is as follows.
>> >>
>> >> - Pass the information between kernels.
>> >>
>> >>   It is probably simplest for the kernel to have a command line option
>> >>   that tells the kernel the address and size of the tpm_log.
>> >>
>> >>   We have a couple of mechanisms here.  Assuming you are loading a
>> >>   bzImage with kexec_file_load you should be able to have the in kernel
>> >>   loader to add those arguments to the kernel command line.
>> >>
>> >
>> > This shouldn't be necessary, and I think it is actively harmful to
>> > keep inventing special ways for the kexec kernel to learn about these
>> > things that deviate from the methods used by the first kernel. This is
>> > how we ended up with 5 sources of truth for the physical memory map
>> > (EFI memory map, memblock and 3 different versions of the e820 memory
>> > map).
>> >
>> > We should try very hard to make kexec idempotent, and reuse the
>> > existing methods where possible. In this case, the EFI configuration
>> > table is already being exposed to the kexec kernel, which describes
>> > the base of the allocation. The size of the allocation can be derived
>> > from the table header.
>> >
>> >> - Ensure that when the loader is finding an address to load the new
>> >>   kernel it treats the address of the tpm_log as unavailable.
>> >>
>> >
>> > The TPM log is a table created by the EFI stub loader, which is part
>> > of the kernel. So if we need to tweak this for kexec's benefit, I'd
>> > prefer changing it in a way that can accommodate the first kernel too.
>> > However, I think the current method already has that property so I
>> > don't think we need to do anything (modulo fixing the bug)
>>
>> I am fine with not inventing a new mechanism, but I think we need
>> to reuse whatever mechanism the stub loader uses to pass it's
>> table to the kernel.  Not the EFI table that disappears at
>> ExitBootServices().
>>
>
> Not sure what you mean here - the EFI table that gets clobbered by
> kexec *is* the table that is created by the stub loader to pass the
> TPM log to the kernel. Not sure what alternative you have in mind
> here.

I was referring to whatever the EFI table that James Bottomley mentioned
that I presume the stub loader reads from when the stub loader
constructs the tpm_log that is passed to the kernel.

So I believe we are in agreement of everything except terminology.

>> > That said, I am doubtful that the kexec kernel can make meaningful use
>> > of the TPM log to begin with, given that the TPM will be out of sync
>> > at this point. But it is still better to keep it for symmetry, letting
>> > the higher level kexec/kdump logic running in user space reason about
>> > whether the TPM log has any value to it.
>>
>> Someone seems to think so or there would not be a complaint that it is
>> getting corrupted.
>>
>
> No. The problem is that the size of the table is *in* the table, and
> so if it gets corrupted, the code that attempts to memblock_reserve()
> it goes off into the weeds. But that does not imply there is a point
> to having access to this table from a kexec kernel in the first place.

If there is no point to having access to it then we should just not
pass anything to the loaded kernel, so the kernel does not think there
is anything there.

>> This should not be the kexec-on-panic kernel as that runs in memory
>> that is reserved solely for it's own use.  So we are talking something
>> like using kexec as a bootloader.
>>
>
> kexec as a bootloader under TPM based measured boot will need to do a
> lot more than pass the firmware's event log to the next kernel. I'd
> expect a properly engineered kexec to replace this table entirely, and
> include the hashes of the assets it has loaded and measured into the
> respective PCRs.
>
> But let's stick to solving the actual issue here, rather than
> philosophize on how kexec might work in this context.


I am fine with that.  The complaint I had seen was that the table was
being corrupted and asking how to solve that.  It seems I haven't read
the part of the conversation where it was made clear that no one wants
the tpm_log after kexec.

If someone wants the tpm_log then we need to solve this problem.

Eric

