Return-Path: <linux-efi+bounces-6188-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOH5KV5El2kiwQIAu9opvQ
	(envelope-from <linux-efi+bounces-6188-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 18:11:58 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AB8160FB0
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 18:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C5D2303CE17
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 17:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0C434B194;
	Thu, 19 Feb 2026 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qi9a6aXI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF6D34CFD7;
	Thu, 19 Feb 2026 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521074; cv=none; b=qClpwlzPd69Lq3fjpt0Vck1ubswCIo6dQJIyk4b8xb2DAFRr5ZwOHQsgGiu5wRCJpY6svMFFe802KrSbAigpuTdn2YMXiJldK7OQjUTwDRFT/AtRmwDDWP4HCiMvfAg3dpzAozZLG+/U3SSWvkqi2SEZOfxxWImdxnqRdXcQoCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521074; c=relaxed/simple;
	bh=YsjWyAGSyAzJqcz0jlZAz0lznVHz9OA+6mfXetjPUxQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=s48aMWDjiD5z9Z67yU1rF+9m3LcDyn40wtURrYWz7+gK5Uza6zdTGwEsTJYMmVtT3Dn9OlkJP1i9saOiZac6FWXftaMEZH1cXkHmTTwaPjm09QqfUTtMwrIOeT2f9wOSqi6jaZU0cOIDQEv4IF5NIcqdzo2q6iFTl1rWZudAikQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=qi9a6aXI; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61JHA6mF061543
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 19 Feb 2026 09:10:07 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61JHA6mF061543
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1771521011;
	bh=kccVFgKV/Gov4dZzwLE1ZqBthUx7ayVQs5AokW/GCIk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=qi9a6aXIYjVNA1t7lLg6lec45w4xiw/YNvwOXsl/BeUiwX3xR8D9fg6pp9oKGexCZ
	 6D3eyWIxQARRqjXrLiPOKFSwMuvLa3SxUpYrik5QBcJlaohTjifVD4ietFKfvE7YN0
	 wGeIqxEW8FdjCO8akb1R+UoMvl4JtQ7/RU8Xif3Ylgo+7pe4T+aNWgPHm1TKvr0DBT
	 h5QK/ukeiKE88Z1agf+xXaZbQMsQlIdbiodoT0w2TISCu7dIboN8odsnzmqr+SnZuM
	 duXP5P8r7zdUdBl8CEBY5fTSLz/lMWYG/QiQKEhgKr0CyRp8VCM0Z1hAXRxr36F9Jq
	 mAhHSoO2EMSOA==
Date: Thu, 19 Feb 2026 09:10:01 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ard Biesheuvel <ardb@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Simo Sorce <simo@redhat.com>
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
In-Reply-To: <558d0f28-01fb-4447-891c-2ffbf869c077@app.fastmail.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com> <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com> <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com> <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com> <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com> <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com> <CALCETrWzG1Mjb-RcwLQ5-tGFZ15WKHjZbqtLvyif+UPuVKJ_5g@mail.gmail.com> <32e62cef7b89d9691bdd4120388ce752fd041230.camel@redhat.com> <CALCETrUMR0RvOFXGzL7=F4c-3veL+1Sm2xf-BprHTK4=UKw8yA@mail.gmail.com> <558d0f28-01fb-4447-891c-2ffbf869c077@app.fastmail.com>
Message-ID: <4AF70D88-AD0C-4421-B8D5-2055D6B5E736@zytor.com>
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
	TAGGED_FROM(0.00)[bounces-6188-lists,linux-efi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[apertussolutions.com,oracle.com,vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,linux.intel.com,linutronix.de,redhat.com,alien8.de,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,citrix.com,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[32];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amacapital.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zytor.com:mid,zytor.com:dkim,zytor.com:email]
X-Rspamd-Queue-Id: 04AB8160FB0
X-Rspamd-Action: no action

On February 18, 2026 11:54:55 PM PST, Ard Biesheuvel <ardb@kernel=2Eorg> wr=
ote:
>On Wed, 18 Feb 2026, at 22:54, Andy Lutomirski wrote:
>> On Wed, Feb 18, 2026 at 1:04=E2=80=AFPM Simo Sorce <simo@redhat=2Ecom> =
wrote:
>>>
>>> On Wed, 2026-02-18 at 12:34 -0800, Andy Lutomirski wrote:
>>> > On Wed, Feb 18, 2026 at 12:29=E2=80=AFPM H=2E Peter Anvin <hpa@zytor=
=2Ecom> wrote:
>>> > >
>>> > > On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@amacap=
ital=2Enet> wrote:
>>> > > > On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@ke=
rnel=2Eorg> wrote:
>>> > > > >
>>> > > > > On Thu, 12 Feb 2026, at 20:49, Daniel P=2E Smith wrote:
>>> > > > > > On 2/9/26 09:04, Ard Biesheuvel wrote:
>>> > > > > =2E=2E=2E
>>> > > > > But would it be better to disable the runtime services by defa=
ult when doing a secure launch? PREEMPT_RT already does the same=2E
>>> > > >
>>> > > > So I have a possible way to disable EFI runtime service without =
losing
>>> > > > the ability to write EFI vars=2E  We come up with a simple file =
format
>>> > > > to store deferred EFI var updates and we come up with a place to=
 put
>>> > > > it so that we find it early-ish in boot the next time around=2E =
 (This
>>> > > > could be done via integration with systemd-boot or shim some oth=
er
>>> > > > boot loader or it could actually be part of the kernel=2E)  And =
then,
>>> > > > instead of writing variables directly, we write them to the defe=
rred
>>> > > > list and then update them on reboot (before TXT launch, etc)=2E =
 [0]
>>> > > > This would be a distincly nontrivial project and would not work =
for
>>> > > > all configurations=2E
>>> > > >
>>> > > > As a maybe less painful option, we could disable EFI runtime ser=
vices
>>> > > > but have a root-writable thing in sysfs that (a) turns them back=
 on
>>> > > > but (b) first extends a PCR to say that they're turned back on=
=2E
>>> > > >
>>> > > > (Or someone could try running runtime services at CPL3=2E=2E=2E)
>>> > > >
>>> > > > [0] I have thought for years that Intel and AMD should do this o=
n
>>> > > > their end, too=2E  Keep the sensitive part of SMI flash entirely=
 locked
>>> > > > after boot and, instead of using magic SMM stuff to validate tha=
t
>>> > > > write attempts have the appropriate permissions and signatures, =
queue
>>> > > > them up as deferred upates and validate the signatures on the ne=
xt
>>> > > > boot before locking flash=2E
>>> > > >
>>> > >
>>> > > *If* a physical EFI partition exists there is a lot to be said for=
 this approach=2E
>>> > >
>>> > > The only issue with this that I can see is for things like network=
 or CD/DVD booting where there isn't necessarily any EFI boot partition, it=
 might not be writable, or it might not be persistent (e=2Eg=2E http bootin=
g typically uses a ramdisk, like the old Linux initrd=2E)
>>> >
>>> > Hmm, I guess my approach is a 100% complete nonstarter for installin=
g
>>> > Linux from a CD, and it's really not awesome for installing Linux fr=
om
>>> > a USB stick=2E
>>>
>>> Doing any of this on a removable device feels generally like a trap=2E
>>> You get your USB disk in, try to boot, and it saves vars, but reboot
>>> fails for whatever reason, you plug it in another machine =2E=2E=2E an=
d it
>>> tries to "continue" from there? The amount of validation needed and
>>> testing for failure modes across reboots sounds really painful=2E
>>
>> I kind of stand by my other previous suggestion, though:
>>
>> As a maybe less painful option, we could disable EFI runtime services
>> but have a root-writable thing in sysfs that (a) turns them back on
>> but (b) first extends a PCR to say that they're turned back on=2E
>>
>
>After setting the EFI boot path to GRUB (or systemd-boot or whatever) at =
installation time, what other meaningful interactions do we expect with the=
 EFI runtime services?
>
>And given that the secure launch is orchestrated by the bootloader , with=
 which the kernel has a backchannel via its configuration file, it should b=
e rather straight-forward to implement the staging of variable updates ther=
e if we really need it=2E=20
>
>Doing any of this at the EFI/spec level might lead to a situation where t=
he OS now has to guess which of the provided APIs to manipulate variables i=
s the least broken=2E
>
>Of course, for readinf variables, dumping the RT variables into a memory =
buffer at boot time and exposing it via a EFI config table would be rather =
straight-forward, but it is also something I feel should be the job of the =
boot component that takes part in the decision to shield the runtime servic=
es from the OS=2E
>
>
>
>

The statement "that the kernel has a backchannel to" is *not true in gener=
al*=2E

