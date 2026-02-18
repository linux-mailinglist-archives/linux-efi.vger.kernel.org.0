Return-Path: <linux-efi+bounces-6179-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC4FC0Qllmn0bAIAu9opvQ
	(envelope-from <linux-efi+bounces-6179-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 21:47:00 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BA515988F
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 21:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AE063027111
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 20:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE6031A813;
	Wed, 18 Feb 2026 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bJpqkk9/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5F311C32;
	Wed, 18 Feb 2026 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771447615; cv=none; b=kjzfDjwTUHMdH1Z/fo0KDEZFvfZBiIUMon0P5AbaEgBhQN73o/iEAOiN2lFkGcZK28nytQXhnptB7M//GgsVpdv+IQa4nUSKBE64FpluPmKrRUVKvuMGenfxkDJgBu9MZhL3PHKjj0s968Rq8VtV6g6r11B6RgImXK7XrRIR4YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771447615; c=relaxed/simple;
	bh=ecP1w21ZzTWQNiel3buvd0Vxebpdlm8NAS7MCNpLiuc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=IvIX/LUl5NcEbl0wq7XvfCb78hMdyzIPj/NQsUE42GXcxqNrmqf8A1X6YwLKt/Tc9pHzpi3032vMwaOFFGz0S2CzJeP+830t7QAaOGhc/0kZ7p4mx3DeJ6wGNB4W3f6eKdwY5dbJ+hS3xObWUhhfuEM9LNP/52uZGr4lThIikXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=bJpqkk9/; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61IKTSZs2293374
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 18 Feb 2026 12:29:29 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61IKTSZs2293374
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1771446572;
	bh=2gPzya6BB0Sl+zzXsDx+pwzRpOh2oc+CKQ8HWLmwgWE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bJpqkk9/AJoFly8m3Npd1K3kPS9DEfbjAuwr8tbmbMS1bEJyUYtu57rgx9c7gdLqj
	 NPU6TneU8ckfJRMVa/Wk9aMku2aXMaw2xttjgShJG4kD/0bM6oD4Wzh7MR1sEXLoq7
	 f0a4f/s8UxlbT8mR3dQdNIdvWJS5Ps+6wEJ6lrlRdchEylHXT0tDZftWn5tp3t3+rI
	 ggN/M8XpcT1GncUmxQSgzpCpFaMl+aSGoA5zTlmxu2OlArCgi8oFpMjADDrqpTRM/v
	 iQkxDFl8gsNk5jRKM+IaQRWLI3I/0fpi6Ld9f+mQn1YUyPEmJcat0W/jfzazbYF8/R
	 8X1ZhDkxbpAIw==
Date: Wed, 18 Feb 2026 12:29:22 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andy Lutomirski <luto@amacapital.net>, Ard Biesheuvel <ardb@kernel.org>
CC: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev,
        dave.hansen@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
        peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        nivedita@alum.mit.edu, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
User-Agent: K-9 Mail for Android
In-Reply-To: <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com> <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com> <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com> <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com> <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
Message-ID: <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6179-lists,linux-efi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[apertussolutions.com,oracle.com,vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,linux.intel.com,linutronix.de,redhat.com,alien8.de,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,citrix.com,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[zytor.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amacapital.net:email,zytor.com:mid,zytor.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6BA515988F
X-Rspamd-Action: no action

On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@amacapital=2Ene=
t> wrote:
>On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel=2Eor=
g> wrote:
>>
>> On Thu, 12 Feb 2026, at 20:49, Daniel P=2E Smith wrote:
>> > On 2/9/26 09:04, Ard Biesheuvel wrote:
>> =2E=2E=2E
>> >> Surprisingly, even when doing a secure launch, the EFI runtime servi=
ces still work happily, which means (AIUI) that code that was excluded from=
 the D-RTM TCB is still being executed at ring 0? Doesn't this defeat D-RTM=
 entirely in the case some exploit is hidden in the EFI runtime code? Shoul=
d we measure the contents of EfiRuntimeServicesCode regions too?
>> >
>> > Yes, in fact in the early days I specifically stated that we should
>> > provide for the ability to measure the RS blocks=2E Particularly if y=
ou
>> > are not in an environment where you can isolate the calls to RS from =
the
>> > TCB=2E While the RS can pose runtime corruption risks, the larger con=
cern
>> > is integrating the D-RTM validation of the Intel System Resources
>> > Defense (ISRD), aka SMI isolation/SMM Supervisor, provided by the Int=
el
>> > System Security Report (ISSR)=2E Within the ISSR is a list of memory
>> > regions which the SMM Policy Shim (SPS) restricts a SMI handler's acc=
ess
>> > when running=2E This allows a kernel to restrict what access a SMI ha=
ndler
>> > are able to reach, thus allowing them to be removed from the TCB when
>> > the appropriate guards are put in place=2E
>> >
>> > If you are interested in understanding these further, Satoshi Tanda h=
as
>> > probably the best technical explanation without Intel market speak=2E
>> >
>> > ISRD: https://tandasat=2Egithub=2Eio/blog/2024/02/29/ISRD=2Ehtml
>> > ISSR: https://tandasat=2Egithub=2Eio/blog/2024/03/18/ISSR=2Ehtml
>> >
>>
>> Thanks, I'll take a look at those=2E
>>
>> But would it be better to disable the runtime services by default when =
doing a secure launch? PREEMPT_RT already does the same=2E
>
>So I have a possible way to disable EFI runtime service without losing
>the ability to write EFI vars=2E  We come up with a simple file format
>to store deferred EFI var updates and we come up with a place to put
>it so that we find it early-ish in boot the next time around=2E  (This
>could be done via integration with systemd-boot or shim some other
>boot loader or it could actually be part of the kernel=2E)  And then,
>instead of writing variables directly, we write them to the deferred
>list and then update them on reboot (before TXT launch, etc)=2E  [0]
>This would be a distincly nontrivial project and would not work for
>all configurations=2E
>
>As a maybe less painful option, we could disable EFI runtime services
>but have a root-writable thing in sysfs that (a) turns them back on
>but (b) first extends a PCR to say that they're turned back on=2E
>
>(Or someone could try running runtime services at CPL3=2E=2E=2E)
>
>[0] I have thought for years that Intel and AMD should do this on
>their end, too=2E  Keep the sensitive part of SMI flash entirely locked
>after boot and, instead of using magic SMM stuff to validate that
>write attempts have the appropriate permissions and signatures, queue
>them up as deferred upates and validate the signatures on the next
>boot before locking flash=2E
>

*If* a physical EFI partition exists there is a lot to be said for this ap=
proach=2E

The only issue with this that I can see is for things like network or CD/D=
VD booting where there isn't necessarily any EFI boot partition, it might n=
ot be writable, or it might not be persistent (e=2Eg=2E http booting typica=
lly uses a ramdisk, like the old Linux initrd=2E)

Even *if* there is a back channel to the boot server, it would require the=
 OS to know what it is and how to get to it=2E Maybe we need to consider st=
andardizing a protocol for uploads to the boot server, but that doesn't sol=
ve the boot from readonly media, or legacy boot server setups =2E=2E=2E and=
 boot server infrastructure is something that changes slowly at best=2E

Just *reading out* the EFI variables doesn't have that issue, of course; w=
e can do that in the EFI stub (and pass them onward to kexec kernels etc us=
ing the setup_data protocol=2E)



