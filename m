Return-Path: <linux-efi+bounces-6213-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHtpBUNhnWksPQQAu9opvQ
	(envelope-from <linux-efi+bounces-6213-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 09:28:51 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA50183AB9
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 09:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 650C8300C039
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 08:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5FD366552;
	Tue, 24 Feb 2026 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axVIXYxU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A781A33C18C
	for <linux-efi@vger.kernel.org>; Tue, 24 Feb 2026 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921620; cv=none; b=W0h9eZvgU1QgO3Oo84TZ9mkez+kQUcOXgktBPz4nwPz2eHeBjmSqdUFXa4EEAA1mp8diJ2ta6h3sdAVFALCEKNukUccKnwWe8klz/mbsEsf6UiZYPCksXCZVBUJ62uqKDOq+hEcjaG83zN+ZBeR6vqAnFlXutT2J0VkUHxi/yYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921620; c=relaxed/simple;
	bh=uGL5V4ybrZtgDy4Ez2EE0bWwenNORHtw2SqAtXBgfrM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bMw+wLYHIkqqJ3SI14GJKpyE8W9OT7R47j8wUncLtD5K9xWdeS5YtATSWETT/odzWQZySmzgbwCLP16LGz23TtRHIrR2ZQklMywVC1bAaV7w4D3x/Utzytf+LMCkk8CtVCP3X1LQ2cyo5TyfK6hUY59UCuo1hUT7DNQbKO5BPS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axVIXYxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9812AC19423;
	Tue, 24 Feb 2026 08:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771921620;
	bh=uGL5V4ybrZtgDy4Ez2EE0bWwenNORHtw2SqAtXBgfrM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=axVIXYxUgRkP5VNvV98V1g0wnA7ipOtwAd357KTFn/CRheTNFVp2/ypFLpseuiOSL
	 s9Q7QuK+wValYwI9sm1NvSzwKKauls2jJemU2qF4e2xWQENKI5xKo6RkUE1FQx1B6Q
	 vVyy4y3eIPEpyz/hZYwSrq7o9uLSizPq5zATgrc1OgaUp8r4HGU/V6B/QLFH3tXvZv
	 jxyPe5nAOBfUIt5RSL/OxgJ4TK0+zElK7XNg+lj1xTPrTENRsg8gx6GocV9NXgfZPb
	 49tGwDX7vI7I+gmhucE9HiReXDACKRnKGuO23ez5Ccp5cxjJxw9fzJi/X67fWXSBqk
	 3RDTrQdPBZ1jQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8F85BF4006A;
	Tue, 24 Feb 2026 03:26:58 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 24 Feb 2026 03:26:58 -0500
X-ME-Sender: <xms:0mCdaeS4gs9_4cI0M3pb0ELas63mgebvYSvnSqB9RAqe_bOYHciYMQ>
    <xme:0mCdaelkhNJa-C8gAgeqSnHrqMx1JykXK-Eg_2ErefnrT4Df3ZGe-uThtv4pUDPFO
    ZQhtHrXX3ZH00eunOoHDteXfbtsHZRZiB_CKFosv4GOq7i0LD320dc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeuteeiudeigeekjedvheduieehteetgfdtuefghfejgffhfedtleehvdeh
    fffhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeefvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepnhhivhgvughithgrsegrlh
    humhdrmhhithdrvgguuhdprhgtphhtthhopehluhhtohesrghmrggtrghpihhtrghlrdhn
    vghtpdhrtghpthhtohepughpshhmihhthhesrghpvghrthhushhsohhluhhtihhonhhsrd
    gtohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtgho
    mhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoh
    epphgvthgvrhhhuhgvfigvsehgmhigrdguvgdprhgtphhtthhopehhvghrsggvrhhtsehg
    ohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohepthhrvghntghhsghooh
    htqdguvghvvghlsehgohhoghhlvghgrhhouhhpshdrtghomh
X-ME-Proxy: <xmx:0mCdaVC92Ri72Ftpm6M5ZohWHZYKotgc9AzwW5hBVioygJzJDEfkLw>
    <xmx:0mCdaeNvbe_P3jm_Oi-bOhVymevi0WIoW07XL-dampoag-b4eTcdow>
    <xmx:0mCdaUkYLeWTXG5vbaFJ-xDDYExrF_SQLlH8ZGP-nr6zp_k6ZkhkZA>
    <xmx:0mCdaQc57QXzPMBBpX0iwdRcBoNXBcYM2z9j-KjrSVl2AiKAzVHE5Q>
    <xmx:0mCdaZD30e_5mV6VzzV0zJSiWC_PzLK46AJe_IvUTDxy6JlFAdW7YCjw>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5DE47700069; Tue, 24 Feb 2026 03:26:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1ToacgRLhLF
Date: Tue, 24 Feb 2026 09:25:33 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Andrew Cooper" <andrew.cooper3@citrix.com>,
 "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "Eric Biggers" <ebiggers@kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "H . Peter Anvin" <hpa@zytor.com>, dave.hansen@linux.intel.com,
 "Matthew Garrett" <mjg59@srcf.ucam.org>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>, peterhuewe@gmx.de,
 "Jarkko Sakkinen" <jarkko@kernel.org>, jgg@ziepe.ca,
 "Andy Lutomirski" <luto@amacapital.net>, nivedita@alum.mit.edu,
 "Herbert Xu" <herbert@gondor.apana.org.au>, davem@davemloft.net,
 corbet@lwn.net, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Message-Id: <ce68fcc7-d90d-4ee3-bb25-3f960442e281@app.fastmail.com>
In-Reply-To: <02e6a889-ff72-4c18-b9ee-35fcef3570f6@citrix.com>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
 <281c3bb3-13f6-47a2-9a9a-134e397bf686@apertussolutions.com>
 <c9a0cd9f-17cb-49e5-a411-b78ef9c7e35e@app.fastmail.com>
 <02e6a889-ff72-4c18-b9ee-35fcef3570f6@citrix.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch early
 measurements
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-6213-lists,linux-efi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,kernel.org,lists.infradead.org,lists.linux-foundation.org,redhat.com,alien8.de,zytor.com,linux.intel.com,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,infradead.org,googlegroups.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6AA50183AB9
X-Rspamd-Action: no action



On Tue, 24 Feb 2026, at 00:08, Andrew Cooper wrote:
> On 20/02/2026 3:35 pm, Ard Biesheuvel wrote:
>> Coming back to this old thread after having spent some time playing w=
ith the code:
>>
>> On Thu, 22 Aug 2024, at 20:29, Daniel P. Smith wrote:
>>
>> <selective snip>
>>
>>> Another fact to consider is that the current Intel's TXT MLE=20
>>> specification dictates SHA1 as a valid configuration. Secure Launch'=
s=20
>>> use of SHA1 is therefore to comply with Intel's specification for TX=
T.=20
>> As I understand the Intel TXT spec and the code:
>>
>> - TPM 1.2 is no longer supported by the TXT spec (since 2023)
>> - TPM 1.2 is not supported by your GRUB implementation
>> - in TPM 2.0 mode, SHA1 is only supported by the TXT spec if it is th=
e /only/ algo supported by the TPM
>> - the proposed kernel implementation ignores any SHA-384 and SM3-256 =
PCR banks if they are active, and caps them using a { 1, 0, ... } fake d=
igest.
>>
>> So apologies for being slow, but I still struggle to understand why i=
t is so important to have a SHA-1 implementation to cap those PCRs. Is i=
t just to support systems with a TPM 2.0 that only has SHA-1 banks enabl=
ed?
>>
>> Assuming that this code will get merged this year, it will be in a LT=
S branch by 2027, by which time distros like Debian will pick it up.=20
>>
>> I fully understand that this code has lived out-of-tree for more than=
 a decade, and you likely prefer to get everything upstream that your cu=
rrent users may be relying on. But for Linux, this is a new feature, and=
 merging code now that is basically obsolete on day 1 is not something w=
e should entertain imo.
>>
>> (and apologies for re-opening yet another can of worms - I assure you=
 I am trying to be constructive here)
>>
>
> I appreciate that you've got concerns, but I don't think these
> characterisations are fair.=C2=A0 Ultimately yes, we do want to suppor=
t TPM
> 1.2 systems because we have users wanting a way off the out-of-tree pa=
tches.
>

That was my question, yes. So supporting TPM 1.2 as well as TPM 2.0 with=
 only SHA-1 banks enabled is needed not to comply with the spec, but to =
support existing out-of-tree users. That needs to be called out, because=
 what I am quoting above is a claim that it is needed to comply with the=
 TXT MLE spec.

So the debate is really about whether or not such systems should be cons=
idered obsolete at this point.

And why is it ok to just cap active SHA-384 banks rather than perform th=
e proper measurements?

> 3-year-old hardware is new enough to still be in full support from OEM=
s,
> and totally fair game for distro LTS's even at this juncture.
>

3-year old hardware that shipped with a TPM 1.2?

> The TXT spec does not speak for what OEMs choose to support, nor for t=
he
> TPM spec (where SHA1 is a mandatory algorithm for TPM 2.0), nor does it
> speak for other silicon vendors we're trying to support (there are AMD
> patches waiting for the interface to stop changing).
>
>
> But lets ask the question the other way around.=C2=A0 What does refusi=
ng SHA1
> gain?
>
> AFAICT, there's no meaningful reduction in complexity in the early cod=
e;
> the TPM library speaks TPM 1.2 and 2.0.=C2=A0 There is a small reducti=
on in
> binary size for not including SHA-1, but including it is no extra C
> because we reuse the library that already exists.
>

The complexity of the code is not the problem. The problem is that we'll=
 be stuck supporting it long past the point where anyone is making meani=
ngful use of it. I'm not keen on being on the receiving end of a bug rep=
ort from your last remaining TPM 1.2 user, with no means whatsoever to t=
est or reproduce.

> The cost is a failure to operate in some TXT configurations that exist
> on in-support CPUs, as well as older systems.
>

Sure, some systems will be left behind. I just wonder how many of those =
would be upgrading to the v7.3 LTS kernel to begin with, 4 years after T=
PM 1.2 support was dropped from the TXT spec.

In any case, the code changes themselves look fine to me. I am more conc=
erned about the long term maintenance: the x86 boot code is very complex=
, given how many boot methods it supports, and it is rather difficult to=
 regression test all of those.




