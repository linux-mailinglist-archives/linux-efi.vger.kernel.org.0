Return-Path: <linux-efi+bounces-1785-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E73DE97A842
	for <lists+linux-efi@lfdr.de>; Mon, 16 Sep 2024 22:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941F32808F8
	for <lists+linux-efi@lfdr.de>; Mon, 16 Sep 2024 20:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F2D165F0F;
	Mon, 16 Sep 2024 20:21:41 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D548165EE2;
	Mon, 16 Sep 2024 20:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726518101; cv=none; b=hIw/YykLCbj5BOceL5M6E2oZ4O1y0G2ufLnUmQpm75EdLCY2m2k4JK3FtoIuH2e/D+JUawVzEzm9nKpjrDAMGU6Qe8z6s6z5y9kLHpeCQv9BQ0yr7FzrNQalR+UHe222EznreOVwv8Nby+U0KPE9kKU3lghWGeWOnAzy/9LNTq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726518101; c=relaxed/simple;
	bh=kp+I+XPz98RdBc/O0AdiHrofN1wY96ltF5ISC7pSh3s=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=Exaf2UMjwviO7h5rVccQeML4IiszO66vP/6ml4algB3ex+A49zaIoNboskdBBlYFlWa76/mLpmpZg2TiCEPeD7MBQu3nTbAlgcjaQX548SJN3BYWDD5Aio4fFqmwZbtEXH3eFTVsmvJW94+DEfzfD1kNuAMp19uYG+KjvsbPFRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:42630)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sqIDz-001tnV-Dg; Mon, 16 Sep 2024 14:21:31 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:37670 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sqIDx-005wGA-MA; Mon, 16 Sep 2024 14:21:30 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Breno Leitao <leitao@debian.org>,  Ard Biesheuvel <ardb@kernel.org>,
  Usama Arif <usamaarif642@gmail.com>,  linux-efi@vger.kernel.org,
  kexec@lists.infradead.org,  bhe@redhat.com,  vgoyal@redhat.com,
  tglx@linutronix.de,  dave.hansen@linux.intel.com,  x86@kernel.org,
  linux-kernel@vger.kernel.org,  rmikey@meta.com,  gourry@gourry.net
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
	<CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
	<2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
	<CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
	<20240912-wealthy-gabby-tamarin-aaba3c@leitao>
	<d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
	<20240913-careful-maroon-crab-8a0541@leitao>
	<5c525fe8f33fffebc0d275086cc7484e309dfae0.camel@HansenPartnership.com>
Date: Mon, 16 Sep 2024 15:20:58 -0500
In-Reply-To: <5c525fe8f33fffebc0d275086cc7484e309dfae0.camel@HansenPartnership.com>
	(James Bottomley's message of "Fri, 13 Sep 2024 08:07:18 -0400")
Message-ID: <87o74n5p05.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1sqIDx-005wGA-MA;;;mid=<87o74n5p05.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18ZE5XOodQ0y66kw/dUg5oYa8/l9iiyLZM=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
	*      [score: 0.3257]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;James Bottomley <James.Bottomley@HansenPartnership.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 462 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 10 (2.1%), b_tie_ro: 8 (1.8%), parse: 1.01 (0.2%),
	 extract_message_metadata: 13 (2.8%), get_uri_detail_list: 1.90 (0.4%),
	 tests_pri_-2000: 11 (2.4%), tests_pri_-1000: 2.7 (0.6%),
	tests_pri_-950: 1.24 (0.3%), tests_pri_-900: 1.05 (0.2%),
	tests_pri_-90: 88 (19.0%), check_bayes: 85 (18.5%), b_tokenize: 9
	(1.9%), b_tok_get_all: 10 (2.2%), b_comp_prob: 3.1 (0.7%),
	b_tok_touch_all: 60 (13.0%), b_finish: 0.91 (0.2%), tests_pri_0: 322
	(69.7%), check_dkim_signature: 0.60 (0.1%), check_dkim_adsp: 3.2
	(0.7%), poll_dns_idle: 0.17 (0.0%), tests_pri_10: 2.1 (0.5%),
	tests_pri_500: 7 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: gourry@gourry.net, rmikey@meta.com, linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de, vgoyal@redhat.com, bhe@redhat.com, kexec@lists.infradead.org, linux-efi@vger.kernel.org, usamaarif642@gmail.com, ardb@kernel.org, leitao@debian.org, James.Bottomley@HansenPartnership.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Fri, 2024-09-13 at 04:57 -0700, Breno Leitao wrote:
>> Hello James,
>>=20
>> On Thu, Sep 12, 2024 at 12:22:01PM -0400, James Bottomley wrote:
>> > On Thu, 2024-09-12 at 06:03 -0700, Breno Leitao wrote:
>> > > Hello Ard,
>> > >=20
>> > > On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
>> > > > I don't see how this could be an EFI bug, given that it does
>> > > > not deal with E820 tables at all.
>> > >=20
>> > > I want to back up a little bit and make sure I am following the
>> > > discussion.
>> > >=20
>> > > From what I understand from previous discussion, we have an EFI
>> > > bug as the root cause of this issue.
>> > >=20
>> > > This happens because the EFI does NOT mark the EFI TPM event log
>> > > memory region as reserved (EFI_RESERVED_TYPE). Not having an
>> > > entry for the event table memory in EFI memory mapped, then
>> > > libstub will ignore it completely (the TPM event log memory
>> > > range) and not populate e820 table with it.
>> >=20
>> > Wait, that's not correct.=C2=A0 The TPM log is in memory that doesn't
>> > survive ExitBootServices (by design in case the OS doesn't care
>> > about it).=C2=A0 So the EFI stub actually copies it over to a new
>> > configuration table that is in reserved memory before it calls
>> > ExitBootServices.  This new copy should be in kernel reserved
>> > memory regardless of its e820 map status.
>>=20
>> First of all, thanks for clarifying some points here.
>>=20
>> How should the TPM log table be passed to the next kernel when
>> kexecing() since it didn't surive ExitBootServices?
>
> I've no idea.  I'm assuming you don't elaborately reconstruct the EFI
> boot services, so you can't enter the EFI boot stub before
> ExitBootServices is called?  So I'd guess you want to preserve the EFI
> table that copied the TPM data in to kernel memory.

This leaves two practical questions if I have been following everything
correctly.

1) How to get kexec to avoid picking that memory for the new kernel to
   run in before it initializes itself. (AKA the getting stomped by
   relocate kernel problem).

2) How to point the new kernel to preserved tpm_log.


This recommendation is from memory so it may be a bit off but
the general structure should work.  The idea is as follows.

- Pass the information between kernels.

  It is probably simplest for the kernel to have a command line option
  that tells the kernel the address and size of the tpm_log.

  We have a couple of mechanisms here.  Assuming you are loading a
  bzImage with kexec_file_load you should be able to have the in kernel
  loader to add those arguments to the kernel command line.

- Ensure that when the loader is finding an address to load the new
  kernel it treats the address of the tpm_log as unavailable.

Does that sound like a doable plan?

Eric

