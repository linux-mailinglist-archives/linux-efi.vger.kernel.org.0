Return-Path: <linux-efi+bounces-1698-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777C4974111
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 19:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A744D1C25524
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134AF1A2863;
	Tue, 10 Sep 2024 17:50:53 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633F261FE1
	for <linux-efi@vger.kernel.org>; Tue, 10 Sep 2024 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990653; cv=none; b=cVn2g//7WPjhkL+CRrnPI6EupkuSZ5YtQrQiOIqqC/yQzKh63uCljV8Iao+YsRWcQHfHuo7Eo4LFkYUSFcV5W67tJ3uiE0K6qnUMnBRCKoWzHCkgGB5IKiu9+1xBNeZHwXg0z6nzx0ddY5OGyZ0wueSgqRToCbjmbaPOjPG0qlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990653; c=relaxed/simple;
	bh=aMBxF3p7MzwTwIwO9q9FRbxST9y9GM7O6z8v6L0xQTY=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=HJtBA4QAT2NZl4pYwy36gcr9FXLWnGFNzVtuOhiOoaUk8eDH+5Zu0vBKTt/9OK1xAGoqrz40UEUaNjOwmTec9oxFWbuiDIjV5VqUZSuWqnwQzizteNfFK8ehUOjaQeAOhiFBzbTpjYQqBvdd5i7E41r2Wtystug1i/LE7jLH+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:55468)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1so4Iw-0092sG-Ob; Tue, 10 Sep 2024 11:05:26 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:46314 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1so4Iv-005kJH-SY; Tue, 10 Sep 2024 11:05:26 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Breno Leitao <leitao@debian.org>
Cc: ardb@kernel.org,  linux-efi@vger.kernel.org,  kexec@lists.infradead.org,
  bhe@redhat.com,  vgoyal@redhat.com,  devel@edk2.groups.io,
  rppt@kernel.org,  usamaarif642@gmail.com,  gourry@gourry.net,
  rmikey@meta.com
References: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
	<87ed5rd1qf.fsf@email.froward.int.ebiederm.org>
	<20240910-uppish-gopher-of-spirit-f14f0e@devvm32600>
Date: Tue, 10 Sep 2024 12:05:19 -0500
In-Reply-To: <20240910-uppish-gopher-of-spirit-f14f0e@devvm32600> (Breno
	Leitao's message of "Tue, 10 Sep 2024 08:13:44 -0700")
Message-ID: <87seu7a180.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1so4Iv-005kJH-SY;;;mid=<87seu7a180.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19JOxRHwKLUZUCY1QPm1gfN+KbZ5kGU+nk=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4994]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Breno Leitao <leitao@debian.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 333 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 11 (3.4%), b_tie_ro: 10 (3.0%), parse: 0.74
	(0.2%), extract_message_metadata: 2.8 (0.8%), get_uri_detail_list:
	0.99 (0.3%), tests_pri_-2000: 15 (4.6%), tests_pri_-1000: 2.4 (0.7%),
	tests_pri_-950: 1.37 (0.4%), tests_pri_-900: 1.18 (0.4%),
	tests_pri_-90: 100 (29.9%), check_bayes: 98 (29.4%), b_tokenize: 6
	(1.7%), b_tok_get_all: 8 (2.4%), b_comp_prob: 2.2 (0.6%),
	b_tok_touch_all: 70 (20.9%), b_finish: 1.12 (0.3%), tests_pri_0: 182
	(54.6%), check_dkim_signature: 0.43 (0.1%), check_dkim_adsp: 2.9
	(0.9%), poll_dns_idle: 1.08 (0.3%), tests_pri_10: 2.2 (0.7%),
	tests_pri_500: 7 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: EFI table being corrupted during Kexec
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: rmikey@meta.com, gourry@gourry.net, usamaarif642@gmail.com, rppt@kernel.org, devel@edk2.groups.io, vgoyal@redhat.com, bhe@redhat.com, kexec@lists.infradead.org, linux-efi@vger.kernel.org, ardb@kernel.org, leitao@debian.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Breno Leitao <leitao@debian.org> writes:

> Hello Eric,
>
> On Tue, Sep 10, 2024 at 09:26:00AM -0500, Eric W. Biederman wrote:
>> > I am wondering if that memory region/range should be part of e820 table that is
>> > passed by EFI firmware to kernel, and if it is not passed (as it is not being
>> > passed today), then the kernel doesn't need to respect it, and it is free to
>> > overwrite (as it does today). In other words, this is a firmware bug and not a
>> > kernel bug.
>> >
>> > Am I missing something?
>> 
>> I agree that this appears to be a firmware bug.  This memory is reserved
>> in one location and not in another location.
>
> That was is our current understanding also, but, having the same issue
> in EDK2 and on a real machine firmware was surprising.
>
> Anyway, I've CCed the EDK2 mailing list in this thread as well, let's
> see if someone has any comment.
>
>> As I recall the memblock allocator is the bootstrap memory allocator
>> used when bringing up the kernel.  So I don't see reserving something
>> in the memblock allocator as being authoritative as to how the firmware
>> has setup memory.
>> 
>> I would suggest writing a patch to update whatever is calling
>> memblock_reserve to also, or perhaps in preference to update the e820
>> map.  If the code is not x86 specific I would suggest using ACPI's
>> arch_reserve_mem_area call.
>
> Should all memblock_reserve() memory ranges be mapped to e820 table, or,
> just specific cases where we see problems?

Just specific cases.  There could be other linux specific reasons to
tell the memblock allocator not to allocation from a specific range
of memory.

Eric


