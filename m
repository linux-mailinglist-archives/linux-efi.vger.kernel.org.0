Return-Path: <linux-efi+bounces-6181-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FYGFUY1lmkkcQIAu9opvQ
	(envelope-from <linux-efi+bounces-6181-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 22:55:18 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F16A615A722
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 22:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52B78302D0B8
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 21:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9A53314D1;
	Wed, 18 Feb 2026 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="pRs5B5ix"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951A2320CD9
	for <linux-efi@vger.kernel.org>; Wed, 18 Feb 2026 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451708; cv=pass; b=B7CmvzarnjeLzIGUtvFz1MmhjP1h9LsnYDuVICUzIc5S/YQpvdrWWQZ3IOD5I8T8IKADFFBgUga5t/EtndWx4v9vOi65vLHnmeSW1DEzKckZeb5nNvkE9cT9aePa9Asz0aaj1webPeGTkODffjiMH8e5LbHEua6eoZ1zjR12sQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451708; c=relaxed/simple;
	bh=DtMCBbJ603M+9lFH3b7cqRU6jOZc0GNXvqZDaNm0YIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeiWyr4nitjWiQl5Ef4+CnM8qVBfVKpzwMTIoDzkeDoEZ8AgplJd9C8BVRdS4Z7/CwWqLJGL9JVPCE7hkW/2cA0shMpOwBzVtO6XT9zBM047HPxNiUh+hm7NfWfvq/Fu0vaZGP9vlpJZIs4tgkcaqV66wyF7Azncmu5F/IYMbzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=pRs5B5ix; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59e5eaa491cso459837e87.0
        for <linux-efi@vger.kernel.org>; Wed, 18 Feb 2026 13:55:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771451705; cv=none;
        d=google.com; s=arc-20240605;
        b=W+t5Tobk6rSxgLaIpXABcvQpFv2XGOCzzWd8UXPhxmquN+mHImpBWKaRWiZPW0B2kj
         iHwZeq6JObPL4G+wiNtNRjnZsHcJUozYizf8rEf5TIpiuQKWcpAOEZz66WN1Js4ww+2k
         zLpf9eKleklVnQISArcqqkoWJQPQz8NMxr/04lo8Q88pwus0st2PR6LjzHNa8CYCWgd4
         Q+ng/+7x0YhTElhtSI3R6LVxANvcyADmpehOSdJdydCbBlJJxwoGRG0kMr78ZLIR8vbm
         u215/94fzfxLOXqvaosKPE+ndEsLfO/6Z7ppCKX7v8zX/WYvRFFrHO/VcklyySD3Jug+
         7ibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K6id67RYm+WkjGu//HTup/gkJF0wPsfSPDN/OaX8LFM=;
        fh=+dDk2r6zTUZ49hGh+TbF5mkmSsIHzj7emVKM0I8IGo4=;
        b=ku6aGFBfUZomFCHEE8KiW3F8m2myiF9tKjiiaJr4tBRml6yPZ1XPGS9xQ2oJdPIfnP
         93PX1/E6mPXgl20GrilqjgcCmz8txbTbC5jQQ9tEIRjfIr7TOb9ZbqFztiRc5SNrN9YF
         ZcICrAD9TGQ4mXU5pegbhx8x4OQrL+suPPXUpycNbTbWE2uAclbObd11Ai5Vwbm0nCj0
         JFX088i/X7Umw8elbTQY9Crih9Z9gcxrZhadytiellSQYU+NmzBODyCUAZpPCGTOl/Cj
         iBG5lXLMKO/Gbm/N7ZVuU49tdvkXnhZrRzBY75n2A8UNG+M8REKXj224HteTJgpn9fiF
         LDTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1771451705; x=1772056505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6id67RYm+WkjGu//HTup/gkJF0wPsfSPDN/OaX8LFM=;
        b=pRs5B5ixqZAoZ/MuQdcDAKL060Wdyz+aZ0N43KGNlKbESCH1SfUhAdTsjTbHtXH8A4
         AsN9gTBlySg+NddHpkoQZs3w3sxlRpYSKErlsHPZ9/lZYmiQURfD8oAszAQ7ObA6GGtx
         rVurIm65lZ8pLNFrEtIYocMnjNGdBQ/7U8fIqObvUvWA/ptxkuzNkZ/c3F+eg+24zgSu
         ZrmHwR52UomBtGZIYFHgQqF2NBX5iQudF5SqS5glJTWUWE+bTblFybo7lMn/qzRUP4MC
         kb+fQ3P5Rnm15fTO1FyR+MyH7W1EdEJAWmfbUfvf41SXdyY0KtEA+p+HsWX4C5F3XnMl
         0XsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771451705; x=1772056505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6id67RYm+WkjGu//HTup/gkJF0wPsfSPDN/OaX8LFM=;
        b=PYoRs0UdwNaR9HW2+Wzv4+ASI26GCRvl7kVtl6SPHHOhLNcATt0iUXK4cFiPPxDCFo
         tICLSUGPjUnVTjX/8K95MdjXleKOCw45AIJ8QRt3KOKlLO6TEfDCGNfd0eQMvTkscZkI
         fMfHKxVR+ibye4iDXK6K3/oa29JfO4hKaBVVHCev01M2rnONCk2dp0GWV37MFbvY3XoN
         gy3RUvpifSFXidVOCvD0M8Mx7VRKE7GWpVqpj6GWKqRWQWE0NfnK0AroOslgUDB5HYDZ
         AMjb53pYbU4FxrL4lHqixIqjHdFWYvLUCIm2cgI8h7SWCuyF5mtPqIoFpIDLRdkVk6Mh
         Oqvg==
X-Forwarded-Encrypted: i=1; AJvYcCWGBAKdpkxKfKmN6B1MuvIAeiHusdl+4EG/qB5MlKKtT6oRCVzJdD6N7SImOFgOUEEKdHfOlhVrbBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHy4cHidHswshTen0LBC0TO0eM7Dw1tpdn2F7DOO+x7Vgiun7g
	UZvEfUG54zkFUpvyEEsVRBm80rHFx/XeD/s4gsNKZxLyJNfCesdowC0VtjEVlgHZI3FSV+wylmg
	7fk53KTzGKCC2Zt6a2jTIZFUyjOAwlrgqV2Bf3Ux4
X-Gm-Gg: AZuq6aJcCAhUhgf+0EokaswRmderafrGqHP4Xt1tERMOST4Y2YQ+TtS5jthDdfWZNg2
	1gEel9t/v1uV+nBb+N39zwPWtDY20ZF86W4RE803tOz/9M3WUxi5IYrRftPCPZCzkvUIEcsR+q4
	A+nTTTo+y47aSP8FhwBXY4CjBK1StK5ZH8rHA6zlXVe0Eer2DlGnmWIXUnWwPyykBN8hOfr7BXE
	pfyvIDo2efexfOXjxpxiGemYnvJ6YUdzqZhud1Tv64HT3U1Zq+zjIiTAIwdI+L+MYuOqSKMJX/o
	JQn/
X-Received: by 2002:a05:6512:304d:b0:59e:1880:2ef6 with SMTP id
 2adb3069b0e04-59f69c0f33dmr5396130e87.10.1771451704704; Wed, 18 Feb 2026
 13:55:04 -0800 (PST)
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
In-Reply-To: <32e62cef7b89d9691bdd4120388ce752fd041230.camel@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 18 Feb 2026 13:54:53 -0800
X-Gm-Features: AaiRm50_oD7OC0ANa5Bzl9PQloeEGVtFI0Bz_O-wbD80wJJi63Y8TTUsLaV64pE
Message-ID: <CALCETrUMR0RvOFXGzL7=F4c-3veL+1Sm2xf-BprHTK4=UKw8yA@mail.gmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
To: Simo Sorce <simo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[amacapital.net];
	TAGGED_FROM(0.00)[bounces-6181-lists,linux-efi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,kernel.org,apertussolutions.com,oracle.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,linux.intel.com,linutronix.de,redhat.com,alien8.de,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,citrix.com,googlegroups.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[amacapital-net.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_TWELVE(0.00)[32];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F16A615A722
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 1:04=E2=80=AFPM Simo Sorce <simo@redhat.com> wrote:
>
> On Wed, 2026-02-18 at 12:34 -0800, Andy Lutomirski wrote:
> > On Wed, Feb 18, 2026 at 12:29=E2=80=AFPM H. Peter Anvin <hpa@zytor.com>=
 wrote:
> > >
> > > On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@amacapita=
l.net> wrote:
> > > > On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@kerne=
l.org> wrote:
> > > > >
> > > > > On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
> > > > > > On 2/9/26 09:04, Ard Biesheuvel wrote:
> > > > > ...
> > > > > > > Surprisingly, even when doing a secure launch, the EFI runtim=
e services still work happily, which means (AIUI) that code that was exclud=
ed from the D-RTM TCB is still being executed at ring 0? Doesn't this defea=
t D-RTM entirely in the case some exploit is hidden in the EFI runtime code=
? Should we measure the contents of EfiRuntimeServicesCode regions too?
> > > > > >
> > > > > > Yes, in fact in the early days I specifically stated that we sh=
ould
> > > > > > provide for the ability to measure the RS blocks. Particularly =
if you
> > > > > > are not in an environment where you can isolate the calls to RS=
 from the
> > > > > > TCB. While the RS can pose runtime corruption risks, the larger=
 concern
> > > > > > is integrating the D-RTM validation of the Intel System Resourc=
es
> > > > > > Defense (ISRD), aka SMI isolation/SMM Supervisor, provided by t=
he Intel
> > > > > > System Security Report (ISSR). Within the ISSR is a list of mem=
ory
> > > > > > regions which the SMM Policy Shim (SPS) restricts a SMI handler=
's access
> > > > > > when running. This allows a kernel to restrict what access a SM=
I handler
> > > > > > are able to reach, thus allowing them to be removed from the TC=
B when
> > > > > > the appropriate guards are put in place.
> > > > > >
> > > > > > If you are interested in understanding these further, Satoshi T=
anda has
> > > > > > probably the best technical explanation without Intel market sp=
eak.
> > > > > >
> > > > > > ISRD: https://tandasat.github.io/blog/2024/02/29/ISRD.html
> > > > > > ISSR: https://tandasat.github.io/blog/2024/03/18/ISSR.html
> > > > > >
> > > > >
> > > > > Thanks, I'll take a look at those.
> > > > >
> > > > > But would it be better to disable the runtime services by default=
 when doing a secure launch? PREEMPT_RT already does the same.
> > > >
> > > > So I have a possible way to disable EFI runtime service without los=
ing
> > > > the ability to write EFI vars.  We come up with a simple file forma=
t
> > > > to store deferred EFI var updates and we come up with a place to pu=
t
> > > > it so that we find it early-ish in boot the next time around.  (Thi=
s
> > > > could be done via integration with systemd-boot or shim some other
> > > > boot loader or it could actually be part of the kernel.)  And then,
> > > > instead of writing variables directly, we write them to the deferre=
d
> > > > list and then update them on reboot (before TXT launch, etc).  [0]
> > > > This would be a distincly nontrivial project and would not work for
> > > > all configurations.
> > > >
> > > > As a maybe less painful option, we could disable EFI runtime servic=
es
> > > > but have a root-writable thing in sysfs that (a) turns them back on
> > > > but (b) first extends a PCR to say that they're turned back on.
> > > >
> > > > (Or someone could try running runtime services at CPL3...)
> > > >
> > > > [0] I have thought for years that Intel and AMD should do this on
> > > > their end, too.  Keep the sensitive part of SMI flash entirely lock=
ed
> > > > after boot and, instead of using magic SMM stuff to validate that
> > > > write attempts have the appropriate permissions and signatures, que=
ue
> > > > them up as deferred upates and validate the signatures on the next
> > > > boot before locking flash.
> > > >
> > >
> > > *If* a physical EFI partition exists there is a lot to be said for th=
is approach.
> > >
> > > The only issue with this that I can see is for things like network or=
 CD/DVD booting where there isn't necessarily any EFI boot partition, it mi=
ght not be writable, or it might not be persistent (e.g. http booting typic=
ally uses a ramdisk, like the old Linux initrd.)
> >
> > Hmm, I guess my approach is a 100% complete nonstarter for installing
> > Linux from a CD, and it's really not awesome for installing Linux from
> > a USB stick.
>
> Doing any of this on a removable device feels generally like a trap.
> You get your USB disk in, try to boot, and it saves vars, but reboot
> fails for whatever reason, you plug it in another machine ... and it
> tries to "continue" from there? The amount of validation needed and
> testing for failure modes across reboots sounds really painful.

I kind of stand by my other previous suggestion, though:

As a maybe less painful option, we could disable EFI runtime services
but have a root-writable thing in sysfs that (a) turns them back on
but (b) first extends a PCR to say that they're turned back on.

--Andy

