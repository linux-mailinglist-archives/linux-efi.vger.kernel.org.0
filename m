Return-Path: <linux-efi+bounces-6189-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEiIFb9Jl2m2wQIAu9opvQ
	(envelope-from <linux-efi+bounces-6189-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 18:34:55 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC3316145B
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 18:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00EFD301A43B
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 17:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5495734FF44;
	Thu, 19 Feb 2026 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="YisUY52t"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990FB34DCF9
	for <linux-efi@vger.kernel.org>; Thu, 19 Feb 2026 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522487; cv=pass; b=p71JurvmNKq5eZfKh/X2MFnCJnKQMBq9aQmRrBn8AUufgqd/gNxTrmHl6UF9mpm6LojuyLoceGiEijZkDR5nusWNEl8PFMZRQ7GdEzaRA/UAfV2fQuKI3fgSPrl2MViEEErbS5DcKB/wPaLS+kbMBSKt3unYxj2LgM3rP6FcfdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522487; c=relaxed/simple;
	bh=Nhfo6WowGFqZTaUMQKHqG7rfam1cmV6bFODpXkitYV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzqWVOCs4BB80debvD3TMhaQe8dtgmt54hZ55WQVzBYNpyuC46yy+LQljJ4skkChZinoDYPPGOAIi3Q+9gZG9pp84bwb2W4F8TGRFC5lZrMspmbMY1NxpXBVOHGzYGCmmoJECJnEzBwudOsMyXsG6uwLJ4NM+U/mPON7M8G1JFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=YisUY52t; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59e4989dacdso1456661e87.1
        for <linux-efi@vger.kernel.org>; Thu, 19 Feb 2026 09:34:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771522484; cv=none;
        d=google.com; s=arc-20240605;
        b=Nf6khkf3wQj5npKA0dKWkYykqHLyUSIAsaY6npXd1d99sTJ5aIIkHFflfH7Ltwk44o
         WQPY7sVrTHB7cFK8P8kKldvEs0/6rNR/ijpKyjM05OLi0N5pNIPPGAyuzhGlu/2MwBVe
         GZ6+5i2cUXUfogHv+AzLNKDPcb896Qn2W5JXq+771JnUeltRrMCXPRllfUK0B/e1ExdA
         hqJyR2BmLTvdMCDkpQzFzCOos56aMAkeXBv7lfn1LEsM6tirSpr7QJJSVmnJmDy1m/K6
         ahAyaA6WBRPAYjtE0Lr3xHhvRBVmvxJPOi5SqdkamI2jGeSP1G+AVdc5Z0ZW4bXrBuDR
         577Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UUE/Joru8hXMHvDVf62I8TaujuFRVcwhp9CDDO4vFKM=;
        fh=Gqelbi1aBW+An9QB4K8XrzM/NZFmAACdYQq5UdHr6EE=;
        b=lDQ16jvpesDucLq4KyOS3IL1H9p+ejCymjAK5W3Xpn1WzontbX5z/+YVnH4S6UOmB5
         8pSOKiJJGbCDHwOklvrR8t7G8nqkISaK50OX96sHs8v7JnARPRW6QxhExN8EQw8C5MuE
         bIVZsD77zuf6sOQu/ql5c0mnzvX1f6aWRre8yMIV8pBM4eMrizbHKVLSWjSXaDy5rXQr
         JRVgoUdM1VKc69D65dfJGOnCOhGcM8Fh+Uu+bD9pSCY8AEZgKAfWDoNRjGEcIJy4J5ny
         qCpCxz4aBL6nNF7ecvKGDXtO3JaaK0BqzNddKqZrf+GK015qI0Vs5mN2pp2ATsph2fGy
         LCdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1771522484; x=1772127284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUE/Joru8hXMHvDVf62I8TaujuFRVcwhp9CDDO4vFKM=;
        b=YisUY52t5F2N/Mobb4iTxZEVeKpzj/NwpGCrpnX98cKCyu72Crp4S65evd7o3/gUnq
         kUf8f0uZvpuHyTdpNbsmCcSowPwHEgYx9eFolMJakQM2Hlc0/T3uL6WNEuZneHliVl9y
         9YJ/bvVzv1wG7wM7ZJHJqWYKr8oVhFlPpL98bcBNEBJy/kISp8PyGHgEKj+B/O2KKV89
         zvbbnskMu/qBi0FSMDwJZeeasVrZl249OKLf6uchp1XVBVei8h9N6L3SXk4sJWCINPW0
         wvsRp68zBzk6M8HAcGDucSXPQ7o0AbQ7Yp8Sc9APee63y8nbN642bNhP8jJRPXqJ8x7b
         R8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771522484; x=1772127284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UUE/Joru8hXMHvDVf62I8TaujuFRVcwhp9CDDO4vFKM=;
        b=Z1SsKPjTrt3Udk8DPGEoXl7WdhN4FGFj1eEVG2tpst7g9NkqABCuF2oVthBwm20ymt
         haGMzKfA9x8vbKF84Q1Pa3bIb0cYsX6+lbshZcivSbh+WBvG4zUoWwu4BEkZK1C+HK36
         XcanOiCTuLGsQvbZbR70t2BAtc2bWCIOXAkP8GJHJolOZbTdqxdoEWfeRJAbdI8UG5ar
         kcOdPNMQ0fNwGkE/lVvLKXZdELACYhiXGtlUlHoQ2GzIwRLBUebq/ylRGF7AOiuSMopx
         egBXfRgh6ohG1zH+uYkdKsh3T7VXrYWxcHvfo3XDDZ63i5LYE2GFsod6rXkszwkjKGXh
         UvcA==
X-Forwarded-Encrypted: i=1; AJvYcCUIGhwmij5hOoUsNWcgETLB5DC5Nh5zDvgn0DPRLVYZUfsPdmvi/FbszNVz2LRvvVRTtbnpmhoE640=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOXKj6EFIKVeGcNVFw2VvSlCz15psHvrNHVYUStVydj/O/dK9R
	Gk0esXQa28L4skUkIkE0H0JbMVWbuvrwtfS7TQEa2PGqwFMvy+tSoY3u8Z4jxovv0Yn+7DRShPQ
	zCag5T/cHm009Uppt1e19qwgtKRz2EZCQhH/6Z1Ri
X-Gm-Gg: AZuq6aJC+MkP0CoGrNutYroMvU5Hkk7I0fgH4o53aSnEIIEA7oiz109ZEKAGTtT0Z/5
	TaSJ4uxNvc8OfLPZAq+I8BFw92olsHVYsp/QzB7L7s3ldPTJxjLbl9oaWnu8lAgW9pHcdQSF3LI
	3HB9tYr0qI3uzrbsMZiE/OdbnvW/FTZ2370ZObx0WeBdquKSO36DNLRukJwK4Z0QQc/aW6YF87v
	mdy2x0vMsE7YZn17mh3MeVWj5RIY9I1J1BUBFxGIDNKb+IDVP8NtG2jyWSaIkbFT1hcCYVRSxuM
	Apco
X-Received: by 2002:a05:6512:2242:b0:59e:5e07:17fc with SMTP id
 2adb3069b0e04-59f69c28542mr6061794e87.18.1771522483387; Thu, 19 Feb 2026
 09:34:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com> <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com> <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
 <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com> <CALCETrWzG1Mjb-RcwLQ5-tGFZ15WKHjZbqtLvyif+UPuVKJ_5g@mail.gmail.com>
 <32e62cef7b89d9691bdd4120388ce752fd041230.camel@redhat.com>
 <CALCETrUMR0RvOFXGzL7=F4c-3veL+1Sm2xf-BprHTK4=UKw8yA@mail.gmail.com> <558d0f28-01fb-4447-891c-2ffbf869c077@app.fastmail.com>
In-Reply-To: <558d0f28-01fb-4447-891c-2ffbf869c077@app.fastmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 19 Feb 2026 09:34:31 -0800
X-Gm-Features: AaiRm522PbtXXP376kUUKctZtEGG7xWnV2UAINAeVODac9_j4h5cpV1OS3ViHZU
Message-ID: <CALCETrWynypSD7vEjJNLcym3JhBw4k0ovDiR_3YuOHh92TnM=A@mail.gmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Simo Sorce <simo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	"Daniel P. Smith" <dpsmith@apertussolutions.com>, Ross Philipson <ross.philipson@oracle.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dave.hansen@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, nivedita@alum.mit.edu, 
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[amacapital.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6189-lists,linux-efi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,zytor.com,apertussolutions.com,oracle.com,vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,linux.intel.com,linutronix.de,alien8.de,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,citrix.com,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[amacapital-net.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zytor.com:email,mail.gmail.com:mid,amacapital.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DC3316145B
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 11:55=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Wed, 18 Feb 2026, at 22:54, Andy Lutomirski wrote:
> > On Wed, Feb 18, 2026 at 1:04=E2=80=AFPM Simo Sorce <simo@redhat.com> wr=
ote:
> >>
> >> On Wed, 2026-02-18 at 12:34 -0800, Andy Lutomirski wrote:
> >> > On Wed, Feb 18, 2026 at 12:29=E2=80=AFPM H. Peter Anvin <hpa@zytor.c=
om> wrote:
> >> > >
> >> > > On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@amacap=
ital.net> wrote:
> >> > > > On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@ke=
rnel.org> wrote:
> >> > > > >
> >> > > > > On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
> >> > > > > > On 2/9/26 09:04, Ard Biesheuvel wrote:
> >> > > > > ...
> >> > > > > But would it be better to disable the runtime services by defa=
ult when doing a secure launch? PREEMPT_RT already does the same.
> >> > > >
> >> > > > So I have a possible way to disable EFI runtime service without =
losing
> >> > > > the ability to write EFI vars.  We come up with a simple file fo=
rmat
> >> > > > to store deferred EFI var updates and we come up with a place to=
 put
> >> > > > it so that we find it early-ish in boot the next time around.  (=
This
> >> > > > could be done via integration with systemd-boot or shim some oth=
er
> >> > > > boot loader or it could actually be part of the kernel.)  And th=
en,
> >> > > > instead of writing variables directly, we write them to the defe=
rred
> >> > > > list and then update them on reboot (before TXT launch, etc).  [=
0]
> >> > > > This would be a distincly nontrivial project and would not work =
for
> >> > > > all configurations.
> >> > > >
> >> > > > As a maybe less painful option, we could disable EFI runtime ser=
vices
> >> > > > but have a root-writable thing in sysfs that (a) turns them back=
 on
> >> > > > but (b) first extends a PCR to say that they're turned back on.
> >> > > >
> >> > > > (Or someone could try running runtime services at CPL3...)
> >> > > >
> >> > > > [0] I have thought for years that Intel and AMD should do this o=
n
> >> > > > their end, too.  Keep the sensitive part of SMI flash entirely l=
ocked
> >> > > > after boot and, instead of using magic SMM stuff to validate tha=
t
> >> > > > write attempts have the appropriate permissions and signatures, =
queue
> >> > > > them up as deferred upates and validate the signatures on the ne=
xt
> >> > > > boot before locking flash.
> >> > > >
> >> > >
> >> > > *If* a physical EFI partition exists there is a lot to be said for=
 this approach.
> >> > >
> >> > > The only issue with this that I can see is for things like network=
 or CD/DVD booting where there isn't necessarily any EFI boot partition, it=
 might not be writable, or it might not be persistent (e.g. http booting ty=
pically uses a ramdisk, like the old Linux initrd.)
> >> >
> >> > Hmm, I guess my approach is a 100% complete nonstarter for installin=
g
> >> > Linux from a CD, and it's really not awesome for installing Linux fr=
om
> >> > a USB stick.
> >>
> >> Doing any of this on a removable device feels generally like a trap.
> >> You get your USB disk in, try to boot, and it saves vars, but reboot
> >> fails for whatever reason, you plug it in another machine ... and it
> >> tries to "continue" from there? The amount of validation needed and
> >> testing for failure modes across reboots sounds really painful.
> >
> > I kind of stand by my other previous suggestion, though:
> >
> > As a maybe less painful option, we could disable EFI runtime services
> > but have a root-writable thing in sysfs that (a) turns them back on
> > but (b) first extends a PCR to say that they're turned back on.
> >
>
> After setting the EFI boot path to GRUB (or systemd-boot or whatever) at =
installation time, what other meaningful interactions do we expect with the=
 EFI runtime services?
>
> And given that the secure launch is orchestrated by the bootloader , with=
 which the kernel has a backchannel via its configuration file, it should b=
e rather straight-forward to implement the staging of variable updates ther=
e if we really need it.
>
> Doing any of this at the EFI/spec level might lead to a situation where t=
he OS now has to guess which of the provided APIs to manipulate variables i=
s the least broken.
>
> Of course, for readinf variables, dumping the RT variables into a memory =
buffer at boot time and exposing it via a EFI config table would be rather =
straight-forward, but it is also something I feel should be the job of the =
boot component that takes part in the decision to shield the runtime servic=
es from the OS.

So there's sort of a usability issue here.  On the one hand, this can
all be orchestrated to work.  We build a kernel, and the kernel
supports secure launch.  Someone makes an installer image, and that
image is configured to skip secure launch, then install to disk, then
program EFI vars, then reboot.  And the installed image is configured
to do the secure launch, and EFI variable writes are turned off.

On the other hand, this all sucks.  I'm getting sick of having the
kernel tell me that I am not permitted to do things.  I'm sick of
writing software that deals with unnecessary restrictions.  If I were
writing an OS with a USB stick-based installer, I might want to be
able to boot the thing and decide later whether I'm installing an OS
to disk.  (In fact, many USB installers work this way.)  But, in the
model where EFI variable writes are hard-disabled on a secure launch,
the decision to do the secure launch happens before the decision to
install an OS, and we all lose.

So I'm proposing that EFI variable writes be treated a bit like kexec
[0] -- root (which is already part of the TCB for any practical
purpose) is going to decide, like a grown up, to execute some code
that it doesn't fully trust -- in this case, the EFI variable writes.
And root will coordinate, correctly, with whomever it's busy using the
TPM to coordinate with, and tell it that it's going to do something
that will change its trustworthiness.  So it works like this:

1. Secure launch the environment on the stick.  (At this stage,
neither the boot loader nor the kernel has the faintest clue whether
anyone needs that secure launch, but this doesn't matter.)

2. The owner of the machine clicks "install".

3. The installer makes some partitions and writes some files.

(Up until now, the security posture of the running environment has not chan=
ged.)

4. The installer decides that it's now time to do untrustworthy
things, namely writing EFI vars.  So it unmounts anything it mounted
using TPM-sealed keys (or not -- this is between the distro and
whoever trusts the distro), and it does:

# echo 1 >/sys/.../extend_pcr_and_unlock_efi

which *first* extends a PCR because we are about to change our
security posture and *second* sets whatever flag permits use of EFI
runtime services.

5. The installer writes to EFI variables.  And the installer can no
longer generate attestations to its previous security posture, which
is the correct behavior.  And maybe the user can no longer unlock
their home directory or whatever until they reboot.  Which is not
really a big deal.

(This is *dynamic* root of trust.  In theory the system could do a
DRTM re-launch and recover its security posture, but I don't think
this is implemented.)


One thing I like about this is that it involves very little code.

[0] Do we actually handle kexec intelligently?  I have no idea.  I'm
still getting used to the time that gdb fails half the time because
someone has a strange concept of security.

