Return-Path: <linux-efi+bounces-1692-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AE99739CC
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 16:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6967B226DC
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42A818785A;
	Tue, 10 Sep 2024 14:26:28 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0E2AEF1
	for <linux-efi@vger.kernel.org>; Tue, 10 Sep 2024 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978388; cv=none; b=P/x2QgTZ7hJWBdVgodPL5NEghJ5Me7IRmIJZa5WeIm5dNYVT6H3syV59lYJuoko4rAXZqOZVMD8WX+WmTMk9jPD7xwatDENY46e/BIz58ipzmYFhRavBZ1f6NMd7hnfEJfyUYGlsVdmlevS/o7sru5mquR6pfHpY4pc1LWb9KR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978388; c=relaxed/simple;
	bh=vcTJnM0dA7zYEB7f46hJZy1AjbwMCAyNqGO1bPL4pMI=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=pD45C9tPYyIRAFKOVbQeH6/Xp/jCgBSXFSC+v2kVXj5ZrIJWZYG20bKWGHKILt0ihCB3eAfpuzc7AvitFDr+QKr6N2szKkWTwATCtuB0WmwsGE+pNUU6bVQ/jLnwsAjRIU4n2gqAjqzP1Y6DbhOVaI9LtjHTcwwy+fcEVf0VvZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:35602)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1so1p3-00FrpQ-8z; Tue, 10 Sep 2024 08:26:25 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:55678 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1so1p2-009HMx-7D; Tue, 10 Sep 2024 08:26:24 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Breno Leitao <leitao@debian.org>
Cc: ardb@kernel.org,  linux-efi@vger.kernel.org,  kexec@lists.infradead.org,
  bhe@redhat.com,  vgoyal@redhat.com,  devel@edk2.groups.io,
  rppt@kernel.org,  usamaarif642@gmail.com,  gourry@gourry.net,
  rmikey@meta.com
References: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
Date: Tue, 10 Sep 2024 09:26:00 -0500
In-Reply-To: <20240910-juicy-festive-sambar-9ad23a@devvm32600> (Breno Leitao's
	message of "Tue, 10 Sep 2024 06:58:44 -0700")
Message-ID: <87ed5rd1qf.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1so1p2-009HMx-7D;;;mid=<87ed5rd1qf.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19dkBTjOgMEh0RF9HPfgeclbCjl4TDYDm8=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4998]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Breno Leitao <leitao@debian.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 482 ms - load_scoreonly_sql: 0.08 (0.0%),
	signal_user_changed: 11 (2.3%), b_tie_ro: 10 (2.0%), parse: 1.01
	(0.2%), extract_message_metadata: 13 (2.7%), get_uri_detail_list: 2.0
	(0.4%), tests_pri_-2000: 16 (3.3%), tests_pri_-1000: 2.5 (0.5%),
	tests_pri_-950: 1.25 (0.3%), tests_pri_-900: 1.07 (0.2%),
	tests_pri_-90: 62 (12.9%), check_bayes: 60 (12.5%), b_tokenize: 8
	(1.6%), b_tok_get_all: 9 (1.9%), b_comp_prob: 2.9 (0.6%),
	b_tok_touch_all: 36 (7.4%), b_finish: 1.03 (0.2%), tests_pri_0: 362
	(75.1%), check_dkim_signature: 0.59 (0.1%), check_dkim_adsp: 2.8
	(0.6%), poll_dns_idle: 0.99 (0.2%), tests_pri_10: 2.1 (0.4%),
	tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: EFI table being corrupted during Kexec
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: rmikey@meta.com, gourry@gourry.net, usamaarif642@gmail.com, rppt@kernel.org, devel@edk2.groups.io, vgoyal@redhat.com, bhe@redhat.com, kexec@lists.infradead.org, linux-efi@vger.kernel.org, ardb@kernel.org, leitao@debian.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Breno Leitao <leitao@debian.org> writes:

> We've seen a problem in upstream kernel kexec, where a EFI TPM log event =
table
> is being overwritten.  This problem happen on real machine, as well as in=
 a
> recent EDK2 qemu VM.
>
> Digging deep, the table is being overwritten during kexec, more precisely=
 when
> relocating kernel (relocate_kernel() function).
>
> I've also found that the table is being properly reserved using
> memblock_reserve() early in the boot, and that range gets overwritten lat=
er in
> by relocate_kernel(). In other words, kexec is overwriting a memory that =
was
> previously reserved (as memblock_reserve()).
>
> Usama found that kexec only honours memory reservations from /sys/firmwar=
e/memmap
> which comes from e820_table_firmware table.
>
> Looking at the TPM spec, I found the following part:
>
> 	If the ACPI TPM2 table contains the address and size of the Platform Fir=
mware TCG log,
> 	firmware =E2=80=9Cpins=E2=80=9D the memory associated with the Platform =
Firmware TCG log, and reports
> 	this memory as =E2=80=9CReserved=E2=80=9D memory via the INT 15h/E820 in=
terface.
>
>
> From: https://trustedcomputinggroup.org/wp-content/uploads/PC-ClientPlatf=
orm_Profile_for_TPM_2p0_Systems_v49_161114_public-review.pdf
>
> I am wondering if that memory region/range should be part of e820 table t=
hat is
> passed by EFI firmware to kernel, and if it is not passed (as it is not b=
eing
> passed today), then the kernel doesn't need to respect it, and it is free=
 to
> overwrite (as it does today). In other words, this is a firmware bug and =
not a
> kernel bug.
>
> Am I missing something?

I agree that this appears to be a firmware bug.  This memory is reserved
in one location and not in another location.

That said that doesn't mean we can't deal with it in the kernel.
acpi_table_upgrade seems to have hit a similar issue issue and calls
arch_reserve_mem_area to reserve the area in the e820tables.


The last time I looked the e820 tables (in the kernel) are used to store
the efi memory map when available and only use the true e820 data on
older systems.

Which is a long way of say that the e820 table in the kernel last I
looked was the master table, of how the firmware views the memory.


As I recall the memblock allocator is the bootstrap memory allocator
used when bringing up the kernel.  So I don't see reserving something
in the memblock allocator as being authoritative as to how the firmware
has setup memory.



I would suggest writing a patch to update whatever is calling
memblock_reserve to also, or perhaps in preference to update the e820
map.  If the code is not x86 specific I would suggest using ACPI's
arch_reserve_mem_area call.


If you have a good path to your the folks who write for the computers
where this happens it seems entirely reasonable to report this as a bug
to them as well.

Eric

