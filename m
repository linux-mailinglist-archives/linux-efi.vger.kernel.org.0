Return-Path: <linux-efi+bounces-6178-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGcwKU0ilmnYawIAu9opvQ
	(envelope-from <linux-efi+bounces-6178-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 21:34:21 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0BF159774
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 21:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B55BB3028814
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 20:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C776346FAD;
	Wed, 18 Feb 2026 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="Z4MERPRO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C2C309F1F
	for <linux-efi@vger.kernel.org>; Wed, 18 Feb 2026 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771446855; cv=pass; b=deuVTeY8dD2LNjhxo4chmQMfNWER2ILIlPO1hCy0nqm8wVqR4/AYBrXZCNVrK0dF/euu7DFenUjVPjRB6EdL7HIK7o9XRJqgLXU/ijpzGdK9aKFp4K7rVb541u49GnbEuB5k/L29/PxQ5x55UKgAUz8KIrFuZ2AJIBo8TeYFNVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771446855; c=relaxed/simple;
	bh=7C5a/FWuVnB5cGwTAOV2Br2wE+JlZH1M0yzztc2OQnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNss5VHtDkcLWQXZJVCfzpVy9IgxRehbvH1Ix/bgM0SjXPG/xOEyctdGIY/P4Q99ipfE0Bpk6IOpcb2c2DAPkC2k0GWkf6LWreMzI1nGBbqpsGCd3vec8K7CXP6C/AGvkwFq77+ItBKBhgaBnmseEtIVxfqV1E2EPGQziBHdJoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=Z4MERPRO; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59e4989dacdso347320e87.1
        for <linux-efi@vger.kernel.org>; Wed, 18 Feb 2026 12:34:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771446852; cv=none;
        d=google.com; s=arc-20240605;
        b=Rheu1FfbvFn7ogvlCAIFzUidF37a1qr2paSOGREDV5MLLjjTrcexuxUlFabAQKcPh+
         RSjTc9MZJZ98eBVIobA1+UtsToe2F/IRIpKOSSJLwp7+UlG3bkMuMAFaTL3vruKjDvED
         /N2S3steqn7JCM1l4UpvYFXhG+xrpgulR80ftXvpZXj6wg+G37pAObyJRSY6MCBgZeFL
         lw7eAaS2UUU3j9g3g6SbbrHx5otLT3CXorU4ZyEBfiWUGUWu/MQpj8jHLCQKvecPjDt2
         48MOdanGgKkPa5A2VlDbK5KntVf9hL+ZW20tDHaUKCsEjUwF1TEjbZxGhlxSzBcHbf/J
         jbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6AtdZqt2ARoYJJMPe919rNdJ3JohEndwFbHKNaMS4Pw=;
        fh=NibRO7wLXQNiEI6xh3gFGzJ6MtSNo2ZxdEbp/mMA5Ww=;
        b=P1XpilnWXcDyXF2ob+gtPAyBsx82LYDGiQO9mhpjb+nLwViIoY43/cqQ2vl8106FzN
         GSIBfP30kUj74Yjt22f0m/9O/79Rg9qnQWhYenzDJz9qu6BtVqBCcfxFMTAL6LFoJpK+
         4WmRhs86bFdDP4UUOm5vCRkAxrrJMh9JbJnGKLkOwSKtm25xwFq+gQhWwGihpobHxvJS
         tp2dGn5dk2fDA6P/nda4Acb5/Tcf77mJISdq1dtJNCTwhjlk45ZL2UWrndDHDV7EWkAm
         UAv6b+QX49xF0cbcL2QOTbTXQTG/rPo7ezdy3KawIoVrCU17sQdV1pyuXlKpdmLfal3F
         hqJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1771446852; x=1772051652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AtdZqt2ARoYJJMPe919rNdJ3JohEndwFbHKNaMS4Pw=;
        b=Z4MERPROgc9FSVfsG/kG3t98pIsPZiZa2ci+uYC8QxNYZkIennmepWfaiy7Su18KK4
         XL22ZPuUBe0n4IDEa5pCurRylazjGAVX1OmmoNEjfSxpevk9PQUIMFk5G6kXLbqdjiOO
         fqYt3arXfK+vc7SaJ/DL7BwDklV9pbrB8HHrXjb+oweXnLTx4Cdk5LXocPhK7369V3HC
         aBoWerMPnojZBqm+P7TfDpbyBsNBRPoofMPIJsdtWxi+ymZYmqEnYt2BJKtIS6s8nGkP
         h+gbveSCj6t3jiYDKFzSlZTqUuiFL/tNzrF6CYvIzH75E4v/8g0KMg91glEciuzyaGGt
         Ltkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771446852; x=1772051652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6AtdZqt2ARoYJJMPe919rNdJ3JohEndwFbHKNaMS4Pw=;
        b=l1U7EzuFL0V7YT+5b0SnQ+JWdP1xXW29YyRAzRY/JDbiONql72OL/n28a2AvO228uP
         cjSQwyQr4l7LmFE1Ow6v4WhTXH/chOcsE39TzxU2xfSj61b7gHjOdbVXL1dj5Nys/+Vj
         Ic0PiFQjp720omdXK1CgPKT5JMMQVs8lKfHg69YqA3D/hoSmLBsxyO7DQukg0BzwZ9Y8
         RjXLjtN4/dW9qLhCa2ItZ6BprNFMrQijj1P7IWow9jhS9iw9jQAPYuCmCA18UMgH5Ucm
         uydzn4OdbCQG4V2lI9OhMWGBVYMv8JXGZrkMeYdMW27Ddg3wuS/v8oryB4mBm+ghCTfD
         Ff/g==
X-Forwarded-Encrypted: i=1; AJvYcCVOmDk/+YxH7rsHQmlsdPnRBzadu3jXfwaWS1eJUOf0fTk7OJPwjcZ226UVaLqEZHluxc2sZjsJiTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkeeLl8+Y8NJpTVep12kUYam0+AhVQtm/4mBlHoxm6AmchN/XI
	L48UhhUstRjyvbHh6P+aSfj1GBySXx6kiYxkq0MHji+f6PlthYBiWjVd1wm/qVoda+SGJwET78h
	p1njyyN5lxmqn3XhMsTij3hJ5hDfz/WHzVUVb6s1t
X-Gm-Gg: AZuq6aIBbzbMwVx2YTPj+7lkReQUK16GMb9zClD5voIrzBHvvhrRWeMBggxwZeJu9xQ
	o1kbCoX8COzIvtpaoI4OEKmwhTxDT2OCDwiU5//wQFtzTQM+iksay+FupmmDZaiLc44a2v27msG
	den3xkna1bi1CYEL0is1SlzRPMRcYgfkNodN2LN0BUEmNOkFHviSbVyKVR1YdayOeFQU5mPpSK/
	0ZxPUYys352BLEIRRAAG21Qw6DUEHyPL5yyCmG/cjklLRge5y4jY3y8s+6e2N2WaSxYmY5U+SFE
	DrY0
X-Received: by 2002:a05:6512:1284:b0:59e:63b7:585e with SMTP id
 2adb3069b0e04-59f69c68122mr5099221e87.36.1771446852112; Wed, 18 Feb 2026
 12:34:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com> <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com> <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
 <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com>
In-Reply-To: <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 18 Feb 2026 12:34:00 -0800
X-Gm-Features: AaiRm52O5CUthtEuekouveR3oQDy41lsj_ZjT1TsYC4xSgI6Vkc6OZxoV-XcGok
Message-ID: <CALCETrWzG1Mjb-RcwLQ5-tGFZ15WKHjZbqtLvyif+UPuVKJ_5g@mail.gmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, "Daniel P. Smith" <dpsmith@apertussolutions.com>, 
	Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, dave.hansen@linux.intel.com, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[amacapital.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6178-lists,linux-efi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,apertussolutions.com,oracle.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,linux.intel.com,linutronix.de,redhat.com,alien8.de,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,citrix.com,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[amacapital-net.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amacapital-net.20230601.gappssmtp.com:dkim,amacapital.net:email,zytor.com:email,mail.gmail.com:mid,tandasat.github.io:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F0BF159774
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:29=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wro=
te:
>
> On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@amacapital.ne=
t> wrote:
> >On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> >>
> >> On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
> >> > On 2/9/26 09:04, Ard Biesheuvel wrote:
> >> ...
> >> >> Surprisingly, even when doing a secure launch, the EFI runtime serv=
ices still work happily, which means (AIUI) that code that was excluded fro=
m the D-RTM TCB is still being executed at ring 0? Doesn't this defeat D-RT=
M entirely in the case some exploit is hidden in the EFI runtime code? Shou=
ld we measure the contents of EfiRuntimeServicesCode regions too?
> >> >
> >> > Yes, in fact in the early days I specifically stated that we should
> >> > provide for the ability to measure the RS blocks. Particularly if yo=
u
> >> > are not in an environment where you can isolate the calls to RS from=
 the
> >> > TCB. While the RS can pose runtime corruption risks, the larger conc=
ern
> >> > is integrating the D-RTM validation of the Intel System Resources
> >> > Defense (ISRD), aka SMI isolation/SMM Supervisor, provided by the In=
tel
> >> > System Security Report (ISSR). Within the ISSR is a list of memory
> >> > regions which the SMM Policy Shim (SPS) restricts a SMI handler's ac=
cess
> >> > when running. This allows a kernel to restrict what access a SMI han=
dler
> >> > are able to reach, thus allowing them to be removed from the TCB whe=
n
> >> > the appropriate guards are put in place.
> >> >
> >> > If you are interested in understanding these further, Satoshi Tanda =
has
> >> > probably the best technical explanation without Intel market speak.
> >> >
> >> > ISRD: https://tandasat.github.io/blog/2024/02/29/ISRD.html
> >> > ISSR: https://tandasat.github.io/blog/2024/03/18/ISSR.html
> >> >
> >>
> >> Thanks, I'll take a look at those.
> >>
> >> But would it be better to disable the runtime services by default when=
 doing a secure launch? PREEMPT_RT already does the same.
> >
> >So I have a possible way to disable EFI runtime service without losing
> >the ability to write EFI vars.  We come up with a simple file format
> >to store deferred EFI var updates and we come up with a place to put
> >it so that we find it early-ish in boot the next time around.  (This
> >could be done via integration with systemd-boot or shim some other
> >boot loader or it could actually be part of the kernel.)  And then,
> >instead of writing variables directly, we write them to the deferred
> >list and then update them on reboot (before TXT launch, etc).  [0]
> >This would be a distincly nontrivial project and would not work for
> >all configurations.
> >
> >As a maybe less painful option, we could disable EFI runtime services
> >but have a root-writable thing in sysfs that (a) turns them back on
> >but (b) first extends a PCR to say that they're turned back on.
> >
> >(Or someone could try running runtime services at CPL3...)
> >
> >[0] I have thought for years that Intel and AMD should do this on
> >their end, too.  Keep the sensitive part of SMI flash entirely locked
> >after boot and, instead of using magic SMM stuff to validate that
> >write attempts have the appropriate permissions and signatures, queue
> >them up as deferred upates and validate the signatures on the next
> >boot before locking flash.
> >
>
> *If* a physical EFI partition exists there is a lot to be said for this a=
pproach.
>
> The only issue with this that I can see is for things like network or CD/=
DVD booting where there isn't necessarily any EFI boot partition, it might =
not be writable, or it might not be persistent (e.g. http booting typically=
 uses a ramdisk, like the old Linux initrd.)

Hmm, I guess my approach is a 100% complete nonstarter for installing
Linux from a CD, and it's really not awesome for installing Linux from
a USB stick.

